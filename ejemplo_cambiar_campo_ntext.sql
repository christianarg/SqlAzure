alter table Table_1 add textoaux nvarchar(50)
 
go
 
update Table_1 set textoaux = texto
 
 --(opcional en caso de que Text sea not null)
alter table Table_1 alter column textoaux nvarchar(50) not null
 
go

 
alter table Table_1 drop column texto
 
go
exec sp_RENAME 'Table_1.textoaux', 'texto' , 'COLUMN'
