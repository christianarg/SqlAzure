SELECT
  s.session_id
  ,s.login_time
  ,s.host_name
  ,s.program_name
  ,s.login_name
  ,s.status
  ,s.cpu_time
  ,s.memory_usage
  ,s.total_scheduled_time
  ,s.total_elapsed_time
  ,s.last_request_start_time
  ,s.last_request_end_time
  ,s.reads   writes
  ,s.logical_reads
  ,st1.text
  , c.*
FROM sys.dm_exec_connections AS c
JOIN sys.dm_exec_sessions AS s
ON c.session_id = s.session_id
OUTER APPLY sys.dm_exec_sql_text(c.most_recent_sql_handle) as st1
order by c.num_reads desc