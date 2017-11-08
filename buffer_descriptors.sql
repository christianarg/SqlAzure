--https://www.sqlshack.com/insight-into-the-sql-server-buffer-cache/
SELECT
COUNT(*) * 8 / 1024 AS mb_used
FROM sys.dm_os_buffer_descriptors
where database_id = 5
