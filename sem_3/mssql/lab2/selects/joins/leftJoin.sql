-- LEFT JOIN
-- select all categories and their associated passwords and tags
-- created after a specific date
SELECT top 5 C.CategoryName, P.WebUrl, T.TagName FROM Categories C

LEFT JOIN Passwords P ON C.CategoryID = P.CategoryID AND P.CreatedDate > '2024-01-01'
LEFT JOIN PasswordTags PT ON P.PasswordID = PT.PasswordID
LEFT JOIN Tags T ON PT.TagID = T.TagID

ORDER BY C.CategoryName;  -- Optional: Order by category name for better readability
