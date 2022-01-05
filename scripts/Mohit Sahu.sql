HASH MAP JOIN
===
SELECT *
FROM [MASTER].[HR].[EMPLOYEES]
INNER HASH JOIN [MASTER].[HR].[DEPARTMENTS]
ON ([MASTER].[HR].[EMPLOYEES].DEPARTMENT_ID =[MASTER].[HR].[DEPARTMENTS].DEPARTMENT_ID )
FROM [MASTER].[HR].[EMPLOYEES]
INNER HASH JOIN [MASTER].[HR].[DEPARTMENTS]
ON ([MASTER].[HR].[EMPLOYEES].DEPARTMENT_ID =[MASTER].[HR].[DEPARTMENTS].DEPARTMENT_ID )
==================================
NESTED LOOPS JOINS NESTED LOOPS JOINS
------------
SELECT *
FROM [MASTER].[HR].[EMPLOYEES]
INNER LOOP JOIN [MASTER].[HR].[DEPARTMENTS]
ON ([MASTER].[HR].[EMPLOYEES].DEPARTMENT_ID =[MASTER].[HR].[DEPARTMENTS].DEPARTMENT_ID )
NESTED LOOPS JOINS
FROM [MASTER].[HR].[EMPLOYEES]
INNER LOOP JOIN [MASTER].[HR].[DEPARTMENTS]
ON ([MASTER].[HR].[EMPLOYEES].DEPARTMENT_ID =[MASTER].[HR].[DEPARTMENTS].DEPARTMENT_ID )
==========================
MERGE JOIN
-------------
SELECT *
 FROM [MASTER].[HR].[EMPLOYEES] AS A JOIN
 [MASTER].[HR].[DEPARTMENTS] AS B ON
 (A.DEPARTMENT_ID=B.DEPARTMENT_ID)OPTION (MERGE JOIN)

==========================
-------------Enable Adaptive Join
.
---------------Reason 1: Incorrect Compatibility Level
----------Even though you are using SQL Server 2017 or SQL Server 2019, your compatibility level may not contain values for SQL Server
-------------2017 or 2019. If your database compatibility level is lower than SQL Server 2017, you need to set it to a higher level. Here is how
-------------you can do it.
-------------For SQL Server 2017
ALTER DATABASE [DatabaseName]
SET COMPATIBILITY_LEVEL = 140
GO
For SQL Server 2019
ALTER DATABASE [DatabaseName]
SET COMPATIBILITY_LEVEL = 150
GO
-------------Reason 2: Enable Adaptive Join
-------------It is quite possible that even though the compatibility level is the latest, it is possible that this feature is explicitly disabled.
-------------Here is the script to enable this feature in your SQL Server.
-------------For SQL Server 2017
ALTER DATABASE SCOPED CONFIGURATION SET DISABLE_BATCH_MODE_ADAPTIVE_JOINS = ON;
-------------For SQL Server 2019
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ADAPTIVE_JOINS = OFF;
-------------Please do remember that this feature is on by default when you install SQL Server so if you find it disabled in your system,
-------------someone must have done that explicitly in the past.
-------------Summary
-------------Once you have enabled this feature on SQL Server 2017/2019 compatibility level, you should be able to use the feature of
-------------adaptive join.


==============
ALTER COLUMN
=============
CREATE TABLE DEMO2(DNO INT,DNAME VARCHAR(20), ID INT
IDENTITY(1,1))

INSERT INTO DEMO2 (DNO)VALUES (1),(2),(3),(4),(5)

----------------------
ALTER TABLE DEMO2

ADD DCITY VARCHAR(20);
----------------------

ALTER TABLE DEMO2
DROP COLUMN DCITY;
------------------------

ALTER TABLE DEMO2
 ALTER COLUMN DCITY VARCHAR(50)
-------------------------------
ALTER CONSTRAINT
=======================
ALTER TABLE DEMO2

ALTER COLUMN DCITY VARCHAR(20) NOT NULL;
--------------------------------------------------------------
ALTER TABLE DEMO2

ADD CONSTRAINT DF_DEMO2

DEFAULT'UNKNOWN' FOR DNAME
-------------------------------------------------------------
ALTER TABLE DEMO2

ADD CONSTRAINT P_DEMO2

PRIMARY KEY(DCITY)
--------------------------------------------------------------
ALTER TABLE DEMO2

ADD CONSTRAINT F_DEMO2

FOREIGN KEY(ID) REFERENCES DBO.DEMO(ID)
------------------------------------------------------------
ALTER TABLE DEMO2

DROP CONSTRAINT F_DEMO2;
Alter View
CREATE VIEW DEMOV AS SELECT * FROM DEMO;

SELECT * FROM DEMOV

ALTER VIEW DEMOV AS SELECT ID FROM demo

SELECT * FROM DEMOV
ALTER ON INDEX (enable/rebuild)



CREATE INDEX DEI ON DEMO2(DNO)

ALTER INDEX DEI ON DEMO2 DISABLE;

ALTER INDEX DEI ON DEMO2 REBUILD;

----------------------------------------------------
ALTER ON DATABASE


ALTER DATABASE SALES2019

MODIFY NAME=POL12
ALTER STORED PROCEDURE

====================================================================
CREATE PROCEDURE F_EX
AS

SELECT EMPLOYEE_ID,LAST_NAME,FIRST_NAME FROM MASTER.HR.EMPLOYEES;

EXEC F_EX
====================================================================
ALTER PROCEDURE F_EX
AS

SELECT DEPARTMENT_ID,DEPARTMENT_NAME FROM MASTER.HR.DEPARTMENTS;

EXEC F_EX
====================================================================
ALTER TRIGGERS

DROP TABLE TRPR1

CREATE TABLE TRPR1(NO INT );

INSERT INTO TRPR1 VALUES(1),(2),(3),(4),(5)

DROP TRIGGER TRR1
=====================================================================
CREATE TRIGGER TRR1 ON TRPR1
 FOR INSERT,UPDATE,DELETE
 AS
BEGIN
 SELECT 'DATA CHANGE IN TABLE TRPR1 'AS MESSAGE
 END;
=====================================================================
 ALTER TRIGGER TRR1 ON TRPR1
 FOR INSERT,UPDATE,DELETE
 AS
BEGIN
 SELECT 'TABLE TRPR1 UPDATED ' AS AGE
 END;
====================================================================
SP_RENAME/SP_RENAMEDB
=====================================
RENAME PROCEDURES

SELECT * FROM SYSOBJECTS WHERE TYPE = 'P' AND CATEGORY = 0

EXEC SP_RENAME 'F_EX', 'F_XX';

SELECT * FROM SYSOBJECTS WHERE TYPE = 'P' AND CATEGORY = 0

