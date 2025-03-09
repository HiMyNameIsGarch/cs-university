DROP PROCEDURE IF EXISTS dbo.AddUserWithPassword;
GO

CREATE PROCEDURE dbo.AddUserWithPassword
    @Username NVARCHAR(255),
    @Email NVARCHAR(255),
    @AccountPassword NVARCHAR(255),
    @PasswordCategory NVARCHAR(255),
    @PasswordUsername NVARCHAR(255),
    @PasswordHash NVARCHAR(255),
    @Notes NVARCHAR(MAX),
    @WebUrl NVARCHAR(255)
AS
BEGIN
    BEGIN TRY
        -- Validate parameters
        IF dbo.isNullOrEmpty(@Username) = 1
        BEGIN
            PRINT 'Error: Username is invalid.';
            RETURN;
        END
        -- Check if username is unique
        IF dbo.isUsernameUnique(@Username) = 0
        BEGIN
            PRINT 'Error: Username is already taken.';
            RETURN;
        END
        -- Validate email
        IF dbo.isNullOrEmpty(@Email) = 1
        BEGIN
            PRINT 'Error: Email is invalid.';
            RETURN;
        END
        -- Validate password
        IF dbo.isNullOrEmpty(@AccountPassword) = 1
        BEGIN
            PRINT 'Error: Account password is invalid.';
            RETURN;
        END
        -- Validate password category
        IF dbo.isNullOrEmpty(@PasswordCategory) = 1
        BEGIN
            PRINT 'Error: Password category is invalid';
            RETURN;
        END
        -- Validate password username
        IF dbo.isNullOrEmpty(@PasswordUsername) = 1
        BEGIN
            PRINT 'Error: Password username is invalid';
            RETURN;
        END
        -- Validate password hash
        IF dbo.isNullOrEmpty(@PasswordHash) = 1
        BEGIN
            PRINT 'Error: Password hash is invalid';
            RETURN;
        END

        -- Insert into Users table
        BEGIN TRY
            INSERT INTO Users (Username, Email, AccountPassword) VALUES
                (@Username, @Email, @AccountPassword);
        END TRY
        BEGIN CATCH
            PRINT 'Error: Failed to insert into Users table. ' + ERROR_MESSAGE();
            RETURN;
        END CATCH

        DECLARE @UserID INT;
        SELECT @UserID = SCOPE_IDENTITY();

        -- Ensure Category exists or insert it
        DECLARE @CategoryID INT;
        IF dbo.DoesCategoryExists(@PasswordCategory) = 0
        BEGIN
            BEGIN TRY
                INSERT INTO Categories (CategoryName) VALUES (@PasswordCategory);
            END TRY
            BEGIN CATCH
                PRINT 'Error: Failed to insert into Categories table. ' + ERROR_MESSAGE();
                RETURN;
            END CATCH
        END

        -- Select the category ID after it is inserted
        SELECT @CategoryID = CategoryID FROM Categories WHERE CategoryName = @PasswordCategory;

        -- Insert into Passwords table
        BEGIN TRY
            INSERT INTO Passwords (UserID, CategoryID, Username, PasswordHash, Notes, WebUrl)
                VALUES (@UserID,
                    @CategoryID,
                    @PasswordUsername,
                    @PasswordHash,
                    @Notes,
                    @WebUrl);
        END TRY
        BEGIN CATCH
            PRINT 'Error: Failed to insert into Passwords table. ' + ERROR_MESSAGE();
            RETURN;
        END CATCH

        PRINT 'User and password added successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'An unexpected error occurred: ' + ERROR_MESSAGE();
        RETURN;
    END CATCH
END

-- example usage
-- modify the parameters as needed
EXEC dbo.AddUserWithPassword
    @Username = 'cata',
    @Email = 'cata.doe@example.com',
    @AccountPassword = 'Secure@ssw0rd',
    @PasswordCategory = 'Games',
    @PasswordUsername = 'john_doe_social',
    @PasswordHash = 'hashedpaword123',
    @Notes = '',
    @WebUrl = 'https://games.example.com';
--
--
-- select * from Users;
--
-- -- Query to verify data in the Users table
SELECT
    UserID,
    Username,
    Email,
    AccountPassword,
    CreatedDate,
    LastModified
FROM Users
WHERE Username = 'cata';

-- Query to verify data in the Categories table
SELECT
    CategoryID,
    CategoryName
FROM Categories
WHERE CategoryName = 'SocialMedia';

select * from Passwords;

-- Query to verify data in the Passwords table
SELECT
    PasswordID,
    UserID,
    CategoryID,
    Username AS PasswordUsername,
    PasswordHash,
    Notes,
    WebUrl,
    CreatedDate,
    UpdatedDate
FROM Passwords
WHERE Username = 'john_doe_social' AND WebUrl = 'https://socialmedia.example.com';

