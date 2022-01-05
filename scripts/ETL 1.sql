/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [StudentId]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
  FROM [INTERNS].[dbo].[tbStudent]

  TRUNCATE table [dbo].[tbStudent]
  select @@SERVERNAME

  CREATE DATABASE ETL
  
  SELECT * INTO Employee_details
  FROM INTERNS.dbo.Emp

  SELECT * FROM Employee_details
  TRUNCATE TABLE Employee_details
  
  SELECT * INTO STUDENT_DETAILS
  FROM INTERNS.dbo.tbStudent
  TRUNCATE TABLE STUDENT_DETAILS

  SELECT * FROM STUDENT_DETAILS

  SELECT * INTO STUDENT_DETAILS_multi
  FROM INTERNS.dbo.tbStudent
  SELECT * FROM STUDENT_DETAILS_multi
  TRUNCATE TABLE STUDENT_DETAILS_multi
SET IDENTITY_INSERT STUDENT_DETAILS_multi ON
--*************************************************************--
Create table TB
(
StudentId int,
FirstName varchar(50),
MiddleName varchar(50),
LastName varchar(50)
)

select * from TB 
TRUNCATE TABLE TB

--*****************************************--  
  SELECT * INTO TB_fixed_width
  FROM TB
  SELECT * FROM TB_fixed_width 

  --*********************************************--
  SELECT * INTO TB_Comma_separated
  FROM TB
  SELECT * FROM TB_Comma_separated 

 --************************************************--
 SELECT * INTO big_data
 FROM Employee.employees.employees

 SELECT * FROM big_data
 TRUNCATE TABLE big_data
 --without fast parse  Finished, 15:13:54, Elapsed time: 00:00:26.906--
 --after fast parse Finished, 15:31:40, Elapsed time: 00:00:19.016--
 --******************************************************************----

MONTH(GETDATE()) == 1 ? "JAN":
MONTH(GETDATE()) == 2 ? "FEB":
MONTH(GETDATE()) == 3 ? "MARCH":
MONTH(GETDATE()) == 4 ? "APRIL":
MONTH(GETDATE()) == 5 ? "MAY":
MONTH(GETDATE()) == 6 ? "JUN":
MONTH(GETDATE()) == 7 ? "JULY":
MONTH(GETDATE()) == 8 ? "AUG":
MONTH(GETDATE()) == 9 ? "SEP":
MONTH(GETDATE()) == 10 ? "OCT":
MONTH(GETDATE()) == 11 ? "NOV": "DEC"

---*******************************************************************************************
CREATE TABLE EXECUTE_SQL_TASK
(
 ID INT IDENTITY(1,1),
 NAME VARCHAR(50),
 GENDER VARCHAR(10)
)
INSERT INTO EXECUTE_SQL_TASK 
VALUES('A','M')
DROP TABLE EXECUTE_SQL_TASK

SELECT * FROM EXECUTE_SQL_TASK

--************************************************************************************
CREATE TABLE Files_to_load
(
Folderpath varchar(100),
FileName varchar(100)
)
 INSERT INTO Files_to_load 
 VALUES('C:\Users\DOLLY SINGH\Documents\SOURCE_files_for_ETL','customer_details')

 select Folderpath,FileName from Files_to_load

CREATE TABLE customer
(
customerID int,
customer_name varchar(100)
)

select * from customer
--****************************************************************************************
SELECT * FROM [dbo].[lookup_matched]
SELECT * FROM [dbo].[lookup_unmatched]

TRUNCATE TABLE [dbo].[lookup_matched]


--*****************************************************************************************--
/*
slowly changing dimension can be used for incremental data load.
It has three types 
1.SCD type1(changing attributre):used to overwrite existing data in dimension or
destination table with the data from source table. so no history is kept

2.SCD type2(Historical attribute):used to store history of existing data with new data
in destination table.we can use start and end date to identify the active record.

3.SCD type3(Fixed attribute):if we don't want to change a data of particular column
over period o time we can use this type there
*/

CREATE TABLE dbo.Source_Employee
(
    Emp_id int,
    First_name varchar(50),
	last_name varchar(50),
	Designation varchar(50)
);
INSERT INTO Source_Employee
Values
(1,'sony','yadav','engineer'),
(2,'aman','singh','DBA'),
(3,'sita','agrwal','analyst'),
(4,'neeti','bisht','software_engineer')

