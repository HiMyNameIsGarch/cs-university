CREATE PROCEDURE removeDefaultConstraint
(
    -- parameters
    @DefaultConstraint nvarchar(128) = NULL
    @TableName nvarchar(128) = NULL
    @ColumnName nvarchar(128) = NULL
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
    SET @Sql = N'ALTER TABLE ' + QUOTENAME(@TableName) + N' DROP CONSTRAINT ' + QUOTENAME(@DefaultConstraint) + N';';
    EXEC sp_executesql @Sql;

    -- prepare the message for logging
    DECLARE @Message NVARCHAR(255);
    SET @Message = N'Default constraint ' + @DefaultConstraint + N' removed from column ' + @ColumnName + N' in table ' + @TableName + N'.';

    -- Increment the database version with the store procedure
    EXEC IncrementDatabaseVersion @Message;
END;
