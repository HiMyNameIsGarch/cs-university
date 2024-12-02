CREATE PROCEDURE CreateTable
(
    -- parameters
    @TableName nvarchar(128) = NULL
)
AS
BEGIN
    -- check if the table name is provided
    IF @TableName IS NULL or @TableName = '':
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

    -- Increment the database version with the store procedure
    EXEC IncrementDatabaseVersion @Message;
END;
