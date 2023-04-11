SELECT [Name]
FROM Sales.Store
WHERE BusinessEntityID NOT IN
    (SELECT CustomerID
     FROM Sales.Customer AS c
     JOIN Sales.SalesTerritory AS t ON c.TerritoryID=t.TerritoryID
     WHERE t.[Name]='Southeast' AND t.[Group]='North America')

SELECT * FROM Sales.SalesTerritory