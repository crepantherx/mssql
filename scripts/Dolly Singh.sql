/* 

1. WHAT IS VIEW ?
-> View is nothing more than a saved SQL query.
-> view can also be considered as virtual table
-> It hold data from one or more tables.
-> It is stored in the database. 
-> A view does not contain any data itself,
  it is a set of queries that are applied to one or more tables
  that are stored within the database as an object.



2. Why should we use View?
-> Views are generally used to focus, simplify, and customize the perception each user
   has of the database.
-> Views can be used as security mechanisms by letting users access data through the view,
   without granting the users permissions to directly access the underlying base tables of 
   the view.



3. SYNTAX: 

CREATE [ OR ALTER ] VIEW [ schema_name . ] view_name [ (column [ ,...n ] ) ]
[ WITH <view_attribute> [ ,...n ] ]
AS select_statement
[ WITH CHECK OPTION ]
[ ; ]  
  
<view_attribute> ::=
{  
    [ ENCRYPTION ]  
    [ SCHEMABINDING ]  
    [ VIEW_METADATA ]
}


SIMPLE SYNTAX  */

CREATE VIEW VW_SIMPLE
AS
SELECT d.dept_name,de.dept_no
FROM Employee.employees.departments d
JOIN Employee.employees.dept_emp de
ON d.dept_no= de.dept_no


ALTER TABLE Employee.employees.departments
ALTER COLUMN dept_name nvarchar(60)

SELECT * FROM VW_SIMPLE
DROP VIEW VW_SIMPLE


---VIEW WITH VIEW ATTRIBUTE---

---WITH SCHEMABINDING--
/* Binds the view to the schema of the underlying table or tables.
  When SCHEMABINDING is specified, the base table or tables cannot be modified
  in a way that would affect the view definition. 
  The view definition itself must first be modified or dropped to remove dependencies 
  on the table that is to be modified */

CREATE VIEW employees.VW_WITH_ATRRIBUTE
WITH SCHEMABINDING
AS
SELECT d.dept_name,de.dept_no
FROM employees.departments d
JOIN employees.dept_emp de
ON d.dept_no= de.dept_no

ALTER table Employee.employees.departments
ALTER column dept_name nvarchar(50)

DROP VIEW employees.VW_WITH_ATRRIBUTE

----WITH ENCRYPTION---
/*Using WITH ENCRYPTION prevents the view from being published as part of 
SQL Server replication */

sp_helptext 'VW_SIMPLE'

ALTER VIEW VW_SIMPLE
WITH ENCRYPTION
AS
SELECT d.dept_name,de.dept_no
FROM Employee.employees.departments d
JOIN Employee.employees.dept_emp de
ON d.dept_no= de.dept_no


---VIEW_METADATA---
/* VIEW_METADATA causes the SQL Server to return the view name when describing columns 
   in the result set and hide the base tables from the client application.

 ->  You would not see any differences with the view with VIEW_METADATA or without
   VIEW_METADATA when interacting from within SSMS.
   */

ALTER VIEW VW_SIMPLE
WITH VIEW_METADATA
AS
SELECT d.dept_name,de.dept_no
FROM Employee.employees.departments d
JOIN Employee.employees.dept_emp de
ON d.dept_no= de.dept_no

SELECT * FROM VW_SIMPLE


---WITH CHECK OPTION---
/* Forces all data modification statements executed against the view to follow 
the criteria set within select_statement. When a row is modified through a view, 
the WITH CHECK OPTION makes sure the data remains visible through the view 
after the modification is committed. */

CREATE VIEW VW_with_checkoption
AS
SELECT * FROM dbo.Details
WHERE Name like 'd%'
WITH CHECK OPTION

SELECT * FROM VW_with_checkoption
DROP VIEW VW_with_checkoption

INSERT INTO VW_with_checkoption VALUES(16,'ANY',56,'ASD',5) --does not work
INSERT INTO VW_with_checkoption VALUES(16,'DNY',56,'ASD',5)

/*
4. TYPES OF VIEW
1.INDEXED VIEW
2.PARTITIONED VIEW
3.SYSTEM VIEW

1. INDEXED VIEW-->
   An indexed view is a view that has been materialized. 
   This means the view definition has been computed and
   the resulting data stored just like a table. 
   we index a view by creating a unique clustered index on it.
   Indexed views can dramatically improve the performance of some types of queries.
   Indexed views work best for queries that aggregate many rows.
   They are not well-suited for underlying data sets that are frequently updated.

 
 
 Performance Gains from Indexed Views:-

-> Aggregations can be precomputed and stored in the index to minimize expensive
   computations during query execution.
-> Tables can be prejoined and the resulting data set stored.
-> Combinations of joins or aggregations can be stored.

 How the Query Optimizer Uses Indexed Views:-

->the SQL Server query optimizer automatically determines when an indexed view can be
  used for a given query execution. 
->The view does not need to be referenced directly in the query for the optimizer to 
  use it in the query execution plan. Therefore, existing applications can take
  advantage of the indexed views without any changes to the application itself; 
  only the indexed views have to be created.


  Requirements for Indexed Views

-> Set the ANSI_NULLS option to ON when you create the tables referenced by the view.
-> Set the ANSI_NULLS and QUOTED_IDENTIFIER options to ON prior to creating the view.
->The view must only reference base tables, not any other views.
->Base tables referenced by the view must be in the same database as the view 
  and must have the same owner.
->Create the view and any user-defined functions referenced in the view with the 
  SCHEMABINDING option.
->Reference all table names and user-defined functions with two-part names only—
 for example, "dbo.Customers" for the Customers table.

->The following Transact-SQL syntax elements are illegal in an indexed view:
   ->The * syntax to specify all columns. Column names must be explicitly stated.
   ->Derived tables and subqueries.
   ->UNION
   ->Outer joins or self joins.
   ->TOP and ORDER BY.
   ->DISTINCT
   ->COUNT(*). Use COUNT_BIG(*) instead, which returns a bigint data type and is allowed.

--commands we should run for the correct session start before ---
 SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET CONCAT_NULL_YIELDS_NULL ON
SET NUMERIC_ROUNDABORT OFF
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON

*/

SELECT * INTO NEW_Emp_salary
FROM Employee.employees.salaries

SELECT * FROM NEW_Emp_salary


SELECT emp_no,SUM(salary) as total
FROM NEW_Emp_salary
GROUP BY emp_no

----creating a view without index---
CREATE VIEW vw_non_indexed
AS
SELECT emp_no,SUM(salary) as total
FROM NEW_Emp_salary
GROUP BY emp_no

