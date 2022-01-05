CREATE DATABASE DB

SELECT name
FROM sys.databases


CREATE DATABASE dl IF NOT IN ('fr', 're')
GO

CREATE DATABASE IF NOT EXISTS DB


IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'DB')
BEGIN
	CREATE DATABASE DB
end

ALTER DATABASE DB 
MODIFY NAME = DB_1 

EXEC sp_renameDB 'DB_1','DB'


CREATE TABLE prac_table
( ID INT PRIMARY KEY)

CREATE TABLE t1   
(ID INT,
CONSTRAINT durga_doll FOREIGN KEY (ID) REFERENCES prac_table(ID)
)

INSERT Into prac_table 
values
(1),
(2)

INSERT Into TAB1 
values
(1),
(2)

SELECT * 
FROM prac_table

SELECT *
FROM TAB1

INSERT Into TAB1 
values
(3)
GO

WITH cte_doll AS
(
	SELECT *, 
			ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID) AS RK
	FROM TAB1
)  SELECT * FROM cte_doll



DELETE FROM TAB1 WHERE (
	SELECT *, 
			ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID) AS RK
	FROM TAB1
) 

alter table TAB1 
drop constraint FK__TAB1__ID__25869641

DELETE FROM TAB1 WHERE ID=3

ALTER TABLE TAB1
ADD CONSTRAINT
	FK_doll FOREIGN KEY (ID) REFERENCES prac_table(ID)


CREATE TABLE t2   
(ID INT,
name varchar(64) DEFAULT 'sudhir',
CONSTRAINT durga_dll FOREIGN KEY (ID) REFERENCES prac_table(ID)
)

SELECT *
FROM t3

CREATE TABLE t3
(ID INT,
CONSTRAINT durga_dl FOREIGN KEY (ID) REFERENCES prac_table(ID)
)

ALTER TABLE t2
ALTER 

SELECT *
FROM sys.all_columns

exec sp_rename 
@objname = 'DB.dbo.t2.ID',
@newname = 'num',
@objtype = 'COLUMN'

alter table t2
alter column sp_rename 'num','NUM'


sp_rename 'DB', 'll', 'DATABASE'

alter table t2 
add  cl int identity(1,1) 


INSERT Into t2 
values
(5,'hgh')

alter table t2
drop 
constraint durga_dll

select * from t2


SS00
SS01

