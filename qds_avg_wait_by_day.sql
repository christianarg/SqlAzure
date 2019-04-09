SELECT TOP (100)
  convert(date, [rsi].[end_time]) [date],
  avg([ws].[avg_query_wait_time_ms]) avg_query_wait_time_ms,
  avg([ws].[total_query_wait_time_ms]) total_query_wait_time_ms
FROM [sys].[query_store_query_text] [qt]
JOIN [sys].[query_store_query] [q]
    ON [qt].[query_text_id] = [q].[query_text_id]
JOIN [sys].[query_store_plan] [qp] 
    ON [q].[query_id] = [qp].[query_id]
JOIN [sys].[query_store_runtime_stats] [rs] 
    ON [qp].[plan_id] = [rs].[plan_id]
JOIN [sys].[query_store_runtime_stats_interval] [rsi] 
    ON [rs].[runtime_stats_interval_id] = [rsi].[runtime_stats_interval_id]
JOIN [sys].[query_store_wait_stats] [ws]
    ON [ws].[runtime_stats_interval_id] = [rs].[runtime_stats_interval_id]
    AND [ws].[plan_id] = [qp].[plan_id]
WHERE [rsi].[end_time] > DATEADD(DAY, -14, GETUTCDATE()) 
AND [ws].[execution_type] = 0
GROUP BY convert(date, [rsi].[end_time]) 
ORDER BY convert(date, [rsi].[end_time])  DESC;