--SEE the execution plan----it have to scan whole table
SELECT * FROM vw_non_indexed

DROP VIEW vw_non_indexed


---create a indexed view -----

CREATE VIEW vw_indexed
WITH SCHEMABINDING
AS
SELECT emp_no,SUM(salary) as total,COUNT_BIG(*) AS Counting
FROM dbo.NEW_Emp_salary
GROUP BY emp_no

--creating index on it-------------
CREATE  UNIQUE CLUSTERED INDEX ix_on_view
ON vw_indexed(emp_no)
 
 --see the execution plan ,it only have to look for index to fetch result---
SELECT * FROM vw_indexed

DROP INDEX vw_indexed.ix_on_view
DROP VIEW vw_indexed

--Another important use of indexed view---
--suppose we want to fetch data from table not from view--

SELECT emp_no,SUM(salary) as total
FROM NEW_Emp_salary
GROUP BY emp_no

CREATE  UNIQUE CLUSTERED INDEX ix_on_view
ON vw_indexed(emp_no)
 
/*
 2. PARTITIONED VIEW
-> partitioning is a great feature that can be used to split large tables into multiple 
   smaller tables, transparently.
-> It allows you to store your data in many filegroups and keep the database files in 
   different disk drives, with the ability to move the data in and out the partitioned 
   tables easily.
-> A common example for tables partitioning is archiving old data to slow disk drives 
  and use the fast ones to store the frequently accessed data. 
  
-> Table partitioning improves query performance by excluding the partitions that are not 
   needed in the result set. But table partitioning is available only in the Enterprise SQL
   Server Edition, which is not easy to upgrade to for most of small and medium companies 
   due to its expensive license cost.

->Fortunately, SQL Server allows you to design your own partitioning solution without the
  need to upgrade your current SQL Server instance to Enterprise Edition. 
  This new option is called Partitioned Views. 
  It is up to you to manually design the tables that will work as partitions and combine 
  it together using the UNION ALL operator in the Partitioned View that will work like table 
  partitioning.

  */

CREATE DATABASE Demo

CREATE TABLE Shipments_Q1 (
Ship_Num INT NOT NULL,
Ship_CountryCode CHAR(3) NOT NULL,
Ship_Date DATETIME NULL,
Ship_Quarter SMALLINT NOT NULL CONSTRAINT CK_Ship_Q1 CHECK (Ship_Quarter = 1),
CONSTRAINT PK_Shipments_Q1 PRIMARY KEY (Ship_Num, Ship_Quarter)
);
 
GO
CREATE TABLE Shipments_Q2 (
Ship_Num INT NOT NULL,
Ship_CountryCode CHAR(3) NOT NULL,
Ship_Date DATETIME NULL,
Ship_Quarter SMALLINT NOT NULL CONSTRAINT CK_Ship_Q2 CHECK (Ship_Quarter = 2),
CONSTRAINT PK_Shipments_Q2 PRIMARY KEY (Ship_Num, Ship_Quarter)
);
 
GO
CREATE TABLE Shipments_Q3 (
Ship_Num INT NOT NULL,
Ship_CountryCode CHAR(3) NOT NULL,
Ship_Date DATETIME NULL,
Ship_Quarter SMALLINT NOT NULL CONSTRAINT CK_Ship_Q3 CHECK (Ship_Quarter = 3),
CONSTRAINT PK_Shipments_Q3 PRIMARY KEY (Ship_Num, Ship_Quarter)
);
 
GO
CREATE TABLE Shipments_Q4 (
Ship_Num INT NOT NULL,
Ship_CountryCode CHAR(3) NOT NULL,
Ship_Date DATETIME NULL,
Ship_Quarter SMALLINT NOT NULL CONSTRAINT CK_Ship_Q4 CHECK (Ship_Quarter = 4),
CONSTRAINT PK_Shipments_Q4 PRIMARY KEY (Ship_Num, Ship_Quarter)
);

----creating partition view ----

CREATE VIEW DBO.Shipments_Info
WITH SCHEMABINDING
AS
SELECT [Ship_Num],[Ship_CountryCode],[Ship_Date],[Ship_Quarter] FROM DBO.Shipments_Q1
UNION ALL
SELECT [Ship_Num],[Ship_CountryCode],[Ship_Date],[Ship_Quarter] FROM DBO.Shipments_Q2
UNION ALL
SELECT [Ship_Num],[Ship_CountryCode],[Ship_Date],[Ship_Quarter] FROM DBO.Shipments_Q3
UNION ALL
SELECT [Ship_Num],[Ship_CountryCode],[Ship_Date],[Ship_Quarter] FROM DBO.Shipments_Q4

----inserting data to view and it will accept according to check constraint---
INSERT INTO DBO.Shipments_Info VALUES(1117,'JOR',GETDATE(),1)
INSERT INTO DBO.Shipments_Info VALUES(1118,'JFK',GETDATE(),2)
INSERT INTO DBO.Shipments_Info VALUES(1119,'CAS',GETDATE(),3)
INSERT INTO DBO.Shipments_Info VALUES(1120,'BEY',GETDATE(),4)

---see the data in all four tables---
SELECT * FROM DBO.Shipments_Q1
GO
SELECT * FROM DBO.Shipments_Q2
GO
SELECT * FROM DBO.Shipments_Q3
GO
SELECT * FROM DBO.Shipments_Q4
GO

---see result in view---------
SELECT * FROM DBO.Shipments_Info

--see the execution plan for this--
SELECT * FROM DBO.Shipments_Info WHERE [Ship_Num] = 1119

--see the execution plan for the query which have check constraint column--
SELECT * FROM DBO.Shipments_Info WHERE [Ship_Quarter] = 3

/*
3.SYSTEM VIEW:-
The system views are views that contain internal information about a Database.

for example-
1.How can I get the list of tables in a database? */

SELECT * FROM [INFORMATION_SCHEMA].[TABLES]
--OR--
SELECT *
FROM sysobjects WHERE xtype = 'U'

--2. How can I get the list of views in a database? --
SELECT * 
FROM [INFORMATION_SCHEMA].[VIEWS]
--or--
SELECT *
 FROM sysobjects 
 WHERE xtype = 'V'

--3.How can I get the list of procedures in a database?--
select * from [INFORMATION_SCHEMA].[ROUTINES]
where routine_type='PROCEDURE'
--or--
 
SELECT *
FROM sysobjects 
WHERE xtype = 'P'

--4.How can I get the list of stored procedures names and their code?
SELECT name, [text]
 FROM sysobjects o
 INNER JOIN syscomments c
 ON 
 o.id=c.id
