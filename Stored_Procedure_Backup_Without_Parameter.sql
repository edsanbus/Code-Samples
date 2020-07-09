USE TSQL2012;
GO

DECLARE @databasename AS NVARCHAR(128);
SET @databasename = (SELECT MIN(name) FROM sys.databases WHERE name NOT IN ('master', 'model', 'msdb', 'tempdb', 'ReportServer', 'ReportServerTempDB'));
WHILE @databasename IS NOT NULL
BEGIN
	PRINT @databasename;
	SET @databasename = (SELECT MIN(name) FROM sys.databases WHERE name NOT IN ('master', 'model', 'msdb', 'tempdb','ReportServer', 'ReportServerTempDB') AND name > @databasename);
END
GO

SELECT CONVERT(NVARCHAR, GETDATE(), 120)
SELECT REPLACE(REPLACE(REPLACE(CONVERT(NVARCHAR, GETDATE(),120), ' ', '_'),':',''), '_', '');
GO

IF OBJECT_ID(N'dbo.BackupDatabase', N'P') IS NOT NULL DROP PROCEDURE dbo.BackupDatabases
GO

 CREATE PROCEDURE dbo.BackupDatabase
AS
BEGIN
	DECLARE @databasename AS NVARCHAR(128), @timecomponent AS NVARCHAR(50), @sqlcommand AS NVARCHAR(1000);
	SET @databasename = (SELECT MIN(name) FROM sys.databases WHERE name NOT IN ('master', 'model', 'msdb', 'tempdb', 'ReportServer', 'ReportServerTempDB'))
	WHILE @databasename IS NOT NULL
	BEGIN
		SET @timecomponent = REPLACE(REPLACE(REPLACE(CONVERT(NVARCHAR, GETDATE(),120), ' ', '_'),':',''), '_', '');
		SET @sqlcommand = 'BACKUP DATABASE ' + @databasename + 'TO DISK = ''C:\Backup\' + @databasename + '_' + @timecomponent + '.bak''';
		PRINT @sqlcommand;
		--EXEC(@sqlcommand);
		SET @databasename = (SELECT MIN(name) FROM sys.databases WHERE name NOT IN ('master', 'model', 'msdb', 'tempdb','ReportServer', 'ReportServerTempDB') AND name > @databasename);
	END;
	RETURN;
END;
GO

EXECUTE dbo.BackupDatabase;