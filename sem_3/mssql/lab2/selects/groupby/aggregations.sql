-- Query to find users with more passwords than the average number of passwords
-- saved by all users
SELECT TOP 5 U.Username, COUNT(P.PasswordID) AS NumberOfPasswords
FROM Users U
LEFT JOIN Passwords P ON U.UserID = P.UserID
GROUP BY U.Username
HAVING COUNT(P.PasswordID) > (
    SELECT AVG(PasswordCount)
    FROM (
        SELECT COUNT(PasswordID) AS PasswordCount
        FROM Passwords
        GROUP BY UserID
    ) AS UserPasswordCounts
);

