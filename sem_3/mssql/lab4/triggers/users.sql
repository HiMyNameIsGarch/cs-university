-- Drop the trigger if it exists
IF OBJECT_ID('Log_User_Changes', 'TR') IS NOT NULL
    DROP TRIGGER Log_User_Changes;
GO

-- Create the trigger for INSERT, UPDATE, DELETE on Users table
CREATE TRIGGER Log_User_Changes
ON Users
AFTER INSERT, UPDATE
AS
BEGIN
    -- Declare a variable for the number of records affected
    DECLARE @RecordCount INT;
    DECLARE @AffectedTable NVARCHAR(50) = 'Users';

    -- Handle INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        SELECT @RecordCount = COUNT(*) FROM inserted;
        INSERT INTO Logs(UserID, PasswordID, LogDate, ActionType, AffectedTable, RecordCount)
        SELECT UserID, NULL, GETDATE(), 'Create', @AffectedTable, @RecordCount
        FROM inserted;
    END

    -- Handle UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        SELECT @RecordCount = COUNT(*) FROM inserted;
        INSERT INTO Logs(UserID, PasswordID, LogDate, ActionType, AffectedTable, RecordCount)
        SELECT UserID, NULL, GETDATE(), 'Update', @AffectedTable, @RecordCount  FROM inserted;
    END

END;

-- examples
-- Insert a new user into the Users table
INSERT INTO Users (Username, Email, AccountPassword)
VALUES ('butas', 'butas@example.com', 'arola');
select * from Users;

-- Check the Logs table for the logged action
SELECT * FROM Logs;

-- Update the user's email in the Users table
UPDATE Users
SET Email = 'butas_now@example.com'
WHERE UserID = 1016;

-- Check the Logs table for the logged action
SELECT * FROM Logs;

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = N'Logs'


