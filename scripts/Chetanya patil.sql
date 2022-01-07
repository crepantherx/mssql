
--------------------------------------------------------------------------DAY 1
--Difference Between Cast and Convert

--Syntax
cast(expression AS data_type [(length)]) as ConvertedDate
convert(data_type [(length)],expression,[style]) as convertedDate

SELECT GETDATE()

select year(getdate())

select cast(getdate() as nvarchar) as ConvertedDate;

select convert(nvarchar,getdate(),105) as ConvertedDate;     ----105 == dd-mm-yy


---CONVERT DATETIME TO DATE ONLY

SELECT GETDATE();
SELECT CAST(GETDATE() AS DATE) AS gettingDateOnly;
SELECT CONVERT(DATE, GETDATE(),105) AS gettingDateOnly;


------------------------------------------------------------------------DAY 2

--Ascii
SELECT ASCII('A')

--char
SELECT CHAR(65)

--char example
DECLARE @start int
set @start = 65
while(@start <= 90)
BEGIN
	PRINT CHAR(@start)
	SET @start = @start + 1
END

--LTRIM
SELECT LTRIM('  HELLO WORLD  ')
SELECT LEN(LTRIM('  HELLO WORLD  '))--------------------------LEN()
SELECT DATALENGTH(LTRIM('  HELLO WORLD  '))-------------------DATALENGTH()

--RTRIM
SELECT RTRIM('  HELLO WORLD  ')

--TRIM
SELECT TRIM('  HELLO WORLD  ')

--LOWER
SELECT LOWER('CHETANYA')

--UPPER
SELECT UPPER('chetanya')

--REVERSE
SELECT REVERSE('CHETANYA')

--LEFT
SELECT LEFT('Chetanya sanjay patil',4)

--RIGHT
SELECT RIGHT('Chetanya sanjay patil',4)

--CHARINDEX
SELECT CHARINDEX(' ','Chetanya sanjay patil',1) ---getting position

--SUBSTRING
SELECT SUBSTRING('Chetanya sanjay patil',charindex(' ','Chetanya sanjay patil',1),len('Chetanya sanjay patil')) --specifying middle name and surname

select * from sales.customers;

--Example of substring and charindex
select substring(email,charindex('@',email) + 1, len(email) - charindex('@',email)) as EmailDomain, count(email) as Total
from sales.customers
group by substring(email,charindex('@',email) + 1, len(email) - charindex('@',email));


--replicate function
select replicate('Biyani',4)

--mask the email with 4* (star) symbols
select first_name,last_name,
substring(email,1,2) + replicate('*',5) + substring(email,charindex('@',Email), len(Email) -charindex('@',Email)+1) as Email
from sales.customers;

--space
select first_name + space(3) + last_name from sales.customers;

--patternindex
select email,patindex('%@yahoo.com',email) as firstoccurences from sales.customers; ----Here We are using wildcard

--Replace
select email,replace(email,'yahoo','gamil') as replacecolumn from sales.customers;

--stuff
select email,stuff(email,2,3,'****') as replacestuff from sales.customers;



--DATE FORMAT

select getdate();
select CURRENT_TIMESTAMP;
select SYSDATETIME();
select SYSDATETIMEOFFSET()  --india is 5 hour 30 min ahead of utc timezone.
select GETUTCDATE()

--ISDATE Example
SELECT ISDATE('PRAGIN')-----------IS CHECKING FOR DATE
SELECT ISDATE(GETDATE())

--DAY, MONTH, YEAR
SELECT DAY(GETDATE());
SELECT MONTH(GETDATE());
SELECT YEAR(GETDATE());

--DateName function
SELECT DATENAME(DAY,GETDATE());
SELECT DATENAME(WEEKDAY,GETDATE());
SELECT DATENAME(MONTH,GETDATE());

--DATEPART
--DATEPART(DatePart,Date)
SELECT DATEPART(WEEKDAY,GETDATE());
SELECT DATEPART(MONTH,GETDATE());

--DATEADD(datepart,numberToAdd,date)
SELECT DATEADD(MONTH,1,GETDATE());

--DATEDIFF
SELECT DATEDIFF(MONTH,'1999-10-24','2022-1-4')
SELECT DATEDIFF(DAY,'1999-10-24','2022-1-4')