CREATE TABLE dbo.Dimension_Employee
(
    Id int identity(1,1),
	Emp_id int,
    First_name varchar(50),
	last_name varchar(50),
	Designation varchar(50),
	Startdate datetime,
	Enddate datetime
);

SELECT * FROM Source_Employee
SELECT * FROM Dimension_Employee

--SCD type 1 changing atrribute--
UPDATE Source_Employee
SET last_name = 'singhhh'
WHERE Emp_id = 3

--SCD type 2 historical attribute--
UPDATE Source_Employee
SET Designation = 'analyst'
WHERE Emp_id = 3

--SCD type 3 fixed attribute--
UPDATE Source_Employee
SET First_name = 'Sonnnyyy'
WHERE Emp_id = 1

TRUNCATE TABLE Dimension_Employee

--*****************************************************************************************--
--merge join---
SELECT * INTO Dummy_emp
FROM Employee.employees.employees

SELECT * FROM Dummy_emp
TRUNCATE TABLE Dummy_emp
INSERT INTO Dummy_emp
VALUES
(64430,'Nahum','Limongiello','F'),
(64431,'Faiza','Zongker','M')

select * from [dbo].[Merge_join_tranformation]

--******************************************************************--
--OLE DB Command--

select * into source_emp_copy
from Source_Employee

select * from source_emp_copy
truncate table source_emp_copy
--***********************************************************************--
--row count--
CREATE table package_load_information
(
 Pkgid int identity(1,1),
 packageName varchar(50),
 insertRecordCount int,
 Load_date_time datetime default getdate()
 )
 SELECT * FROM package_load_information
 SELECT * FROM [dbo].[row_count_transformation]

 INSERT INTO package_load_information(packageName,insertRecordCount)
 values(?,?)

 --************************************************************************************--
 /* UNION ALL  
 can have more than two input
 data output is unsorted 
 can accept unsorted data */
 --************************************************************************************--

 --exec strore procedure from ssis-------
 CREATE TABLE person
 ( p_id int identity(1,1),
   P_Name varchar(50),
   place varchar(50)
 )
 
 CREATE PROCEDURE sp_insert_person
 @place varchar(50)
 AS
 BEGIN
    Insert into person(P_Name,place)
	values('Dolly',@place)
 END

 Exec sp_insert_person 'kolkata'
 select * from person
 truncate table person

 --sp with output parameter--
 ALTER PROCEDURE sp_insert_person_out
 @place varchar(50),
 @msg varchar(50) output
 AS
 BEGIN
    set @msg= 'output_string'
    Insert into person(P_Name,place)
	values('Dolly',@place)
	
 END

 declare @message varchar(50)
 exec sp_insert_person_out
 @place = 'noidaa',
 @msg = @message output
 print @message 

--*************************************************************************************--
--single row task---
select * from Source_Employee
--****************************************************************************************--


--LOOKUP TRANSFORMATION----
/*
1. It helps us to have a look in source table and compare with the reference table
   to filter out matched records and unmatched records
*/
SELECT TOP (4) [id]
      ,[fullname] INTO Lookup_reference_table
  FROM [BikeStores].[hr].[employees]

SELECT * FROM Lookup_reference_table

SELECT * FROM [match_record_details]

TRUNCATE TABLE [match_record_details]

--****************************************************************************************--
CREATE TABLE Sales_details  
(  
   Name nvarchar(50),  
   [Year] [int] ,  
   Sales [int]  
) 
drop table Sales_details 

INSERT INTO Sales_details  
SELECT 'Pankaj',2010,72500 UNION ALL  
SELECT 'Rahul',2010,60500 UNION ALL  
SELECT 'Sandeep',2010,52000 UNION ALL  
SELECT 'Pankaj',2011,45000 UNION ALL  
SELECT 'Sandeep',2011,82500 UNION ALL  
SELECT 'Rahul',2011,35600 UNION ALL  
SELECT 'Pankaj',2012,32500 UNION ALL  
SELECT 'Pankaj',2010,20500 UNION ALL  
SELECT 'Rahul',2011,200500 UNION ALL  
SELECT 'Sandeep',2010,32000   

SELECT * FROM Sales_details; 
go;


SELECT Year, [Pankaj], [Rahul], [Sandeep] 
FROM Sales_details 
PIVOT (
	avg(Sales)
	FOR Name in ([Pankaj], [Rahul], [Sandeep])
) AS pvt

