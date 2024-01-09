
CREATE view [dbo].[grafana_offerpersstockdimid_view] as
select 
	ropd.RAPStockDimId as Name
	,count(*) as Total
	,count(case ro.status when 1 then 1 else null end) as Active
	,count(case ro.status when 2 then 1 else null end) as NotActive
	,count(case ro.status when 3 then 1 else null end) as Ended
	from ax63prod.dbo.RAPOFFERS as ro with (nolock) 
	join ax63prod.dbo.rapofferproduct as rop with (nolock) 
		on ro.recid = rop.OFFERREFRECID
		and ro.EXTERNALID = rop.EXTERNALID
		and ro.PARTITION = rop.PARTITION
		and ro.DATAAREAID = rop.DATAAREAID
	join ax63prod.dbo.rapofferproductdim ropd with (nolock)
		on rop.recid = ropd.RAPOFFERPRODUCTREFRECID
		and rop.PARTITION = ropd.PARTITION
		and rop.DATAAREAID = ropd.DATAAREAID
	where 
		ro.status < 6 
		and ro.PARTITION = 0 
		and ro.DATAAREAID = '---' 
group by 
	ropd.RAPStockDimId
GO