----Creating table for windows function
CREATE TABLE ForWindowsFunction
(
	id int,
	Name varchar(255),
	Gender varchar(255),
	Salary int
)

insert into ForWindowsFunction values
(1, 'Mark','Male',5000),
(2,'John','Male',4500),
(3,'Pam','Female',5500),
(4,'Sara','Female',4000),
(5,'Todd','Male',3500),
(6,'Mary','Female',5000),
(7,'Ben','Male',6500),
(8,'Jodi','Female',7000),
(9,'Tom','Male',5500),
(10,'Ron','Male',5000)

select * from ForWindowsFunction;

--GENDER COUNT, AVGSAL,MINSAL, MAXSAL
SELECT Gender,count(*) as GenderTotal, avg(Salary) as avgsalary, Min(Salary) as minsal, max(salary) as maxsal
from ForWindowsFunction
group by Gender;

--Now we want other column like Name and Salary of each employee also in output.
-----we will be getting error because we are trying to take some other columns which are not the part of group by or aggregate function.
SELECT Name,Salary,Gender,count(*) as GenderTotal, avg(Salary) as avgsalary, Min(Salary) as minsal, max(salary) as maxsal
from ForWindowsFunction
group by Gender;


--we are able to do it with joins too but the line of code will be more

--using over clause

SELECT Name,Salary,Gender,
COUNT(Gender) over(partition by Gender) As GendersTotal,
AVG(Salary) Over(partition by Gender) As AvgSal,
MIN(Salary) Over(partition by Gender) As MinSal,
MAX(Salary) Over(partition by Gender) As MaxSal
FROM ForWindowsFunction;

select * FROM ForWindowsFunction;


---Row_Number
SELECT Name,Gender,Salary,
ROW_NUMBER() OVER(ORDER BY Gender) as RowNumber
from ForWindowsFunction;

SELECT Name,Gender,Salary,
ROW_NUMBER() OVER(PARTITION BY Gender ORDER BY Gender) as RowNumber
from ForWindowsFunction;

--use case for row_number 
--for deleting duplicate rows--right down

with Employeecte AS
(
SELECT Name,Gender,Salary,
ROW_NUMBER() OVER(PARTITION BY Gender ORDER BY Gender) as RowNumber
from ForWindowsFunction
)
DELETE FROM Employeecte WHERE RowNumber > 1;


--Rank and dense rank
select Name,Gender,Salary,
RANK() OVER (ORDER BY Salary desc) as RankGiven,
DENSE_RANK() OVER( ORDER BY Salary desc) as DenseRankGiven
FROM ForWindowsFunction;


--LET DO WITH PARTITION BY
select Name,Gender,Salary,
RANK() OVER (Partition by Gender ORDER BY Salary desc) as RankGiven,
DENSE_RANK() OVER(Partition by Gender ORDER BY Salary desc) as DenseRankGiven
FROM ForWindowsFunction;

--After every new partition rank reset to one similar like row_number.

--use case for rank and dense_Rank
--for to find nth highest salary

with salcte as 
(
select Salary,DENSE_RANK() over(order by Salary DESC) AS Salary_Rank
From ForWindowsFunction
)
select Salary from salcte where Salary_Rank = 2;


--rank is not used to calculate the nth highest because rank skip the next rank if it got multiple records with data.

with salcte as 
(
select Salary,DENSE_RANK() over(Partition by Gender order by Salary DESC) AS Salary_Rank
From ForWindowsFunction
)
select Salary from salcte where Salary_Rank = 2 and Gender = 'Male';


--differnce between rank, dense_Rank, row_number

select Name,Salary,Gender,
row_number() over(order by Salary desc) as rowNumber,
rank() over(order by Salary desc) as rankorder,
dense_rank() over(order by Salary desc) as denserankorder
from ForWindowsFunction;

---table we used contains duplicate 


--calculating a running total

SELECT Name,Gender,Salary,
sum(Salary) over(order by id) as runningtotal
from ForWindowsFunction;

--running total on partition 
SELECT Name,Gender,Salary,
sum(Salary) over(partition by Gender order by id) as runningtotal
from ForWindowsFunction;

--why we are not using salary column in order by
SELECT Name,Gender,Salary,
sum(Salary) over(order by id) as runningtotal
from ForWindowsFunction;

--Using salary column in order by
SELECT Name,Gender,Salary,
sum(Salary) over(order by Salary) as runningtotal
from ForWindowsFunction;

