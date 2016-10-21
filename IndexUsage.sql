SELECT  OBJECT_NAME(ddius.[object_id], ddius.database_id) AS [object_name] ,        
        ddius.index_id ,
    i.[name] AS [index_name],
        ddius.user_seeks ,
        ddius.user_scans ,
        ddius.user_lookups ,
        ddius.user_seeks + ddius.user_scans + ddius.user_lookups 
                                                     AS user_reads ,
        ddius.user_updates AS user_writes ,
        ddius.last_user_scan ,
        ddius.last_user_update
FROM    sys.dm_db_index_usage_stats ddius
 INNER JOIN sys.indexes i ON ddius.[object_id] = i.[object_id]
                                     AND i.[index_id] = ddius.[index_id]
WHERE   ddius.database_id > 4 -- filter out system tables
        AND OBJECTPROPERTY(ddius.OBJECT_ID, 'IsUserTable') = 1
        AND ddius.index_id > 0  -- filter out heaps      
ORDER BY ddius.user_scans DESC
