-- total_cpu (acumulado)
SELECT TOP 25 
qs.query_hash
, qs.creation_time
, qs.last_execution_time
, qs.execution_count
, case
	when DATEDIFF(minute, qs.creation_time, qs.last_execution_time) > 0 
		then
			 qs.execution_count / DATEDIFF(minute, qs.creation_time, qs.last_execution_time) 
		else
			-1
end as executions_per_minute
, qs.total_worker_time as total_cpu_time
, qs.max_worker_time as max_cpu_time
, (qs.total_worker_time / qs.execution_count) / 1000 avg_cpu_time_ms
, qs.total_elapsed_time
, qs.max_elapsed_time
, (qs.total_elapsed_time / qs.execution_count) / 1000 avg_elapsed_time_ms
, qs.total_logical_reads
, qs.max_logical_reads
, qs.total_logical_reads / qs.execution_count / 1000 avg_logical_reads
, qs.total_physical_reads
, qs.max_physical_reads
, qs.total_dop
, qs.max_dop
, qs.last_dop
, qs.total_dop / qs.execution_count avg_dop
, t.[text]
, qp.query_plan
FROM sys.dm_exec_query_stats qs 
CROSS APPLY sys.dm_exec_sql_text(plan_handle) AS t 
CROSS APPLY sys.dm_exec_query_plan(plan_handle) AS qp 
ORDER BY qs.total_worker_time DESC, qs.last_execution_time DESC
--ORDER by (qs.total_worker_time / qs.execution_count) DESC -- MUY DURO
--ORDER BY qs.last_execution_time DESC
--ORDER BY qs.max_worker_time DESC, qs.last_execution_time DESC
