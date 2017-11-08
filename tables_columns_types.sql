select 
t.name as table_name
,c.name as column_name
,ty.name [type_name]
from sys.tables t
inner join sys.columns c on t.object_id = c.object_id
inner join sys.types ty on c.user_type_id = ty.user_type_id 
where ty.name = 'text' or ty.name = 'ntext' or ty.name = 'image'