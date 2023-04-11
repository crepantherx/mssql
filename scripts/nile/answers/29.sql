SELECT [Name]
FROM Production.Product
WHERE ProductSubcategoryID IN
    (SELECT ProductSubcategoryID
     FROM Production.ProductSubcategory
     WHERE [Name] = 'Wheels');

SELECT p.[Name]
FROM Production.Product p
JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID=ps.ProductSubcategoryID
WHERE ps.Name='Wheels'