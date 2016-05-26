select 
    obj.name, 
    idx.name,
    parts.index_id, 
    parts.partition_id, 
    parts.hobt_id, 
    all_units.allocation_unit_id, 
    all_units.type_desc, 
    all_units.total_pages
from sys.objects obj
  inner join sys.partitions parts on obj.object_id = parts.object_id
  inner join sys.allocation_units all_units on all_units.container_id = parts.hobt_id
  inner join sys.indexes idx on parts.index_id = idx.index_id and obj.object_id = idx.object_id
where obj.name = ''