/*
    Obtains spaced used data for ALL user tables in the database
*/
DECLARE @TableName VARCHAR(100)    --For storing values in the cursor

--Cursor to get the name of all user tables from the sysobjects listing
DECLARE tableCursor CURSOR
FOR 
select [name]
from dbo.sysobjects 
where  OBJECTPROPERTY(id, N'IsUserTable') = 1
FOR READ ONLY

--A procedure level temp table to store the results
CREATE TABLE #TempTable
(
    tableName varchar(100),
    numberofRows varchar(100),
    --reservedSize varchar(50),
    dataSizeInMb decimal(10,2)
    --indexSize varchar(50),
    --unusedSize varchar(50)
)

--Open the cursor
OPEN tableCursor

--Get the first table name from the cursor
FETCH NEXT FROM tableCursor INTO @TableName

--Loop until the cursor was not able to fetch
WHILE (@@Fetch_Status >= 0)
BEGIN
    --Dump the results of the sp_spaceused query to the temp table
    INSERT  #TempTable
        select sys.objects.name,sys.dm_db_partition_stats.row_count, Convert(nvarchar,Convert(decimal(10,2),sum(reserved_page_count) * 8.0 / 1024))
        from sys.dm_db_partition_stats, 
             sys.objects 
        where sys.dm_db_partition_stats.object_id = sys.objects.object_id and
            sys.objects.name = @TableName
        group by sys.objects.name, sys.dm_db_partition_stats.row_count

    --Get the next table name
    FETCH NEXT FROM tableCursor INTO @TableName
END

--Get rid of the cursor
CLOSE tableCursor
DEALLOCATE tableCursor

--Select all total
SELECT sum(dataSizeInMb) as TotalSizeInMb
FROM #TempTable

--Select all records so we can use the results
SELECT * 
FROM #TempTable order by dataSizeInMb desc

--Final cleanup!
DROP TABLE #TempTable
GO


