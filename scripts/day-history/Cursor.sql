
DECLARE emp CURSOR FOR
SELECT TOP 10 emp_no, name + ' ' + sur_name AS EmployeeName
FROM employees.employees



DECLARE @emp_no INT
DECLARE @name varchar(64)

OPEN emp
	FETCH NEXT FROM emp INTO @emp_no, @name
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		PRINT 'Employee ID: ' + CAST(@emp_no AS nvarchar(64)) + ' Name: ' + @name  
		FETCH NEXT FROM emp INTO @emp_no, @name
	END
CLOSE emp
DEALLOCATE emp

SET NOCOUNT ON
SET STATISTICS IO, TIME ON
SELECT name, emp_no
FROM employees.employees
WHERE  emp_no = 10003

GO

SELECT name, emp_no
FROM employees.employees
WHERE name='Parto'
