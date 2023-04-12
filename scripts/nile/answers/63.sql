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

SELECT DISTINCT CAST(Name AS CHAR(10)) AS Name,
    ListPrice
FROM Production.Product
WHERE Name LIKE 'Long-Sleeve Logo Jersey, M';

SELECT p.FirstName,
    p.LastName,
    s.SalesYTD,
    s.BusinessEntityID
FROM Person.Person AS p
INNER JOIN Sales.SalesPerson AS s
    ON p.BusinessEntityID = s.BusinessEntityID
WHERE CAST(CAST(s.SalesYTD AS INT) AS CHAR(20)) LIKE '2%';

--date time cast
SELECT GETDATE() AS UnconvertedDateTime,
    CAST(GETDATE() AS NVARCHAR(30)) AS UsingCast,
    CONVERT(NVARCHAR(30), GETDATE(), 126) AS UsingConvertTo_ISO8601;

DECLARE @d1 DATE,
    @t1 TIME,
    @dt1 DATETIME;

SET @d1 = GETDATE();
SET @t1 = GETDATE();
SET @dt1 = GETDATE();
SET @d1 = GETDATE();

-- When converting date to datetime the minutes portion becomes zero.
SELECT @d1 AS [DATE],
    CAST(@d1 AS DATETIME) AS [date as datetime];

-- When converting time to datetime the date portion becomes zero
-- which converts to January 1, 1900.
SELECT @t1 AS [TIME],
    CAST(@t1 AS DATETIME) AS [time as datetime];

-- When converting datetime to date or time non-applicable portion is dropped.
SELECT @dt1 AS [DATETIME],
    CAST(@dt1 AS DATE) AS [datetime as date],
    CAST(@dt1 AS TIME) AS [datetime as time];

DECLARE @d1 DATE, @dt1 DATETIME , @dt2 DATETIME2

SET @d1 = '1492-08-03'
--This is okay; Minimum YYYY for DATE is 0001

SET @dt2 = CAST(@d1 AS DATETIME2)
--This is okay; Minimum YYYY for DATETIME2 IS 0001

SET @dt1 = CAST(@d1 AS DATETIME)
--This will error with (Msg 242) "The conversion of a date data type to a datetime data type resulted in an out-of-range value."
--Minimum YYYY for DATETIME is 1753

--Effects of data type precedence in allowed conversions

DECLARE @string VARCHAR(10);
SET @string = 1;
SELECT @string + ' is a string.' AS Result

DECLARE @notastring INT;
SET @notastring = '1';
SELECT @notastring + ' is not a string.' AS Result

--parse,try-cast,try_convert,try_parse is not covered in this documentation