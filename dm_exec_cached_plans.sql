select count(*) dm_exec_cached_plans from sys.dm_exec_cached_plans

select cp.*,t.text from sys.dm_exec_cached_plans cp
CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) AS t 

select sum(CAST( size_in_bytes AS BIGINT ))/1024/1024 size_in_mb from sys.dm_exec_cached_plans