WHERE xtype = 'P'

--**********************************************************************************--


/**                MAIN TOPICS OF SQL SERVER

Quering data -> select
sorting data -> order by
limiting rows -> offset,fetch,select top
filtering data -> distict ,where,and,or,in,between,like,alias
joining tables -> joins,inner,outer,left,right,full,self
grouping data-> group by, having,grouping set,cube,rollup
subquery -> corealated subquery,exists,any,all
set operaters -> union,intersect,except
cte--> cte ,recursive cte
pivot -> rows to columns

modifying data -> insert ,insert into multiple,insert into select,update,update join,delete,merge

ddl-> create database,drop db,create schm,alter schm,drop schma,create table,identity column,sequence,alter table
add column,alter table alter column,alter table drop column,computed columns,drop table,truncate table,select into
,rename a table,temprorary tables,synonyms

data types-> bit ,int,decimal,char,varchar,nvarchar,datetime2,date,time,datetime,offset,guid
constraints ->p.k,f.k,not null,unique,check
expressions -> case,coalesce,nullif
find duplicates,delete duplicates

views
indexes
store procedure
user defined functions
triggers

--sql server functions----
agrregate functions
date functions
string functions
system functions
window functions
*/



SELECT 
TABLE_CATALOG,
TABLE_SCHEMA,
TABLE_NAME, 
COLUMN_NAME, 
DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'brands' 

SELECT TABLE_SCHEMA,TABLE_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
where TABLE_CATALOG = 'BikeStores' 

SELECT * FROM production.products

-----remove duplicates-----
SELECT category_id ,count(*) AS num
FROM production.products
GROUP BY category_id
HAVING COUNT(*)>1

-----select--------
SELECT city,COUNT(*) AS number 
FROM sales.customers
WHERE state='CA'
GROUP BY city
HAVING COUNT(*)>5
ORDER BY city

----SORTING DATA----
---order by---
SELECT
    city,
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    city,
    first_name;


SELECT
    city,
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    city DESC,
    first_name ASC;


SELECT
    city,
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    state;

SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    LEN(first_name) DESC;


-----LIMITING ROWS------
-----offset fetch------
SELECT
product_name,list_price 
FROM
production.products
ORDER BY
product_name,list_price DESC
OFFSET 5 ROWS
FETCH NEXT 10 ROWS ONLY

------SELECT TOP---
SELECT TOP 5 
product_name,list_price
FROM 
production.products
ORDER BY 
product_name,list_price

SELECT TOP 1 PERCENT 
product_name,list_price
FROM 
production.products
ORDER BY 
product_name,list_price

SELECT TOP 5 WITH TIES 
product_name,list_price
FROM 
production.products
ORDER BY 
list_price DESC


----FILTERIND DATA-------
  ---DISTINCT----
SELECT DISTINCT
    city
FROM
    sales.customers
ORDER BY
    city


SELECT DISTINCT
    city,
    state
FROM
    sales.customers

---GROUP BY VS DISTINCT
SELECT 
	city, 
	state, 
	zip_code
FROM 
	sales.customers
GROUP BY 
	city, state, zip_code
ORDER BY
	city, state, zip_code


SELECT 
	DISTINCT 
       city, 
       state, 
       zip_code
FROM 
	sales.customers;

---WHERE ,AND,OR-----
SELECT
    *
FROM
    production.products
WHERE
    category_id = 1
AND list_price > 400
AND brand_id = 1
ORDER BY
    list_price DESC;

SELECT
    *
FROM
    production.products
WHERE
    (brand_id = 1 OR brand_id = 2)
AND list_price > 1000
ORDER BY
    brand_id;


-----IN----
SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price IN (89.99, 109.99, 159.99)
ORDER BY
    list_price;

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price NOT IN (89.99, 109.99, 159.99)
ORDER BY
    list_price;


SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    product_id IN (
        SELECT
            product_id
        FROM
            production.stocks
        WHERE
            store_id = 1 AND quantity >= 30
    )
ORDER BY
    product_name;


----BETWEEN----

SELECT
    product_id,
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price BETWEEN 149.99 AND 199.99
ORDER BY
    list_price;


SELECT
    product_id,
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price NOT BETWEEN 149.99 AND 199.99
ORDER BY
    list_price;

----LIKE----
SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE 'z%'
ORDER BY
    first_name;

SELECT 
   feedback_id, 
   comment
FROM 
   sales.feedbacks
WHERE 
   comment LIKE '%30!%%' ESCAPE '!';

