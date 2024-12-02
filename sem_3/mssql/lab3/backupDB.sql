USE passman;
GO

BACKUP DATABASE passman
TO DISK = 'c:\tmp\SQLTestDB.bak'
   WITH FORMAT,
      MEDIANAME = 'passman.Backup',
      NAME = 'Full Backup of passman database';
GO
