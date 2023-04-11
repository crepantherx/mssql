SELECT [Name], ListPrice,
(SELECT AVG(ListPrice) FROM Production.Product) AS Average,
    ListPrice - (SELECT AVG(ListPrice) FROM Production.Product)
    AS Difference
FROM Production.Product
WHERE ProductSubcategoryID = 1;

WITH cte(name,price,avg_price,psid)
AS(
SELECT [Name], ListPrice,AVG(ListPrice),ProductSubcategoryID
FROM Production.Product
GROUP BY ProductID
)
SELECT cte.name,cte.price,cte.avg_price,(cte.price-cte.avg_price) AS difference
FROM cte 
JOIN Production.ProductSubcategory ps ON cte.psid=ps.ProductSubcategoryID
WHERE ps.ProductSubcategoryID=1
