DROP PROCEDURE IF EXISTS RemoveColumnFromTableProcedure;
GO

CREATE PROCEDURE RemoveColumnFromTableProcedure
(
    -- parameters
    @TableName nvarchar(128),
    @ColumnName nvarchar(128),
    @CanIncrement bit = 1
)
AS
BEGIN
    -- Check if table name and column name are provided
    IF @TableName IS NULL OR @ColumnName IS NULL or @TableName = '' or @ColumnName = ''
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
    IF COL_LENGTH(@TableName, @ColumnName) IS NULL
    BEGIN
        RAISERROR(N'Column %s does not exists in the table.', 16, 1, @ColumnName);
        RETURN 1;
    END;

    DECLARE @Sql NVARCHAR(MAX);
    SET @Sql = N'ALTER TABLE ' + QUOTENAME(@TableName) + N' DROP COLUMN ' + QUOTENAME(@ColumnName) + N';'
    -- Execute the dynamic SQL with the alter statement
    EXEC sp_executesql @Sql;


    -- prepare the message for logging
    DECLARE @Message NVARCHAR(255);
    SET @Message = N'Column ' + @ColumnName + N' removed from table ' + @TableName + N'.';

    -- Increment the database version with the store procedure
    IF @CanIncrement = 1
    BEGIN
        DECLARE @RevertSql NVARCHAR(MAX);
        SET @RevertSql = N'AddColumnToTableProcedure' + N' @TableName = ' + @TableName + N', @ColumnName = ' + @ColumnName + N', @CanIncrement = 0;';
        DECLARE @ActionT NVARCHAR(255);
        SET @ActionT = N'RemoveColumnFromTableProcedure' + N' @TableName = ' + @TableName + N', @ColumnName = ' + @ColumnName + N', @CanIncrement = 0;';
        EXEC IncrementDatabaseVersion @Message, @ActionT, @RevertSql;
    END;
END;
GO
-- -- --
--
-- -- testing to see if the procedure works correctly
-- EXEC RemoveColumnFromTableProcedure @TableName = '', @ColumnName = ''
-- EXEC RemoveColumnFromTableProcedure @TableName = 'Users', @ColumnName = 'muie';
-- EXEC RemoveColumnFromTableProcedure @TableName = 'Users', @ColumnName = 'serID'