-----JOINING TABLES----
CREATE SCHEMA hr;
GO
CREATE TABLE hr.candidates(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

CREATE TABLE hr.employees(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

INSERT INTO 
    hr.candidates(fullname)
VALUES
    ('John Doe'),
    ('Lily Bush'),
    ('Peter Drucker'),
    ('Jane Doe');


INSERT INTO 
    hr.employees(fullname)
VALUES
    ('John Doe'),
    ('Jane Doe'),
    ('Michael Scott'),
    ('Jack Sparrow');

SELECT * FROM hr.candidates
SELECT * FROM hr.employees

SELECT e.fullname employee_name,
       e.id employee_id,
	   c.id candidate_id,
	   c.fullname candidate_name
FROM hr.candidates c 
INNER JOIN hr.employees e
ON e.fullname = c.fullname

---left join---
SELECT  
	c.id candidate_id,
	c.fullname candidate_name,
	e.id employee_id,
	e.fullname employee_name
FROM 
	hr.candidates c
	LEFT JOIN hr.employees e 
		ON e.fullname = c.fullname;

SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    LEFT JOIN hr.employees e 
        ON e.fullname = c.fullname
WHERE 
    e.id IS NULL;


----right join-----
SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    RIGHT JOIN hr.employees e 
        ON e.fullname = c.fullname;

SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    RIGHT JOIN hr.employees e 
        ON e.fullname = c.fullname
WHERE
    c.id IS NULL;

---full join----
SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    FULL JOIN hr.employees e 
        ON e.fullname = c.fullname;

SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    FULL JOIN hr.employees e 
        ON e.fullname = c.fullname
WHERE
    c.id IS NULL OR
    e.id IS NULL;


	----------------cross join---------------
SELECT
    s.store_id,
    p.product_id,
    ISNULL(sales, 0) sales
FROM
    sales.stores s
CROSS JOIN production.products p
LEFT JOIN (
    SELECT
        s.store_id,
        p.product_id,
        SUM (quantity * i.list_price) sales
    FROM
        sales.orders o
    INNER JOIN sales.order_items i ON i.order_id = o.order_id
    INNER JOIN sales.stores s ON s.store_id = o.store_id
    INNER JOIN production.products p ON p.product_id = i.product_id
    GROUP BY
        s.store_id,
        p.product_id
) c ON c.store_id = s.store_id
AND c.product_id = p.product_id
WHERE
    sales IS NULL
ORDER BY
    product_id,
    store_id;



---window function---


SELECT list_price,
DENSE_RANK() OVER (ORDER BY list_price DESC)as rnk,
FIRST_VALUE(product_name)
OVER (ORDER BY product_id) frst ,
LAST_VALUE(product_name)
OVER (ORDER BY product_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) LASTVAL
FROM production.products
order by list_price DESC

---system functions----
SELECT  1 + '1' AS RES
SELECT product_name + '_'+ cast(product_id as varchar(20)) FROM production.products

SELECT 
    MONTH(order_date) month, 
    CAST(SUM(quantity * list_price * (1 - discount)) AS INT) amount
FROM sales.orders o
    INNER JOIN sales.order_items i ON o.order_id = i.order_id
WHERE 
    YEAR(order_date) = 2017
GROUP BY 
    MONTH(order_date)
ORDER BY 
    month;

----convert---
SELECT 
    CONVERT(DATETIME, '2019-03-14') result;
SELECT 
    CONVERT(VARCHAR, GETDATE(),13) result;

---choose-----
SELECT 
    CHOOSE(2, 'First', 'Second', 'Third') Result;

	SELECT
    order_id, 
    order_date, 
    order_status,
    CHOOSE(order_status,
        'Pending', 
        'Processing', 
        'Rejected', 
        'Completed') AS order_status
FROM 
    sales.orders
ORDER BY 
    order_date DESC;

	SELECT 
    order_id,
    order_date,
    customer_id,
    CHOOSE(
        MONTH(order_date), 
        'Winter', 
        'Winter', 
        'Spring', 
        'Spring', 
        'Spring', 
        'Summer', 
        'Summer', 
        'Summer', 
        'Autumn', 
        'Autumn', 
        'Autumn', 
        'Winter') month
FROM 
    sales.orders
ORDER BY 
    customer_id;

-----try cast-
	SELECT 
    CASE
        WHEN TRY_CAST('test' AS INT) IS NULL
        THEN 'Cast failed'
        ELSE 'Cast succeeded'
    END AS Result;

-----aggregate functions
SELECT
    AVG(list_price) avg_product_price
FROM
    production.products;


	SELECT
    COUNT(*) product_count
FROM
    production.products
WHERE
    list_price > 500;

SELECT COUNT(*) OVER (ORDER BY list_price) product_count
FROM production.products
WHERE list_price > 500

SELECT 
    product_id, 
    SUM(quantity) stock_count
FROM 
    production.stocks
GROUP BY
    product_id
ORDER BY 
    stock_count DESC;

SELECT
    CAST(ROUND(STDEV(list_price),2) as DEC(10,2)) stdev_list_price
FROM
    production.products;

-----STRING FUNCTION-----

SELECT 
    ASCII('AB') A, 
    ASCII('Z') Z;

SELECT CHARINDEX('DOLLY','MY NAME IS DOLLY SINGH',1) RES



--**********************************************************************************

--Creating table with all possible constraints---

CREATE TABLE dbo.Sample_Table_1
(
    A INT NOT NULL PRIMARY KEY,
    B VARCHAR(10) NULL DEFAULT 'ABC',
	C INT CHECK(C>10),
	D NVARCHAR(20) UNIQUE
);

--creating table with all possible constraints with their name--
CREATE TABLE dbo.Sample_Table_2
(
    E INT NOT NULL,
    F VARCHAR(10) CONSTRAINT DF_F DEFAULT 'ABC', 
	G INT,
	H NVARCHAR(20),
	I INT,
	CONSTRAINT PK_E PRIMARY KEY(E),
	CONSTRAINT check_G CHECK(G>10),
	CONSTRAINT Unique_H UNIQUE(H),
	CONSTRAINT FK_I FOREIGN KEY(I) REFERENCES Sample_Table_1(A)


);

--Insert records for all column except B to see the effect of default constraint--
INSERT INTO Sample_Table_1(A,C,D)
VALUES
(1,11,'JOHN')

SELECT * FROM Sample_Table_1

INSERT INTO Sample_Table_2(E,G,H,I)
VALUES
(1,11,'JOHN',1)

SELECT * FROM Sample_Table_2


--**********************************************************************************
--All Alter Commands--

CREATE TABLE Student
(Name VARCHAR(10))

CREATE TABLE Marks
(roll_number int)

--add a column in an existing table using ALTER clause

ALTER TABLE Student 
ADD marks_obtained int;

ALTER TABLE Student 
ADD roll_num int;

--to modify existing column using ALTER command
ALTER TABLE Student
ALTER COLUMN marks_obtained DECIMAL (5, 2);

ALTER TABLE Student 
ALTER COLUMN roll_number int NOT NULL;


--to drop an existing column from the table using ALTER command
ALTER TABLE Student 
DROP COLUMN marks_obtained;

--to add primary key constraints using ALTER command
ALTER TABLE Student
ADD Constraint pk_roll_num  PRIMARY KEY(roll_number)

--to drop Primary Key Constraint using ALTER command
ALTER TABLE Student 
DROP CONSTRAINT pk_roll_num

--to add foreign key Constraints using alter command
ALTER TABLE Marks
ADD Constraint fk_roll_num FOREIGN KEY (roll_number) REFERENCES Student (roll_number)

--to drop foreign key Constraint using Alter command:
ALTER TABLE Marks 
DROP CONSTRAINT fk_roll_num;

--to add unique key Constraints using ALTER command
ALTER TABLE Student 
ADD CONSTRAINT unique_roll_no UNIQUE (roll_Number);

--to drop unique Key Constraint using ALTER command
ALTER TABLE Student 
DROP CONSTRAINT unique_roll_no

--to add check Constraint using ALTER command
ALTER TABLE table_name
ADD CONSTRAINT MyUniqueConstraint CHECK (CONDITION);

--to add default constraint using alter command
ALTER TABLE Student
ADD DEFAULT 'SUDHIR' FOR Name

SELECT * FROM Student


--**********************************************************************************


------INDEX------------------
/*Avoid indexing highly used table/columns
Use narrow index keys whenever possible 
Use clustered indexes on unique columns 
Nonclustered indexes on columns that are frequently searched and/or joined on
 */

CREATE INDEX IX_ON_Detail_age 
ON Details(Age)

----composite index---
CREATE INDEX IX_COMP
ON Details(Name,Profession)

ALTER INDEX IX_ON_Detail_age
ON Details rebuild

ALTER INDEX IX_ON_Detail_age
ON Details disable

DROP INDEX Details.IX_ON_Detail_age

----getting all indexes-----
sp_helpindex 'Details'

--***********************************************************************************

--------STORED PROCEDURE-----------
----SET NOCOUNT ON----------
/*While we set SET NOCOUNT ON it means there is no messages 
which shows the number of rows affected.
 NOCOUNT means do not count that is ON. 
 SET NOCOUNT OFF to show the affected rows again */

 SET NOCOUNT ON
 SET NOCOUNT OFF

 -----TYPES----
 /* 1.Userdefined store procedure
  2. system store procedures */

  -----userdefined store procedure-------
  /*two types of userdefined sp
  1. T-SQL stored procedures: T-SQL (Transact SQL) SPs receive and returns parameters. 
  These SPs process the Insert, Update and Delete queries 
  with or without parameters and return data of rows as output
  This is one of the most common ways to write SPs in SQL Server

  2.CLR stored procedures: CLR (Common Language Runtime) SPs are written in
  a CLR based programming language 
  such as C# or VB.NET and are executed by the .NET Framework.
  */
  
  ---create sp-----
CREATE PROCEDURE SP_ON_Deatials
AS
BEGIN
 SELECT * FROM Details
END
 
EXEC SP_ON_Deatials

-----with input parameter--- Input parameters - Pass values to a stored procedure.----------
 
 CREATE PROCEDURE Pro
 @age int 
 AS
 BEGIN
  SELECT * FROM Details
  WHERE Age = @age
 END

 EXEC Pro @age = 24
 
 
 
 
ALTER PROCEDURE SP_ON_Deatials
 @id int
 AS
 BEGIN
   SELECT * FROM Details
   WHERE ID = @id
 END

 ---execute sp with input parameter---------
 EXEC SP_ON_Deatials @id = 1


 ----OUTPUT PARAMETERS -Return values from a stored procedure-------
 SELECT * FROM Employee.employees.employees
 CREATE PROCEDURE stp_out_emp
 @gen nvarchar(1),
 @count_records int output
 AS
 BEGIN
  SELECT name,sur_name
  FROM Employee.employees.employees
  WHERE gender = @gen
  SELECT @count_records = @@ROWCOUNT;
 END

 ---execute sp with output parameter-----
 DECLARE @Count int
 EXEC stp_out_emp
 @gen = 'M',
 @count_records = @Count OUTPUT
 SELECT @Count AS 'no of records'


--************************************************************************************

 ---TRIGGERS---------------
/* 3 types of triggers
1. DML TRIGGERS
2. DDL TRIGGERS
3. LOGON TRIGGERS

1.DML TRIGGGER :- Dml trigggers fires automatically in response to dml events
                  like(insert,update and delete)

Dml trigger has two types
1.After/For trigger :-it fires after the trigger option,the insert,update,delete
                      statement cause an after trigger to fire after complete
					  execution of statements

2.Instead of triggger:-it fires instead of the triggering option,the insert
                       update,delete statements causes instead of trigger to
					   fire instead of irrespective statement execution

*/
SELECT * FROM Emp

CREATE TABLE ALL_DATA
(ID INT IDENTITY(1,1),
 Details nvarchar(100)
 )

 ---Trigger for insert----

 CREATE TRIGGER Tr_for_insert
 ON Emp
 AFTER INSERT
 AS
 BEGIN 
     DECLARE @id int
	 SELECT @id = id from inserted
	 INSERT INTO ALL_DATA VALUES('new employee with id = ' + cast(@id as nvarchar(5)) +
	 'is addded at' + CAST(GETDATE() AS NVARCHAR(20)))
 END

 INSERT INTO Emp values(1,'Farhan Ahmed','Male',60000)
 SELECT * FROM ALL_DATA

 ----trigger for delete----
 CREATE TRIGGER Tr_for_deleteee
 ON Emp
 AFTER DELETE
 AS
 BEGIN 
     DECLARE @id int
	 SELECT @id = id from deleted
	 INSERT INTO ALL_DATA VALUES('new employee with id = ' + cast(@id as nvarchar(5)) +
	 'is deleted at ' + CAST(GETDATE() AS NVARCHAR(20)))
 END

 DELETE FROM Emp where ID = 4
 SELECT * FROM ALL_DATA

 ------After update--------
 /* after update trigger use both table inserted and deleted,inserted table have
    updated data and deleted table have deleted data*/

 CREATE TRIGGER Tr_for_update
 ON Emp
 AFTER UPDATE
 AS
 BEGIN 
     select * from inserted
	 select * from deleted
 END

 select * from Emp
 UPDATE Emp
 set Name = 'dolly'
 where ID =1

 -----instead of trigger---
 CREATE TRIGGER Tr_instead_of_INSERT
 ON Emp
 INSTEAD OF INSERT
 AS
 BEGIN 
     SELECT * FROM Emp
 END

 INSERT INTO Emp values(1,'Farhan Ahmed','Male',60000)

 ----instead of update--------
 ALTER TRIGGER Tr_instead_of_update
 ON Emp
 INSTEAD OF UPDATE
 AS
 BEGIN 
     SELECT * FROM Emp
 END

 UPDATE Emp
 set Name = 'abc'
 where ID =2

 /*
 2.DDL triggers :-it fires automaticaly when ddl event like create,drop,alter event
                  executed
				  use to prevent certain changes to database schema
				  audit the changes that user makeing to the database structure
* it can be created on specific database or at all server level
*/

CREATE TRIGGER Tr_emp_ddl
ON DATABASE
FOR CREATE_TABLE,ALTER_TABLE,DROP_TABLE
AS
BEGIN
   PRINT 'YOU have just created,altered or modifies table'
END

alter table Emp
ADD age int

----to prevent database change-------
ALTER TRIGGER Tr_emp_ddl
ON DATABASE
FOR CREATE_TABLE,ALTER_TABLE,DROP_TABLE
AS
BEGIN
   ROLLBACK
   PRINT 'YOU CAN NOT CHANGE SCHEMA OF THE THIS DATABASE'
END

alter table Emp
ADD A int

----disable trigger-------
DISABLE TRIGGER Tr_emp_ddl ON DATABASE

ENABLE TRIGGER Tr_emp_ddl ON DATABASE

DROP TRIGGER Tr_emp_ddl ON DATABASE

---WE CAN ALSO FIRE TRIGGER ON SYSTEM DEFINED STORE PROCEDURE-----
CREATE TRIGGER Tr_emp_ddl_SP
ON DATABASE
FOR RENAME
AS
BEGIN
  
   PRINT 'YOU JUST RENAME SOMETHING'
END

SP_RENAME 't','T'

----server scoped ddl trigger-----
CREATE TRIGGER Tr_serverscope_ddl
ON ALL SERVER
FOR CREATE_TABLE,ALTER_TABLE,DROP_TABLE
AS
BEGIN
   ROLLBACK
   PRINT 'YOU CAN NOT CHANGE SCHEMA OF THE THIS DATABASE'
END

alter table Emp
ADD A int

DISABLE TRIGGER Tr_serverscope_ddl ON ALL SERVER
ENABLE TRIGGER Tr_serverscope_ddl ON ALL SERVER
DROP TRIGGER Tr_serverscope_ddl ON ALL SERVER


----we can also fetch all data related to changes by trigger-----
CREATE TRIGGER Tr_serverscope_auditdata
ON ALL SERVER
FOR CREATE_TABLE,ALTER_TABLE,DROP_TABLE
AS
BEGIN
      SELECT EVENTDATA()
END

CREATE TABLE AC
(ID INT)

DROP TRIGGER Tr_serverscope_auditdata ON ALL SERVER

/*
3.LOGON TRIGGER:- It fires in response to logon event
                  logon trigger fires after the authentication phase and before the
				  user session is actually statblished

Logon triggger can be used for
1.Tracking login activity
2.restricting login to sql server
3.limiting the number of session for a specific login
*/

--wrriting a trigger to limit the max num of open connection to 3---

--to see all active user connections---
select * from sys.dm_exec_sessions

select is_user_process,original_login_name,* from sys.dm_exec_sessions
ORDER BY login_time desc

CREATE TRIGGER Tr_on_logon
ON ALL SERVER
FOR LOGON
AS
BEGIN
      DECLARE @LOGIN_NAME NVARCHAR(200)
	  SET @LOGIN_NAME = ORIGINAL_LOGIN()

	  IF( SELECT count(*) FROM sys.dm_exec_sessions
	  where is_user_process = 1 AND original_login_name = @LOGIN_NAME)> 4
	  BEGIN
	     PRINT '5TH connection ' + @LOGIN_NAME + ' IS BLOCKED'
	     ROLLBACK
	  END
END



DISABLE TRIGGER Tr_on_logon ON ALL SERVER
DROP TRIGGER Tr_on_logon ON ALL SERVER

---We can see all the errors by using store procedure sp_readerrorlog----
EXECUTE sp_readerrorlog


--********************************************************************************

--Row Number,Rank,Dense_rank--


with cte
 AS 
 (

  SELECT *,ROW_NUMBER() OVER( ORDER BY id) ro
  FROM t
 )
 DELETE FROM cte WHERE ro>1

 ------------------------------------------
 -------ROW_NUMBER--- FUNCTION-------
 /* 1. Return the sequential number of row starting at 1
    2. order by clause is required, partition by clause is optional
	3. when the data is partitioned,row_number is reset to 1 when the partion changes */
	
create table Emp  
(  
   ID int,  
   Name nvarchar(50),  
   Gender char(10),  
   Salary int  
)  
insert into Emp values(1,'Farhan Ahmed','Male',60000),  
(5,'Monika','Female',25000) , 
(2,'Abdul Raheem','Male',30000),  
(4,'Rahul Sharma','Male',60000) , 
(1,'Farhan Ahmed','Male',60000),  
(2,'Abdul Raheem','Male',30000),  
(5,'Monika','Female',25000) , 
(4,'Rahul Sharma','Male',60000),  
(1,'Farhan Ahmed','Male',60000),  
(3,'Priya','Female',20000) , 
(5,'Monika','Female',25000) , 
(4,'Rahul Sharma','Male',60000),  
(5,'Monika','Female',25000)  ,
(2,'Abdul Raheem','Male',30000),  
(1,'Farhan Ahmed','Male',60000) , 
(4,'Rahul Sharma','Male',60000) 

SELECT * FROM Emp

SELECT * ,ROW_NUMBER() OVER(ORDER BY ID) as rownum
FROM Emp 

--we can remove dublicates from table by using partition by in row_number function 
with cte
 AS 
 (
    SELECT *,ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID) rownum
    FROM Emp
 )
   DELETE FROM cte WHERE rownum>1

SELECT * FROM Emp

-------------RANK AND DENSE_RANK--------------
/*1. Return a rank starting at 1 based on the ordering of rows imposed by order by clause
  2. Order by clause is required
  3. partition by clause is optional
  4. when the data is partitioned ,rank is reset to 1 when partition changes 

  --difference between rank and dense_rank-----
  rank function skips ranking when there is tie where is dense_rank will not */

  SELECT *,RANK() OVER(ORDER BY ID) AS RNK FROM Emp
  SELECT *,DENSE_RANK() OVER(ORDER BY ID) AS DENS_RNK FROM Emp

  ---use of rank and dense_rank to find nth salary------
  
  With cte_on_emp_for_ranking_with_rank
  AS
  ( SELECT *,RANK() OVER(ORDER BY Salary DESC) sal_rank
  FROM Emp
  )
  SELECT * FROM cte_on_emp_for_ranking_with_rank WHERE sal_rank = 3 

  ----dense_rank----------------------
  
  With cte_on_emp_for_ranking
  AS
  ( SELECT *,DENSE_RANK() OVER(ORDER BY Salary DESC) sal_rank
  FROM Emp
  )
  SELECT DISTINCT * FROM cte_on_emp_for_ranking WHERE sal_rank = 3 

  SELECT TOP 1* FROM(SELECT distinct TOP 3 Salary FROM Emp ORDER BY Salary DESC) tbl ORDER BY Salary ASC

  
  With cte_on_emp_for_ranking
  AS
  ( SELECT *,RANK() OVER(ORDER BY Salary DESC) sal_rank
  FROM Emp
  )
  SELECT DISTINCT * FROM cte_on_emp_for_ranking WHERE sal_rank = 3 


  --similarties between row_number,dense_rank,rank--------
  /* 1. all rows have same increasing number integer staring from 1 if 
  there are no tie
  2. order by clause required
  3. partition by is optional
  4. when partition changes squential number reset to 1 again

  if there are no duplicates records on that column which we use in
  order by clause then all three functions going to give same sequential number

  ----remove duplicates first to see the effect--------- */
  with cte
 AS 
 (
    SELECT *,ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID) rownum
    FROM Emp
 )
   DELETE FROM cte WHERE rownum>1


  SELECT *,ROW_NUMBER() OVER(ORDER BY ID) rownum,
  DENSE_RANK() OVER( ORDER BY ID) AS DENS_RNK,
  RANK() OVER( ORDER BY ID) AS RNK FROM Emp



  ------difference between row_number and dense_rank- and rank------
  SELECT *,ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID) rownum FROM Emp
  SELECT *,DENSE_RANK() OVER(PARTITION BY ID ORDER BY ID) AS DENS_RNK FROM Emp

  SELECT *,ROW_NUMBER() OVER( ORDER BY ID) rownum,
  DENSE_RANK() OVER(ORDER BY ID) AS DENS_RNK,
  RANK() OVER(ORDER BY ID) AS RNK FROM Emp



  ------ROWS/RANGE------------------------------
  /* ROWS/RANGE that limits the rows within the partition by specifying start 
  and end points within the partition. It requires ORDER BY argument and
  the default value is from the start of partition to the current element
  if the ORDER BY argument is specified.*/

  SELECT *,ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID ) rownum,
  DENSE_RANK() OVER(PARTITION BY ID ORDER BY ID ) AS DENS_RNK,
  RANK() OVER(PARTITION BY ID ORDER BY ID ) AS RNK ,
  AVG(Salary) over(order by Salary ROWS BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW) as avgsal,
  AVG(Salary) over(order by Salary ) as avgsal_default FROM Emp

  --******************************************************************************

  -----AUDIT TABLE CHANGES------