DROP PROCEDURE F_XX
======================================
RENAME TRIGGERS

SELECT NAME FROM             SYS.TRIGGERS WHERE        TYPE = 'TR';

EXEC SP_RENAME 'TRPR2','TRPR1'

DROP TRIGGER TRP2
======================================
RENAME DATABASE


EXEC SP_RENAMEDB 'POL12','LOCALDEMO'
======================================



========================


select * from hr.employees e where 5=(select count(distinct(salary)) from hr.employees where salary>=e.salary)

select * from hr.employees where salary in (select min(salary) from (select distinct top 5 salary from hr.EMPLOYEES order by salary desc) as a)


----------
select salary into saldemo from hr.employees
select max(av) from (select avg(salary) as av from  hr.employees group by DEPARTMENT_ID) as ab
alter table saldemo add
id int identity(1,1) 

delete from saldemo where id not in(select min(id) from saldemo group by salary)
select* from saldemo 

drop table saldemo

select * from saldemo where id not  in(select min(id) from saldemo group by salary)

select * from saldemo  as sd where 1=(select count(distinct(salary)) from saldemo  where salary>=sd.salary )

select department_id,job_id,sum(salary) from hr.employees  group by cube
(department_id,job_id )

select job_id,count(employee_id) from hr.employees group by job_id

select max(salary),min(salary), max(salary)-min(salary) from hr.EMPLOYEES

select * from hr.employees


select e.manager_id,e.employee_id,e.salary from hr.employees as e where salary in
(select  min(salary) from hr.employees where manager_id is not null and salary>=6000 group by manager_id )

SELECT  COUNT(EMPLOYEE_ID),YEAR(HIRE_DATE),MONTH(HIRE_DATE)  FROM HR.EMPLOYEES GROUP BY YEAR(HIRE_DATE),MONTH(HIRE_DATE)

create table neg_pos(num INT);
insert into neg_pos values(-1);
insert into neg_pos values(-2);
insert into neg_pos values(-3);
insert into neg_pos values(-4);
insert into neg_pos values(1);
insert into neg_pos values(2);
insert into neg_pos values(3);
insert into neg_pos values(4);
SELECT * FROM NEG_POS

SELECT (SELECT SUM(NUM) FROM neg_pos WHERE NUM>0 ) AS A, (SELECT SUM(NUM) FROM neg_pos WHERE NUM<0 ) AS B

select * from information_schema.table_constraints
where constraint_type = 'Primary Key'


SELECT DEPARTMENT_ID ,STRING_AGG(EMPLOYEE_ID,',') WITHIN GROUP ( ORDER BY DEPARTMENT_ID) FROM HR.EMPLOYEES GROUP BY DEPARTMENT_ID


SELECT LAST_NAME,LEN(LAST_NAME) FROM HR.EMPLOYEES

SELECT EMPLOYEE_ID,DEPARTMENT_ID ,ROW_NUMBER() OVER(PARTITION BY DEPARTMENT_ID ORDER BY EMPLOYEE_ID) AS RK FROM HR.EMPLOYEES

SELECT EMPLOYEE_ID,DEPARTMENT_ID ,DENSE_RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY EMPLOYEE_ID) AS RK FROM HR.EMPLOYEES

SELECT EMPLOYEE_ID,HIRE_DATE,YEAR(HIRE_DATE) FROM HR.EMPLOYEES WHERE YEAR(HIRE_DATE) IN(2005,2006)


SELECT MIN(SALARY),MAX(SALARY) ,DEPARTMENT_ID FROM HR.EMPLOYEES GROUP BY DEPARTMENT_ID

SELECT COUNT(EMPLOYEE_ID),MONTH(HIRE_DATE),YEAR(HIRE_DATE) FROM    HR.EMPLOYEES WHERE YEAR(HIRE_DATE)=2005
GROUP BY YEAR(HIRE_DATE),MONTH(HIRE_DATE)


SELECT DEPARTMENT_ID,SUM(SALARY) FROM HR.EMPLOYEES GROUP BY DEPARTMENT_ID  HAVING SUM(SALARY)>50000  


SELECT CONCAT( LEFT('MOHIT',1),LOWER (SUBSTRING('MOHIT',2,LEN('MOHIT'))))

SELECT EMPLOYEE_ID,SALARY FROM HR.EMPLOYEES WHERE SALARY =(SELECT SALARY FROM HR.EMPLOYEES WHERE EMPLOYEE_ID=138)

SELECT EMPLOYEE_ID,DEPARTMENT_ID FROM HR.EMPLOYEES WHERE DEPARTMENT_ID =(SELECT DEPARTMENT_ID FROM HR.EMPLOYEES WHERE EMPLOYEE_ID=145)

SELECT EMPLOYEE_ID,LAST_NAME ,SALARY,DEPARTMENT_ID FROM HR.EMPLOYEES WHERE SALARY>(SELECT SALARY FROM HR.EMPLOYEES WHERE EMPLOYEE_ID=138) 
AND DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM HR.EMPLOYEES WHERE EMPLOYEE_ID=145)

SELECT DEPARTMENT_ID ,AVG(SALARY) FROM HR.EMPLOYEES GROUP BY DEPARTMENT_ID HAVING AVG(SALARY)>(SELECT AVG(SALARY) FROM HR.EMPLOYEES)


SELECT  DISTINCT TOP 5 ( SALARY) FROM HR.EMPLOYEES ORDER BY SALARY DESC


SELECT E.SALARY FROM HR. EMPLOYEES AS E  WHERE 3=(SELECT COUNT(DISTINCT SALARY) FROM HR.EMPLOYEES WHERE SALARY>=E.SALARY )

SELECT EMPLOYEE_ID,JOB_ID FROM HR.EMPLOYEES WHERE JOB_ID IN(SELECT JOB_ID FROM HR.EMPLOYEES WHERE JOB_ID='IT_PROG')

