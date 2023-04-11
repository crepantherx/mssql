SELECT LastName, FirstName
FROM Person.Person
WHERE BusinessEntityID IN
        (SELECT BusinessEntityID
         FROM Sales.SalesPerson)
    
