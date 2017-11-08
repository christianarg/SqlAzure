-- añadir nuevo campo auxiliar
alter table SampleTable add Id1 nvarchar(50)
 
go

-- rellenar con datos del campo actual
update SampleTable set Id1 = Id
 
 -- (opcional) si el campo no es nulable establecerlo
alter table SampleTable alter column Id1 nvarchar(50) not null
 
go
 
-- eliminar el campo antiguo
alter table [SampleTable] drop column Id
 
go

-- renombrar el campo viejo para que se llame como el antiguo
exec sp_RENAME 'SampleTable.Id1', 'Id' , 'COLUMN'