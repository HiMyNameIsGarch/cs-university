--  queries with the GROUP BY clause, from which 2 queries will also contain
--  the HAVING clause; 1 query from the latter 2 will also have a subquery in
--  the HAVING clause; use the aggregation operators: SUM, AVG, MIN, MAX,
--  COUNT.

-- Query to count the number of passwords saved by each user
SELECT U.Username, COUNT(P.PasswordID) AS NumberOfPasswords FROM Users U
LEFT JOIN Passwords P ON U.UserID = P.UserID

GROUP BY U.Username order by U.Username;