SELECT* FROM HR.EMPLOYEES WHERE DEPARTMENT_ID IN
	(SELECT DEPARTMENT_ID FROM HR.DEPARTMENTS WHERE LOCATION_ID IN
	(SELECT LOCATION_ID FROM HR.LOCATIONS WHERE COUNTRY_ID IN
	(SELECT COUNTRY_ID FROM HR.COUNTRIES WHERE REGION_ID IN
	(SELECT REGION_ID FROM HR.REGIONS WHERE  REGION_NAME='Americas')
	) 
	)
	)

	SELECT * FROM HR.REGIONS

	select e.salary from hr.employees as e where 3=(select COUNT(distinct (salary)) from hr.EMPLOYEES where salary>=e.SALARY  )



	select * from (select distinct salary,DENSE_RANK() over(  order by salary)  as r from hr.employees) as a where r=3
	  select department_id ,avg(salary) from hr.employees group by DEPARTMENT_ID
	 select department_id ,avg(salary) from hr.employees e where salary>(select avg(salary) from hr.employees where DEPARTMENT_ID=e.DEPARTMENT_ID )
	 group by DEPARTMENT_ID


	 select * from (select salary,DENSE_RANK()over(order by salary desc) as r from hr.employees) as s where r=3
	 select distinct salary from hr.EMPLOYEES order by salary desc
 select * from hr.EMPLOYEES as e where 3=(select count(distinct salary) from hr.employees where salary>=e.salary)


 SELECT TOP (1000) [JOB_ID]
      ,[JOB_TITLE]
      ,[MIN_SALARY]
      ,[MAX_SALARY]
  FROM [master].[HR].[JOBS]

  select * from hr.jobs

  select * from hr.employees where job_id in(select job_id from hr.jobs where job_title='Sales Manager')

  select upper('mohit'),lower('Mohit'),concat(upper(substring('mOHIT',1,1)),lower(substring('mOHIT',2,len('mOHIT'))) )

  -------------------------------------------------
  create procedure initcap (@a varchar(50))
	
	as
	begin

	print concat(upper(substring(@a,1,1)),lower(substring(@a,2,len(@a))) )

	end

	exec initcap 'mLOOLLO'

	drop procedure proinitcap

	create procedure proinitcap (@a varchar(50))
	
	as
	begin

	print concat(upper(substring(@a,1,1)),lower(substring(@a,2,len(@a))) )

	end

	

	exec proinitcap 'mOHIKDWD '
	---------------------------------


	create function initcap (@a varchar(50))
	returns varchar(60)
	as
	begin

	declare

	@reval varchar(50)

	set @reval= concat(upper(substring(@a,1,1)),lower(substring(@a,2,len(@a))) )

	return @reval

	end

	select lower('MOHIT'),upper('mohit'),dbo.initcap('mOHIT')


	create function demail(@a int)

	returns varchar(60)

	as

	begin

	declare
	@reval varchar(60);

	declare
	@fn varchar(60);
	select @fn=first_name from hr.EMPLOYEES where employee_id=@a
	declare
	@ln varchar(60);
	select @ln=last_name from hr.EMPLOYEES where employee_id=@a

	set @reval=concat(@fn,@a,'.',@ln,'@Gmail.com')

	return @reval
	end;



	select dbo.demail(206)

	select concat('*',last_name,'*') from hr.employees

	 select len('dexxxepppppexx'),len('dexxxepppppexx')-charindex('e','dexxxepppppexx')+1


	select  charindex('e','dexxxepppppexx',len('dexxxepppppexx')-charindex('e','dexxxepppppexx')+1)


	CREATE FUNCTION CHARINDEX2
(
@TargetStr varchar(8000), 
@SearchedStr varchar(8000), 
@Occurrence int
)

RETURNS int

as
begin

declare @pos int, @counter int, @ret int

set @pos = CHARINDEX(@TargetStr, @SearchedStr)
set @counter = 1

if @Occurrence = 1 set @ret = @pos

else
begin

while (mr < @Occurrence)
begin

select @ret = CHARINDEX(@TargetStr, @SearchedStr, @pos + 1)

set @counter = @counter + 1

set @pos = @ret

end

end

RETURN(@ret)

end




select dbo.charindex2 ('e','exxexxexxe',3)


select left('mohit',3)

select employee_id,(employee_id %2 ) as eve0odd1 ,last_name,len(last_name) from hr.employees where (employee_id %2 )=0 and len(last_name)%2=1

select hire_date,year(getdate())-year(hire_date) from hr.EMPLOYEES

select replace('ahhahahhhaa','a','x')

select replace(phone_number,'.','') from hr.employees

select datediff(MONTH,hire_date,getdate()) from hr.employees

select PHONE_NUMBER, SUBSTRING(phone_number,dbo.CHARINDEX2('.',PHONE_NUMBER,2)+1,
LEN(PHONE_NUMBER)-dbo.CHARINDEX2('.',PHONE_NUMBER,3) -1) from hr.employees

DECLARE @DATE DATETIME
SET @DATE='2017-10-28'
SELECT @DATE AS GIVEN_DATE, @DATE-DAY(@DATE)+1 AS FIRST_DAY_OF_DATE, 
EOMONTH(@DATE) AS LAST_DAY_OF_MONTH

DECLARE @DATE DATETIME
SET @DATE='2017-10-20'

SELECT @DATE-DAY(@DATE)+1,EOMONTH(@DATE)

SELECT SALARY INTO DEMSAL  FROM HR.EmployeeS

ALTER TABLE DEMSAL 
ADD ID INT IDENTITY(1,1)

SELECT CONVERT(DATETIME,CONCAT(  YEAR(GETDATE()), '-12-31')) AS LAST_DATE_OF_YEAR

SELECT HIRE_DATE, CONVERT(DATETIME,HIRE_DATE) - DAY(HIRE_DATE)+1  AS FIRST_DAY_OF_HIRE_MONTH FROM HR. EMPLOYEES
 



SELECT   SALARY,COUNT(*) FROM DEMSAL GROUP BY SALARY HAVING COUNT(*)>1 

SELECT   SALARY,COUNT(*)   ,DENSE_RANK() OVER (PARTITION BY SALARY ORDER BY 1)   FROM DEMSAL GROUP BY SALARY  


===================

---------------------------------------------------

SELECT EMPLOYEE_ID,SALARY,DEPARTMENT_ID,DENSE_RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) FROM HR.EMPLOYEES

SELECT EMPLOYEE_ID,SALARY,DEPARTMENT_ID, RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) FROM HR.EMPLOYEES

SELECT EMPLOYEE_ID,SALARY,DEPARTMENT_ID,ROW_NUMBER() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) FROM HR.EMPLOYEES
---------------------------------------------------------------------
SELECT * FROM HR.EMPLOYEES

------------IN SAME TABLE------------------

SELECT MAX(SALARY) FROM HR.EMPLOYEES  WHERE SALARY<(SELECT MAX(SALARY) FROM HR.EMPLOYEES)

SELECT EMPLOYEE_ID,SALARY,DEPARTMENT_ID ,RK FROM
(SELECT EMPLOYEE_ID,SALARY,DEPARTMENT_ID,DENSE_RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS RK FROM HR.EMPLOYEES ) AS SA 
WHERE RK=1


