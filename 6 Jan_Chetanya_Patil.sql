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




--unpivot
SELECT SalesAgent, Country, SalesAmount
FROM tblProductSales
UNPIVOT
(
	SalesAmount
	FOR Country IN (India, US, UK)
) AS UnpivotExample