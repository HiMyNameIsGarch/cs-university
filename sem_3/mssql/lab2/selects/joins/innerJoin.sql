-- INNER JOIN
-- select all the passwords and their tags for a specific category
-- ( social media )
SELECT P.WebUrl, T.TagName FROM Passwords P

INNER JOIN PasswordTags PT ON P.PasswordID = PT.PasswordID
INNER JOIN Tags T ON PT.TagID = T.TagID
INNER JOIN Categories C ON P.CategoryID = C.CategoryID

WHERE C.CategoryName = 'Social Media';
