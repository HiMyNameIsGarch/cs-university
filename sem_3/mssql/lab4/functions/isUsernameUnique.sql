IF OBJECT_ID('dbo.IsUsernameUnique', 'FN') IS NOT NULL
    DROP FUNCTION dbo.IsUsernameUnique;
GO

CREATE FUNCTION dbo.IsUsernameUnique(@Username NVARCHAR(100))
RETURNS BIT
AS
BEGIN
    DECLARE @IsUnique BIT
    IF EXISTS (SELECT * FROM Users WHERE Username = @Username)
        SET @IsUnique = 0
    ELSE
        SET @IsUnique = 1
    RETURN @IsUnique
END