--check the difference between above 2 query


--NTILE
--number of rows is divisible by number of groups
--larger rows group come first

SELECT * FROM ForWindowsFunction;

SELECT Name,Gender,Salary,
NTILE(2) OVER (ORDER BY Salary) as NtileColumn
from ForWindowsFunction;


SELECT Name,Gender,Salary,
NTILE(3) OVER (ORDER BY Salary) as NtileColumn
from ForWindowsFunction;

--using partition by in ntile
SELECT Name,Gender,Salary,
NTILE(3) OVER (partition by Gender ORDER BY Salary) as NtileColumn
from ForWindowsFunction;

--work on example of expensive product,moderate product,minimum product



----lead and lag

--lead(column_name,offset,default_value)
--lag(column_name,offset,default_value)

select Name,Gender, Salary,
lead(Salary) over (order by Salary) as nexsalary
from ForWindowsFunction;

select Name,Gender, Salary,
lag(Salary) over (order by Salary) as presalary
from ForWindowsFunction;

select Name,Gender, Salary,
lead(Salary) over (order by Salary) as nexsalary,
lag(Salary) over (order by Salary) as presalary
from ForWindowsFunction;


--default value for NULL
select Name,Gender, Salary,
lag(Salary,1,0) over (order by Salary) as presalary
from ForWindowsFunction;


--how to put any string value at place of default value as data type require here is int only ?


---FIRST_VALUE

--lowest paid salary
SELECT Name,Gender,Salary,
FIRST_VALUE(Name) over(order by Salary) as firstvalue
from ForWindowsFunction;

--lowest paid as per the paritition by  gender
SELECT Name,Gender,Salary,
FIRST_VALUE(Name) over(partition by Gender order by Salary) as firstvalue
from ForWindowsFunction;



--Windows Function in SQL SERVER
--AGGREGATE,RANKING,ANALYTIC FUNCTIONS..

--Default for rows and range clause
--range between unbounded preceding and current row


SELECT Name, Gender, Salary,
AVG(Salary) over(order by Salary) as AverageValue,
FROM ForWindowsFunction;

--default frame clause is use here 
--range between unbounded preceding and current row

--WE HAVE TO CHANGE THE FRAME CLAUSE TO GET A REQUIRED RESULT THAT COLUMN SHOULD SHOW AVG OF ALL RECORDS IN A PARTICULAR RECORD.

--Changing the frame clause
--rows between unbounded preceding and unounded following
SELECT Name, Gender, Salary,
AVG(Salary) over(order by Salary rows between unbounded preceding and unbounded following) as AverageValue
FROM ForWindowsFunction;

--HARDCODING THE VALUES
SELECT Name, Gender, Salary,
AVG(Salary) over(order by Salary rows between 1 preceding and 1 following) as AverageValue
FROM ForWindowsFunction;


--DIFFERENCE BETWEEN ROWS AND RANGE
--using range
with cte as
(
SELECT Name,Salary FROM ForWindowsFunction
)
select Name,Salary,sum(Salary) over (order by Salary range between unbounded preceding and current row) as runningTotal from cte;

--using rows
with cte as
(
SELECT Name,Salary FROM ForWindowsFunction
)
select Name,Salary,sum(Salary) over (order by Salary range between unbounded preceding and current row) as runningTotal from cte;


--Rows treat duplicates as distinct values, where as Range treats as a single entity.

--By using rows we get running total as expected.


---Last_value function

select * from ForWindowsFunction;

-- Giving name of the highest paid employee
select Name,Gender,Salary,
LAST_VALUE(Salary) over(order by Salary) as last_value
from ForWindowsFunction;

--But we didn't got expected result why ?

--because of the default frame clause
--we have to change the frame clause as per our need

select Name,Gender,Salary,
LAST_VALUE(Salary) over(order by Salary range between unbounded preceding and unbounded following) as last_value
from ForWindowsFunction;



-----------------------------------------------------------------------------------------DAY 3

---Transaction in sql server and Error Handling

/*
--Transaction processing follows these steps:
1. Begin a transaction
2. Process database commands
3. Check for errors
	 if errors occurred,
	   rollback the transaction
	 else,
		commit the transaction

Note: Not able to see the un-commited the changes
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

*/

