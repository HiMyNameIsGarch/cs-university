-- RIGHT JOIN
-- select all tags and their passwords for category Games
-- ( can be expanded to any category )
SELECT T.TagName, P.WebUrl, C.CategoryName FROM Tags T

RIGHT JOIN PasswordTags PT ON T.TagID = PT.TagID
RIGHT JOIN Passwords P ON PT.PasswordID = P.PasswordID
RIGHT JOIN Categories C ON P.CategoryID = C.CategoryID

WHERE C.CategoryName = 'Social Media';  -- Filter for a specific category

