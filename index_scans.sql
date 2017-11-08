select 

t.name table_name
,  i.name index_name
, i.type_desc
, ius.user_scans
, s.used_page_count
, ius.*

from sys.dm_db_index_usage_stats ius
inner join  sys.indexes i on i.object_id = ius.object_id and i.index_id = ius.index_id
inner join sys.tables t on t.object_id =  i.object_id
inner join sys.dm_db_partition_stats AS s on i.object_id = s.object_id and i.index_id = s.index_id
--order by s.used_page_count desc, ius.user_scans desc
order by (s.used_page_count * ius.user_scans) desc


