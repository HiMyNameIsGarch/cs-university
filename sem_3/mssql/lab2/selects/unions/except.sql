-- EXCEPT
-- the following query will return all inactive users (no passwords saved)
SELECT Username FROM Users
EXCEPT
SELECT U.Username FROM Passwords P
JOIN Users U ON P.UserID = U.UserID;

-- INSERT INTO Users (Username, Email, AccountPassword)
-- VALUES
-- ('test', 'mihai@gmail.com', 'SuperSecurePassword123')

