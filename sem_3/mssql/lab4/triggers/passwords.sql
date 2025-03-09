-- Drop the trigger if it exists
IF OBJECT_ID('Log_Password_Insert', 'TR') IS NOT NULL
    DROP TRIGGER Log_Password_Insert;
GO

-- Create the trigger for AFTER INSERT on Passwords table
CREATE TRIGGER Log_Password_Insert
ON Passwords
AFTER INSERT
AS
BEGIN
    -- Declare a variable for the number of records affected
    DECLARE @RecordCount INT;
    DECLARE @AffectedTable NVARCHAR(50) = 'Passwords';

    -- Handle INSERT: Log the creation of new passwords
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SELECT @RecordCount = COUNT(*) FROM inserted;

        -- Insert into Logs table
        INSERT INTO Logs(UserID, PasswordID, LogDate, ActionType, AffectedTable, RecordCount)
        SELECT UserID, PasswordID, GETDATE(), 'Create', @AffectedTable, @RecordCount
        FROM inserted;
    END
END;
GO

-- Drop the trigger if it exists
IF OBJECT_ID('Log_Password_Delete', 'TR') IS NOT NULL
    DROP TRIGGER Log_Password_Delete;
GO

-- Create the trigger for AFTER DELETE on Passwords table
CREATE TRIGGER Log_Password_Delete
ON Passwords
AFTER DELETE
AS
BEGIN
    -- Declare a variable for the number of records affected
    DECLARE @RecordCount INT;
    DECLARE @AffectedTable NVARCHAR(50) = 'Passwords';

    -- Handle DELETE: Log the deletion of passwords
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        SELECT @RecordCount = COUNT(*) FROM deleted;

        -- Insert into Logs table
        INSERT INTO Logs(UserID, PasswordID, LogDate, ActionType, AffectedTable, RecordCount)
        SELECT UserID, PasswordID, GETDATE(), 'Delete', @AffectedTable, @RecordCount
        FROM deleted;
    END
END;
GO

-- INSERT
INSERT INTO Passwords (UserID, CategoryID, Username, PasswordHash, Notes, WebUrl)
VALUES (1014, 5, 'user', 'hedpassword123', ' password', 'http://example.com');

SELECT * FROM Logs;

SELECT * FROM Passwords;

SELECT * FROM Categories;

select * from Users;

-- DELETE
DELETE FROM Passwords WHERE PasswordID = 19;
