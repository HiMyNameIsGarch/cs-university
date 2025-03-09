DROP PROCEDURE IF EXISTS RevertDatabaseToVersion;
GO

CREATE PROCEDURE RevertDatabaseToVersion
(
    @Version INT -- Target version
)
AS
BEGIN
    BEGIN TRY
        -- Check if the version is valid
        IF @Version IS NULL OR @Version <= 0
        BEGIN
            RAISERROR('Version must be a positive number.', 16, 1);
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

        -- Decide direction: forward or backward
        WHILE (@CurrentVersion <> @Version)
        BEGIN
            DECLARE @ActionToExecute NVARCHAR(MAX);

            IF @CurrentVersion > @Version
            BEGIN
                -- Moving backward: get RevertAction
                SELECT @ActionToExecute = RevertAction
                FROM DatabaseVersion
                WHERE VersionID = @CurrentVersion;

                -- Decrement the version
                SET @CurrentVersion = @CurrentVersion - 1;
                EXEC SetCurrentVersionProcedure @VersionID = @CurrentVersion;
            END
            ELSE
            BEGIN
                -- Moving forward: get Action
                SELECT @ActionToExecute = Action
                FROM DatabaseVersion
                WHERE VersionID = @CurrentVersion + 1;

                -- Increment the version
                SET @CurrentVersion = @CurrentVersion + 1;
                EXEC SetCurrentVersionProcedure @VersionID = @CurrentVersion;
            END;

            -- Execute the action
            IF @ActionToExecute IS NOT NULL
            BEGIN
                EXEC sp_executesql @ActionToExecute;
            END
            ELSE
            BEGIN
                RAISERROR('Action is NULL for version transition.', 16, 1);
                RETURN;
            END;
        END;
    END TRY
    BEGIN CATCH
        -- Handle errors gracefully
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Error occurred during version migration: %s', 16, 1, @ErrorMessage);
    END CATCH;
END;
GO


