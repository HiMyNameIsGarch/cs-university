-- 1 query with a subquery in the FROM clause

-- Query to get users with the count of their passwords, showing only those
-- with more than 5 passwords
SELECT U.Username, U.Email, PasswordCount.CountOfPasswords
FROM Users U
JOIN (
    SELECT UserID, COUNT(PasswordID) AS CountOfPasswords
    FROM Passwords
    GROUP BY UserID
    HAVING COUNT(PasswordID) > 1
) AS PasswordCount ON U.UserID = PasswordCount.UserID;
