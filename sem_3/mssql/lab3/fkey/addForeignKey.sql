DROP PROCEDURE IF EXISTS addForeignKeyProcedure;
GO

CREATE PROCEDURE addForeignKeyProcedure
(
    -- parameters
    -- the table where the foreign key is applied
    @TableName NVARCHAR(128),
    -- the column that is the foreign key
    @ColumnName NVARCHAR(128),
    -- the table that is referenced
    @ReferencedTable NVARCHAR(128),
    -- reference column in the referenced table
    @ReferencedColumn NVARCHAR(128),
    -- FK contraint name
    @FKConstraintName NVARCHAR(128),
    -- CanIncrement
    @CanIncrement BIT = 1
)
AS BEGIN
    IF @TableName IS NULL OR @ColumnName IS NULL OR @ReferencedTable IS NULL OR @ReferencedColumn IS NULL OR @FKConstraintName IS NULL
    BEGIN
        RAISERROR('Table name and column name must be provided.', 16, 1);
        RETURN;
    END;
    -- check if the table exists
    IF OBJECT_ID(@TableName, 'U') IS NULL
    BEGIN
        PRINT 'Table does not exist';
        RETURN;
    END;
    -- check if the referenced table exists
    IF OBJECT_ID(@ReferencedTable, 'U') IS NULL
    BEGIN
        PRINT 'Referenced table does not exist';
        RETURN;
    END;

    -- Check if column exists in the table
    IF COL_LENGTH(@TableName, @ColumnName) IS NULL
    BEGIN
        RAISERROR('Column does not exists in the table.', 16, 1);
        RETURN;
    END;
    -- check if the referenced column exists
    IF COL_LENGTH(@ReferencedTable, @ReferencedColumn) IS NULL
    BEGIN
        PRINT 'Referenced column does not exist';
        RETURN;
    END;

    -- check if the foreign key already exists
    IF OBJECT_ID(@FKConstraintName, 'F') IS NOT NULL
    BEGIN
        PRINT 'Foreign key already exists';
        RETURN;
    END;

    DECLARE @SQL NVARCHAR(MAX);
    -- Construct SQL for adding the foreign key
    SET @SQL = N'ALTER TABLE ' + QUOTENAME(@TableName) +
               N' ADD CONSTRAINT ' + QUOTENAME(@FKConstraintName) +
               N' FOREIGN KEY (' + QUOTENAME(@ColumnName) +
               N') REFERENCES ' + QUOTENAME(@ReferencedTable) +
               N'(' + QUOTENAME(@ReferencedColumn) + N');';

    -- Execute the SQL
    EXEC sp_executesql @SQL;

    -- prepare the message for logging
    DECLARE @Message NVARCHAR(255);
    SET @Message = N'Foreign key ' + @FKConstraintName + N' added to table ' + @TableName + N'.';

    IF @CanIncrement = 1
    BEGIN
        -- Construct the ActionT
        DECLARE @ActionT NVARCHAR(MAX);
        SET @ActionT = N'addForeignKeyProcedure @TableName = ''' + @TableName + ''', @ColumnName = ''' + @ColumnName + ''', @ReferencedTable = ''' + @ReferencedTable + ''', @ReferencedColumn = ''' + @ReferencedColumn + ''', @FKConstraintName = ''' + @FKConstraintName + '''' + ', @CanIncrement = 0';

        -- Construct the RevertAction to remove the foreign key
        DECLARE @RevertAction NVARCHAR(MAX);
        SET @RevertAction = N'removeForeignKeyProcedure @ForeignKeyName = ''' + @FKConstraintName + ''', @ParentTableName = ''' + @TableName + ''', @ColumnName = ''' + @ColumnName + ''', @ReferencedTable = ''' + @ReferencedTable + ''', @ReferencedColumn = ''' + @ReferencedColumn + '''' + ', @CanIncrement = 0';

        -- Increment the database version with the store procedure
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
    @FKConstraintName = 'FK_MockTable1_to_MockTable3';


SELECT * FROM DatabaseVersion;

