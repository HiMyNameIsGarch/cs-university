DROP VIEW IF EXISTS UserDetailedInfo;
GO

CREATE VIEW UserDetailedInfo AS
SELECT
    u.UserID,
    u.Username AS UserName,
    u.Email AS UserEmail,
    c.CategoryName AS PasswordCategory,
    p.WebUrl AS Website,
    p.Notes AS PasswordNotes,
    t.TagName AS PasswordTag,
    p.CreatedDate AS PasswordCreatedDate,
    p.UpdatedDate AS PasswordUpdatedDate
FROM
    Users u
INNER JOIN
    Passwords p ON u.UserID = p.UserID
LEFT JOIN
    Categories c ON p.CategoryID = c.CategoryID
LEFT JOIN
    PasswordTags pt ON p.PasswordID = pt.PasswordID
LEFT JOIN
    Tags t ON pt.TagID = t.TagID;
GO

-- Example time:
-- get all passwords, grouped by user and category, including tags
-- total of 4 tables ( Users, Passwords, Categories, Tags )
-- in one document it says 3 but in another 4 so I did it with 4 tables anyway
SELECT
    UserName,
    UserEmail,
    PasswordCategory,
    Website,
    PasswordNotes,
    PasswordTag,
    PasswordCreatedDate,
    PasswordUpdatedDate
FROM
    UserDetailedInfo
WHERE
    UserName = 'cata' -- Filter for a specific user
ORDER BY
    PasswordCategory, PasswordCreatedDate;
