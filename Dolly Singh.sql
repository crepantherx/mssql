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