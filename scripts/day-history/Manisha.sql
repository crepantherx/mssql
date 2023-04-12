
-----------------------------------------------DAY=1------------------------------------------------------------------------------------------
----WITH OUTPUT PARAMETER

CREATE PROCEDURE SPemployeeCountBygender
@Gender nvarchar(10),
@EmployeeCount int Output
AS
BEGIN
	SELECT @EmployeeCount = COUNT(emp_no) 
	FROM Employee.employees.employees
	WHERE gender=@Gender
END

DECLARE @EmployeeCount int
EXEC SPemployeeCountBygender 'M',@EmployeeCount Output
Print @EmployeeCount


SELECT * 
FROM Employee.employees.employees

------------ RETURN VALUES

CREATE PROCEDURE SPemployeeCount2
AS
BEGIN
	RETURN(SELECT COUNT(emp_no) 
	FROM Employee.employees.employees)
END

DECLARE @TotalCount int
EXECUTE @TotalCount = SPemployeeCount2
SELECT @TotalCount

-- RETURN VALUE WITH INPUT PARAMETER

CREATE PROCEDURE SPemployeeCount3
@Gender nvarchar(10)
AS
BEGIN
	RETURN
		(SELECT COUNT(emp_no) 
		FROM Employee.employees.employees
		WHERE Gender = @Gender)
END

DECLARE @TotalCount int
EXECUTE @TotalCount = SPemployeeCount3 'M'
PRINT  @TotalCount

-- RETURN DOES WORK WITH ONLY ONE VALUES OUTPUT AND INT DATATYPE

ALTER PROCEDURE SPEmployeesalary
AS
BEGIN
	RETURN(
			SELECT 
				name
			FROM Employee.employees.employees
			WHERE emp_no=10001
			)		
END


DECLARE @EmpName nvarchar(30)
EXECUTE @EmpName = SPEmployeesalary
PRINT @EmpName

------------------------------------------------DAY=2-----------------------------------------------------------------------------

CREATE TABLE TEST.dbo.Marks
(
  Subject VARCHAR(15)
, Name VARCHAR(12)
, Makrs INT
)

INSERT INTO TEST.dbo.Marks VALUES
  ('English','Subham',23)
, ('English','Charu',45)
, ('English','Arnav',67)
, ('English','Harry',78)
, ('Maths','Subham',54)
, ('Maths','Arnav',32)
, ('Maths','Harry',72)
, ('Hindi','Harry',85)
, ('Hindi','Harry',80)
, ('Hindi','Harry',68)
, ('Maths','Cahru',58)
, ('Hindi','Charu',18)
, ('Science','Subham',28)
, ('Science','Arnav',38)
, ('Science','Charu',58)

DROP TABLE TEST.dbo.Marks


SELECT *
FROM
(
	SELECT 
	   Subject
	 , Name
	 , Makrs 
	FROM TEST.dbo.Marks
) StudentMarks
PIVOT (
	  SUM(Makrs)
	  FOR Name
	  IN (Subham
		, Charu
		, Arnav
		, cahru
		, Harry
		)
) AS PivotTable

SELECT *
FROM PivotTable
SELECT *
FROM TEST.dbo.Marks




----WITH OUTPUT PARAMETER

CREATE PROCEDURE SPemployeeCountBygender
@Gender nvarchar(10),
@EmployeeCount int Output
AS
BEGIN
	SELECT @EmployeeCount = COUNT(emp_no) 
	FROM Employee.employees.employees
	WHERE gender=@Gender
END

DECLARE @EmployeeCount int
EXEC SPemployeeCountBygender 'M',@EmployeeCount Output
Print @EmployeeCount


SELECT * 
FROM Employee.employees.employees

------------ RETURN VALUES

CREATE PROCEDURE SPemployeeCount2
AS
BEGIN
	RETURN(SELECT COUNT(emp_no) 
	FROM Employee.employees.employees)
END

DECLARE @TotalCount int
EXECUTE @TotalCount = SPemployeeCount2
SELECT @TotalCount

-- RETURN VALUE WITH INPUT PARAMETER

CREATE PROCEDURE SPemployeeCount3
@Gender nvarchar(10)
AS
BEGIN
	RETURN
		(SELECT COUNT(emp_no) 
		FROM Employee.employees.employees
		WHERE Gender = @Gender)
END

DECLARE @TotalCount int
EXECUTE @TotalCount = SPemployeeCount3 'M'
PRINT  @TotalCount

-- RETURN DOES WORK WITH ONLY ONE VALUES OUTPUT AND INT DATATYPE

ALTER PROCEDURE SPEmployeesalary
AS
BEGIN
	RETURN(
			SELECT 
				name
			FROM Employee.employees.employees
			WHERE emp_no=10001
			)		
END


DECLARE @EmpName nvarchar(30)
EXECUTE @EmpName = SPEmployeesalary
PRINT @EmpName


------------------------------------------------DAY=3----------------------------------------------------------------------------------------------

