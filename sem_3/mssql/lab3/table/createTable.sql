DROP PROCEDURE IF EXISTS CreateTableProcedure;
GO

CREATE PROCEDURE CreateTableProcedure
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

    -- check if the table already exists:
    IF OBJECT_ID(@TableName, 'U') IS NOT NULL
    BEGIN
        RAISERROR('Table already exists.', 16, 1);
        RETURN;
    END;

    -- create table
    DECLARE @SQL nvarchar(MAX);
    SET @SQL = N'CREATE TABLE ' + @TableName + N' (ID INT PRIMARY KEY)';
    EXEC sp_executesql @SQL;

    -- prepare the message for logging
    DECLARE @Message NVARCHAR(255);
    DECLARE @DB NVARCHAR(255);
    SET @DB = DB_NAME();
    SET @Message = N'To the database ' + @DB + N' has been added the table ' + @TableName + N'.';

    IF @CanIncrement = 1
    BEGIN
        DECLARE @RevertSql NVARCHAR(MAX);
        SET @RevertSql = N'RemoveTableProcedure ' + N'@TableName = ' + @TableName + N', @CanIncrement = 0;'
        DECLARE @ActionT NVARCHAR(MAX);
        SET @ActionT = N'CreateTableProcedure ' + N'@TableName = ' + @TableName + N', @CanIncrement = 0;'
        EXEC IncrementDatabaseVersion @Message, @ActionT, @RevertSql;
    END;
END;
GO

-- Create MockTable1
-- EXEC CreateTableProcedure @TableName = 'MockTable1';
EXEC CreateTableProcedure @TableName = 'Users';
SELECT * FROM DatabaseVersion;


SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'Users';