/*We can fetch all details of a user who makes any changes to any table
  like login name,time,events,typename,databasename,tablename etc.....
  
  To fetch all the details we have to create a DDL trigger */

  ---TABLE to store details of user----
  CREATE TABLE Capture_details
  (
  DatabaseName NVARCHAR(250),
  TableName NVARCHAR(250),
  LoginName NVARCHAR(250),
  SQLCommand NVARCHAR(2000),
  AuditDateTime datetime
  )

  ALTER TABLE Capture_details
  ADD EventType nvarchar(250)

  SELECT * FROM Capture_details

  ---create trigger for capturing details of user------
  ALTER TRIGGER Tr_on_audit_tablechange
  ON ALL SERVER
  FOR CREATE_TABLE,ALTER_TABLE,DROP_TABLE
  AS
  BEGIN
       DECLARE @eventdata XML
	   SET @eventdata = EVENTDATA()
	   
	   INSERT INTO INTERNS.dbo.Capture_details(DatabaseName,TableName, LoginName,
	   SQLCommand,AuditDateTime,EventType)
	   VALUES
	   (
	     @eventdata.value('(/EVENT_INSTANCE/DatabaseName) [1]','nvarchar(250)'),
		 @eventdata.value('(/EVENT_INSTANCE/ObjectName) [1]','nvarchar(250)'),
		  @eventdata.value('(/EVENT_INSTANCE/LoginName) [1]','nvarchar(250)'),
		 @eventdata.value('(/EVENT_INSTANCE/TSQLCommand)[1]','nvarchar(250)'),
		 GETDATE(),
		 @eventdata.value('(/EVENT_INSTANCE/EventType)[1]','nvarchar(250)')
		 
	   )

	   select 'HEY Someone change something on yourdatabase table' AS Important_information
	   SELECT * FROM INTERNS.dbo.Capture_details
  END

  -----create table,alter,drop to see the effect-------
  CREATE TABLE C
  (ID INT )

  INSERT INTO C(ID) values(1)
  
  ALTER TABLE C
  ADD NAM NVARCHAR(10)

  DROP TABLE C

