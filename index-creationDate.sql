SELECT STATS_DATE(OBJECT_ID('MyTable'), 
(SELECT index_id FROM sys.indexes WHERE name = 'Index_Name'))