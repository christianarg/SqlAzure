select req.session_id
, req.request_id
, req.cpu_time
, req.total_elapsed_time
, req.wait_time
, req.logical_reads
, req.writes
, req.reads
, req.start_time
, req.status
, req.command
, st1.text
, qp.query_plan
, req.connection_id
, req.wait_type
, req.last_wait_type
, req.wait_resource
, req.open_transaction_count
, req.open_resultset_count
, req.database_id 
, s.[host_name]
, s.[program_name]
, s.client_interface_name
, qp.query_plan
from sys.dm_exec_requests req
inner JOIN sys.dm_exec_sessions AS s ON req.session_id = s.session_id 
CROSS APPLY sys.dm_exec_sql_text(req.sql_handle) as st1
CROSS APPLY sys.dm_exec_query_plan(req.plan_handle) AS qp
where req.session_id <> @@spid
order by req.cpu_time desc