CREATE TABLE tblPhysicalAddress(
Addressid int,
EmployeeNumber int,
HouseNumber int,
StreetAddress varchar(255),
city varchar(255),
postalcode varchar(255)
)

select * from tblPhysicalAddress

select * from tblMailingAddress

insert into tblPhysicalAddress values
(1,101,10,'kingstreet','london','cr27dw');

create table tblMailingAddress(
addressid int,
EmployeeNumber int,
HouseNumbere int,
StreetAddress varchar(255),
city varchar(255),
postalcode varchar(255));

insert into tblMailingAddress values
(1,101,10,'kingstreet','london','cr27dw');

select * from tblMailingAddress;
select * from tblPhysicalAddress;

go
Alter PROCEDURE spUodateAddress
AS
BEGIN
	BEGIN TRY
		BEGIN Transaction
			update tblMailingAddress set city = 'LONDON'
			WHERE addressid = 1 and EmployeeNumber = 101

			update tblPhysicalAddress set city = 'LONDON'
			WHERE addressid = 1 and EmployeeNumber = 101
		COMMIT TRANSACTION
		Print 'Transaction Completed'
	END TRY
	BEGIN CATCH
			ROLLBACK Transaction
			Print 'Transaction Rolled Back'
	END CATCH
END

exec spUodateAddress;


----ACID TEST Example in TRANSACTION

--ATOMIC
--CONSISTENT
--ISOLATION
--DURABILITY

CREATE TABLE tblProduct(
Productid int,
Name varchar(255),
unitPrice int,
QtyAvailable int);

insert into tblProduct values
(1,'Laptops',2340,90),
(2,'Desktops',3467,50);

CREATE TABLE tblProductSales1(
ProductSalesod int,
Productid int,
QuantitySold int);

insert into tblProductSales1 values
(1,1,10),
(2,1,10);

select * from tblProduct

go
CREATE Procedure spUpdateInventory_and_sell
AS
BEGIN
	BEGIN TRY
		BEGIN Transaction
			Update tblProduct
			set QtyAvailable = (QtyAvailable - 10)
			WHERE Productid = 1

			insert into tblProductSales1 values(3,1,10)
		COMMIT Transaction
	END TRY
	BEGIN CATCH
		Rollback Transaction
	END CATCH
END

Exec spUpdateInventory_and_sell



--isolation
select * from tblProduct;

BEGIN TRANSACTION
 UPDATE tblProduct SET QtyAvailable = 100 WHERE Productid = 1;



 -----------------------------SELECT INTO
 
Create table Employeesforselectinto
(
	id int,
	Name varchar(255),
	Gender varchar(255),
	Salary int,
	Deptid int
);

insert into Employeesforselectinto values
(1,'Mark','Male',50000,1),
(2,'Sara','Female',65000,2),
(3,'Mike','Male',48000,3),
(4,'Pam','Female',70000,1),
(5,'John','Male',55000,2)

select * from Employeesforselectinto;

--copy all rows and columns from an existing table into a new table
select * into EmployeesBackup from Employeesforselectinto;

select * from EmployeesBackup;
drop table EmployeesBackup;

--copy all rows and columns from an existing table into a new table in an external database
select * into BikeStores.dbo.EmployeesBackup from Employeesforselectinto;

select * from BikeStores.dbo.EmployeesBackup;
drop table BikeStores.dbo.EmployeesBackup;

--copy only selected columns into a new table
select * from Employeesforselectinto;

select id, Name,Gender INTO EmployeesBackup from Employeesforselectinto

select * from EmployeesBackup;
drop table EmployeesBackup;

--copy only selected rows into a new table
select * from Employeesforselectinto;

select * into EmployeesBackup from Employeesforselectinto where id = 1;

drop table EmployeesBackup;


 --Copy columns from 2 or more table into a new table
 

 select * into EmployeesBackup
 from Employeesforselectinto
 inner join tblDepartment
 on Employees.id = tblDepartment.Deptid

 select * from EmployeesBackup;
 drop table EmployeesBackup;

 --Create a new table wwhose columns and datatype match with an existing table
 select * into EmployeesBackup from dbo.Employeesforselectinto where 1 <> 1;

 --You cannot use select into statement to select data into an existing table
 select * into EmployeesBackup from Employees;

 ---Use INSERT INTO statement to select data into an existing table
 INSERT INTO EmployeesBackup
 select * from Employees



 ----Difference between where and Having
