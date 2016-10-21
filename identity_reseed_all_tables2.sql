
SET NOCOUNT ON
 
DECLARE @lcl_name VARCHAR(100)
DECLARE @identity_reseed nVARCHAR(MAX)

 
DECLARE cur_name CURSOR FOR

SELECT 
  [table] = t.name
FROM sys.schemas AS s
INNER JOIN sys.tables AS t
  ON s.[schema_id] = t.[schema_id]
WHERE EXISTS 
(
  SELECT 1 FROM sys.identity_columns
    WHERE [object_id] = t.[object_id]
);

OPEN cur_name
FETCH NEXT FROM cur_name INTO @lcl_name
WHILE @@Fetch_status = 0
BEGIN
set @identity_reseed = 'DBCC CHECKIDENT(' + @lcl_name + ',RESEED)'
execute sp_executesql @identity_reseed
print @identity_reseed

--  EXEC (@lcl_name )
FETCH NEXT FROM cur_name INTO @lcl_name
END
CLOSE cur_name
DEALLOCATE cur_name
SET NOCOUNT OFF 