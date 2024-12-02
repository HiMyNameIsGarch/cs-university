-- 2 queries using IN and EXISTS to introduce a subquery in the WHERE clause (one query per operator);

-- EXISTS
-- get all users that has an gmail account
-- get top 3 users that has a gmail account and the username is shorter than 12
-- characters
SELECT TOP 3 U.Username, U.Email
FROM Users U
WHERE LEN(U.Username) < 17-- AND EXISTS (
--     SELECT *
--     FROM Passwords P
--     WHERE P.UserID = U.UserID AND U.Email LIKE '%@gmail.com'
-- );