/*
   1. In having we are open to use aggreagate function but not in case of where.


   2. WHERE clause filters rows before aggregate calculations are performed where as 
      HAVING clause fiters rows after aggregate calculations are performed.
	  So from a performance standpoint, HAVING is slower than WHERE and should be avoided when possible.
*/
  

  ---intersec operator
  --retrievce common records from the both table

  create table intersecttable
  (
	id int,
	name varchar(255)
 );

 insert into intersecttable values
 (1,'ram'),
 (2,'sham'),
 (3,'mohan');

 create table intersecttable2
 ( id int,
   name varchar(255));

insert into intersecttable2 values
 (2,'sham'),
 (3,'mohan');


 select * from intersecttable
 intersect
 select * from intersecttable2;

 select * from intersecttable
 inner join intersecttable2
 on intersecttable.id = intersecttable2.id

 --intersect filters duplicates and returns only DISTINCT rows that are common between the left and right query,
 --where the left and right query, where as inner join does not filter the duplicates.

 ---use distinct operator to get filters records as distinct ones in joins.

 ---use join when our main column contain null values.




 ---Difference between Union vs INTERSECT vs EXCEPT

 CREATE TABLE TABLEA
 ( id int,
Name varchar(255),
Gender varchar(255));


 CREATE TABLE TABLEB
 ( id int,
Name varchar(255),
Gender varchar(255));

INSERT INTO TABLEA VALUES
(1,'Mark','Male'),
(2,'Mary','Female'),
(3,'Steve','Male'),
(4,'Steve','Male');

insert into TABLEB VALUES
(2,'Mary','Female'),
(3,'Steve','Male'),
(4,'John','Male')

--union
select * from TABLEA
UNION
SELECT * FROM TABLEB

select * from TABLEA
UNION ALL
SELECT * FROM TABLEB

--INTERSECT
--INTERSECT operator retrieves the common unique rows from both the left and the right query.
SELECT * FROM TABLEA
INTERSECT
SELECT * FROM TABLEB

--EXCEPT
--Except operator returns unique rows from the left query that aren't in the right query result.
SELECT * FROM TABLEA
EXCEPT
SELECT * FROM TABLEB



---query to list all tables in database

select * from sysobjects;---getting all the objects

select * from sysobjects where xtype = 'U'---U Means user table  check other xtype in official documentation like for scalar function,store procedure,views etc

select distinct xtype from sysobjects;----to get all types of objects in database.

--Gets the list of tables only
select * from sys.tables;

--Gets the list of tables and views
select * from INFORMATION_SCHEMA.tables;
select * from INFORMATION_SCHEMA.views;
select * from INFORMATION_SCHEMA.ROUTINES;

---for store procedure use 'ROUTINE'



-----GROUPING SETS IN SQL SERVER

 Create Table Employeesgrouping
(
    Id int primary key,
    Name nvarchar(50),
    Gender nvarchar(10),
    Salary int,
    Country nvarchar(10)
)
Go

Insert Into Employeesgrouping Values (1, 'Mark', 'Male', 5000, 'USA')
Insert Into Employeesgrouping Values (2, 'John', 'Male', 4500, 'India')
Insert Into Employeesgrouping Values (3, 'Pam', 'Female', 5500, 'USA')
Insert Into Employeesgrouping Values (4, 'Sara', 'Female', 4000, 'India')
Insert Into Employeesgrouping Values (5, 'Todd', 'Male', 3500, 'India')
Insert Into Employeesgrouping Values (6, 'Mary', 'Female', 5000, 'UK')
Insert Into Employeesgrouping Values (7, 'Ben', 'Male', 6500, 'UK')
Insert Into Employeesgrouping Values (8, 'Elizabeth', 'Female', 7000, 'USA')
Insert Into Employeesgrouping Values (9, 'Tom', 'Male', 5500, 'UK')
Insert Into Employeesgrouping Values (10, 'Ron', 'Male', 5000, 'USA')
Go

select Country, Gender, sum(Salary) As TotalSalary
FROM Employeesgrouping
group by Country,Gender;

select Country, null, sum(Salary) As TotalSalary
FROM Employeesgrouping
group by Country;


--Query 1st

select Country, Gender, sum(Salary) As TotalSalary
FROM Employeesgrouping
group by Country,Gender

union all

select Country, null, sum(Salary) As TotalSalary
FROM Employeesgrouping
group by Country

