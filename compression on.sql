/*
SELECT o.[name], o.[object_id ], c.[object_id ], c.[name], t.[name]
from sys.all_columns c
INNER JOIN sys.all_objects o
	ON c.object_id = o.object_id
INNER JOIN sys.types t
	ON c.system_type_id = t.system_type_id
WHERE c.system_type_id IN (35, 165, 99, 34, 173)
	AND o.[name] NOT LIKE 'sys%'
	AND o.[name] <> 'dtproperties'
	AND o.[type] = 'U'
	and o.name like 'KMCOLLECTIONTEMPLATE'
	
go
--ALTER TABLE [dbo].[KMCOLLECTIONTEMPLATE] REBUILD WITH (DATA_COMPRESSION=ROW);
--35 - text
--165 - varbinary
--99 - ntext
--34 - image
--173 - binary

ALTER TABLE PURCHLINEFOREIGNTRADECATEGORYHISTORY -- 14gb data 46 indexy 3min 41s
REBUILD WITH (DATA_COMPRESSION = ROW);


--inventsumlogtts --30gb data 12gb indeksy 8min 13s


SET NOCOUNT ON

SELECT top 100 
   --'ALTER TABLE [' + s.[name] + '].[' + o.[name] + '] REBUILD WITH (DATA_COMPRESSION=ROW);'
   --,
   *
FROM sys.objects AS o WITH (NOLOCK)
INNER JOIN sys.indexes AS i WITH (NOLOCK)
   ON o.[object_id] = i.[object_id]
INNER JOIN sys.schemas AS s WITH (NOLOCK)
   ON o.[schema_id] = s.[schema_id]
INNER JOIN sys.dm_db_partition_stats AS ps WITH (NOLOCK)
   ON i.[object_id] = ps.[object_id]
inner join sys.partitions p
	ON p.object_id = o.object_id
	and p.index_id = i.index_id
AND ps.[index_id] = i.[index_id]
WHERE o.[type] = 'U'
	AND o.[name] NOT LIKE 'sys%'
	AND o.[name] <> 'dtproperties'
	--AND p.data_compression = 0
	and o.name = 'PURCHLINEFOREIGNTRADECATEGORYHISTORY'
and not EXISTS( SELECT 1
		from sys.all_columns cc
		INNER JOIN sys.all_objects oo
			ON cc.object_id = oo.object_id
		WHERE cc.system_type_id IN (35, 165, 99, 34, 173)
			AND o.[type] = 'U'
			and oo.object_id = o.object_id)
ORDER BY ps.[reserved_page_count]
SET NOCOUNT OFF
*/
-- kompresja na heap i cluster
SELECT [t].[name] AS [Table], [p].[partition_number] AS [Partition],
    [p].[data_compression_desc] AS [Compression]
	,'ALTER TABLE [' + s.[name] + '].[' + t.[name] + '] REBUILD WITH (DATA_COMPRESSION=ROW);'
FROM [sys].[partitions] AS [p]
INNER JOIN sys.tables AS [t] ON [t].[object_id] = [p].[object_id]
INNER JOIN sys.schemas AS s ON t.[schema_id] = s.[schema_id]
WHERE [p].[index_id] in (0,1)
and data_compression = 0
and not EXISTS( 
	SELECT 1
	from sys.all_columns cc
	INNER JOIN sys.all_objects oo ON cc.object_id = oo.object_id
	WHERE cc.system_type_id IN (35, 165, 99, 34, 173)
		AND t.[type] = 'U'
		and oo.object_id = t.object_id
)

-- kompresja na nonklaster
SELECT [t].[name] AS [Table], [i].[name] AS [Index],  
    [p].[partition_number] AS [Partition],
    [p].[data_compression_desc] AS [Compression]
	,'ALTER INDEX '+ i.name +' ON '+ t.name +' REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = ROW);'
FROM [sys].[partitions] AS [p]
INNER JOIN sys.tables AS [t] ON [t].[object_id] = [p].[object_id]
INNER JOIN sys.indexes AS [i] ON [i].[object_id] = [p].[object_id] AND [i].[index_id] = [p].[index_id]
WHERE 
	[p].[index_id] > 1
	AND p.data_compression = 0
	and not EXISTS( 
		SELECT 1
		from sys.all_columns cc
		INNER JOIN sys.all_objects oo ON cc.object_id = oo.object_id
		WHERE cc.system_type_id IN (35, 165, 99, 34, 173)
			AND t.[type] = 'U'
			and oo.object_id = t.object_id
	)