DROP PROCEDURE IF EXISTS addDefaultConstraintProcedure;
GO

CREATE PROCEDURE addDefaultConstraintProcedure
(
    -- parameters
    @DefaultConstraint nvarchar(128),
    @TableName nvarchar(128),
    @ColumnName nvarchar(128),
    @CanIncrement bit = 1
)
AS
BEGIN
    -- Check if table name and column name are provided
    IF @TableName IS NULL OR @ColumnName IS NULL OR @TableName = '' OR @ColumnName = ''
    BEGIN
        RAISERROR('Table name and column name must be provided.', 16, 1);
        RETURN;
    END;

    -- Check if table exists
    IF OBJECT_ID(@TableName, 'U') IS NULL
    BEGIN
        RAISERROR('Table does not exist.', 16, 1);
        RETURN;
    END;

    -- Check if column exists in the table
    IF COL_LENGTH(@TableName, @ColumnName) IS NULL
    BEGIN
        RAISERROR('Column does not exists in the table.', 16, 1);
        RETURN;
    END;

    -- Check if default constraint exists in the table
    IF NOT EXISTS (SELECT 1 FROM sys.default_constraints WHERE parent_object_id = OBJECT_ID(@TableName) AND name = @DefaultConstraint)

    -- Alter the table accordingly with sql builder
    DECLARE @Sql NVARCHAR(MAX);
    SET @Sql = N'ALTER TABLE ' + QUOTENAME(@TableName) + N' ADD CONSTRAINT ' + QUOTENAME(@DefaultConstraint) + N' DEFAULT 0 FOR ' + QUOTENAME(@ColumnName) + N';';
    EXEC sp_executesql @Sql;

    -- prepare the message for logging
    DECLARE @Message NVARCHAR(255);
    SET @Message = N'Default constraint ' + @DefaultConstraint + N' added to column ' + @ColumnName + N' in table ' + @TableName + N'.';

    IF @CanIncrement = 1
    BEGIN
        -- Increment the database version with the store procedure
        DECLARE @RevertSql NVARCHAR(MAX);
        SET @RevertSql = N'removeDefaultConstraint ' + N'@DefaultConstraint = ' + @DefaultConstraint + N'@TableName = ' + @TableName + N'@ColumnName = ' + @ColumnName + N', @CanIncrement = 0;';
        DECLARE @ActionT NVARCHAR(MAX);
        SET @ActionT = N'addDefaultConstraintProcedure ' + N'@DefaultConstraint = ' + @DefaultConstraint + N'@TableName = ' + @TableName + N'@ColumnName = ' + @ColumnName + N', @CanIncrement = 0;';
        EXEC IncrementDatabaseVersion @Message, @ActionT, @RevertSql;
    END;
END;
GO

-- Add Default Constraint to MockTable1
EXEC addDefaultConstraintProcedure @DefaultConstraint = 'ID_Default1', @TableName = 'MockTable1', @ColumnName = 'column1';
SELECT * FROM DatabaseVersion;

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';


EXEC GetInformationAboutTable @TableName = 'MockTable1';

