-- 3 queries with UNION, INTERSECT, EXCEPT (one query per operator);

-- UNION
-- Query to get usernames containing the letter 'a'
SELECT Username, Email FROM Users
WHERE Username LIKE '%a%'
UNION
-- Query to get usernames with email from gmail.com
SELECT Username, Email FROM Users
WHERE Email LIKE '%@gmail.com';
-- pe mai multe tabele
