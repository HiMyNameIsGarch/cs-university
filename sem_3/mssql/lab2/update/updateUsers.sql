USE passman;
GO

-- before show
SELECT * FROM Users where UserID = 3;

-- Update password for specific user
UPDATE Users
SET 
    AccountPassword = 'thisismysecurepassword'
WHERE 
    Username LIKE 'vasile%' AND UserID = 3
    AND CreatedDate > '2021-01-01 00:00:00.000';

-- after show
SELECT * FROM Users where UserID = 3;
