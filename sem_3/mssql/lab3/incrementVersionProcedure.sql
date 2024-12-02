CREATE PROCEDURE IncrementDatabaseVersion
(
    -- parameter for the description
    @Description NVARCHAR(255) = NULL
)
AS
BEGIN
    -- check if the message is null
    IF @Description IS NULL OR LEN(@Description) = 0
    BEGIN
        RAISEERROR('Description must be provided.', 16, 1);
        RETURN 1;
    END;

    -- Increment version ( is this the best way to do it? )
    -- also is auto incremented so just put the description
    INSERT INTO DatabaseVersion (Description) VALUES (@Description);

    -- Get the current version
    DECLARE @CurrentVersion INT;
    SELECT @CurrentVersion = MAX(VersionID) FROM DatabaseVersion;

    -- Print the message to the console
    PRINT @Description + N'. Database version now at ' + Cast(@CurrentVersion AS NVARCHAR(10)) + N'.';
    RETURN 0;
END;
