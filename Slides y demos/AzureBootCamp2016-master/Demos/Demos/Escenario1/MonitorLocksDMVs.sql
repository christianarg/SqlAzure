--Before starting. Custom Views For Azure
select * from Sys.dm_db_wait_stats
select * from Sys.dm_db_Resource_stats --info every 15 minutes

--more details: Connect to master
select * from sys.resource_stats
order by start_time desc

--LOCK DMVs

--Old fashion style
select * from sys.sysprocesses where blocked<>0

--new Style
Select
	session_id as blockedSession,
	blocking_session_id as BlockingSession,
	wait_duration_ms
from sys.dm_os_waiting_tasks
where blocking_session_id is not null

--more details
--Monitoring locks and duration
select
conn.session_id as blockerSession,
conn2.session_id as BlockedSession,
req.wait_time as Waiting_Time_ms,
cast((req.wait_time/1000.) as decimal(18,2)) as Waiting_Time_secs,
cast((req.wait_time/1000./60.) as decimal(18,2)) as Waiting_Time_mins,
t.text as BlockerQuery,
t2.text as BlockedQuery
from sys.dm_exec_requests as req
inner join sys.dm_exec_connections as conn
	on req.blocking_session_id=conn.session_id
inner join sys.dm_exec_connections as conn2
	on req.session_id=conn2.session_id
cross apply sys.dm_exec_sql_text(conn.most_recent_sql_handle) as t
cross apply sys.dm_exec_sql_text(conn2.most_recent_sql_handle) as t2



