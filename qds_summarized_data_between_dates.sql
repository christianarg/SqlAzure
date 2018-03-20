SELECT TOP 50
start_time,
end_time,
avg(avg_duration) avg_duration,
avg(count_executions) avg_executions,
sum(count_executions) total_executions

 --rs.avg_duration,
 --qt.query_sql_text,   
 --q.query_id, 
 --qt.query_text_id, 
 --p.plan_id,
 --rs.runtime_stats_id, 
 --rsi.start_time, 
 --rsi.end_time, 
 --rs.avg_rowcount, 
 --rs.count_executions  
FROM sys.query_store_query_text AS qt   
JOIN sys.query_store_query AS q   
    ON qt.query_text_id = q.query_text_id   
JOIN sys.query_store_plan AS p   
    ON q.query_id = p.query_id   
JOIN sys.query_store_runtime_stats AS rs   
    ON p.plan_id = rs.plan_id   
JOIN sys.query_store_runtime_stats_interval AS rsi   
    ON rsi.runtime_stats_interval_id = rs.runtime_stats_interval_id  
WHERE rsi.start_time between '2018-02-22 16:00' and '2018-02-26 17:00'
group by start_time, end_time
ORDER BY start_time DESC;  


