DROP PROCEDURE IF EXISTS addForeignKeyProcedure;
GO

CREATE PROCEDURE addForeignKeyProcedure
(
    -- parameters
    @TableName NVARCHAR(128),          -- Table where the foreign key is applied
    @ColumnName NVARCHAR(128),         -- Column that is the foreign key
    @ReferencedTable NVARCHAR(128),    -- Table that is referenced
    @ReferencedColumn NVARCHAR(128),   -- Column in the referenced table
    @FKConstraintName NVARCHAR(128),   -- Foreign Key constraint name
    @CanIncrement BIT = 1              -- Can increment version flag
)
AS
BEGIN
    -- Validate input parameters
    IF @TableName IS NULL OR @ColumnName IS NULL OR @ReferencedTable IS NULL OR @ReferencedColumn IS NULL OR @FKConstraintName IS NULL
    BEGIN
        RAISERROR('All parameters must be provided.', 16, 1);
        RETURN 1;
    END;

    -- Check if the table exists
    IF OBJECT_ID(@TableName, 'U') IS NULL
    BEGIN
        RAISERROR('Table does not exist.', 16, 1);
        RETURN 1;
    END;

    -- Check if the referenced table exists
    IF OBJECT_ID(@ReferencedTable, 'U') IS NULL
    BEGIN
        RAISERROR('Referenced table does not exist.', 16, 1);
        RETURN 1;
    END;

    -- Check if the column exists in the table
    IF COL_LENGTH(@TableName, @ColumnName) IS NULL
    BEGIN
        RAISERROR('Column does not exist in the table.', 16, 1);
        RETURN 1;
    END;

    -- Check if the referenced column exists in the referenced table
    IF COL_LENGTH(@ReferencedTable, @ReferencedColumn) IS NULL
    BEGIN
        RAISERROR('Referenced column does not exist in the referenced table.', 16, 1);
        RETURN 1;
    END;

    -- Check if the foreign key already exists
    IF OBJECT_ID(@FKConstraintName, 'F') IS NOT NULL
    BEGIN
        RAISERROR('Foreign key constraint already exists.', 16, 1);
        RETURN 1;
    END;

    -- Construct the SQL for adding the foreign key
    DECLARE @SQL NVARCHAR(MAX);
    SET @SQL = N'ALTER TABLE ' + QUOTENAME(@TableName) +
               N' ADD CONSTRAINT ' + QUOTENAME(@FKConstraintName) +
               N' FOREIGN KEY (' + QUOTENAME(@ColumnName) +
               N') REFERENCES ' + QUOTENAME(@ReferencedTable) +
               N' (' + QUOTENAME(@ReferencedColumn) + N');';

    -- Execute the constructed SQL
    EXEC sp_executesql @SQL;

    -- Handle database version increment if required
    IF @CanIncrement = 1
    BEGIN
        PRINT 'we will increment';
        -- Construct the Action and RevertAction
        DECLARE @ActionT NVARCHAR(MAX) =
            N'addForeignKeyProcedure @TableName = ''' + @TableName + ''', @ColumnName = ''' + @ColumnName + ''', @ReferencedTable = ''' + @ReferencedTable + ''', @ReferencedColumn = ''' + @ReferencedColumn + ''', @FKConstraintName = ''' + @FKConstraintName + ''', @CanIncrement = 0;';
        PRINT 'Action sql: ' + @ActionT

        DECLARE @RevertAction NVARCHAR(MAX) =
            N'removeForeignKeyProcedure @ForeignKeyName = ''' + @FKConstraintName + ''', @ParentTableName = ''' + @TableName + ''', @ColumnName = ''' + @ColumnName + ''', @ReferencedTable = ''' + @ReferencedTable + ''', @ReferencedColumn = ''' + @ReferencedColumn + ''', @CanIncrement = 0;';
        PRINT 'Revert sql: ' + @RevertAction

        -- Construct the log message
        DECLARE @Message NVARCHAR(255) =
            N'Foreign key ' + @FKConstraintName + N' added to table ' + @TableName + N'.';

        -- Increment the database version
        EXEC IncrementDatabaseVersion @Message, @ActionT, @RevertAction;
    END;
END;
GO


-- Add Foreign Key from MockTable1.column1 to MockTable3.ID
EXEC addForeignKeyProcedure
    @TableName = 'MockTable1',
    @ColumnName = 'column1',
    @ReferencedTable = 'MockTable3',
    @ReferencedColumn = 'ID',
    @FKConstraintName = 'okTae1_to_Mok',
    @CanIncrement = 1;


SELECT * FROM DatabaseVersion;

