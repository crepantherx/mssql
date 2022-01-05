---what is trigger 
---A trigger is a special type of stored procedure that automatically runs
---when an event occurs in the database server.

----types of triggers
DML triggers
DDL triggers
LOGON triggers

--------
DML triggers

Two types
--1) After  (insert, update,delete)
--2) instead of (insert,update,delete)

---database creation

CREATE DATABASE tr_project

DROP DATABASE tr_project

USE tr_project

backup database tr_project
to disk ='G:\New folder\dddf'


-----AFTER TRIGGERS


CREATE TABLE emp(
id int identity(1,1),
name varchar(10),
dept varchar(10))

DROP TABLE emp;


INSERT INTO  emp (name,dept) VALUES
('anil','it'),
('mohit','hr'),
('dolly','it'),
('suraj','fe'),
('sinidhi','fe'),
('elliyaz','hr'),
('santosh','it'),
('sudhir','it')

SELECT * from emp

CREATE TABLE emp_audit_table(
slno int identity (1,1),
auditreason varchar(50))

DROP TABLE emp_audit_table

ALTER TABLE emp_audit_table
ADD old_data varchar(50),
newdata varchar(50),
typeofevent  varchar(100),
event_time datetime

ALTER TABLE emp_audit_table
drop column auditreason

select * from emp_audit_table


-----insert trigger

-----simple insert trigger with print message 

CREATE TRIGGER tr_simple_insert
on emp
AFTER INSERT 
AS
BEGIN
       print('new data inserted') 
END

INSERT INTO  emp (name,dept) VALUES
('anil','it')

DROP TRIGGER tr_simple_insert

CREATE TRIGGER tr_insert_data
on  emp
for insert
AS
BEGIN
      declare @newdata varchar(50)
      declare @olddata varchar(50)
	  select @newdata=name from inserted
	select @olddata=name from deleted
	    insert into emp_audit_table (old_data,newdata,event_time) values (@olddata,@newdata,getdate()) 
END

INSERT INTO emp (name,dept) values
('sachin','hr')

select * from emp
select * from emp_audit_table

DROP TRIGGER tr_insert_data

select * into emp2 from emp

select * from emp2

CREATE TRIGGER tr_instaedof_insert_data2
on  emp2
instead of  insert
AS
BEGIN
      select * from inserted
	  select * from deleted
END

insert into emp2 (name,dept) values ('anil1','it')

DROP TRIGGER tr_instaedof_insert_data2


-----delete trigger 


CREATE TRIGGER tr_delete_data
on emp
after delete
as
begin
    declare @newdata varchar(50)
		declare @olddata varchar(50)
		declare @eventtype varchar(100)
    select @newdata=name from inserted
	select @olddata=name from deleted
	
	insert into emp_audit_table(old_data,newdata,event_time) values (@olddata,@newdata,getdate())  
end


DELETE from emp2
where name='elliyaz'

select * from emp
select * from emp_audit_table

DROP TRIGGER tr_delete_data



-----update trigger 

CREATE TRIGGER tr_insteadof_upadate
on emp2
instead of update
as 
begin
        print ('you can not update data')
rollback
end

update  emp2
set dept='it' where name='elliyaz'


select * from emp2



create trigger tr_upadte_data
on emp
after update 
as
begin 
   declare @newdata varchar(50)
		declare @olddata varchar(50)
		declare @eventtype varchar(100)
    select @newdata=name from inserted
	select @olddata=name from deleted
	
	insert into emp_audit_table(old_data,newdata,event_time) values (@olddata,@newdata,getdate())  
end


   update  emp 
   set name='sarfraz' where id=10

   select * from emp_audit_table


  
----instead of trigger

CREATE TRIGGER tr_instaedof_delete_data2
on  emp2
instead of  delete
AS
BEGIN
      select * from inserted
	  select * from deleted
END



DELETE from emp2
WHERE id=9

select * from emp2

