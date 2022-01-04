SELECT * INTO TechM FROM (
SELECT 
	sales
	, CAST(
		CONCAT(year, '-',month,'-','1') AS DATE
		) AS date
FROM [dbo].[SalesTechM]
) as TM

SELECT *
FROM [dbo].[TechM]

DROP TABLE dbo.TechMSales

