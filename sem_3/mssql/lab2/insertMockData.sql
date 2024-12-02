USE passman;
GO

-- Insert the users
INSERT INTO Users (Username, Email, AccountPassword)
VALUES
('mihaiull', 'mihai@gmail.com', 'SuperSecurePassword123'),
('gobilianul', 'gobi@yahoo.com','AnotherSecurePassword456'),
('vasilepopescu', 'vasile@gmail.com', 'PassWord987'),
('florinconstantin', 'florin@gmail.com', 'Secure!Pass678'),
('andreiionescu', 'andrei@gmail.com', 'AndreiPassword123');

-- Insert categories 
INSERT INTO Categories (CategoryName)
VALUES
('Social Media'),
('Games'),
('Email'),
('Banking');

-- Insert passwords for each user
INSERT INTO Passwords (UserID, WebUrl, Username, PasswordHash, Notes, CategoryID)
VALUES
(1, 'facebook.com', 'mihaiull', 'fbpassword123', 'Facebook account', 1),
(1, 'lol.com', 'lolololol', 'lolpassword', 'League of Legends account', 2),

(2, 'instagram.com', 'gobilianul123', 'instaPass456', 'Instagram account', 1),
(2, 'dota2.com', 'dotaismylife', 'ilovedota', 'Dota account', 2),

(3, 'gmail.com', 'vasilepopescu', 'gmailPass789', 'Gmail account', 3),
(3, 'bcr.ro', 'vasilepopescu', 'bankingPass321', 'BCR banking account', 4),

(4, 'yahoo.com', 'florinconst', 'yahooSecure123', 'Yahoo account', 3),

(5, 'revolut.com', 'andreiio', 'revolutSecure678', 'Revolut account', 4);

-- Insert tags for categorizing passwords
INSERT INTO Tags (TagName)
VALUES
('Important'),
('New'),
('Personal'),
('Work'),
('Old');

-- Associate passwords with tags
INSERT INTO PasswordTags (PasswordID, TagID)
VALUES
(1, 1),  -- Facebook password tagged as Important
(1, 2),  -- Facebook password tagged as New
(2, 3),  -- League of Legends password tagged as Personal
(3, 4),  -- Instagram password tagged as Work
(4, 1),  -- Dota password tagged as Important
(5, 5),  -- Gmail password tagged as Old
(6, 1),  -- BCR banking password tagged as Important
(6, 3),  -- BCR banking password tagged as Personal
(7, 4),  -- Yahoo password tagged as Work
(8, 1);  -- Revolut password tagged as Important

-- Insert logs for actions taken on passwords
INSERT INTO Logs (UserID, PasswordID, ActionType)
VALUES
(1, 1, 'Create'),
(1, 2, 'Create'),
(2, 3, 'Create'),
(2, 4, 'Create'),
(3, 5, 'Create'),
(3, 6, 'Create'),
(4, 7, 'Create'),
(5, 8, 'Create'),
(1, 1, 'Update'),  -- Example of an Update action
(3, 5, 'Delete');  -- Example of a Delete action