--*************************************************************************************
/*
More on Joins

JOINS
1.Nested joins :-It is best when we want to join few records of data from large tables
                 and we can optimize it by creating index on table 
2.Merge joins:- It is useful when our data is already sort but sorting is slow operation
                so this is rare operation
3.Hash joins:- hash join is best wwhen we want to join large records from large tables
               indexing is not useful here ,
*/

SET SHOWPLAN_ALL ON
SET SHOWPLAN_ALL OFF
SELECT  d.dept_name,de.dept_no,dm.emp_no
FROM    Employee.employees.departments d
JOIN    Employee.employees.dept_emp de      ON d.dept_no= de.dept_no
JOIN    Employee.employees.dept_manager dm  ON dm.emp_no=de.emp_no

SELECT *
FROM Employee.employees.employees e
JOIN Employee.employees.dept_emp de
ON e.emp_no = de.emp_no


SELECT a.dept_no,b.dept_no
FROM Employee.employees.departments a
JOIN Employee.employees.departments b
ON a.dept_name = b.dept_name

SELECT *
FROM Employee.employees.departments a
JOIN Employee.employees.departments b
ON a.dept_name = b.dept_name

SELECT * FROM Employee.employees.departments a , Employee.employees.departments b

SELECT * FROM INTERNS.dbo.Emp
ALTER TABLE Emp
DROP COLUMN age 

