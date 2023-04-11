SELECT DISTINCT c.LastName, c.FirstName, e.BusinessEntityID
FROM Person.Person AS c 
JOIN HumanResources.Employee AS e ON e.BusinessEntityID = c.BusinessEntityID
WHERE 5000.00 IN
    (SELECT Bonus
    FROM Sales.SalesPerson sp
    WHERE e.BusinessEntityID = sp.BusinessEntityID) 
