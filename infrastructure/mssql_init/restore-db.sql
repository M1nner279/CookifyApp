USE [master];
GO
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'CookifyDb')
BEGIN
    RESTORE DATABASE [CookifyDb]
    FROM DISK = '/var/opt/mssql/backup/database.bak'
    WITH MOVE 'CookifyDb' TO '/var/opt/mssql/data/CookifyDb.mdf',
         MOVE 'CookifyDb_log' TO '/var/opt/mssql/data/CookifyDb_log.ldf',
         REPLACE, STATS = 5;
END
GO