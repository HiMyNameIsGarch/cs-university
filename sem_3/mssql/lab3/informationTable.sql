DROP PROCEDURE IF EXISTS GetInformationAboutTable;
GO

CREATE PROCEDURE GetInformationAboutTable
(
    @TableName nvarchar(128)
)
AS BEGIN

    SELECT
        c.name AS ColumnName,
        t.name AS DataType,
        c.max_length AS MaxLength,
        c.precision,
        c.scale,
        c.is_nullable AS IsNullable,
        c.is_identity AS IsIdentity,
        c.default_object_id AS DefaultConstraint
    FROM sys.columns c
    INNER JOIN sys.tables t ON c.object_id = t.object_id
    WHERE t.name = @TableName AND SCHEMA_NAME(t.schema_id) = 'dbo'
    ORDER BY c.column_id;

END;
GO

EXEC GetInformationAboutTable @TableName = 'Users';

