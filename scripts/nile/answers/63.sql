DECLARE @myval DECIMAL(5, 2);
SET @myval = 193;

SELECT CAST(CAST(@myval AS VARBINARY(20)) AS DECIMAL(10, 5)) AS castCol;

-- Or, using CONVERT
SELECT CONVERT(DECIMAL(10, 5), CONVERT(VARBINARY(20), @myval)) AS convertCol;

SELECT CAST(10.6496 AS INT) AS trunc1,
       CAST(-10.6496 AS INT) AS trunc2,
       CAST(10.6496 AS NUMERIC) AS round1,
       CAST(-10.6496 AS NUMERIC) AS round2;

SELECT CAST(10.3496847 AS money);

SELECT SUBSTRING(Name, 1, 30) AS ProductName,
    ListPrice
FROM Production.Product
WHERE CAST(ListPrice AS INT) LIKE '33%';

SELECT SUBSTRING(Name, 1, 30) AS ProductName,
    ListPrice
FROM Production.Product
WHERE CONVERT(INT, ListPrice) LIKE '33%';

--example shows a resulting expression that is too small to display
SELECT p.FirstName,
    p.LastName,
    SUBSTRING(p.Title, 1, 25) AS Title,
    CAST(e.SickLeaveHours AS CHAR(1)) AS [Sick Leave]
FROM HumanResources.Employee e
INNER JOIN Person.Person p
    ON e.BusinessEntityID = p.BusinessEntityID
WHERE NOT e.BusinessEntityID > 5;

SELECT CAST(ROUND(SalesYTD / CommissionPCT, 0) AS INT) AS Computed
FROM Sales.SalesPerson
WHERE CommissionPCT != 0;

SELECT 'The list price is ' + CAST(ListPrice AS VARCHAR(12)) AS ListPrice
FROM Production.Product
WHERE ListPrice BETWEEN 350.00 AND 400.00;