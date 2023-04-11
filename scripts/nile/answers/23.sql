SELECT Ord.SalesOrderID, Ord.OrderDate,
    (SELECT MAX(oDet.UnitPrice)
     FROM Sales.SalesOrderDetail AS oDet
     WHERE Ord.SalesOrderID = oDet.SalesOrderID) AS MaxUnitPrice
FROM Sales.SalesOrderHeader AS Ord
