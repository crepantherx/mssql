SELECT [Name]
FROM Production.Product
WHERE ListPrice =
    (SELECT ListPrice
     FROM Production.Product
     WHERE [Name] = 'Chainring Bolts' )