CREATE TABLE Emp
(

)

insert into Emp values(1,'Farhan Ahmed','Male',60000),  
(5,'Monika','Female',25000) , 
(2,'Abdul Raheem','Male',30000),  
(4,'Rahul Sharma','Male',60000) , 
(1,'Farhan Ahmed','Male',60000),  
(2,'Abdul Raheem','Male',30000),  
(5,'Monika','Female',25000) , 
(4,'Rahul Sharma','Male',60000),  
(1,'Farhan Ahmed','Male',60000),  
(3,'Priya','Female',20000) , 
(5,'Monika','Female',25000) , 
(4,'Rahul Sharma','Male',60000),  
(5,'Monika','Female',25000)  ,
(2,'Abdul Raheem','Male',30000),  
(1,'Farhan Ahmed','Male',60000) , 
(4,'Rahul Sharma','Male',60000) 

SELECT a.ID FROM Emp a,Emp b

SELECT a.ID FROM Emp a
INNER JOIN Emp b
ON a.ID = b.ID

CREATE INDEX Ix_on_ID
ON Emp(ID)

DROP INDEX Emp.Ix_on_ID

SELECT * INTO NewEmp
FROM Employee.employees.employees

SELECT * FROM NewEmp

-----HASH join-----because it does not have index and have big data 
SELECT * FROM NewEmp a
JOIN 
NewEmp b
ON a.emp_no = b.emp_no

--merge join--because it have clustered index and big data
SELECT * FROM Employee.employees.employees a
JOIN 
Employee.employees.employees b
ON a.emp_no = b.emp_no


