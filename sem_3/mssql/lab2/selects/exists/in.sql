-- IN
-- get all users that have passwords in Social Media or Games
SELECT U.UserId, U.Username, U.Email
FROM Users U
WHERE U.UserID IN (
    SELECT P.UserID
    FROM Passwords P
    WHERE P.CategoryID IN (
        SELECT C.CategoryID
        FROM Categories C
        WHERE C.CategoryName IN ('Social Media', 'Games')
    )
);