drop trigger tr_instaedof_delete_data2

delete from  emp
where name='sarfraz'

select * from emp




-----instaed of trigger for 

CREATE TRIGGER tr_insteadof_upadate
on emp2
after update
as 
begin
        print ('you can not update data')
rollback
end

select * from emp2

update emp2 
   set name='rakesh' where id=7


-----DDL trigger
---create | alter | drop | 

 CREATE TRIGGER  Tr_create
 on database 
 for create_table 
  as
  begin
       print('new table created')
	   end

	   CREATE TABLE  t1(id int)
	   DROP TABLE t1


IF OBJECT_ID('dbo.tr_project') IS NOT NULL
Drop trigger Tr_create


CREATE TRIGGER tr_audittable
ON ALL SERVER
FOR create_table,drop_table,alter_table
AS
BEGIN
    select EVENTDATA()
END

IF OBJECT_ID('dbo.tr_project') IS NOT NULL
DROP TRIGGER tr_audittable

CREATE TABLE NewTable (Column1 INT);  

DROP TABLE NewTable
GO  

create table changes_table_on_db(
databasename nvarchar(250),
tablename nvarchar(250),
eventtype nvarchar(250),
loginname nvarchar(250),
sqlcommand nvarchar(2500),
audittime datetime)


ALTER TRIGGER tr_audittable
ON ALL SERVER
FOR create_table,drop_table,alter_table
AS
BEGIN
    declare	@eventdata xml
	select @eventdata=EVENTDATA()
insert into tr_project.dbo.changes_table_on_db
(databasename,tablename,eventtype,loginname,sqlcommand,audittime) values
(
@eventdata.value ('(/EVENT_INSTANCE/DatabaseName) [1]','varchar(250)'),
@eventdata.value ('(/EVENT_INSTANCE/ObjectName) [1]','varchar(250)'),
@eventdata.value ('(/EVENT_INSTANCE/EventType) [1]','varchar(250)'),
@eventdata.value ('(/EVENT_INSTANCE/LoginName) [1]','varchar(250)'),
@eventdata.value ('(/EVENT_INSTANCE/TSQLCommand) [1]','varchar(2500)'),
GETDATE()
)
END

CREATE TABLE NewTable (Column1 INT);  

select * from changes_table_on_db

IF OBJECT_ID('dbo.tr_project') IS NOT NULL
DROP TRIGGER tr_audittable


USE tr_project  
GO  
CREATE TRIGGER safety_instaed_of 
ON DATABASE   
FOR CREATE_TABLE   
AS   
    PRINT 'CREATE TABLE Issued.'  
    SELECT EVENTDATA().value  
        ('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','nvarchar(max)')  
   RAISERROR ('New tables cannot be created in this database.', 16, 1)   
   ROLLBACK  
;  
GO  
--Test the trigger.  

CREATE TABLE NewTable (Column1 INT);  

drop table NewTable
GO  

--Drop the trigger.  

DROP TRIGGER safety_instaed_of
ON DATABASE;  
GO  

EVENTDATA(tr_insteadof_upadate)

-----alter table

CREATE TRIGGER  Tr_alter
 on database 
 after alter_table 
  as
  begin
       print('existing table altered')
	   end

	   alter table t1
	   alter column id varchar(10)

	   select * from  t1

IF OBJECT_ID('dbo.tr_project') IS NOT NULL
Drop trigger Tr_alter

------drop table 
create trigger  Tr_after_drop_DDL
 on database 
 after drop
  as
  begin
       print(' table droped')
	   end

IF OBJECT_ID('dbo.tr_project') IS NOT NULL
DROP TRIGGER Tr_aftetr_DDL

alter table t1
	   alter column id varchar(10)





----logon trigger

---logon trigger fires in response to logon activities,logon triggers fires after the authrnction phase of 
---   loging in finishes,but before the user season actually established

--Advantages
---1.tracking login activity
---2.restricting logins to sql server
---3.limiting the number of sessions for a specific login