SELECT TOP 10 * INTO NewEmp1
FROM Employee.employees.employees

-----Nested join because it have few data-----
SELECT TOP 5 * FROM NewEmp1 a
JOIN 
NewEmp1 b
ON a.emp_no = b.emp_no

CREATE TABLE A (ID INT)
INSERT INTO A VALUES(1),(1),(0),(1),(NULL)

SELECT * 
FROM A a join A b
ON a.ID = b.ID


SELECT a.name,count(*) as number_of_records FROM Employee.employees.employees a
JOIN 
Employee.employees.employees b
ON a.emp_no = b.emp_no
GROUP BY a.name

SELECT a.name,count(*) as number_of_records FROM NewEmp a
JOIN 
NewEmp b
ON a.emp_no = b.emp_no
GROUP BY a.name

--************************************************************************************

---cursor--
---use to fetch result set on row by row basis


DECLARE @name nvarchar(14),
        @sur_name nvarchar(16)

DECLARE my_cursorrr CURSOR
FOR SELECT name,sur_name
    FROM employees.employees

OPEN my_cursorrr
FETCH NEXT FROM my_cursorrr
INTO @name,@sur_name;

WHILE @@FETCH_STATUS = 0
  BEGIN
  PRINT @name +'  '+ @sur_name;
  FETCH NEXT FROM my_cursorrr
  INTO @name,@sur_name;
  END
CLOSE my_cursorrr
DEALLOCATE my_cursorrr


--**********************************************************************************

----functions-------

/* 
two types
1. USER DEFINED
2. SYSTEM DEFINED

1. USER DEFINED CAN BE OF 3 TYPES
 -> inline Table valued functions
 ->multi statement table valued function
 -> Scalar valued functions

 inline table valued -- in this we select a table data it returns a table
 */

 CREATE FUNCTION Table_vaued()
 returns table
 as
  return(select * from employees.employees)
  
  select * from Table_vaued()
   
--sql server treats inline table valued as a view internally and
--we can also update it---

update Table_vaued()
set name = 'dolly'
where emp_no=10001



----multistatement table valued----------
/* have to define structure of table ,begin and end complusory */

CREATE FUNCTION FUN()
returns @table TABLE(emp_no int,name nvarchar(14))
as
begin 
	 insert into @table
	 select emp_no,name from employees.employees
	 return
end

	select * from FUN()

--sql server treats multistatement table valued as a strore procedure internally and
--we can not edit or update it---
 
update FUN()
set name = 'dolly'
where emp_no=10001
 
 
---scalar valued functions--
  /* it should return single scalar value*/

CREATE FUNCTION Scalar_valued(@name nvarchar(14),@sur_name nvarchar(16))
returns nvarchar(100)
AS
   begin
   return (select @name + ' '+ @sur_name)
   end

   
   
select [dbo].[Scalar_valued](name,sur_name) from employees.employees

--*********************************************************************************

--*******FIND NTH HIGHEST SALARY IN DIFFERENT WAYS********************************

--************** 1ST WAY ***************************

SELECT TOP 1 *

FROM
(
SELECT DISTINCT TOP 3*
FROM employees.salaries
ORDER BY salary DESC
)a
Order by salary 
--**************************************


-- ************* 2nd way *************


SELECT * FROM (

SELECT DENSE_RANK() OVER (ORDER BY salary DESC) AS row_rank,salary
FROM employees.salaries ) AS Maxs
WHERE row_rank = 3 
--**************************************



-- ************* 3rd way *************
SELECT * 
FROM employees.salaries 
WHERE salary = 
(
	SELECT MIN(salary) 
	FROM employees.salaries
	WHERE  salary IN 
		(  
			SELECT DISTINCT TOP 3 salary 
			FROM employees.salaries 
			ORDER BY salary DESC
		)
)



--**************************************



-- ************* 4th way *************
WITH cte 
AS
( SELECT *,DENSE_RANK() OVER(ORDER BY Salary DESC) AS rnk 
 FROM employees.salaries)
 SELECT * FROM cte WHERE rnk = 3

--***********************************************************



-- ************* For Second Highest Salary Query *************

SELECT MAX(salary) AS SAL 
FROM employees.salaries
WHERE salary <> (
	SELECT MAX(salary)
	FROM employees.salaries
	)




--**************** 5th way *********************************** 

SELECT * FROM (
SELECT salary,
ROW_NUMBER() OVER (ORDER BY salary DESC) AS rownumber
FROM employees.salaries
) AS result
WHERE rownumber = 3

--************* 6TH way *******************************************

SELECT MAX(salary) 
FROM employees.salaries
WHERE salary <(
	SELECT MAX(salary) AS SAL
	FROM employees.salaries
	WHERE salary<(
		SELECT MAX(salary)
		FROM employees.salaries 
	)
)


--****************  7th way **********************

Select  *
From    employees.salaries E1
Where 3 = ( 
            Select Count(Distinct(E2.salary)) 
            From employees.salaries E2
			Where E2.Salary >= E1.Salary
			)




 --********* with partitions*******************************
 
 with cte AS (
 select D.dept_name,S.salary,DE.emp_no ,DENSE_RANK() over(PARTITION BY dept_name ORDER BY Salary) AS rk 
 from employees.departments D
 join employees.dept_emp DE
 ON DE.dept_no = D.dept_no
 join employees.salaries S
 ON S.emp_no = DE.emp_no
 ) select * from cte where rk =3


 --query for finding duplicate salary----
    
	SELECT
        salary ,
        COUNT(*) occurrences
    FROM employees.salaries
    GROUP BY 
        salary 
        
    HAVING 
        COUNT(*) > 1

--********************************************************
SELECT  *
FROM    employees.salaries E1
WHERE 3 = ( 
            Select Count(Distinct(E2.salary)) 
            From employees.salaries E2
			Where E2.Salary >= E1.Salary
		)



--*********************************************************************************

--Analytical and ranking functions----

SELECT * FROM employees.employees
SELECT emp_no,name,gender,  
FIRST_VALUE(name) OVER(PARTITION BY gender ORDER BY emp_no ROWS BETWEEN UNBOUNDED PRECEDING 
AND CURRENT ROW ) AS FIRST_NAME,
LAST_VALUE(name) OVER(ORDER BY emp_no ROWS BETWEEN UNBOUNDED PRECEDING 
AND UNBOUNDED FOLLOWING) AS LAST_NAME,
LEAD(emp_no,1,-1) over(order by emp_no) as [lead],
LAG(emp_no,1,-1) over(order by emp_no) as [lag]
FROM employees.employees



  
 
  


			






 
