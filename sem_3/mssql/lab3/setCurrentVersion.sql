DROP PROCEDURE IF EXISTS setCurrentVersionProcedure;
GO

CREATE PROCEDURE setCurrentVersionProcedure
(
    -- parameters
    @VersionID INT
)
AS
BEGIN

    -- check if the version is in the database
    IF NOT EXISTS (SELECT VersionID FROM DatabaseVersion WHERE VersionID = @VersionID)
    BEGIN
        RAISERROR('Version %d does not exist.', 16, 1, @VersionID);
        RETURN 1;
    END;

    BEGIN TRANSACTION;

    BEGIN TRY
        UPDATE DatabaseVersion
            SET IsCurrentVersion = 0
            WHERE IsCurrentVersion = 1;

        -- Set the new current version
        UPDATE DatabaseVersion
            SET IsCurrentVersion = 1
            WHERE VersionID = @VersionID;

        -- Check if the update of version succeeded
        IF @@ROWCOUNT = 0
        BEGIN
            THROW 50001, 'The specified VersionID does not exist.', 1;
        END
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        RAISERROR('Error while setting the current version.', 16, 1);
        -- rethrow the error
        THROW;
    END CATCH;

END;
GO


EXEC SetCurrentVersionProcedure @VersionID = 1;
SELECT * FROM DatabaseVersion;

