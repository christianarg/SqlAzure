SELECT
sysprc.spid,
sysprc.waittime,
sysprc.lastwaittype,
DB_NAME(sysprc.dbid) AS database_name,
sysprc.cpu,
sysprc.physical_io,
sysprc.login_time,
sysprc.last_batch,
sysprc.status,
sysprc.hostname,
sysprc.[program_name],
sysprc.cmd,
sysprc.loginame,
OBJECT_NAME(sqltxt.objectid) AS [object_name],
sqltxt.text
FROM sys.sysprocesses sysprc
OUTER APPLY sys.dm_exec_sql_text(sysprc.sql_handle) sqltxt
where status <> 'sleeping'