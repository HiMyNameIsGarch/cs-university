-- Query to get the total number of passwords per category, filtering for
-- categories with more than 2 passwords
SELECT C.CategoryName, COUNT(P.PasswordID) AS TotalPasswords FROM Categories C

JOIN Passwords P ON C.CategoryID = P.CategoryID
GROUP BY C.CategoryName

HAVING COUNT(P.PasswordID) > 1;
