USE passman;
GO

BACKUP DATABASE passman
TO DISK = '/var/opt/mssql/data/passman.bak'
   WITH FORMAT,
      MEDIANAME = 'passman.Backup',
      NAME = 'Full Backup of passman database';
GO
