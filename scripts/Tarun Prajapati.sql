---------DAY 1

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


------------------------------Temp table---------------------------------------------
--local
CREATE TABLE #temp(id INT, name NVARCHAR(25))

INSERT INTO #temp VALUES(1,'ram'),(2,'shyam'),(3,'raju'),(4,'joe')

SELECT * FROM #temp

---global
CREATE TABLE ##temp(id INT, name NVARCHAR(25))

INSERT INTO ##temp VALUES(1,'ram'),(2,'shyam'),(3,'raju'),(4,'jay')

SELECT * FROM ##temp

-----------------------------day2

Create table countries ( country nvarchar(50),city nvarchar(50))

Insert into countries values('USA','New York')
insert into countries values('USA','Housten')
Insert into countries values('USA','Dalias')
insert into countries values('India','Hydrabad')
Insert into countries values('India','Banglore')
Insert into countries values('India','New Delhi')
Insert into countries values('UK','London')
Insert into countries values('UK','Birmingham')
Insert into countries values('UK','Manchester')
insert into countries values('india','chennai')
select * from countries
go
select * from countries;

WITH cte AS(
select country,city1,city2,city3,city4
from 
(Select country,city, 'City'+ cast(ROW_NUMBER() over(partition by country order by country)as nvarchar(50)) as columsequence
from countries ) temp
pivot
(
max(city) for columsequence in (city1,city2,city3,city4)
)piv
)
--SELECT * FROM cte;
--SELECT USA, India, UK
--FROM countries
--PIVOT(
--	MAX(city) FOR country IN (USA, India, UK)
--)piv

SELECT country, city_no, city 
FROM cte
UNPIVOT(
	city 
	FOR city_no IN (city1, city2, city3, city4)
) P


--------------------Error handling

---raiserror

SELECT *
FROM Employee.employees.employees;

CREATE PROC find_emp 
@emp VARCHAR(30)
AS 
BEGIN
	IF(@emp IN (SELECT name FROM Employee.employees.employees ))
		BEGIN
		SELECT * FROM Employee.employees.employees
		WHERE name = @emp
		END
	ELSE
		BEGIN
		RAISERROR('name not in table!',16,1)
		END
END

EXEC find_emp @emp = 'eorgi'


---------@@error


CREATE TABLE temp(
id INT PRIMARY KEY,
name VARCHAR(25) 
)

INSERT INTO temp
VALUES(1, 'ram'),(2, 'shyam')


INSERT INTO temp
VALUES(1,'joy')

SELECT * FROM temp

IF @@ERROR <> 0
	PRINT 'error!'
ELSE
	PRINT 'all good'

-----------Try Catch

BEGIN TRY
	INSERT INTO temp
	VALUES(1,'joy')
END TRY
BEGIN CATCH
	SELECT
		ERROR_MESSAGE() AS msg,
		ERROR_NUMBER() AS num,
		ERROR_LINE() AS error_line
END CATCH


---------------------------Transactions

BEGIN TRY
	BEGIN TRANSACTION
		INSERT INTO temp
		VALUES(3, 'chotu')

		--INSERT INTO temp        ---error line
		--VALUES(2, 'jim')
	COMMIT TRANSACTION
	PRINT 'Transaction committed'
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	PRINT 'Error! transaction roll back'
END CATCH

SELECT * FROM temp

------------------------------------------------------------Day 3

SELECT * FROM temp

INSERT INTO temp
VALUES(5,NULL)

ALTER TABLE temp
WITH NOCHECK ADD CONSTRAINT n CHECK(name IS NOT NULL)


----------------------subquery & correlated subquery

SELECT * 
FROM Employee.employees.employees

SELECT * 
FROM Employee.employees.dept_emp

---------subquery
SELECT * 
FROM Employee.employees.employees 
WHERE emp_no IN (SELECT DISTINCT emp_no FROM Employee.employees.dept_emp )

--------correlated subquery
SELECT * 
FROM Employee.employees.employees e
WHERE emp_no IN (SELECT DISTINCT emp_no FROM Employee.employees.dept_emp WHERE from_date = e.hire_date )


-------------------------------Cursor

DECLARE t_cursor CURSOR FOR
SELECT * FROM temp

OPEN t_cursor

DECLARE @c_id INT
DECLARE @c_name VARCHAR(25)
FETCH NEXT FROM t_cursor INTO @c_id, @c_name

WHILE(@@FETCH_STATUS = 0)
BEGIN
	PRINT CAST(@c_id AS NVARCHAR(5)) + '-' + @c_name
	FETCH NEXT FROM t_cursor INTO @c_id, @c_name
END

