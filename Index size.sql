sp_spaceused

create table #t
(
  name nvarchar(128),
  rows varchar(50),
  reserved varchar(50),
  data varchar(50),
  index_size varchar(50),
  unused varchar(50)
)

declare @id nvarchar(128)
declare c cursor for
select name from sysobjects where xtype='F'

open c
fetch c into @id

while @@fetch_status = 0 begin

  insert into #t
  exec sp_spaceused @id

  fetch c into @id
end

close c
deallocate c

select * from #t
order by convert(int, substring(data, 1, len(data)-3)) desc

drop table #t

select * from sysobjects

SELECT
    i.name                  AS IndexName,
    SUM(s.used_page_count) * 8   AS IndexSizeKB
FROM sys.dm_db_partition_stats  AS s 
JOIN sys.indexes                AS i
ON s.[object_id] = i.[object_id] AND s.index_id = i.index_id
WHERE s.[object_id] = object_id('dbo.TableName')
GROUP BY i.name
ORDER BY i.name

SELECT
    i.name              AS IndexName,
    SUM(page_count * 8) AS IndexSizeKB
FROM sys.dm_db_index_physical_stats(
    db_id(), object_id('dbo.TableName'), NULL, NULL, 'DETAILED') AS s
JOIN sys.indexes AS i
ON s.[object_id] = i.[object_id] AND s.index_id = i.index_id
GROUP BY i.name
ORDER BY i.name