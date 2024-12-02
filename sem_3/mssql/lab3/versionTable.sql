-- Table to track database versions
CREATE TABLE DatabaseVersion (
    -- version id to be the primary key to ensure uniqueness
    -- question: why not use an identity column with auto incrementing the version
    -- im thinking that in real world application you would want to have
    -- control over the version number
    VersionID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,

    -- date of the version when it was created
    VersionDate DATETIME DEFAULT GETDATE(),

    -- column name with the version description (what has changed)
    Description NVARCHAR(255) NOT NULL
);

-- Initialize default version
INSERT INTO DatabaseVersion (VersionID, Description)
VALUES
    (1, "Initial version. Database created.");
