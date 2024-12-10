DROP TABLE IF EXISTS DatabaseVersion;
GO

-- Table to track database versions
CREATE TABLE DatabaseVersion (
    -- version id to be the primary key to ensure uniqueness
    -- question: why not use an identity column with auto incrementing the version
    -- im thinking that in real world application you would want to have
    -- control over the version number
    VersionID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,

    -- date of the version when it was created
    VersionDate DATETIME DEFAULT GETDATE(),

    -- flag to indicate if this is the current version
    IsCurrentVersion BIT NOT NULL DEFAULT 1,

    -- the store procedure that has been called
    Action NVARCHAR(255) NOT NULL,

    -- revert the action that was performed to create the version
    RevertAction NVARCHAR(255) NOT NULL, -- here will be the name of the stored procedure that was executed

    -- column name with the version description (what has changed)
    Description NVARCHAR(255) NOT NULL
);
GO

--Initialize default version
INSERT INTO DatabaseVersion (Description, Action, RevertAction)
VALUES
    ("Initial version. Database created.", "Create", "CreateDatabase");
GO


-- create a trigger to ensure that only one version is curren
DROP TRIGGER IF EXISTS trigger_EnsureSingleCurrentVersion;
GO

CREATE TRIGGER trigger_EnsureSingleCurrentVersion
ON DatabaseVersion
AFTER INSERT, UPDATE
AS
BEGIN
    -- If a new row is marked as current, reset others to 0
    -- inserted is a virtual table that holds the rows that were inserted
    IF EXISTS (SELECT * FROM inserted WHERE IsCurrentVersion = 1)
    BEGIN
        UPDATE DatabaseVersion
        SET IsCurrentVersion = 0
        WHERE VersionID <> (SELECT VersionID FROM inserted) AND IsCurrentVersion = 1;
    END;
END;
GO

SELECT * FROM DatabaseVersion;
