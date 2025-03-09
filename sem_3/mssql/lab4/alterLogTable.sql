-- Modify Logs table to include additional information
ALTER TABLE Logs
ADD
    -- Name of the affected table
    AffectedTable NVARCHAR(255),
    -- Number of records affected
    RecordCount INT;