WITH EMPLOYEECOUNT (emp_no,Salary,Rnk)
AS
(
   SELECT 
		s.emp_no
	  , s.salary
	  , DENSE_RANK() OVER(PARTITION BY s.emp_no ORDER BY s.salary DESC) AS Rk
    FROM Employee.employees.salaries AS s
) 
SELECT *
FROM Employee.employees.employees as e
JOIN EMPLOYEECOUNT as emp
ON emp.emp_no = e.emp_no
WHERE Rnk =1

------------------------------------------------------------

WITH EmployeeCountGender
AS
(
   SELECT 
	  s.emp_no
	, max(s.salary) AS Max_Salary
	FROM Employee.employees.salaries as s
	GROUP BY s.emp_no
) 
SELECT 
	 e.emp_no
   , e.gender
   , e.name
   , e.sur_name
   , emp.Max_Salary
FROM Employee.employees.employees as e
JOIN EmployeeCountGender as emp
ON emp.emp_no = e.emp_no

-----------------------------------------------------------------------------

WITH EmployeeCountGender
AS
(
   SELECT 
	  s.emp_no
	, max(s.salary) AS Max_Salary
	FROM Employee.employees.salaries as s
	GROUP BY s.emp_no
) 
SELECT 
	 e.emp_no
   , e.gender
   , e.name
   , e.sur_name
   , emp.Max_Salary
FROM Employee.employees.employees as e
JOIN EmployeeCountGender as emp
ON emp.emp_no = e.emp_no



----WITH OUTPUT PARAMETER

CREATE PROCEDURE SPemployeeCountBygender
@Gender nvarchar(10),
@EmployeeCount int Output
AS
BEGIN
	SELECT @EmployeeCount = COUNT(emp_no) 
	FROM Employee.employees.employees
	WHERE gender=@Gender
END

DECLARE @EmployeeCount int
EXEC SPemployeeCountBygender 'M',@EmployeeCount Output
Print @EmployeeCount


SELECT * 
FROM Employee.employees.employees

------------ RETURN VALUES

CREATE PROCEDURE SPemployeeCount2
AS
BEGIN
	RETURN(SELECT COUNT(emp_no) 
	FROM Employee.employees.employees)
END

DECLARE @TotalCount int
EXECUTE @TotalCount = SPemployeeCount2
SELECT @TotalCount

-- RETURN VALUE WITH INPUT PARAMETER

CREATE PROCEDURE SPemployeeCount3
@Gender nvarchar(10)
AS
BEGIN
	RETURN
		(SELECT COUNT(emp_no) 
		FROM Employee.employees.employees
		WHERE Gender = @Gender)
END

DECLARE @TotalCount int
EXECUTE @TotalCount = SPemployeeCount3 'M'
PRINT  @TotalCount

-- RETURN DOES WORK WITH ONLY ONE VALUES OUTPUT AND INT DATATYPE

ALTER PROCEDURE SPEmployeesalary
AS
BEGIN
	RETURN(
			SELECT 
				name
			FROM Employee.employees.employees
			WHERE emp_no=10001
			)		
END


DECLARE @EmpName nvarchar(30)
EXECUTE @EmpName = SPEmployeesalary
PRINT @EmpName




-----------------------------------DAY=4---------------------------------------------------------------------------------------------------------

CREATE DATABASE Task

CREATE SCHEMA emp 

CREATE TABLE Task.emp.employee
(
  emp_no INT CONSTRAINT PK_employee_emp_no PRIMARY KEY
, birth_date DATE
, first_name VARCHAR(14)
, last_name VARCHAR(16)
, gender VARCHAR(3) CONSTRAINT CK_employee_gender CHECK(gender IN('F','M'))
, hire_date DATE
)


CREATE TABLE Task.emp.departments
(
  dept_no CHAR(4) CONSTRAINT PK_dept PRIMARY KEY
, dept_name VARCHAR(40)
)


--DROP TABLE Task.emp.dept_emp

CREATE TABLE Task.emp.dept_emp
(
  emp_no INT CONSTRAINT FK_dept_emp FOREIGN KEY REFERENCES Task.emp.employee(emp_no)
, dept_no CHAR(4) CONSTRAINT FK_dept_emp_dept FOREIGN KEY REFERENCES Task.emp.departments(dept_no)
, from_date DATE
, to_date DATE
)


CREATE TABLE Task.emp.dept_manager
(
  dept_no CHAR(4) CONSTRAINT FK_dept_manager_dept FOREIGN KEY REFERENCES Task.emp.departments(dept_no)
, emp_no INT CONSTRAINT FK_dept_manager_emp FOREIGN KEY REFERENCES Task.emp.employee(emp_no)
, from_date DATE
, to_date DATE
)


CREATE TABLE Task.emp.salaries
(
  emp_no INT CONSTRAINT FK_salaries_emp FOREIGN KEY REFERENCES Task.emp.employee(emp_no)
, salary INT 
, from_date DATE CONSTRAINT PK_salaries PRIMARY KEY
, to_date DATE
)


CREATE TABLE Task.emp.titles
(
  emp_no INT CONSTRAINT FK_titles_emp FOREIGN KEY REFERENCES Task.emp.employee(emp_no)
, title VARCHAR(50)
, from_date DATE
, to_date DATE
, CONSTRAINT PK_Composite_key PRIMARY KEY(title,from_date)
)