----------------------------------------------------------------------
---------IN MULTIPLE TABLE USING JOIN------------
SELECT  ENO,DNO,SAL,DR FROM
(
select e.emp_no AS ENO,d.dept_no AS DNO ,s.salary AS SAL  , DENSE_RANK() over(partition by d.dept_no order by s.salary DESC ) dr from 

[Employee].[employees].[employees] as e

join [Employee].[employees].[dept_emp] as d

on(e.emp_no=d.emp_no)

join[Employee].[employees].[departments]

on([Employee].[employees].[departments].dept_no=d.dept_no)  

join [Employee].[employees].[salaries] as s 
on(e.emp_no=s.EMP_NO)) AS TEM WHERE DR=2

-----------------------------------------------
with cte

as

(
select e.emp_no,d.dept_no,s.salary  , DENSE_RANK() over(partition by d.dept_no order by s.salary ) dr from 

[Employee].[employees].[employees] as e

join [Employee].[employees].[dept_emp] as d

on(e.emp_no=d.emp_no)

join[Employee].[employees].[departments]

on([Employee].[employees].[departments].dept_no=d.dept_no)  

join [Employee].[employees].[salaries] as s 
on(e.emp_no=s.salary) group by e.emp_no,d.dept_no ,s.salary 

)
select * from cte where dr=1


--------------------------

-------------UPDATE CURSOR--------------
DROP TABLE DEMODEPT

SELECT * INTO DEMODEPT FROM HR.EMPLOYEES
SELECT *  FROM DEMODEPT


DECLARE @NO INT

DECLARE C2 CURSOR FOR SELECT DEPARTMENT_ID FROM HR.DEPARTMENTS
OPEN C2
FETCH NEXT FROM C2 INTO @NO

WHILE(@@FETCH_STATUS=0)
BEGIN

UPDATE DEMODEPT SET DEPARTMENT_ID=400 WHERE DEPARTMENT_ID=90
FETCH NEXT FROM C2 INTO @NO
PRINT 'TABLE UPDATED'
END

DEALLOCATE C2

----------------------------------

declare @name varchar(30);
declare cur1 cursor for select  location_id,city  from master.hr.locations;



open cur1;

fetch next from cur1 into @no,@name;

while(@@fetch_status=0)begin
print'  '+cast(@no as varchar(10))+'  '+@name;
fetch next from cur1 into @no,@name;

end;

close cur1;
deallocate cur1;
---------------------------------


declare @a varchar(50);

declare c1  cursor for select department_name from master.hr.DEPARTMENTS;

open c1;

fetch next from  c1 into @a ;

while(@@FETCH_STATUS=0)
begin

print 'dept_name='+@a;
fetch next from  c1 into @a ;
end;

close c1
deallocate c1

-------------------------------------------------
create function  calc(@a int,@b int,@c varchar(1))

returns int

as
begin


 
declare
@return_value int;

 

  IF (@c='+') SET @return_value = @a+@b;
  IF (@c='-') SET @return_value = @a-@b;
  IF (@c='*') SET @return_value = @a*@b;
  IF (@c='/') SET @return_value = @a/@b;
     
return @return_value;

end;
select master.dbo.calc(2,2,'+')
===============================================================

create function masked1( @a varchar(50))
returns varchar(50)

begin

declare
@eml varchar(50);

set @eml=  STUFF(@a,2,CHARINDEX('@',@a)-2,'*****') 

return @eml

end;
select master.dbo.masked1('assa@gmail.com')
-----------------------------------------------

inline table

create function desg(@desgn varchar(30))
returns table
as
return(select * from master.hr.EMPLOYEES where JOB_ID=@desgn)



select * from master.dbo.desg('IT_PROG')

-------------------------


multistatement table valued


create function muld()
returns @muldemo  table(id int,name varchar(30),hired date)
as
begin
insert into @muldemo 

select employee_id,concat(first_name,' ',last_name) ,cast(hire_date as date) from master.hr.employees;

return

end

select * from master.dbo.muld()
---------------------------------


declare @ano int
declare @aname varchar(30)

declare democursor  cursor for select  employee_id,concat(first_name,' ',last_name) from master.hr. employees where department_id<=60

open  democursor


fetch next from democursor into @ano,@aname

while (@@fetch_status=0)  begin

print 'emp_id='+  cast(@ano as varchar(5) )+'full_name='+@aname 

fetch next from democursor into @ano,@aname;

end
close democursor
deallocate democursor
-------------------------------------

declare @no int;
declare @name varchar(30);
declare cur1 cursor for select  location_id,city  from master.hr.locations;



open cur1;

fetch next from cur1 into @no,@name;

while(@@fetch_status=0)begin
print'  '+cast(@no as varchar(10))+'  '+@name;
fetch next from cur1 into @no,@name;

end;

close cur1;
deallocate cur1;
------------------------------------------------------------

create function aor(@l int ,@w int)
returns int

as
begin

declare
@a int;

set @a=@l*@w;

return @a;

end;

select dbo.aor(4,2) as 'Area Of Rectangle'


=====================

create function  calc(@a int,@b int,@c varchar(1))

returns int

as
begin


 
declare
@return_value int;

 

  IF (@c='+') SET @return_value = @a+@b;
  IF (@c='-') SET @return_value = @a-@b;
  IF (@c='*') SET @return_value = @a*@b;
  IF (@c='/') SET @return_value = @a/@b;
     
return @return_value;

end;
select master.dbo.calc(2,2,'+')
===============================================================

create function masked1( @a varchar(50))
returns varchar(50)

begin

declare
@eml varchar(50);

set @eml=  STUFF(@a,2,CHARINDEX('@',@a)-2,'*****') 

return @eml

end;
select master.dbo.masked1('assa@gmail.com')
-----------------------------------------------

inline table

create function desg(@desgn varchar(30))
returns table
as
return(select * from master.hr.EMPLOYEES where JOB_ID=@desgn)



select * from master.dbo.desg('IT_PROG')

-------------------------


multistatement table valued


create function muld()
returns @muldemo  table(id int,name varchar(30),hired date)
as
begin
insert into @muldemo 

select employee_id,concat(first_name,' ',last_name) ,cast(hire_date as date) from master.hr.employees;

return

end

select * from master.dbo.muld()
---------------------------------


declare @ano int
declare @aname varchar(30)

declare democursor  cursor for select  employee_id,concat(first_name,' ',last_name) from master.hr. employees where department_id<=60

open  democursor


fetch next from democursor into @ano,@aname

while (@@fetch_status=0)  begin

print 'emp_id='+  cast(@ano as varchar(5) )+'full_name='+@aname 

fetch next from democursor into @ano,@aname;

end
close democursor
deallocate democursor
-------------------------------------

declare @no int;
declare @name varchar(30);
declare cur1 cursor for select  location_id,city  from master.hr.locations;



open cur1;

fetch next from cur1 into @no,@name;

