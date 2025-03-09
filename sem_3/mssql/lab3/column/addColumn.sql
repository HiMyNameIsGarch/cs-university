DROP PROCEDURE IF EXISTS AddColumnToTableProcedure;
GO

CREATE PROCEDURE AddColumnToTableProcedure
(
    -- parameters
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
        RETURN 1;
    END;

    -- Check if table exists
    IF OBJECT_ID(@TableName, 'U') IS NULL
    BEGIN
        RAISERROR(N'Table %s does not exist.', 16, 1, @TableName);
        RETURN 1;
    END;

    -- Check if column exists in the table
    IF COL_LENGTH(@TableName, @ColumnName) IS NOT NULL
    BEGIN
        RAISERROR(N'Column %s does exists in the table.', 16, 1, @ColumnName);
        RETURN 1;
    END;

    -- Prepare the dynamic SQL for altering the table
    DECLARE @Sql NVARCHAR(MAX);
    SET @Sql = N'ALTER TABLE ' + QUOTENAME(@TableName) + N' ADD ' + QUOTENAME(@ColumnName) + N' INT;';
    -- Execute the dynamic SQL with the alter statement
    EXEC sp_executesql @Sql;

    -- prepare the message for logging
    DECLARE @Message NVARCHAR(255);
    SET @Message = N'Column ' + @ColumnName + N' added to table ' + @TableName + N'.';

    -- Increment the database version with the store procedure
    -- put the revert action
    IF @CanIncrement = 1
    BEGIN
        DECLARE @RevertSql NVARCHAR(255);
        SET @RevertSql = N'RemoveColumnFromTableProcedure' + N' @TableName = ' + @TableName + N', @ColumnName = ' + @ColumnName + N', @CanIncrement = 0;';
        DECLARE @ActionT NVARCHAR(255);
        SET @ActionT = N'AddColumnToTableProcedure' + N' @TableName = ' + @TableName + N', @ColumnName = ' + @ColumnName + N', @CanIncrement = 0;';
        EXEC IncrementDatabaseVersion @Message, @ActionT, @RevertSql;
    END;
END;
GO
-- --
-- -- test to see if this works properly
-- EXEC AddColumnToTableProcedure @TableName = '', @ColumnName = '';
-- -- EXEC AddColumnToTableProcedure @TableName = 'sd', @ColumnName = 'asd';
-- -- EXEC AddColumnToTableProcedure @TableName = 'Users', @ColumnName = 'UserID';
-- -- EXEC AddColumnToTableProcedure @TableName = 'Users', @ColumnName = 'ser';
-- EXEC AddColumnToTableProcedure @TableName = 'Users', @ColumnName = 'column1';
-- EXEC AddColumnToTableProcedure @TableName = 'Users', @ColumnName = 'column2';
-- EXEC AddColumnToTableProcedure @TableName = 'sers', @ColumnName = 'column3';
-- EXEC AddColumnToTableProcedure @TableName = 'MockTable1', @ColumnName = 'column1';

EXEC AddColumnToTableProcedure @TableName = 'Users', @ColumnName = 'columnMock5';
EXEC AddColumnToTableProcedure @TableName = 'Users', @ColumnName = 'marcus';

-- EXEC RevertDatabaseToVersion @Version = 5;

EXEC GetInformationAboutTable @TableName = 'MockTable1';

SELECT * FROM DatabaseVersion;
