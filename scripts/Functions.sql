-------------Funstions

-------------------Scalar

ALTER FUNCTION MINUS(@num INT)
RETURNS INT
AS
BEGIN 
RETURN (-@num)
END

SELECT Practice.dbo.minus(2)


CREATE FUNCTION age(@dob DATE)
RETURNS INT
AS 
BEGIN
DECLARE @age INT
SET @age = DATEDIFF(YEAR, @dob, GETDATE())
RETURN @age
END

SELECT *,Practice.dbo.age(birth_date) age
FROM Employee.employees.employees

Sp_helptext 

------------inline


CREATE FUNCTION under_age(@u_age INT)
RETURNS TABLE
AS
RETURN(
	SELECT *,practice.dbo.age(birth_date) age
	FROM Employee.employees.employees
	WHERE practice.dbo.age(birth_date) < @u_age
)

SELECT * FROM Employee.dbo.under_age(58)

-------------------------multi-statement

CREATE FUNCTION age_above(@u_age INT)
RETURNS @tbl TABLE (emp_no INT, name NVARCHAR(30), age INT)
AS
BEGIN
	INSERT INTO @tbl
	SELECT emp_no, name, practice.dbo.age(birth_date) age
	FROM Employee.employees.employees
	WHERE practice.dbo.age(birth_date) > @u_age
RETURN 
END

SELECT * FROM Employee.dbo.age_above(60)


------------------------------Temp table
--local
CREATE TABLE #temp(id INT, name NVARCHAR(25))

INSERT INTO #temp VALUES(1,'ram'),(2,'shyam'),(3,'raju'),(4,'joe')

SELECT * FROM #temp

---global
CREATE TABLE ##temp(id INT, name NVARCHAR(25))

INSERT INTO ##temp VALUES(1,'ram'),(2,'shyam'),(3,'raju'),(4,'jay')

SELECT * FROM ##temp