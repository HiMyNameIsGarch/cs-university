DROP PROCEDURE IF EXISTS IncrementDatabaseVersion;
GO

CREATE PROCEDURE IncrementDatabaseVersion
(
    -- parameter for the description
    @Description NVARCHAR(255),
    @ActionT NVARCHAR(255),
    @RevertAction NVARCHAR(255)
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
    DECLARE @Sql NVARCHAR(MAX);
    SET @Sql = N'INSERT INTO DatabaseVersion (Description, Action, RevertAction, IsCurrentVersion) VALUES (' + QUOTENAME(@Description, '''') + N', ' + QUOTENAME(@ActionT, '''') + N', ' + QUOTENAME(@RevertAction, '''') + N', 0);';
    -- Execute the dynamic SQL with the alter statement
    EXEC sp_executesql @Sql;

    -- Get the current version
    DECLARE @CurrentVersion INT;
    SELECT @CurrentVersion = MAX(VersionID) FROM DatabaseVersion;

    -- Execute the store procedure to alter the database version
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER ON;
    EXEC SetCurrentVersionProcedure @VersionID = @CurrentVersion;

    -- Print the message to the console
    PRINT @Description + N'. Database version now at ' + Cast(@CurrentVersion AS NVARCHAR(10)) + N'.';
END;
GO

