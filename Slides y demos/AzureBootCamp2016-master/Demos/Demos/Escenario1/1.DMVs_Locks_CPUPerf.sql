------------ Locks Workload --------------
/*

create database DMVsDemos
(SERVICE_OBJECTIVE = 'S3', MAXSIZE=100GB)


*/

--Connected to DMVsDemos

if exists (select top 1 1 from sys.tables where name='LockTable')
begin
	drop table LockTable;
end
go

create table dbo.LockTable
(
	id int identity(1,1),
	c1 int,
	c2 varchar(100),
	TimeMark datetime
);


-- Insert some data in Lock Tables

Insert into dbo.LockTable (c1,c2,TimeMark)
values
(2,'Not updated',getdate()),
(3,'Not updated',getdate()),
(4,'Not updated',getdate()),
(5,'Not updated',getdate()),
(6,'Not updated',getdate()),
(7,'Not updated',getdate()),
(8,'Not updated',getdate()),
(9,'Not updated',getdate())
go

-- Lock simulation
--Tran1
begin tran
	select * 
	from dbo.LockTable with(holdlock) -- Hold the lock for demo purposes
	where c1=7

	waitfor delay '00:00:30'
commit

--tran2
begin tran
	update dbo.LockTable
	set c2='Updated C2'
	where c1=7
commit




