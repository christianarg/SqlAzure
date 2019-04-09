SELECT
  convert(date, rsi.end_time) [date],
  avg(rs.avg_duration) avg_duration,
  avg( rs.avg_rowcount) avg_rowcount,
  avg(rs.count_executions) count_executions
FROM sys.query_store_query_text AS qt   
JOIN sys.query_store_query AS q   
    ON qt.query_text_id = q.query_text_id   
JOIN sys.query_store_plan AS p   
    ON q.query_id = p.query_id   
JOIN sys.query_store_runtime_stats AS rs   
    ON p.plan_id = rs.plan_id   
JOIN sys.query_store_runtime_stats_interval AS rsi   
    ON rsi.runtime_stats_interval_id = rs.runtime_stats_interval_id  
WHERE [rsi].[end_time] > DATEADD(DAY, -14, GETUTCDATE()) 
GROUP BY convert(date, rsi.end_time)
ORDER BY convert(date, [rsi].[end_time]) DESC


