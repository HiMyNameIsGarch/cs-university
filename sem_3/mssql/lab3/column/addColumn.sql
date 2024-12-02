CREATE PROCEDURE AddColumnToTable
(
    -- parameters
    @TableName nvarchar(128) = NULL,
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

    -- Alter the table accordingly
    -- ALTER TABLE @TableName ADD @ColumnName NVARCHAR(15);





    -- Prepare the dynamic SQL for altering the table
    DECLARE @Sql NVARCHAR(MAX);
    SET @Sql = N'ALTER TABLE ' + QUOTENAME(@TableName) + N' ADD ' + QUOTENAME(@ColumnName) + N' NVARCHAR(15);';

    -- Execute the dynamic SQL with the alter statement
    EXEC sp_executesql @Sql;




    -- prepare the message for logging
    DECLARE @Message NVARCHAR(255);
    SET @Message = N'Column ' + @ColumnName + N' added to table ' + @TableName + N'.';

    -- Increment the database version with the store procedure
    EXEC IncrementDatabaseVersion @Message;
END;
