 select 
 t.name tableName,
 i.name indexName--, *
 from sys.indexes i 
 inner join sys.objects o on i.object_id = o.object_id
 inner join sys.tables t on t.object_id = i.object_id
 where o.type <> 'S'
 and i.name is not null