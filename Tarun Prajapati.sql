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



-------------------------------------------------Day-2

--------------------------pivot and unpivot

WITH cte AS(
SELECT Monthly_sales year, month, sale
FROM Practice.dbo.sales
UNPIVOT(
    sale
    for month IN (January, February)
)
GO)


--SELECT * FROM cte


SELECT year, January, February
FROM  cte 
PIVOT(
    SUM(sale) 
    FOR month 
    IN ([January], [February]) 
)
GO;



SELECT * FROM #temp

SELECT * FROM ##temp

-----------------------------

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