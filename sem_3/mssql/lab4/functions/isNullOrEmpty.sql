IF OBJECT_ID('dbo.IsNullOrEmpty', 'FN') IS NOT NULL
    DROP FUNCTION dbo.IsNullOrEmpty;
GO

CREATE FUNCTION dbo.IsNullOrEmpty
(
    @Param NVARCHAR(255)
)
RETURNS BIT
AS
BEGIN
    -- If the parameter is NULL or empty, return 1 (invalid)
    IF @Param IS NULL OR @Param = ''
    BEGIN
        RETURN 1;
    END

    -- If the parameter is neither NULL nor empty, return 0 (valid)
    RETURN 0;
END
GO
