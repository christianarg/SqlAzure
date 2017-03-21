SELECT   
  *
FROM sys.objects AS obj   
JOIN sys.stats stat ON stat.object_id = obj.object_id  
CROSS APPLY sys.dm_db_stats_properties(stat.object_id, stat.stats_id) AS sp  
