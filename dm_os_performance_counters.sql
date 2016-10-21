SELECT *
  FROM sys.dm_os_performance_counters
  WHERE counter_name IN('Batch Requests/sec', 'SQL Compilations/sec', 'SQL Re-Compilations/sec')