UNION ALL

select NULL, Gender, sum(Salary) As TotalSalary
FROM Employeesgrouping
group by Gender

UNION ALL

select NULL, NULL, sum(Salary) As TotalSalary
FROM Employeesgrouping;
 
--Grouping set in sql server
SELECT Country,Gender,Sum(Salary) as TotalSalary
FROM Employeesgrouping
Group By
 GROUPING SETS
 (
	(Country,Gender),  --Sum of salary by country & gender
	(Country),         --sum of salary by Country 
	(Gender),		   --sum of salary by gender
	()				   --Grand Total
 )
 order by Grouping(Country), Grouping(Gender),Gender


 --------------------------------------------------------------------------------------Day 4
-- Task : Implementing ER-Diagram
-- Other: Worked on Pivot and Unpivot 
 
/*

Name  : EmployeesDatabase

*/

--create database
CREATE DATABASE EmployeesDatabase;
GO

USE EmployeesDatabase;
go

--create schemas
CREATE SCHEMA Employees
go


--create tables
CREATE TABLE [Employees].[employees] (
	[emp_no] INT PRIMARY KEY,
	[birth_date] DATE NOT NULL,
	[first_name] varchar(14) NOT NULL,
	[last_name] varchar(16) NOT NULL,
	[gender] varchar(1) NOT NULL CHECK (gender IN ('M','F')),
	[hire_date] DATE NOT NULL
);



CREATE TABLE [Employees].[titles] (
	[emp_no] INT NOT NULL,
	[title] varchar(50) NOT NULL,
	[from_date] DATE NOT NULL ,
	[to_date] DATE DEFAULT (NULL)
	CONSTRAINT pk_titles PRIMARY KEY (emp_no,title,from_date)
	FOREIGN KEY (emp_no) REFERENCES Employees.employees (emp_no)
);


CREATE TABLE [Employees].[salaries] (
	[emp_no] INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
	CONSTRAINT PK_salaries PRIMARY KEY (emp_no,from_date)
	FOREIGN KEY (emp_no) REFERENCES Employees.employees (emp_no)
);