while(@@fetch_status=0)begin
print'  '+cast(@no as varchar(10))+'  '+@name;
fetch next from cur1 into @no,@name;

end;

close cur1;
deallocate cur1;
------------------------------------------------------------
create function aor(@l int ,@w int)
returns int

as
begin

declare
@a int;

set @a=@l*@w;

return @a;

end;

select dbo.aor(4,2) as 'Area Of Rectangle'
---------------------------------------

@ 1 procedure by which yo can find exact duration between your date and sysdate

--------------
create procedure x1 (@a varchar(30))

as


declare 
@yy1 int;
declare 
@mm1 int;
declare 
@dd1 int;
begin

select @yy1 = year(getdate()) - year(convert(date,(@a))) 


select @mm1=case when  month(convert(date,(@a)))  >month(getdate()) then

 month(convert(date,(@a)))  -month(getdate()) else

 month(getdate()) - month(convert(date,(@a))) end 


 select @dd1=case when  day(convert(date,(@a)))  >day(getdate()) then

day(convert(date,(@a)))  -day(getdate()) else

day(getdate()) - day(convert(date,(@a))) end 



select concat(@YY1,'year',@mm1,'months ',@dd1 ,'days') 

end ;

===============
@ 2 procedure by which yo can find exact duration between your date and sysdate
create procedure x2 (@a varchar(30), @b varchar(30))

as


declare 
@yy1 int;
declare 
@mm1 int;
declare 
@dd1 int;
begin

select @yy1 = year(convert(date,(@b))) - year(convert(date,(@a))) 


select @mm1=case when  month(convert(date,(@a)))  >month(convert(date,(@b))) then

 month(convert(date,(@a)))  -month(convert(date,(@b))) else

 month(convert(date,(@b))) - month(convert(date,(@a))) end 


 select @dd1=case when  day(convert(date,(@a)))  >day(convert(date,(@b))) then

day(convert(date,(@a)))  -day(convert(date,(@b))) else

day(convert(date,(@b))) - day(convert(date,(@a))) end 



select concat(@YY1,'year',@mm1,'months ',@dd1 ,'days') 

end ;
===================================================


select charindex('m','3111996mohit@gmail.com')
select charindex('m','mom',2)
select charindex('m','momom',4)

----------------------

select substring('mohit_sahu',1,5)
select substring('mohit_sahu',1,charindex('_','mohit_sahu')-1)
select substring('311@gmail.com',charindex('@','311@gmail.com')+1,len('311@gmail.com')-charindex('@','311@gmail.com'))

select REPLICATE('*',5)


select 'mohit'+space(5)+'sahu'

select patindex('%@gmail.com','3111996mohit@gmail.com')

select replace('mohit','t','*')

select stuff('mohit',3,5,'***')


select ascii('a') as 'ascii'

select char(65) as 'chr'

select LTRIM('    welcome') as 'ltr1'

select RTRIM('jack   ') as 'rtr2'

select TRIM('  mohit  ') as'tr1'

select lower('MOHIT') as'lwr'

select upper('mohit') as 'upr'

select len('mohit') as 'len1'

select reverse('mohit')


select concat('mohit','sahu')

select left('mohit',2)
select right('mohit',2)

create table job(nos int not null);
begin transaction;

INSERT INTO job VALUES(2),(7),(4),(5),(2),(1),(7),(9);

save transaction go1;
select * from job



rollback transaction go1;
---------------------
INSERT INTO job VALUES(0),(0),(0)
commit transaction;
------------------------

select * from job


select getdate()

select datediff(MONTH ,convert(date,('1996-01-31')),getdate())/12
-------------------------------

procedure by which yo can find exact duration between your date and sysdate

--------------
create procedure x1 (@a varchar(30))

as


declare 
@yy1 int;
declare 
@mm1 int;
declare 
@dd1 int;
begin

select @yy1 = year(getdate()) - year(convert(date,(@a))) 


select @mm1=case when  month(convert(date,(@a)))  >month(getdate()) then

 month(convert(date,(@a)))  -month(getdate()) else

 month(getdate()) - month(convert(date,(@a))) end 


 select @dd1=case when  day(convert(date,(@a)))  >day(getdate()) then

day(convert(date,(@a)))  -day(getdate()) else

day(getdate()) - day(convert(date,(@a))) end 



select concat(@YY1,'year',@mm1,'months ',@dd1 ,'days') 

end ;
==========================

select is_user_process,original_login_name,*
from sys.dm_exec_sessions order by login_time desc;

-------------------------------------------

create trigger tr_log1 on all server
for logon

as
begin

declare @loginname nvarchar(120)
  set @loginname= original_login()

  if(select count(*) from sys.dm_exec_sessions where is_user_process=1 and
  original_login_name=@loginname)>4
  begin

  print' more than 5 times attempted access blocked';

  rollback;
  end;
end

------------------------------
drop trigger tr_log1 on all server
----------------------------

USE Employee;
GO


CREATE VIEW dbo.LOG6
WITH SCHEMABINDING
AS
     SELECT nos
            
     FROM dbo.num1
          
GO

CREATE UNIQUE CLUSTERED INDEX [IX_Customer_NY_Name] ON [dbo].[lOG6] ( nos )
GO

CREATE INDEX POI3 ON dbo.LOG6(nos)
============================================
select * from employee.dbo.num1

nos
1
2
3
4
5
6
7
8
9
============================================

select * from dbo.LOG6
nos
1
2
3
4
5
6
7
8
9
=================================



CREATE VIEW dbo.LOG6
WITH SCHEMABINDING
AS
     SELECT nos
            
     FROM dbo.num1
          
GO

CREATE UNIQUE CLUSTERED INDEX [IX_Customer_NY_Name] ON [dbo].[lOG6] ( nos )
GO

CREATE INDEX POI3 ON dbo.LOG6(nos)
select * from employee.dbo.num1



drop table  num1
select * from dbo.LOG6


create table rop (nos int unique);
insert into rop values (1),(2)

create view h11  as select * from rop;

drop table rop
========================
dense rank

select department_id,salary ,dense_rank() over(partition by department_id order by salary) from master.hr.employees order by 1;
=========================================
rank

select department_id,salary ,rank() over(partition by department_id order by salary) from master.hr.employees order by 1;
============================================
row_number

select   employee_id,department_id,salary,ROW_NUMBER() over ( order by salary) from master.hr.employees ;
============================================
string_agg

SELECT department_id
     , STRING_AGG(employee_id, ',') WITHIN GROUP (ORDER BY employee_id) AS FieldBs
  FROM  master.hr.employees
 GROUP BY DEPARTMENT_ID;

===============================================


create procedure f1
as
select  * from  master.hr.employees;


exec f1;
=================