select * from sys.dm_exec_sessions

select is_user_process,login_time,original_login_name,session_id,host_name from  sys.dm_exec_sessions
order by login_time desc;

CREATE TRIGGER tr_logon_activity
on ALL server
for logon 
as
begin
     Declare @loginname nvarchar(100)
	 set @loginname= original_login()
	 if(select count(*) from sys.dm_exec_sessions
	 where is_user_process =1  AND
	 original_login_name= @loginname) > 6
	 begin
		print 'seventh connection attempt by ' + @loginname +'blocked'
		rollback;
	 end
end

DROP TRIGGER tr_logon_activity

USE [master]
GO
/****** Object:  DdlTrigger [tr_logon_activity]    Script Date: 12-12-2021 19:30:46 ******/
DROP TRIGGER [tr_logon_activity] ON ALL SERVER
GO

----joins


create table Tablea(
id int)

alter table tableb
add b int

select * from Tablea
truncate table Tablea

create table tableb(
id int)

insert into tableb values
(1,1),
(2,1),
(3,null),
(4,null),
(5,2)

select * from Tablea
select * from Tableb

select * from Tablea
 join tableb on Tablea.a=tableb.b

 select * from Tablea
 left join tableb on Tablea.a=tableb.b

 select * from Tablea
 right join tableb on Tablea.a=tableb.b

 create database anil;

Drop database anil;


DROP TABLE IF EXISTS Students

CREATE TABLE Students
(
StudentId    int          NOT NULL,
FirstName    varchar(20)  NOT NULL, 
LastName     varchar(20)  NOT NULL,
Address      varchar(30)  NULL,
PhoneNumber  nvarchar(10) NULL,
DepartmentId int          NOT NULL
)

CREATE TABLE city (
    id int  NOT NULL IDENTITY(1, 1),
    city_name char(128)  NOT NULL,
    country_id int  NOT NULL,
    CONSTRAINT city_pk PRIMARY KEY  (id))


CREATE TABLE  customer
(
ID int,
last_name varchar(80),
first_name varchar(80),
registration_date date
)

insert into Students values
(7, 'sunidhi', 's','up', '1254786254', 6),
(8, 'jasjsa', 'm','pune', '1253568745', 3),
(9, 'ashbabs', 'm','ashh', '1253555555', 3)

update students
set FirstName='sachin'
where studentid=8

update Students  
set FirstName='santosh',LastName='t'
where StudentId=9

delete from Students where StudentId=8

select * from Students

alter table Students add hobby varchar(20)

select * from Students

alter table Students alter column hobby varchar(30) 

alter table Students alter column hobby varchar(30) null


alter table Students drop column hobby


comparison opeartors
equalto
notequalto
greater then
less then 
greater then and equal to
less then and equal to 
not equal to 

select * from Students where StudentId=2

select * from Students where StudentId!=2

select * from Students where StudentId>2

select * from Students where StudentId<2

select * from Students where StudentId>=2

select * from Students where StudentId<=2

select * from Students where StudentId<>2


between and not between

select * from Students where StudentId between 3 and 5

select * from Students where StudentId not between 3 and 5

null and not null

select * from Students where StudentId is null

select * from Students where StudentId is not null


like operator 

select * from Students where FirstName like 'sh%'

select * from Students where FirstName like '%u%'

select * from Students where FirstName like '%r'


logical operator

and
or 
not


select * from Students

select * from Students
where FirstName='anil' 
or LastName='s'



SELECT * FROM Students

WHERE (StudentId > 1 AND StudentId < 7)


SELECT * FROM Students

WHERE StudentId BETWEEN 1 AND 6


SELECT * FROM Students

WHERE StudentId IN (1,5,7,9)


SELECT * FROM Students

WHERE StudentId NOT IN (1,5,7,9)


group functions or aggregate functions

max,min,avg,count,sum

select * from Students

