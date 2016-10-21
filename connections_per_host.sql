SELECT s.host_name, count(*) as count
FROM sys.dm_exec_connections AS c
JOIN sys.dm_exec_sessions AS s
ON c.session_id = s.session_id
group by s.host_name
order by  count(*) desc

select count(*) connections_count from sys.dm_exec_connections

select count(*) sessions_count from sys.dm_exec_sessions