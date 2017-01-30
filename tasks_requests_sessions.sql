
select 

t.task_state
, t.session_id
, t.request_id
, dm_es.login_time
, dm_r.start_time request_start_time
, dm_r.status
, dm_r.command
, dm_es.cpu_time
, dm_es.total_elapsed_time
,dm_es.logical_reads
, dm_es.host_name
,dm_t.text
,dm_qp.query_plan
 from sys.dm_os_tasks t
INNER JOIN sys.dm_exec_requests dm_r ON t.session_id = dm_r.session_id
INNER JOIN sys.dm_exec_sessions dm_es ON dm_es.session_id = dm_r.session_id
CROSS APPLY sys.dm_exec_sql_text (dm_r.sql_handle) dm_t
CROSS APPLY sys.dm_exec_query_plan (dm_r.plan_handle) dm_qp
WHERE dm_es.is_user_process = 1
and dm_r.session_id <> @@spid


