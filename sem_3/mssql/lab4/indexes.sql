-- Create a clustered index on Logs.LogDate
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_Logs_LogDate_Clustered')
 DROP INDEX idx_Logs_LogDate_Clustered ON Logs;
GO
CREATE CLUSTERED INDEX idx_Logs_LogDate_Clustered
ON Logs (LogDate); -- for the order by optimization

-- Create a nonclustered index on Users.CreatedDate
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_Users_CreatedDate')
 DROP INDEX idx_Users_CreatedDate ON Users;
GO
CREATE NONCLUSTERED INDEX idx_Users_CreatedDate
ON Users (CreatedDate); -- used for where clause optimization


SET STATISTICS IO ON;
SET STATISTICS TIME ON;
SET STATISTICS PROFILE ON;
GO

-- example
SELECT
    u.Username,
    u.Email,
    p.Username AS PasswordUsername,
    p.WebUrl,
    p.CreatedDate AS PasswordCreatedDate,
    l.LogDate,
    l.ActionType
FROM
    Users u
JOIN
    Passwords p ON u.UserID = p.UserID -- join users and passwords
JOIN
    Logs l ON p.PasswordID = l.PasswordID -- join passwords and logs
WHERE
    u.CreatedDate >= '2023-01-01'-- filter on created date
    AND l.ActionType = 'Create'-- filter on action type
ORDER BY
    l.LogDate DESC  -- Sort by log date in descending order

SET STATISTICS PROFILE OFF;
GO
