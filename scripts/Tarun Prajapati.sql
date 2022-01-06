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