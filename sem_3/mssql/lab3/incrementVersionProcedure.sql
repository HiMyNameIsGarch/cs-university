DROP PROCEDURE IF EXISTS IncrementDatabaseVersion;
GO

CREATE PROCEDURE IncrementDatabaseVersion
(
    -- parameter for the description
    @Description NVARCHAR(MAX),
    @ActionT NVARCHAR(MAX),
    @RevertAction NVARCHAR(MAX)
)
AS BEGIN
    -- check if the message is null
    IF @Description IS NULL OR LEN(@Description) = 0
    BEGIN
        RAISERROR('Description must be provided.', 16, 1);
        RETURN 1;
    END;

    -- check if the revert action is null or exists
    IF @RevertAction IS NULL OR LEN(@RevertAction) = 0
    BEGIN
        RAISERROR('Revert action must be provided.', 16, 1);
        RETURN 1;
    END;

    IF @ActionT IS NULL OR LEN(@ActionT) = 0
    BEGIN
        RAISERROR('Action must be provided.', 16, 1);
        RETURN 1;
    END;

    -- check if the revert action is a store procedure
    -- extract the store procedure name from the string
    -- is the first word in the string separated by space
    DECLARE @ProcedureName NVARCHAR(255);
    SELECT @ProcedureName = SUBSTRING(@RevertAction, 1, CHARINDEX(' ', @RevertAction) - 1);

    IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = @ProcedureName)
    BEGIN
        RAISERROR('Revert action must begin with a store procedure. Yours is: %s', 16, 1, @ProcedureName);
        RETURN 1;
    END;

    -- build the sql
    BEGIN TRY
        PRINT 'before set'
        DECLARE @SqlCommand NVARCHAR(MAX);
        SET @SqlCommand = N'INSERT INTO DatabaseVersion (Description, Action, RevertAction, IsCurrentVersion) VALUES (' + QUOTENAME(@Description, '''') + N', ' + QUOTENAME(@ActionT, '''') + N', ' + QUOTENAME(@RevertAction, '''') + N', 0);';
        PRINT 'Action: ' + @ActionT;
        PRINT 'Revert: ' + @RevertAction;
        -- SET @SqlCommand = 'SELECT * FROM DatabaseVersion';
        PRINT 'after set';
        PRINT 'SQL to execute: ' + @SqlCommand;

    -- Execute the dynamic SQL with the alter statement
        EXEC sp_executesql @SqlCommand;
    END TRY
    BEGIN CATCH
        PRINT 'we got an error'
    END CATCH

    -- Get the current version
    DECLARE @CurrentVersion INT;
    SELECT @CurrentVersion = MAX(VersionID) FROM DatabaseVersion;

    -- Execute the store procedure to alter the database version
    EXEC SetCurrentVersionProcedure @VersionID = @CurrentVersion;

    -- Print the message to the console
    PRINT @Description + N'. Database version now at ' + Cast(@CurrentVersion AS NVARCHAR(10)) + N'.';
END;
GO

select * from DatabaseVersion
