use passman;
go

-- before 
select * from Passwords where UserID = 5;

-- Insert this to delete after
INSERT INTO Passwords (UserID, WebUrl, Username, PasswordHash, Notes, CategoryID)
VALUES
(5, 'linkedin.com', 'andrei.ionescu', 'LinkedinPass123', 'LinkedIn account', 1);

-- after insert
select * from Passwords where UserID = 5;


-- delete the password 
DELETE FROM Passwords
WHERE 
    UserID = 5 AND CategoryID BETWEEN 0 AND 2
    AND WebUrl LIKE '%linkedin%'
    AND CreatedDate > '2024-10-01'

-- after
select * from Passwords where UserID = 5;
