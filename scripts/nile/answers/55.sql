CREATE PROCEDURE HumanResources.uspGetEmployeesTest2   
    @LastName nvarchar(50),   
    @FirstName nvarchar(50)   
AS   
    SET NOCOUNT ON;  
    SELECT FirstName, LastName, Department  
    FROM [HumanResources].[EmployeeDepartmentHistory]
    WHERE FirstName = @FirstName AND LastName = @LastName  
    AND EndDate IS NULL; 

--execute
EXECUTE HumanResources.uspGetEmployeesTest2 'Ackerman', 'Pilar'; 
