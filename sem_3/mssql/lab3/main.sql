-- EXEC AddColumnToTableProcedure @TableName = 'Users', @ColumnName = 'Mocking';
-- EXEC addDefaultConstraintProcedure @DefaultConstraint = "ID_Constraint", @TableName = "Users", @ColumnName = "Mocking";
-- select * from DatabaseVersion;
-- EXEC CreateTableProcedure @TableName = 'newTable';
-- EXEC addForeignKeyProcedure
--     @TableName = 'Users',
--     @ColumnName = 'mocking',
--     @ReferencedTable = 'newTable',
--     @ReferencedColumn = 'ID',
--     @FKConstraintName = 'FK_Users_to_newTable';

DROP PROCEDURE IF EXISTS mainProcedure;
GO

CREATE PROCEDURE mainProcedure (
    @Version INT
)
AS
BEGIN
    -- Check if the version is valid
    IF @Version IS NULL OR @Version <= 0
    BEGIN
        RAISERROR('Version must be a positive number. and lower than 4', 16, 1);
        RETURN;
    END;

    -- Check if the version exists
    IF NOT EXISTS (SELECT * FROM DatabaseVersion WHERE VersionID = @Version)
    BEGIN
        RAISERROR('Version does not exist.', 16, 1);
        RETURN;
    END;

    -- Get the current version
    DECLARE @CurrentVersion INT;
    -- take the current version from the property isCurrentVersion
    SELECT TOP 1 @CurrentVersion = VersionID FROM DatabaseVersion WHERE IsCurrentVersion = 1;

    EXEC RevertDatabaseToVersion @Version;

END;
GO

EXEC mainProcedure @Version = 5;

select * from DatabaseVersion;