create procedure  f2 ( @nos int)
as
select * from master.hr.employees where  department_id = @nos;


exec f2 20

============

create procedure  f3 ( @nos int=40)
as
select * from master.hr.employees where  department_id = @nos;


exec f3 60
==========

CREATE PROCEDURE #Temp
AS
BEGIN
PRINT 'Local temp procedure'
END
exec #temp

=============
CREATE PROCEDURE ##Temp
AS
BEGIN
PRINT 'golbal temp procedure'
END
exec ##temp

==============
=============

TRIGGERS



SELECT  DEPARTMENT_ID,DEPARTMENT_NAME into dept_demo  FROM [master].[HR].[DEPARTMENTS]

===========
AFTER   
=======

CREATE TRIGGER DEPT_DEMOT ON DEPT_DEMO

FOR UPDATE

AS

SELECT 'DATA UPDATED ON DEPT_DEMO' AS MESSAGE;


UPDATE DEPT_DEMO SET DEPARTMENT_NAME='MOHIT' WHERE DEPARTMENT_ID=20;


o/p
 MESSAGE
DATA UPDATED ON DEPT_DEMO

============
BEFORE  (  INSTEAD OF ---- ) 
   
==========


CREATE TRIGGER DEPT_DEMOT2 ON DEPT_DEMO

INSTEAD OF  DELETE

AS

SELECT 'DATA DELETED FROM DEPT_DEMO TABLE' AS MESSAGE;

DELETE  FROM DEPT_DEMO WHERE DEPARTMENT_ID=20


O/P:

MESSAGE
DATA DELETED FROM DEPT_DEMO TABLE
====================
============
TRIGGRE ON DATABASE
CREATE TRIGGER DT1 ON DATABASE

FOR CREATE_TABLE

AS

SELECT 'TABLE CREATED ON MASTRE DB'


CREATE TABLE MAST_WX(NO INT)

OP;
(No column name)
TABLE CREATED ON MASTRE DB
==============
TRIGGER FOR ALL DDL
========

CREATE TRIGGER DT2 ON DATABASE

FOR DDL_DATABASE_LEVEL_EVENTS

AS

SELECT 'CHANGE IN OBJECTS OF MASTRE DB'



CREATE TABLE REX(RNO INT)

OP
(No column name)
CHANGE IN OBJECTS OF MASTRE DB



==========

INDEX VIEW (MATERIALIZE VIEW)



CREATE TABLE production.parts(
    part_id   INT NOT NULL, 
    part_name VARCHAR(100)
);

INSERT INTO 
    production_parts(part_id, part_name)
VALUES
    (1,'Frame'),
    (2,'Head Tube'),
    (3,'Handlebar Grip'),
    (4,'Shock Absorber'),
    (5,'Fork');

CREATE TABLE production.part_prices(
    part_id int,
    valid_from date,
    price decimal(18,4) not null,
    PRIMARY KEY(part_id, valid_from) 
);

ALTER TABLE production_parts
ADD PRIMARY KEY(part_id);

In case a table does not have a primary key, which is very rare, you can use the CREATE CLUSTERED INDEX statement to define a clustered index for the table.



CREATE CLUSTERED INDEX ix_parts_id
ON production_parts (part_id);


create procedure f1
as
select  * from  master.hr.employees;


exec f1;



================================
1) SELECT DISTINCT * INTO TEMP FROM TAB1;

TRUNCATE TAB1;

INSERT INTO TAB1 SELECT * FROM TEMP;




 ALTER TABLE [master].[dbo].[FF1]

  ADD P_ID INT IDENTITY(1,1) 


   DELETE  FROM  [master].[dbo].[FF1] WHERE P_ID  NOT IN
  ( SELECT MIN(P_ID)
  FROM [master].[dbo].[FF1] GROUP BY C)

===============================

2)INSERT INTO [master].[dbo].[t1] (c)VALUES(2),(7),(4),(5),(2),(1),(7),(9)



SELECT  C,TID FROM [master].[dbo].[t1] ORDER BY C

C	TID
1	1
1	25
2	24
2	2
2	20
3	3
4	6
4	22
5	23
5	7
7	21
7	5
7	26
9	27
9	11


SELECT C,MIN(TID) FROM [master].[dbo].[t1] GROUP BY C
C	(No column name)
1	1
2	2
3	3
4	6
5	7
7	5
9	11




DELETE  FROM [master].[dbo].[t1]  WHERE TID NOT IN  (SELECT MIN(TID) FROM [master].[dbo].[t1] GROUP BY C)
c	TID
1	1
2	2
3	3
7	5
4	6
5	7
9

========================================
3)


with cte
 AS 
 (

  SELECT C,ROW_NUMBER() OVER(PARTITION BY C ORDER BY C) ro
  FROM [master].[dbo].[t1]
 )
 DELETE FROM cte WHERE ro>1
======================
create table nulldemo (dname varchar(15),dcity varchar(15),dcountry varchar(15));



dname	dcity	dcountry
mohit	pune	ind
rahul	delhi	ind
nikita	ajmer	ind
mit	amravati	NULL
rai	mumbai	NULL
ekta	daund	NULL
NULL	amravati	NULL
NULL	mumbai	NULL
NULL	daund	NULL
NULL	NULL	ind
NULL	NULL	aus
NULL	NULL	pak
=======================================================================
case operations

select dname,dcity,dcountry, case when dname is null then'incomplete data' when dcity is null then 'incomplete data' when dcountry is null then 'incomplete data' else 'ok'  end from nulldemo;

dname	dcity	dcountry	(No column name)
mohit	pune	ind	ok
rahul	delhi	ind	ok
nikita	ajmer	ind	ok
mit	amravati	NULL	incomplete data
rai	mumbai	NULL	incomplete data
ekta	daund	NULL	incomplete data
NULL	amravati	NULL	incomplete data
NULL	mumbai	NULL	incomplete data
NULL	daund	NULL	incomplete data
NULL	NULL	ind	incomplete data
NULL	NULL	aus	incomplete data
NULL	NULL	pak	incomplete data

============================================================================================
select CONVERT(char(20),hire_date) from Employee.employees.employees

alter table emp3 
alter column sno  int NOT NULL
======================================================
CONVERT(char(20),hire_date)

create table emp3(sno int,sname varchar(15),scity nvarchar(20),salary int)

ALTER TABLE table_name
ALTER COLUMN col_name data_type NOT NULL;
===============================================
select * from tt1 
val
a
b
c
p
q
r


select * from tt2

val
a
b
c
x
y
z


select * from tt1 join tt2 on(tt1.val=tt2.val);

val	val
a	a
b	b
c	c

