
--Connected to QDSDemo



----Create table to store data

--if exists(select top 1 1 from sys.tables where name='Tperf')
--begin
--	drop table Tperf;
--end
--go

--Create table Tperf
--(
--	id int identity(1,1) primary key,
--	Name varchar(100),
--	Age int,
--	BirthDate datetime
--);
--go

--set nocount on;

--Insert Data
--declare @rows int =300000
--declare @i int =1
--declare @batchr int = 50000

--while @i<=@rows
--begin

--	if ((@i%@batchr)=1)
--		begin tran

--	insert into Tperf (Name,Age,BirthDate)
--	values
--	(
--		'Name'+cast(@i as varchar(100)),
--		cast((rand()*40+18) as int),
--		getdate()
--	)

--	if ((@i%@batchr)=0)
--		commit tran
--	set @i=@i+1
--end
--go 2



----Add some special values
--insert into Tperf (Name,Age,BirthDate)
--	values
--	(
--		'Z',
--		17,
--		dateadd(year,-1,getdate())
--	)

----create indexes

--drop index ix_Name on Tperf
--create index ix_Name on Tperf(Name)


--Include execution plan
--Q1
Select Name,Age
from Tperf
where name like 'Z%'
order by Age asc


--Q2
Select Name,Age
from Tperf
where name like 'N%'
order by Age asc


drop procedure GetUsersByName

create procedure GetUsersByName @Name varchar(100)
as
Select top 5 Name,age
from Tperf
where name like ''+@Name+'%'
order by age asc
go

--
set statistics io on
set statistics time on

--date

--Z
exec GetUsersByName @Name='Z'

--N
exec GetUsersByName @Name='N'

--N
exec GetUsersByName @Name='N' with recompile



--Test1 -> Parameter sniffing
--test2 -> 2 different plans. Drop an Index