CREATE TABLE t4 (
	name varchar(32) identity(
)

CREATE TABLE dbo.dm(ID INT IDENTITY PRIMARY KEY,
                      IDwithChar AS 'C' + RIGHT('000000' + CAST(ID AS VARCHAR(10)), 6) PERSISTED,
					  nn varchar(50)
                     )

INSERT INTO dbo.dm
VALUES
('rahu')

SELECT *
FROM dbo.dm










/***********************************************************************************/

select  * FROM (

SELECT employees.emp_no,name,dept_name, MAX(salary)as max_sal 

FROM employees.salaries
join employees.employees
on employees.employees.emp_no= employees.salaries.emp_no
join employees.dept_emp
on employees.dept_emp.emp_no= employees.employees.emp_no
join employees.departments
on employees.departments.dept_no=employees.dept_emp.dept_no

GROUP BY employees.emp_no,name,dept_name
) tmp
WHERE max_sal=(
SELECT max(max_sal) FROM (
SELECT employees.emp_no,name,dept_name, MAX(salary)as max_sal 

FROM employees.salaries
join employees.employees
on employees.employees.emp_no= employees.salaries.emp_no
join employees.dept_emp
on employees.dept_emp.emp_no= employees.employees.emp_no
join employees.departments
on employees.departments.dept_no=employees.dept_emp.dept_no

GROUP BY employees.emp_no,name,dept_name
)ge
)


SELECT TOP 1 * FROM (
SELECT TOP 3 E.emp_no, salary
FROM employees.salaries AS S
JOIN employees.employees AS E ON E.emp_no = S.emp_no

ORDER BY salary DESC
) hh
ORDER BY salary




156286



WITH nth AS (
SELECT  E.emp_no, salary,DE.dept_no,
	DENSE_RANK() OVER(PARTITION BY DE.dept_no ORDER BY salary DESC) AS RK
FROM employees.salaries AS S
JOIN employees.employees AS E ON E.emp_no = S.emp_no
JOIN employees.dept_emp AS DE ON DE.emp_no = E.emp_no
) SELECT *
FROM nth 
WHERE RK = 5



--cursor
declare @name varchar(14)
declare db_cursor cursor for
select name from employees.employees
where emp_no in(10001,10004,10008)
open db_cursor 
fetch next from db_cursor into @name
close db_cursor
deallocate db_cursor

-------view-------
create view vw_on_name
as
select name from employees.employees

select * from vw_on_name

-----stored procedure

create procedure sp2
@gender varchar(20) ,
@countname int output
as 
begin
select @countname=count(emp_no) 
from employees.employees
where gender=@gender
end

exec sp1 'dolly'

declare @cn int 
exec sp2 @gender='M',@countname=@cn output
print @cn


select * into dummy
from employees.tbl_person
where 1=2

select * from dummy

--------------**********************************************---------------------------
CREATE DATABASE TEST

CREATE TABLE TEST_TABLE
(ID INT PRIMARY KEY IDENTITY(1,1),
NAME VARCHAR(20) DEFAULT 'DOLLY',
AGE INT CHECK (AGE>18),
CITY VARCHAR(50)
)

CREATE TABLE TEST_TABLE2
(ID INT,
SALARY INT ,
PROFESSION VARCHAR(50) DEFAULT 'NOT KNOWN',
CONSTRAINT FK_ID FOREIGN KEY(ID) REFERENCES TEST_TABLE(ID) 
)

INSERT INTO TEST_TABLE VALUES
('RAM',20,'AYODHYA'),
('SHYAM',22,'VRINDAWAN'),
('RADHA',19,'BARSANA')

INSERT INTO TEST_TABLE2
VALUES(1,5000,'ENGINEER'),
(3,6000,'DATA ANALYST'),
(2,8000,'SOFTWARE ENGINEER')

SELECT * FROM TEST_TABLE
SELECT * FROM TEST_TABLE2

INSERT INTO TEST_TABLE2
VALUES (1,5000,'DESIGNER'),
(2,5000,'PROGRAMMER'),
(2,4000,'WEB DESIGNER')

SELECT NAME,CITY,SALARY 
FROM TEST_TABLE T1
JOIN TEST_TABLE2 T2
ON T1.ID = T2.ID
ORDER BY SALARY DESC

SELECT NAME,CITY,SUM(SALARY) AS TOTAL,MAX(SALARY) AS MAX_SAL
FROM TEST_TABLE T1
JOIN TEST_TABLE2 T2
ON T1.ID = T2.ID
GROUP BY NAME,CITY
ORDER BY TOTAL DESC

CREATE PROCEDURE TESTtbl_details_sp1 
AS 
BEGIN 
SELECT * FROM TEST_TABLE
END


EXEC TESTtbl_details_sp1


CREATE PROCEDURE SP_WITH_PARA
  @INPUT_NAME VARCHAR(20),
  @TOTAL_SAL INT OUTPUT 
AS 
BEGIN
 SELECT  @TOTAL_SAL=SUM(SALARY) 
 FROM TEST_TABLE T1
JOIN TEST_TABLE2 T2
ON T1.ID = T2.ID
WHERE NAME = @INPUT_NAME

END

DECLARE @A INT 
EXEC SP_WITH_PARA  @INPUT_NAME='RADHA' ,@TOTAL_SAL=@A OUT
PRINT @A

CREATE INDEX IX_TEST_TABLE2
ON TEST_TABLE2(PROFESSION)

SELECT * FROM TEST_TABLE2
ORDER BY PROFESSION

----TRIGGER

CREATE TRIGGER TR_ON_TESTTBL 
ON TEST_TABLE
FOR INSERT
AS
BEGIN 
SELECT * FROM TEST_TABLE
END

INSERT INTO TEST_TABLE
VALUES (1,5000,'GRAPHIC DESIGNER')

---functions----
CREATE FUNCTION FUN (@AGE INT)
RETURNS INT
AS 
BEGIN
 DECLARE @A ,
 SET @A=
  CASE  
   WHEN @AGE >50 THEN  1 ELSE 0
  END
 RETURN @A
END


select * from employees.employees 
where  year(hire_date) = 2015