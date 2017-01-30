select req.session_id
, req.request_id
,req.wait_time
, req.start_time
, req.status,req.command
,st1.text
, qp.*
, req.cpu_time
,req.logical_reads
, req.writes
,req.reads
, req.connection_id
,req.last_wait_type
,req.wait_resource
,req.open_transaction_count
,req.open_resultset_count,
 req.database_id 
 , s.host_name
from sys.dm_exec_requests req
inner JOIN sys.dm_exec_connections AS c ON req.connection_id = c.connection_id
inner JOIN sys.dm_exec_sessions AS s
ON c.session_id = s.session_id 
CROSS APPLY sys.dm_exec_sql_text(req.sql_handle) as st1
CROSS APPLY sys.dm_exec_query_plan(req.plan_handle) AS qp
where req.session_id <> @@spid
--and s.host_name = 'PRODWEB04'

--select req.*, st1.text from sys.dm_exec_requests req
--OUTER APPLY sys.dm_exec_sql_text(sql_handle) as st1


--select * from sys.dm_exec_connections