alter table students add fees int 


update students
set fees=10000
where studentid=1

update students
set fees=12000
where studentid=2

update students
set fees=11000
where studentid=3

update students
set fees=12000
where studentid=5

update students
set fees=10000
where studentid=7

update students
set fees=12000
where studentid=7

update students
set fees=15000
where studentid=9

select * from Students


select max(fees) from Students

select min(fees) from Students

select avg(fees) from Students

select count(fees) from Students

select sum(fees) from Students


order by and group by

select * from Students order by StudentId DESC


select * from Students order by StudentId ASC


group by

select COUNT(Departmentid)
FROM Students
GROUP BY DepartmentId

select * from Students

CREATE TABLE emp
(
empno    int          NOT NULL,
FirstName    varchar(20)  NOT NULL, 
LastName     varchar(20)  NOT NULL,
Address      varchar(30)  NULL,
PhoneNumber  nvarchar(10) NULL,
)


CREATE TABLE dept
(
empno    int          NOT NULL,
deptno    int          NOT NULL
)


joins

inner join
 

 select emp.empno,dept.deptno 
 from emp join dept 
 on [emp].[empno]=[dept].[empno]

 CREATE TABLE deptname
(

deptno    int          NOT NULL,
deptname  varchar(20)  NOT NULL
)


select
  emp.empno,
  dept.deptno,
  deptname.deptname
FROM emp
JOIN dept
  ON emp.empno = dept.empno
JOIN deptname
  ON  dept.deptno=deptname.deptno;


select * from employees.salaries

select Max(salary) from employees.salaries

select Min(salary) from employees.salaries


select count(salary) from employees.salaries

To get employee name join to salaries table 


select employees.employees.name,employees.salaries.salary 
from employees.employees join employees.salaries 
on employees.emp_no=salaries.emp_no


select employees.employees.emp_no,
employees.salaries.salary,
employees.dept_emp.dept_no
from employees.employees
join employees.salaries 
on employees.emp_no=salaries.emp_no
join employees.dept_emp
on employees.emp_no=dept_emp.emp_no


dense rank

