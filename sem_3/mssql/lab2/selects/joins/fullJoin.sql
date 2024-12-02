-- 4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN (one query per
-- operator); one query will join at least 3 tables;

-- FULL JOIN
SELECT DISTINCT C.CategoryName, T.TagName FROM Categories C

FULL JOIN Passwords P ON C.CategoryID = P.CategoryID
FULL JOIN PasswordTags PT ON P.PasswordID = PT.PasswordID
FULL JOIN Tags T ON PT.TagID = T.TagID

WHERE T.TagName = 'Important';
