/*

NESTED JOIN
MERGE JOIN
HASH JOIN


*/
52 Deck				52 Deck
	4H			
	3S
	




SELECT *
FROM Employee.dbo.A as A
INNER JOIN Employee.dbo.A as B 
ON A.id = B.id










SET STATISTICS IO, TIME OFF

SELECT *
FROM Employee.employees.employees AS E
JOIN Employee.employees.dept_emp AS D
ON E.emp_no = D.emp_no


GO

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES

DECLARE ABC CURSOR FOR 
SELECT TABLE_NAME AS tbl
FROM INFORMATION_SCHEMA.TABLES

DECLARE @T VARCHAR(10)
declare @query nvarchar(500)

OPEN ABC
	FETCH NEXT FROM ABC INTO @T
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		set @query = 'SELECT COUNT(*) FROM Employee.employees.[' + @T + ']'
		EXEC sp_executesql @query
		FETCH NEXT FROM ABC INTO @T
	END
CLOSE ABC




declare @query nvarchar(500)
set @query = 'SELECT * FROM Employee.employees.[' + 'employees' + ']'
EXEC sp_executesql @query