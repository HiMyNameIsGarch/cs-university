DROP PROCEDURE IF EXISTS RemoveTableProcedure;
GO

CREATE PROCEDURE RemoveTableProcedure
(
    -- parameters
    @TableName nvarchar(128),
    @CanIncrement bit = 1
)
AS
BEGIN
    -- check if the table name is provided
    IF @TableName IS NULL or @TableName = ''
    BEGIN
        RAISERROR('Table name is required', 16, 1);
        RETURN;
    END;

    -- check if the table exists:
    IF OBJECT_ID(@TableName, 'U') IS NULL
    BEGIN
        RAISERROR('Table does not exist.', 16, 1);
        RETURN;
    END;

    -- drop table
    DECLARE @SQL nvarchar(MAX);
    SET @SQL = N'DROP TABLE ' + @TableName;
    EXEC sp_executesql @SQL;

    -- prepare the message for logging
    DECLARE @Message NVARCHAR(255);
    DECLARE @DB NVARCHAR(255);
    SET @DB = DB_NAME();
    SET @Message = N'From the database ' + @DB + N' has been removed the table ' + @TableName + N'.';

    IF @CanIncrement = 1
    BEGIN
        -- Increment the database version with the store procedure
        DECLARE @RevertSql NVARCHAR(MAX);
        SET @RevertSql = N'CreateTableProcedure ' + N'@TableName = ' + @TableName + N', @CanIncrement = 0;'
        DECLARE @ActionT NVARCHAR(MAX);
        SET @ActionT = N'RemoveTableProcedure ' + N'@TableName = ' + @TableName + N', @CanIncrement = 0;'
        EXEC IncrementDatabaseVersion @Message, @ActionT, @RevertSql;
    END;
END;
GO

-- EXEC RemoveTableProcedure @TableName = 'MockTable2';
SELECT * FROM DatabaseVersion;
--
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

EXEC RevertDatabaseToVersion @Version = 8;
