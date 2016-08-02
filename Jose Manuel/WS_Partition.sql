-- ====================================
-- Creamos la base de datos. 
-- ====================================
CREATE DATABASE dbPartition (EDITION = 'standard', SERVICE_OBJECTIVE ='S3' )

-- ====================================
-- Creamos la función de partición.
-- ====================================
CREATE PARTITION FUNCTION PF_HASH_BY_VALUE (BIGINT) AS RANGE LEFT 
FOR VALUES (100000, 200000, 300000, 400000, 500000, 600000, 700000, 800000, 900000)

SELECT * FROM sys.partition_functions

-- ====================================
-- Creamos el schema
-- ====================================
CREATE PARTITION SCHEME PS_HASH_BY_VALUE 
AS PARTITION PF_HASH_BY_VALUE
ALL TO ([PRIMARY]);
GO

SELECT * FROM sys.partition_schemes

-- ====================================
-- Probamos como sería la distribución
-- ====================================
SELECT 
  MY_VALUE,
  $PARTITION.PF_HASH_BY_VALUE(MY_VALUE) AS HASH_IDX
FROM 
(
 VALUES 
   (1),
   (100001), 
   (200001), 
   (300001), 
   (400001), 
   (500001), 
   (600001), 
   (700001), 
   (800001), 
   (900001)
) AS TEST (MY_VALUE);
GO

-- ====================================
-- Creamos la tabla y añadidmos datos y revisamos su distribución
-- ====================================

CREATE TABLE [TBL_PARTITION] 
( [MY_VALUE] [bigint] NOT NULL,
  CONSTRAINT [PK_TBL_PARTITION] PRIMARY KEY CLUSTERED ([MY_VALUE] ASC)
) ON PS_HASH_BY_VALUE ([MY_VALUE])

insert into [TBL_PARTITION] (my_value) values(100001)
insert into [TBL_PARTITION] (my_value) values(200001) 
insert into [TBL_PARTITION] (my_value) values(300001) 
insert into [TBL_PARTITION] (my_value) values(400001) 
insert into [TBL_PARTITION] (my_value) values(500001) 
insert into [TBL_PARTITION] (my_value) values(600001) 
insert into [TBL_PARTITION] (my_value) values(700001) 
insert into [TBL_PARTITION] (my_value) values(800001) 
insert into [TBL_PARTITION] (my_value) values(900001)

insert into [TBL_PARTITION] (my_value) values(100002)
insert into [TBL_PARTITION] (my_value) values(200002) 
insert into [TBL_PARTITION] (my_value) values(300002) 
insert into [TBL_PARTITION] (my_value) values(400002) 
insert into [TBL_PARTITION] (my_value) values(500002) 
insert into [TBL_PARTITION] (my_value) values(600002) 
insert into [TBL_PARTITION] (my_value) values(700002) 
insert into [TBL_PARTITION] (my_value) values(800002) 
insert into [TBL_PARTITION] (my_value) values(900002)

SELECT 
  MY_VALUE,
  $PARTITION.PF_HASH_BY_VALUE(MY_VALUE) AS HASH_IDX
FROM 
( SELECT MY_VALUE FROM [TBL_PARTITION] )  AS TEST (MY_VALUE);

-- ====================================
-- Cómo estamos de particionado.
-- ====================================
SELECT object_name(object_id),* FROM sys.dm_db_partition_stats where object_name(object_id)='TBL_PARTITION'