CREATE TABLE [Employees].[dept_emp] (
	[emp_no] INT NOT NULL,
	dept_no nchar(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
	CONSTRAINT PK_dept_emp PRIMARY KEY (emp_no,dept_no)
	FOREIGN KEY (emp_no) REFERENCES Employees.employees (emp_no)
);


CREATE TABLE [Employees].[departments] (
	dept_no nchar(4) NOT NULL,
	dept_name varchar(40) NOT NULL
	CONSTRAINT PK_DEPARTMENT PRIMARY KEY (dept_no)
);


CREATE TABLE [Employees].[dept_manager] (
	emp_no INT NOT NULL,
	dept_no nchar(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	CONSTRAINT PK_DEPT_MANAGER PRIMARY KEY (dept_no,emp_no),
	FOREIGN KEY (emp_no) REFERENCES Employees.employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES Employees.departments (dept_no)
);

---------------Pivot and Un-pivot

---Understanding pivot properly

--pivot---rows to column
--unpivot --columns to rows



SELECT 
    category_name, 
    COUNT(product_id) product_count
FROM 
    production.products p
    INNER JOIN production.categories c 
        ON c.category_id = p.category_id
GROUP BY 
    category_name;



	SELECT 
    category_name, 
    product_id
FROM 
    production.products p
    INNER JOIN production.categories c 
        ON c.category_id = p.category_id


--Step 1: - Making Derive table

SELECT * FROM (
SELECT 
	category_name, 
    product_id
FROM 
    production.products p
	INNER JOIN production.categories c 
    ON c.category_id = p.category_id
) t


--Step 2: --apply pivot

SELECT * FROM (
SELECT 
	category_name, 
    product_id
FROM 
    production.products p
	INNER JOIN production.categories c 
    ON c.category_id = p.category_id
) t
pivot
(
	count(product_id)
	FOR category_name IN(
	    [Children Bicycles], 
        [Comfort Bicycles], 
        [Cruisers Bicycles], 
        [Cyclocross Bicycles], 
        [Electric Bikes], 
        [Mountain Bikes], 
        [Road Bikes])
) as pivot_table



SELECT * FROM (
SELECT 
	category_name, 
    product_id,
	model_year
FROM 
    production.products p
	INNER JOIN production.categories c 
    ON c.category_id = p.category_id
) t
pivot
(
	count(product_id)
	FOR category_name IN(
	    [Children Bicycles], 
        [Comfort Bicycles], 
        [Cruisers Bicycles], 
        [Cyclocross Bicycles], 
        [Electric Bikes], 
        [Mountain Bikes], 
        [Road Bikes])
) as pivot_table


--------------------------Second Example
use assessment


CREATE TABLE Grades(
  Student VARCHAR(50),
  Subject VARCHAR(50),
  Marks   INT
)
go
 
INSERT INTO Grades VALUES 
('Jacob','Mathematics',100),
('Jacob','Science',95),
('Jacob','Geography',90),
('Amilee','Mathematics',90),
('Amilee','Science',90),
('Amilee','Geography',100)
go


SELECT * FROM
(SELECT 
	[Student],
	[Subject],
	[Marks]
FROM Grades) t
PIVOT
(
	SUM([Marks])
	FOR [Subject] IN ([Mathematics],[Science],[Geography])

) AS pivot_table

SELECT * FROM Grades;

CREATE TABLE Grades2(
  Student VARCHAR(50),
  Subject VARCHAR(50),
  Marks   INT
)

INSERT INTO Grades2 VALUES 
('Jacob','Mathematics',100),
('Jacob','Science',95),
('Jacob','Geography',90);

select * from Grades2;

select * from
(select student,Subject,Marks from Grades2) AS T
PIVOT
(
	SUM(Marks)---------------------------------------------Aggregate function is mandatory here but why ? if we have only distinct records then.
	FOR Subject IN (Mathematics,Science,Geography)
) AS pivot_table



------Unpivot

-- Create the table and insert values as portrayed in the previous example.  
CREATE TABLE pvt (VendorID INT, Emp1 INT, Emp2 INT,  
    Emp3 INT, Emp4 INT, Emp5 INT);  
go


INSERT INTO pvt VALUES (1,4,3,5,4,4);  
INSERT INTO pvt VALUES (2,4,1,5,5,5);  
INSERT INTO pvt VALUES (3,4,3,5,4,4);  
INSERT INTO pvt VALUES (4,4,2,5,5,4);  
INSERT INTO pvt VALUES (5,5,1,5,5,5);  
go

-- Unpivot the table.  


SELECT VendorID, Employee, Orders from
(SELECT VendorID,Emp1,Emp2,Emp3,Emp4,Emp5
 FROM pvt) p
 UNPIVOT
 (
	Orders
	FOR Employee IN (Emp1,Emp2,Emp3,Emp4,Emp5)
 ) AS unpvt

 select * from pvt;



 ----------------third Example  ( Reversing a pivot) Reversing  Aggregated Pivoted table

--pivot
CREATE TABLE Students
(
	Id INT PRIMARY KEY IDENTITY,
	StudentName VARCHAR (50),
	Course VARCHAR (50),
	Score INT
)

INSERT INTO Students VALUES ('Sally', 'English', 95 )
INSERT INTO Students VALUES ('Sally', 'History', 82)
INSERT INTO Students VALUES ('Edward', 'English', 45)
INSERT INTO Students VALUES ('Edward', 'History', 78)


SELECT * FROM Students;

---REVERSING NON-AGGREGATES PIVOTED TABLE

SELECT StudentName,Course,Score FROM
(select * from 
(select StudentName,Course,Score from Students) t
pivot
(
	sum(Score)
	FOR Course IN (English,History)
) as pivottable) PivotedResult
UNPIVOT
(
	score
	FOR Course IN (English,History)

) AS unpivoted


----REVERSING AGGREGATED PIVOTED TABLE

INSERT INTO Students VALUES ('Edward', 'History', 78)

SELECT Id, StudentName, English, History
FROM Students
PIVOT
(
	SUM (Score)
	FOR Course in (English, History)
) AS Schoolpivot




SELECT StudentName, Course, Score
FROM
(SELECT * FROM
 
(SELECT 
	StudentName,
	Score,
	Course
FROM 
	Students
)
AS StudentTable
PIVOT(
	SUM(Score)
	FOR Course IN ([English],[History])
) AS SchoolPivot) PivotedResults
UNPIVOT
(
	Score
	FOR Course in (English, History)
) AS Schoolunpivot