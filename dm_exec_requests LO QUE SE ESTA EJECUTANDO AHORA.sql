select req.session_id
, req.request_id
, req.start_time
, req.status,req.command
,st1.text
, qp.*
, req.cpu_time
,req.logical_reads
, req.writes
,req.reads
, req.connection_id
,req.wait_time
,req.last_wait_type
,req.wait_resource
,req.open_transaction_count
,req.open_resultset_count,
 req.database_id 
from sys.dm_exec_requests req
OUTER APPLY sys.dm_exec_sql_text(req.sql_handle) as st1
CROSS APPLY sys.dm_exec_query_plan(req.plan_handle) AS qp


--select req.*, st1.text from sys.dm_exec_requests req
--OUTER APPLY sys.dm_exec_sql_text(sql_handle) as st1