select * from tt1 left outer join tt2 on(tt1.val=tt2.val);
val	val
a	a
b	b
c	c
p	NULL
q	NULL
r	NULL

select * from tt1 right outer join tt2 on(tt1.val=tt2.val);
val	val
a	a
b	b
c	c
NULL	x
NULL	y
NULL	z

select * from tt1 full outer join tt2 on(tt1.val=tt2.val);
val	val
a	a
b	b
c	c
p	NULL
q	NULL
r	NULL
NULL	x
NULL	y
NULL	z
===========================================================
join operation on emp schema

select * from 
[Employee].[employees].[employees]

join [Employee].[employees].[dept_emp] 

on([Employee].[employees].[employees].emp_no=[Employee].[employees].[dept_emp].emp_no)

join[Employee].[employees].[departments]

on([Employee].[employees].[departments].dept_no=[Employee].[employees].[dept_emp].dept_no)

===========================================================
COALESCE
=======
Note : data type of  all parameter must be same  as first column or it is null

select coalesce(null,null,null,'hello','go') as ded;

ded
hello


select * from emp3

sno	sname	scity	salary
1	mohit	city	5000
2	NULL	NULL	NULL
3	NULL	NULL	NULL
4	mit	chandigarh	12000
NULL	NULL	mumbai	NULL
NULL	NULL	tokyo	NULL
NULL	NULL	nasik	NULL
NULL	NULL	NULL	100
NULL	NULL	NULL	100
NULL	NULL	NULL	100


SELECT sno	,sname	,scity	,salary ,
COALESCE (sname	,scity	) FROM emp3

sno	sname	scity	salary	(No column name)
NULL	mohit	city	5000	mohit
NULL	NULL	NULL	NULL	NULL
NULL	NULL	NULL	NULL	NULL
NULL	mit	chandigarh	12000	mit
NULL	NULL	mumbai	NULL	mumbai
NULL	NULL	tokyo	NULL	tokyo
NULL	NULL	nasik	NULL	nasik
NULL	NULL	NULL	100	NULL
NULL	NULL	NULL	100	NULL
NULL	NULL	NULL	100	NULL

==================================================
select jno,jpo,jko,coalesce(jno,jpo,jko) from jack2

jno	jpo	jko	(No column name)
1	2	3	1
4	5	6	4
7	8	9	7
NULL	2	3	2
NULL	9	10	9
NULL	11	12	11
NULL	NULL	13	13
NULL	NULL	55	55
NULL	NULL	99	99

==================================================

stored procedure

create procedure p1
AS

select  * from [Employee].[employees].[employees]join [Employee].[employees].[dept_emp] on([Employee].[employees].[employees].emp_no=[Employee].[employees].[dept_emp].emp_no)join[Employee].[employees].[departments]on([Employee].[employees].[departments].dept_no=[Employee].[employees].[dept_emp].dept_no);
 
Go;


====================

database


create database hello;

backup database hello
to disk='d:\op.bak';


drop database hello;
=====================
check

CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int CHECK (Age>=18)
);
select * from persons;

ID	LastName	FirstName	Age
1	mohit	sahu	19
2	karan	sharma	21
3	naval	shaha	57
4	pravin	gaud	66


insert into Persons values 
(6,'mohit','sahu',7)

Msg 547, Level 16, State 0, Line 1
The INSERT statement conflicted with the CHECK constraint "CK__Persons__Age__37703C52". The conflict occurred in database "Employee", table "dbo.Persons", column 'Age'.
The statement has been terminated.
=====================
create table home(hno int, hname varchar(20) default'PG_house');
insert into home  (hno) values(100);
select * from home;

hno	hname
100	PG_house

select * from home;

hno	hname
100	PG_house
102	opera
103	myntra
104	amazon
105	flipkart
106	zoom
500	PG_house
800	PG_house

=======================
select top 5 emp_no,sur_name  into logan from [Employee].[employees].[employees]

select * from logan;

emp_no	sur_name
10001	Facello
10002	Simmel
10003	Bamford
10004	Koblick
10005	Maliniak
=============================

select * from 
[Employee].[employees].[employees]

join [Employee].[employees].[dept_emp] 

on([Employee].[employees].[employees].emp_no=[Employee].[employees].[dept_emp].emp_no)

join[Employee].[employees].[departments]

on([Employee].[employees].[departments].dept_no=[Employee].[employees].[dept_emp].dept_no)  where  dept_name= 'Human Resources'; 
==========================
select top 5  employees.emp_no ,sur_name,dept_name from 
[Employee].[employees].[employees]

join [Employee].[employees].[dept_emp] 

on([Employee].[employees].[employees].emp_no=[Employee].[employees].[dept_emp].emp_no)

join[Employee].[employees].[departments]

on([Employee].[employees].[departments].dept_no=[Employee].[employees].[dept_emp].dept_no)  where  dept_name= 'Human Resources'; 


emp_no	sur_name	dept_name
10005	Maliniak	Human Resources
10013	Terkki	Human Resources
10036	Portugali	Human Resources
10039	Brender	Human Resources
10054	Schueller	Human Resources
================



CREATE TABLE tableName
( 
  column_1 datatype [ NULL | NOT NULL ],
  column_2 datatype [ NULL | NOT NULL ],
  ...
);
==================================================


ALTER TABLE table_name 
ALTER COLUMN column_name new_data_type(size);


select * from happy;


name_h
mohit
karan
nikhli
tushar

insert into happy values('mddfahfofoafoafhifh');

Msg 2628, Level 16, State 1, Line 1
String or binary data would be truncated in table 'master.dbo.happy', column 'name_h'. Truncated value: 'mddfahfofo'.
The statement has been terminated.

Completion time: 2021-12-02T13:37:50.9047663+05:30

alter table happy 
alter column name_h varchar(30);


insert into happy values('mddfahfofoafoafhifh');


name_h
mohit
karan
nikhli
tushar
mddfahfofoafoafhifh
==============================================================================
select * from employee.employees.employees where gender='M';


select top 5 * from employee.employees.employees where gender='M' ;

emp_no	birth_date	name	sur_name	gender	hire_date
10001	1953-09-02	Georgi	Facello	M	1986-06-26
10003	1959-12-03	Parto	Bamford	M	1986-08-28
10004	1954-05-01	Chirstian	Koblick	M	1986-12-01
10005	1955-01-21	Kyoichi	Maliniak	M	1989-09-12
10008	1958-02-19	Saniya	Kalloufi	M	1994-09-15

select top 5 emp_no,employee.employees.employees.name into KAAL1 from employee.employees.employees;

emp_no	name
10001	Georgi
10002	Bezalel
10003	Parto
10004	Chirstian
10005	Kyoichi



=============================================================================


create table demo2(sno int,sname varchar(10));

