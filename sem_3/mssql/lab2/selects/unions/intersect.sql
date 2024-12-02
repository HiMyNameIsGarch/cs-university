-- INTERSECT
-- get all the usernames that have v in name
SELECT Username FROM Users
WHERE Username LIKE '%a%'
INTERSECT
-- get all the users that has created their account after 2023
SELECT Username FROM Users
WHERE CreatedDate > '2023-01-01';

