CREATE PROCEDURE RemoveTable
(
    -- parameters
    @TableName nvarchar(128) = NULL
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

    -- Increment the database version with the store procedure
    EXEC IncrementDatabaseVersion @Message;
END;
