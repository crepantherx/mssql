SELECT BusinessEntityID, TerritoryID   
   ,DATEPART(yy,ModifiedDate) AS SalesYear  
   ,SalesYTD 
   ,SUM(SalesYTD) OVER (PARTITION BY TerritoryID  ORDER BY DATEPART(yy,ModifiedDate)) AS CumulativeTotal  
FROM Sales.SalesPerson  
WHERE TerritoryID IS NULL OR TerritoryID < 5  
ORDER BY TerritoryID,SalesYear