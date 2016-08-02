SELECT
  s.session_id
  ,st1.text
  --,s.login_time
  --,s.host_name
  --,s.program_name
  --,s.login_name
  ,s.status
  --,s.last_request_start_time
  ,s.last_request_end_time
  ,s.cpu_time
  ,s.memory_usage
  ,s.total_scheduled_time
  ,s.total_elapsed_time
  ,s.reads   writes
  ,s.logical_reads
  --, c.*
FROM sys.dm_exec_connections AS c
JOIN sys.dm_exec_sessions AS s
ON c.session_id = s.session_id
OUTER APPLY sys.dm_exec_sql_text(c.most_recent_sql_handle) as st1
where s.host_name <> 'zeus'
order by s.last_request_end_time desc


select getdate()