select * from (
select employees.salaries.emp_no,employees.salaries.salary ,
DENSE_RANK() over (order by employees.salaries.salary DESC)r from employees.salaries
where r=1

select max(select employees.employees.emp_no,
employees.salaries.salary,
employees.dept_emp.dept_no
from employees.employees
join employees.salaries 
on employees.emp_no=salaries.emp_no
join employees.dept_emp
on employees.emp_no=dept_emp.emp_no)



where salary in (select max(salary) from employees.employees.emp_no group by employees.dept_emp.dept_no)

select * from 
DENSE_RANK() over (order by employees.salaries.salary DESC)r from employees.salaries
where r=1


  select * from Students;

First question

select * into studentsnew from Students where 1=0;


second question


Alter table students 
Add constraint DF_students_Address
Default 'Gadag' for Address


create table anil 
(
no int,
name varchar(20),
dop date,
ph varchar(4) like [0-9][0-9][0-9][0-9],
)


create table demo (
id int,
name varchar(10))

insert into demo values
(1,'a'),
(1,'a'),
(2,'b'),
(2,'b'),
(2,'b'),
(3,'c')

select * from demo

select distinct * into demo1
from demo

drop table demo

drop table demo1

select * from demo1

----database 

create database anil2

alter database anil2 modify name=anil3

sp_renameDB 'anil3', 'anil4'

alter database anil4 set single_user with rollback immediate

drop database anil4

backup database anil2
to disk ='F:\DCIM'

create table demotable
(
slno int identity (1,1),
name varchar(10) not null,
age int ,
check (age>=18))

alter table demotable 
add phonenumber bigint 

alter table demotable 
add rollno int 

alter table demotable 
alter column rollno int not null

alter table demotable
add constraint pk_demotable primary key (rollno)

drop table demotable


create table demotable
(
slno int identity (1,1),
roll int primary key,
name varchar(10) not null,
age int ,
check (age>=18)
)

alter table demotable 
add dateofjoin date 

select * from demotable

alter table demotable
add unique (name)


create table demoteacher(
teacherid int not null,
teacheranme varchar(20),
rollno int foreign key references demotable(roll))


alter table demoteacher 
add foreign key (rollno) references demotable(roll) 

alter table demotable 
alter column dateofjoin datetime

select * from demotable

insert into demotable (roll,name,age)
values
(1,'anil',19),
(2,'anilhh',22),
(3,'ahh',19),
(4,'anilgghg',149),
(5,'andfdl',149),
(18,'anilxvx',259)

alter table demotable 
add constraint df_dateofjion
default '1447:04:24|12:24:51' for dateofjoin

insert into demotable (dateofjoin)
values
(4)

create trigger audittime 
on demotable.roll
for insert	
as 
begin
select * from inserted
insert into audittable values ('inserteddatetime=' +cast(getdate() as varchar(20))
end;

create table audittable(
inserteddatetime datetime )

select * from demotable

CREATE TABLE new (
    num int
)
GO

INSERT INTO new VALUES (0)
INSERT INTO new VALUES (1)
INSERT INTO new VALUES (2)
INSERT INTO new VALUES (3)
INSERT INTO new VALUES (4)
INSERT INTO new VALUES (5)
INSERT INTO new VALUES (6)
INSERT INTO new VALUES (7)
INSERT INTO new VALUES (8)
INSERT INTO new VALUES (9)
GO

select * from new 

CREATE PROCEDURE sp_name 
AS 
BEGIN
    SELECT  *
    FROM    new
    WHERE   num > 0
END
GO


CREATE FUNCTION fun
RETURNS TABLE
    AS
RETURN
    (
     SELECT *
     FROM  new
     WHERE  num > 0
    )
GO    

EXEC sp_name
EXEC fun

SELECT * FROM sp_name  
SELECT * FROM fun

DROP FUNCTION dbo.tvf_so916784
DROP PROCEDURE dbo.usp_so916784
DROP TABLE dbo.so916784

select * from students

create table auditnew1(
insertedtime datetime)

create trigger inserttime
on students
after insert 
as 
begin
select * from inserted 
end

insert into Students (StudentId,LastName,DepartmentId)
values (6,'k',5)

alter table students 
add constraint df_gender
default 3 for genderid


alter table students
add constraint ch_age
check (age>0 and age<150)
 

 DBCC checkident ( students ,reseed 0)

 select SCOPE_IDENTITY()
 select @@IDENTITY
 select IDENT_CURRENT('test2')



 create table test1(
 id int identity (1,1),
 value varchar(20))


 create table test2(
 id int identity (1,1),
 value varchar(20))

 insert into test1 values (null)

 select * from test1
 select * from test2

 create trigger tr_insert_value
 on test1 
 after insert
 as 
 begin
     insert into test2 values ('gdg')
 end

 alter table test1
 add constraint UQ_test1_id
 unique (id)

 select distinct value from test1
 select distinct id,value from test1

 select * from Students where Address='gadag'
  select * from Students where Address<>'gadag'

  select * from Students where StudentId in (5,6,7)

  
  select * from Students where StudentId between 5 and 7

  select * from Students where address like '[pau]%'

  select * from Students where address like '[^pau]%'


use database employee

select employees.name,employees.gender,employees.sur_name,salaries.salary  from employees.employees join
employees.salaries 
on 
employees.employees.emp_no=employees.salaries.emp_no

select top 1 from employees.employees




join
employees.dept_emp
on
employees.dept_emp.emp_no=employees.employees.emp_no

select * from employees.employees join
employees.salaries 
on 
employees.employees.emp_no=employees.salaries.emp_no
 left join
employees.dept_emp
on
employees.dept_emp.emp_no=employees.employees.emp_no

select * from employees.employees join
employees.salaries 
on 
employees.employees.emp_no=employees.salaries.emp_no
cross join
employees.dept_emp


create table name(
firstname varchar(20),
lastname varchar(20))

insert into name values
('anil','kumar'),
('santosh','ton'),
('shankar','sajjanar'),
('mahesh','kumar')

select * from name

select ascii ('a')

select char (112)

declare @start int
set @start =97
while (@start<=122)
begin
  print char(@start)
  set @start=@start+1
  end

  select '      hello'

  select ltrim('       hello')

  select RTRIM('hello           ')


  ---self join

  create table m(id int,name varchar(10),mid int )
  insert into m values (1,'mike',3),
  (2,'rob',1),(3,'todd',null),(4,'ben',1),(5,'sam',1)

  create table emd (name varchar(20),man varchar(10))
  insert into emd values ('mike','todd'),
  ('rob','mike'),('todd',null),('ben','mike'),('sam','mike')

  alter table emd
  alter column man varchar(20) null

  select * from m
  select * from emd
  ------stored procedure with parameters


 select * from students

 create proc spdeptid
 @studentid int ,
 @firstname varchar(20)
 as
 begin
    select * from Students where StudentId=@studentid and FirstName=@firstname
 end
 
 exec spdeptid  1,'anil'

 -----stored procedure with output parameters

  create proc spdeptid3
 @studentid int output ,
 @firstname varchar(20) output
 as
 begin
    select count(studentid) from Students where  FirstName=@firstname
 end
 
 declare @totalcount int 
 exec spdeptid3  @totalcount output,'anil'
 print @totalcount

 -------------indexes

 select * from students

 create index IX_student_firstname
 on students (firstname asc)
  
select * from students where FirstName='santosh'

drop index IX_student_firstname

exec sp_helpindex students


create clustered index IX_students_studentid
on students (studentid asc)


-------materialized view or indexed view


create view VX_students
with schemabinding
as 
select name 


functions
---string functions
---numeric functions
---date functions
---aggreagate functions


----user defined functions

select square(3)

-----types of udf
----scalar function
-----inline table-valued functions
-----multi-statement table-valued functions

----scalar function
select square(3)

select getdate()

create function dbo.agecalc (@dob date)
returns int
as
begin
   declare @age int
  
set @age =DATEDIFF(year,@dob,getdate())-
case
when (month(@dob) >month(getdate())) or 
      (month(@dob) =month(getdate()) and day(@dob) >day(getdate()))
	  then 1 
	  else 0
	  end
	  return @age
end

select dbo.agecalc ('07/27/1993')

--- inline table valued functions

create table empnew(
id int identity(1,1),
name nvarchar(20),
dateofbirth date,
gender nvarchar(10),
departid int)




create function fn_employeebygender (@gender nvarchar(10))
returns table
as
return (select id,name,dateofbirth,gender,departid 
        from empnew
		where gender =@gender)

-----multi-statement table-valued functions

create function fn_multi_table()
returns @table table (id int,name nvarchar(20),dob date)
as
begin
  insert into @table
  select id,name,cast(dateofbirth as date) from empnew 
  return

  create table organization(
empid int,
name varchar(20),
manager_id int)


insert into organization values
(4,'Saurav',null),
(7,'Devesh Dubey',4),
(10,'Sudhir Singh',7),
(1,'A',10),
(2,'D',10),
(3,'E',10),
(5,'M',10),
(6,'F',10),
(8,'H',10),
(9,'I',10)

selecT * from organization

select o1.empid,o1.name,o1.manager_id from organization as o1,organization as o2
where o2.manager_id=o1.empid


SELECT e1.empid EmployeeId, e1.name EmployeeName,  
       e1.manager_id ManagerId, e2.name AS ManagerName 
FROM   organization e1 
       LEFT JOIN organization e2 
       ON e1.manager_id = e2.empid
	   where e1.name='A'