CLOSE t_cursor
DEALLOCATE t_cursor

--------------------------------
SELECT * FROM sys.tables
---------------------------------

IF OBJECT_ID('temp') IS NULL
BEGIN
	CREATE TABLE temp(
		id INT,
		name NVARCHAR(50)
	)
END
ELSE
BEGIN
	PRINT 'Table already exists!'
END

--------------------------------------------Merge
SELECT * FROM temp
SELECT * FROM source

CREATE TABLE source(
	id INT,
	name NVARCHAR(30)
)

INSERT INTO source
VALUES(2,'sam'),(1,'ram'),(5,'rahul')


MERGE temp AS t
USING source AS s
	ON t.id = s.id
WHEN MATCHED THEN
	UPDATE SET t.name = s.name
WHEN NOT MATCHED BY TARGET THEN
	INSERT (id,name) VALUES(s.id,s.name)
WHEN NOT MATCHED BY SOURCE THEN
 DELETE;
 
-------------------------------------------

SET TRAN ISOLATION LEVEL READ UNCOMMITTED 
SELECT * FROM temp (NOLOCK)

-------------------------------------------------------------------------Day3

CREATE DATABASE Employee1

CREATE TABLE employees(
	emp_no INT PRIMARY KEY,
	birth_date DATE NOT NULL,
	first_name NVARCHAR(14) NOT NULL,
	last_name NVARCHAR(16) NOT NULL,
	gender NVARCHAR(1) NOT NULL CHECK(gender IN ('F','M')),
	hire_date DATE	NOT NULL
)

SELECT * FROM employees

CREATE TABLE salaries(
	emp_no INT NOT NULL FOREIGN KEY REFERENCES employees(emp_no),
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	CONSTRAINT Pk_salaries_emp_no PRIMARY KEY(emp_no, from_date)
)

CREATE TABLE titles(
	emp_no INT FOREIGN KEY REFERENCES employees(emp_no),
	titles NVARCHAR(50),
	from_date DATE,
	to_date DATE,
	CONSTRAINT PK_titles_emp_no PRIMARY KEY(emp_no, titles,from_date)
)

CREATE TABLE departments(
	dept_no NVARCHAR(4) PRIMARY KEY,
	dept_name NVARCHAR(40) NOT NULL
)

CREATE TABLE dept_emp(
	emp_no INT FOREIGN KEY REFERENCES employees(emp_no),
	dept_no NVARCHAR(4) FOREIGN KEY REFERENCES departments(dept_no),
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	CONSTRAINT PK_dept_no_emp_no PRIMARY KEY(emp_no, dept_no)
)

CREATE TABLE dept_manager(
	dept_no NVARCHAR(4) FOREIGN KEY REFERENCES departments(dept_no),
	emp_no INT FOREIGN KEY REFERENCES employees(EMP_NO),
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	CONSTRAINT PK_emp_no_dept_no PRIMARY KEY(dept_no,emp_no)
)

DROP TABLE dept_manager

SP_HELP salaries

-------------------------------------------------------------------nth salary

SELECT * FROM Employee.employees.salaries

SELECT TOP 1 salary
FROM
(
SELECT DISTINCT TOP 2 salary                -----nth
FROM Employee.employees.salaries
ORDER BY salary DESC
) result
ORDER BY salary

------------------------------row_number

WITH cte AS(
	SELECT TOP 20 e.emp_no, s.salary, e.gender
	FROM Employee.employees.employees e
	JOIN Employee.employees.salaries s
	ON e.emp_no = s.emp_no
)

SELECT emp_no, salary, gender,
	ROW_NUMBER() OVER(PARTITION BY gender 
						ORDER BY salary DESC)
FROM cte

CREATE TABLE #temp(
	name NVARCHAR(25),
	salary INT,
	gender NVARCHAR(1)
)

INSERT INTO #temp
VALUES('ram',1000,'M'),('chinki',1000,'F'),('pinky',1000,'F'),('chintu',2000,'M'),('viru',1000,'M'),('sam',800,'M')

SELECT name, salary, gender,
	ROW_NUMBER() OVER(PARTITION BY gender 
						ORDER BY salary DESC) row
FROM #temp

SELECT name, salary, gender,
	RANK() OVER(PARTITION BY gender 
						ORDER BY salary DESC) rank
FROM #temp

SELECT name, salary, gender,
	DENSE_RANK() OVER(PARTITION BY gender 
						ORDER BY salary DESC) d_rank
FROM #temp

SELECT name, salary, gender,
	NTILE(2) OVER(PARTITION BY gender 
						ORDER BY salary DESC) ntile
FROM #temp