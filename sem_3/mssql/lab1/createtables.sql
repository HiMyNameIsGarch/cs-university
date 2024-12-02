-- create enum for actions
CREATE TABLE ActionTypes (
    ActionType NVARCHAR(10) PRIMARY KEY
);

INSERT INTO ActionTypes (ActionType) VALUES ('Create'), ('Update'), ('Delete');

-- Users Table
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    --
    Username NVARCHAR(100) NOT NULL UNIQUE,
    Email NVARCHAR(100) NOT NULL,
    AccountPassword NVARCHAR(255) NOT NULL,
    --
    CreatedDate DATETIME DEFAULT GETDATE(),
    LastModified DATETIME DEFAULT GETDATE()
);

-- Categories Table
CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL
    -- suggestion: enum pentru categorii doar pt flexibilitate
);

-- Passwords Table
CREATE TABLE Passwords (
    -- Login information
    PasswordID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),

    -- Credentials
    Username NVARCHAR(100) NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,

    -- Notes about the password
    Notes NVARCHAR(MAX),
    WebUrl NVARCHAR(255),

    -- Dates for password creation and last update
    CreatedDate DATETIME DEFAULT GETDATE(),
    UpdatedDate DATETIME DEFAULT GETDATE()
);

-- Tags Table
CREATE TABLE Tags (
    TagID INT IDENTITY(1,1) PRIMARY KEY,
    TagName NVARCHAR(100) NOT NULL
);

-- PasswordTags Table (M-N relationship)
CREATE TABLE PasswordTags (
    PasswordID INT NOT NULL FOREIGN KEY REFERENCES Passwords(PasswordID),
    TagID INT NOT NULL FOREIGN KEY REFERENCES Tags(TagID), PRIMARY KEY (PasswordID, TagID)
);

-- Logs Table
CREATE TABLE Logs  (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
    PasswordID INT NOT NULL FOREIGN KEY REFERENCES Passwords(PasswordID),
    -- Action: Create, Update, Delete
    LogDate DATETIME DEFAULT GETDATE(),
    ActionType NVARCHAR(10) NOT NULL,
    FOREIGN KEY (ActionType) REFERENCES ActionTypes(ActionType)
    -- tot un enum per actiune
);
