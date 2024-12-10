DROP PROCEDURE IF EXISTS removeForeignKeyProcedure;
GO

CREATE PROCEDURE removeForeignKeyProcedure
(
    -- parameters
    @ForeignKeyName nvarchar(128),
    @ParentTableName nvarchar(128),
    @CanIncrement bit = 1
)
AS
BEGIN
    -- code here
    -- check if the table exists
    IF OBJECT_ID(@ParentTableName, 'U') IS NULL
    BEGIN
        RAISERROR('Table does not exist.', 16, 1);
        RETURN;
    END;
    -- check if the foreign key exists
    IF OBJECT_ID(@ForeignKeyName, 'F') IS NULL OR @ForeignKeyName IS NULL
    BEGIN
        RAISERROR('Foreign key does not exist.', 16, 1);
        RETURN;
    END;

    -- drop the foreign key
    DECLARE @sql nvarchar(MAX);
    SET @sql = 'ALTER TABLE ' + @ParentTableName + ' DROP CONSTRAINT ' + @ForeignKeyName;
    EXEC sp_executesql @sql;

    -- prepare the message for logging
    DECLARE @Message NVARCHAR(255);
    SET @Message = N'Foreign key ' + @ForeignKeyName + N' removed from table ' + @ParentTableName + N'.';

    DECLARE @ReferencedTable NVARCHAR(128);
    DECLARE @ReferencedColumn NVARCHAR(128);
    DECLARE @ColumnName NVARCHAR(128);

    -- Query system views to get referenced table and column information
    SELECT
        @ReferencedTable = ccu.TABLE_NAME,
        @ReferencedColumn = ccu.COLUMN_NAME,
        @ColumnName = kcu.COLUMN_NAME
    FROM
        INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu
    JOIN
        INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS rc ON kcu.CONSTRAINT_NAME = rc.CONSTRAINT_NAME
    JOIN
        INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE ctu ON rc.UNIQUE_CONSTRAINT_NAME = ctu.CONSTRAINT_NAME
    JOIN
        INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu ON rc.UNIQUE_CONSTRAINT_NAME = ccu.CONSTRAINT_NAME
    WHERE
        kcu.CONSTRAINT_NAME = @ForeignKeyName AND kcu.TABLE_NAME = @ParentTableName;


    -- Check if the referenced table and column were found
    IF @ReferencedTable IS NULL OR @ReferencedColumn IS NULL
    BEGIN
        RAISERROR('Cannot retrieve referenced table or column for foreign the key.', 16, 1);
        RETURN;
    END;

    IF @CanIncrement = 1
    BEGIN -- Increment the database version with the store procedure
        -- Construct the ActionT for the remove operation
        DECLARE @ActionT NVARCHAR(MAX);
        SET @ActionT = N'removeForeignKeyProcedure @ForeignKeyName = ''' + @ForeignKeyName + ''', @ParentTableName = ''' + @ParentTableName + '''' + ', @CanIncrement = 0';
        -- Construct the RevertAction to add the foreign key back
        DECLARE @RevertAction NVARCHAR(MAX);
        SET @RevertAction = N'addForeignKeyProcedure @TableName = ''' + @ParentTableName + ''', @ColumnName = ''' + @ColumnName + ''', @ReferencedTable = ''' + @ReferencedTable + ''', @ReferencedColumn = ''' + @ReferencedColumn + ''', @FKConstraintName = ''' + @ForeignKeyName + '''' + ', @CanIncrement = 0';

        EXEC IncrementDatabaseVersion @Message, @ActionT, @RevertAction;
    END;
END;
GO

-- Remove Foreign Key from MockTable1 (FK_MockTable1_to_MockTable3)
EXEC removeForeignKeyProcedure
    @ForeignKeyName = 'FK_MockTable1_to_MockTable3',
    @ParentTableName = 'MockTable1';

SELECT * FROM DatabaseVersion;
