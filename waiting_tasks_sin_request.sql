SELECT top 100 
dm_ws.*,
dm_es.status,
dm_es.cpu_time,
dm_es.memory_usage,
dm_es.logical_reads,
dm_es.total_elapsed_time,
dm_es.client_interface_name,
dm_es.last_request_start_time,
dm_es.last_request_end_time,
dm_es.login_name,
dm_es.host_name,
dm_t.text
FROM sys.dm_os_waiting_tasks dm_ws
LEFT JOIN sys.dm_exec_sessions dm_es ON dm_es.session_id = dm_ws.session_id
LEFT JOIN sys.dm_exec_connections AS c on c.session_id = dm_es.session_id 
CROSS APPLY sys.dm_exec_sql_text (c.most_recent_sql_handle) dm_t
order by wait_duration_ms desc