insert into  demo2 values(1,'mohit');
insert into  demo2 values(2,'rohit');
insert into  demo2 values(3,'karan');



drop table demo2;

CREATE TABLE task1
(
Course_ID Int,
Course_Name Varchar(10)
)
insert into task1 values(1,'run');
insert into task1 values(2,'jump');
insert into task1 values(3,'fight');
delete  from task1 where course_id=1

update task1 set Course_Name='cricket' where Course_id=2
select * from task1;

Course_ID	Course_Name
2	cricket
3	fight

truncate table task1;

select * from task1
O/P
Course_ID	Course_Name
==================================================================================
Alter TABLE <Table name> ADD Column1 datatype, Column2 datatype;


alter table task1 add city varchar(20);

OP

Course_ID	Course_Name	city


 
alter table task1 add pincode int;
Course_ID	Course_Name	city	pincode

alter table task1
drop column city;

Course_ID	Course_Name	pincode

alter table task1

drop column course_id;

Course_Name	pincode

alter table task1
drop column course_name;
pincode

alter table task1
drop column pincode;

Msg 4923, Level 16, State 1, Line 1
ALTER TABLE DROP COLUMN failed because 'pincode' is the only data column in table 'task1'. A table must have at least one data column.

Completion time: 2021-12-02T12:12:02.2960921+05:30

NOTE: we can no drop all columns we must have to remain atleast one


alter table task1
add sno int primary key;
==========================================================================



select emp_no,name into demo from Employee.employees.employees e;
select * from demo;

emp_no	name
10001	Georgi

13940	Leon
13941	IEEE
13942	Elzbieta
13943	Maya
13944	Takahito
13945	Yuguang
13946	Atilio
13947	Gal



alter table demo 
drop column emp_no;

name
Georgi
name
Bezalel
name
Chirstian
name
Parto
name
Kyoichi
===========================================================================
select * from nos;
nos
1
2
3
4
5
5
6
7
7
7

select distinct nos from nos;
nos
1
2
3
4
5
6
7

alter table nos
alter column nos varchar(10);
======================================================================
insert multiple values 
create table tagg(n int primary key ,names varchar(15) );


insert into tagg 
values
(1,'henkock'),
(2,'peter'),
(3,'lita'),
(4,'edge')

n	names
1	henkock
2	peter
3	lita
4	edge

 INSERT INTO t1
    VALUES
        (1),
        (2),
        (3);
select * from t1;

c
1
2
3
=====================================

CREATE TABLE t2 (c VARCHAR(10));

INSERT INTO t2
VALUES
    ('SQL Server'),
    ('Modify'),
    ('Column')


9
9
9

ALTER TABLE t2 ALTER COLUMN c VARCHAR (50);
=====================================
select max(salary) from employees.salaries;
(No column name)
158220

select min(salary) from employees.salaries;
(No column name)
38623
================================


BEGIN TRANSACTION;   
truncate table mohit1
COMMIT TRANSACTION;   
Commands completed successfully.

Completion time: 2021-12-02T14:40:32.5999491+05:30
======================================

Update

select * from demo2
sno	sname
1	mohit
2	rohit
3	karan

update demo2 set sname ='raju' where sno=1

1	raju
2	rohit
3	karan

============================================
delete from demo2 where sno=1;
select * from demo2
sno	sname
2	rohit
3	karan
==============
delete from demo2;


select top 5  emp_no,Sur_name from Employee.employees.employees;
select * from Employees.salaries  order by salary desc

select top 5 salary from Employees.salaries   order by salary desc 
=========================================

select * from abcd where sur_name like '%a%';

emp_no	sur_name
10001	Facello
10003	Bamford
10005	Maliniak

SELECT TOP (5) [dept_no]
      ,lower(dept_name)
  FROM [Employee].[employees].[departments

SELECT TOP (5) [dept_no]
      ,upper(dept_name)
  FROM [Employee].[employees].[departments]

SELECT TOP (10100) [emp_no]
      ,[birth_date]
      ,[name]
      ,[sur_name]
      ,[gender]
      ,[hire_date]
  FROM [Employee].[employees].[employees] where sur_name like('%q')

select trim(name_1) from demo;

==========================================


create table customer(c_id int primary key,c_name varchar(20),order_id int foreign key refrences orders (order_id))

create table orders(order_id int primary key, oname varchar(20));


======================

join


select * from 
[Employee].[employees].[employees]

join [Employee].[employees].[dept_emp] 

on([Employee].[employees].[employees].emp_no=[Employee].[employees].[dept_emp].emp_no)

join[Employee].[employees].[departments]

on([Employee].[employees].[departments].dept_no=[Employee].[employees].[dept_emp].dept_no)

=================================

create table filestoload(folderpath varchar(200),filename varchar(200))

insert into filestoload values ('C:\Users\hello\Desktop\practice\ssis project\','SQLEXE.txt')

select folderpath,filename from filestoload

create table customer1(id int,name varchar(200))

truncate table customer1

select * from customer1

insert into filestoload values ('C:\Users\hello\Desktop\practice\ssis project\','sql3.txt')

insert into filestoload values ('C:\Users\hello\Desktop\practice\ssis project\demopo\','xyz123.txt')
===================
============PIVOT===========
Create Table ProductSales
(
     SalesAgenName VARCHAR(50),
     SalesCountryName VARCHAR(20),
     SalesAmount INT
)
Go
INSERT INTO ProductSales VALUES ('James', 'India', 9260)
INSERT INTO ProductSales VALUES ('James', 'US',5280)
INSERT INTO ProductSales VALUES ('Pam', 'India',9770)
INSERT INTO ProductSales VALUES ('Pam', 'US',2540)
INSERT INTO ProductSales VALUES ('David', 'India',9970)
INSERT INTO ProductSales VALUES ('David', 'US',5405)
Go

SELECT SalesAgenName, India, US
FROM
(
   SELECT SalesAgenName, SalesCountryName,  SalesAmount 
   FROM ProductSales
) AS PivotData
PIVOT
(
 Sum (SalesAmount) FOR SalesCountryName 
 IN (India, US)
) AS PivotTable
============================
=========UNPIVOT========

SELECT SalesAgenName, SalesCountryName, SalesAmount
FROM
 (
 SELECT SalesAgenName, India, US
 FROM
 (
  SELECT  SalesAgenName, SalesCountryName,  SalesAmount 
  FROM ProductSales
 ) AS PivotData
 PIVOT
 (
  Sum(SalesAmount) FOR SalesCountryName 
  IN (India, US)
 ) AS PivotTable ) PTable
UNPIVOT
(
     SalesAmount
     FOR SalesCountryName IN (India, US)
) AS UnpivotTable
===================















