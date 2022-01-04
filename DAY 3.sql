

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



------------VIEW------------
----A VIEW does not require any storage in a database because it does not exist physically--

--SYNTAX---
CREATE VIEW Demo
AS
SELECT * FROM Details
SELECT * FROM Demo

-----fetch data from multiple tables-----
CREATE VIEW Demo_multiple
AS
SELECT d.ID,d.Name,s.salary
FROM Details d
INNER JOIN Salary s
ON d.ID = s.Intern_ID

SELECT * FROM Demo_multiple

-----to fetch the view definition--
sp_helptext 'Demo'

--------REFRESH VIEW-----------
/* Suppose we have a view on a table to fetch all columns 
and now we add more columns to that table then view is not updated by its own
we have to refresh it*/

ALTER TABLE Details
ADD No_of_leave INT 

SELECT * FROM Demo ---it will show table without new column---
sp_refreshview 'Demo'
SELECT * FROM Demo -----now it will show------

----SCHEMA BINDING---------
/*If we dont want to alter or update any table which is use in view 
then we can use schemabinding */

CREATE VIEW Demo_schemabind
WITH SCHEMABINDING
AS
SELECT * FROM Detials  ---we can not select * when we use schemabinding

CREATE VIEW Demo_schemabind
WITH SCHEMABINDING
AS
SELECT ID,Name FROM [dbo].[Details]

-----view encryption-----
/* if we want that user can not see the view definition 
even by using storeprocedure sp_helptext then use with encryption*/

ALTER VIEW Demo_schemabind
WITH ENCRYPTION
AS
SELECT * FROM dbo.Details

sp_helptext 'Demo_schemabind'

-----VIEW FOR DML------
/* we can use view to insert,update and delete data so we need to know some points
We can use DML operation on a single table only
VIEW should not contain Group By, Having, Distinct clauses
We cannot use a subquery in a VIEW in SQL Server
We cannot use Set operators in a SQL VIEW */

INSERT INTO Demo VALUES(7,'ABC',64,'ANY',1)
DELETE FROM Demo WHERE ID = 7
UPDATE Demo SET Name = 'dolly' WHERE ID = 1
SELECT * FROM Demo

----we can check conditions in view with dml operations----
CREATE VIEW Demo_check_option
AS
SELECT * FROM dbo.Details
WHERE Name like 'd%'
WITH CHECK OPTION

INSERT INTO Demo_check_option VALUES(12,'ANY',56,'ASD',5) --does not work
INSERT INTO Demo_check_option VALUES(8,'dNY',56,'ASD',5)

----DROP VIEW----
DROP VIEW Demo

-----INDEXED VIEW------------------
/* To enhance the performance of complex queries, 
a unique clustered index can be created on the view,
where the result set of that view will be stored in 
your database the same as a real table with a unique clustered index */

CREATE VIEW DEMO_VIEW
WITH SCHEMABINDING
AS
SELECT ID,Name 
FROM dbo.Details 

CREATE UNIQUE CLUSTERED INDEX IX_ON_DEMOVIEW
ON DEMO_VIEW 
(ID,Name)		

SELECT * FROM DEMO_VIEW

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


 --------TRIGGERS--------
 /*triggers are special stored procedures that are executed automatically 
 in response to the database object, database, and server events 
 ------TYPES-------------
 1. DML TRIGGERS
 2. DDL TRIGGERS
 3. LOGON TRIGGERS

 --VIRTUAL TABLE FOR TRIGGERS---
 Triggers maintain two virtual tables inserted and deleted tables 
 to capture data of modified row before and after the event occurs
 */
 ---DML TRIGGERS----
 CREATE TRIGGER trg_Details
 ON Details
 AFTER INSERT,DELETE
 AS
 BEGIN
  SELECT * FROM INSERTED AS insert_detail
  UNION ALL
  SELECT * FROM DELETED AS delete_detail
END

INSERT INTO Details(ID,Name,Age,Profession,No_of_leave)
VALUES(9,'asd',45,'kjh',6)

DELETE FROM Details
WHERE ID = 9
	
ALTER TRIGGER trg_Details
 ON Details
 AFTER INSERT,DELETE
 AS
 BEGIN
  SELECT * FROM INSERTED AS insert_detail
  SELECT * FROM DELETED AS delete_detail
  SELECT * FROM Details
END

-----DDL TRIGGERS-----------------------
CREATE TRIGGER tr_on_database
ON DATABASE
FOR 
 DROP_TABLE,ALTER_TABLE
AS
BEGIN
 PRINT 'You must be disable triggger to alter table'
 END

 ALTER TABLE Details
 ADD last_name nvarchar(10)

 alter trigger tr_on_database
 DROP trigger tr_on_database

 DROP TRIGGER  tr_on_database    
ON  DATABASE 