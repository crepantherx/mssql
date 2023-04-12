-- calculate the salary percentile for each employee within a given department.
SELECT Department, LastName, Rate,   
       CUME_DIST () OVER (PARTITION BY Department ORDER BY Rate) AS CumeDist,   
       PERCENT_RANK() OVER (PARTITION BY Department ORDER BY Rate ) AS PctRank  
FROM HumanResources.vEmployeeDepartmentHistory AS edh  
    INNER JOIN HumanResources.EmployeePayHistory AS e    
    ON e.BusinessEntityID = edh.BusinessEntityID  
WHERE Department IN ('Information Services','Document Control')   
ORDER BY Department, Rate DESC;  

--return the name of the product that is the least expensive in a given product category.
SELECT Name, ListPrice,
       FIRST_VALUE(Name) OVER (ORDER BY ListPrice ASC) AS LeastExpensive
FROM Production.Product
WHERE ProductSubcategoryID = 37;

--eturns the hire date of the last employee in each department for the given salary (Rate)
SELECT Department
    , LastName
    , Rate
    , HireDate
    , LAST_VALUE(HireDate) OVER (
        PARTITION BY Department ORDER BY Rate
        ) AS LastValue
FROM HumanResources.vEmployeeDepartmentHistory AS edh
INNER JOIN HumanResources.EmployeePayHistory AS eph
    ON eph.BusinessEntityID = edh.BusinessEntityID
INNER JOIN HumanResources.Employee AS e
    ON e.BusinessEntityID = edh.BusinessEntityID
WHERE Department IN ('Information Services', 'Document Control');

--return the difference in sales quotas for a specific employee over previous years.
SELECT BusinessEntityID, YEAR(QuotaDate) AS SalesYear, SalesQuota AS CurrentQuota,   
       LAG(SalesQuota, 1,0) OVER (ORDER BY YEAR(QuotaDate)) AS PreviousQuota  
FROM Sales.SalesPersonQuotaHistory  
WHERE BusinessEntityID = 275 AND YEAR(QuotaDate) IN ('2011','2012'); 

--compare year-to-date sales between employees.
SELECT TerritoryName, BusinessEntityID, SalesYTD,   
       LAG (SalesYTD, 1, 0) OVER (PARTITION BY TerritoryName ORDER BY SalesYTD DESC) AS PrevRepSales  
FROM Sales.vSalesPerson  
WHERE TerritoryName IN ('Northwest', 'Canada')   
ORDER BY TerritoryName; 

--return the difference in sales quotas for a specific employee over previous calendar quarters
SELECT BusinessEntityID,QuotaDate, SalesQuota AS SalesQuota,  
       LAG(SalesQuota,1,0) OVER (ORDER BY QuotaDate) AS PrevQuota,  
       SalesQuota - LAG(SalesQuota,1,0) OVER (ORDER BY QuotaDate) AS Diff  
FROM Sales.SalesPersonQuotaHistory 
WHERE  Year(QuotaDate) IN (2011, 2012)  
ORDER BY QuotaDate;

--return the difference in sales quotas for a specific employee over subsequent years
SELECT BusinessEntityID, YEAR(QuotaDate) AS SalesYear, SalesQuota AS CurrentQuota,   
    LEAD(SalesQuota, 1,0) OVER (ORDER BY YEAR(QuotaDate)) AS NextQuota  
FROM Sales.SalesPersonQuotaHistory  
WHERE BusinessEntityID = 275 AND YEAR(QuotaDate) IN ('2011','2012'); 

--compare year-to-date sales between employees. 
SELECT TerritoryName, BusinessEntityID, SalesYTD,   
       LEAD (SalesYTD, 1, 0) OVER (PARTITION BY TerritoryName ORDER BY SalesYTD DESC) AS NextRepSales  
FROM Sales.vSalesPerson  
WHERE TerritoryName IN ('Northwest', 'Canada')   
ORDER BY TerritoryName; 

-- difference in sales quota values for a specified employee over subsequent calendar quarters.
SELECT YEAR(QuotaDate) AS Year, SalesQuota AS SalesQuota,  
       LEAD(SalesQuota,1,0) OVER (ORDER BY QuotaDate) AS NextQuota,  
   SalesQuota - LEAD(SalesQuota,1,0) OVER (ORDER BY QuotaDate) AS Diff  
FROM Sales.SalesPersonQuotaHistory
WHERE BusinessEntityID = 276 AND YEAR(QuotaDate) IN (2011,2012)  
ORDER BY QuotaDate  

--find the median employee salary in each department
SELECT DISTINCT Name AS DepartmentName  
      ,PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY ph.Rate)   
                            OVER (PARTITION BY Name) AS MedianCont  
      ,PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY ph.Rate)   
                            OVER (PARTITION BY Name) AS MedianDisc  
FROM HumanResources.Department AS d  
INNER JOIN HumanResources.EmployeeDepartmentHistory AS dh   
    ON dh.DepartmentID = d.DepartmentID  
INNER JOIN HumanResources.EmployeePayHistory AS ph  
    ON ph.BusinessEntityID = dh.BusinessEntityID  
WHERE dh.EndDate IS NULL; 

