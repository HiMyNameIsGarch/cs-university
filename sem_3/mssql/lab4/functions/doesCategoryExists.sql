IF OBJECT_ID('dbo.DoesCategoryExists', 'FN') IS NOT NULL
    DROP FUNCTION dbo.DoesCategoryExists;
GO

CREATE FUNCTION dbo.DoesCategoryExists(@Category NVARCHAR(256))
RETURNS BIT
AS
BEGIN
    DECLARE @Exists BIT
    IF EXISTS (SELECT 1 FROM Categories WHERE CategoryName = @Category)
        SET @Exists = 1
    ELSE
        SET @Exists = 0
    RETURN @Exists
END
