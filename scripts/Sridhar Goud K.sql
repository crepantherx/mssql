create table demo(
id int not null primary key,
name nvarchar(50) not null,
doj date ,
);
insert into demo
values(6,'c','2021-12-3');
insert into demo
values(9,'c','2021-12-3');


select * from demo 
where doj='2021-12-3' and (id> 6  and not name ='a')


select distinct * from demo

select * from demo  doj order by id;

insert into demo values (113,'e','2021-11-20')

select * from demo where doj is null


select * from demo where doj is not  null

update demo 
set id=11,name='zzz',doj='2120-12-20' 
where id = 5 ;


update demo set name='zz',doj='2222-11-30' ;

delete  demo
where id=10;

select top 2 * from demo  where id >11;

select min(id) from demo     


select MAX(id) from demo where name <='e' ;

select min(id) as fst from demo  ;

select max(doj) as fresher from demo;


select Count(id) from demo
where doj >'11-11-2021'


select avg(id) from demo
where doj >'11-11-2021'

select * from demo where doj like '2___-%-%';

insert into demo
values(893,'ghykl','2021-12-3');

select * from demo where name like '%hy[a-z]%'

select * from demo where id in(1,2,3,6,11,121) ;

select * from demo where id in (select * from memo  );

select * from demo where doj  between '2020-01-01' and '2022-12-31';

select * from demo where doj  between '2020-01-01' and '2022-12-31' and id not in (1,11,111);

select id as eid from demo 

select * from demo as remo  
 select id,name+'---'+'all' as details from demo


 select a.id,a.name,a.doj
 from demo as a
 where  a.id <> 111;

 create table remo (
 ido int not null unique,
 remoo varchar  default 'remomama' )

 insert into remo values (1, defa);
 select * from remo


 select * from demo 
 inner join  remo on id =ido;

 select * from demo left join remo
 on ido=id;

 
 select * from demo right join remo
 on ido=id;

 select * from demo full outer join remo
 on ido=id;
 select a.id as abc, a.name as adc from demo as a
 where 
 a.id = 1 ;
 select * from demo union all select * from demo 
 select * from demo union select * from demo
 select count(id),name 
 from demo
 group by id

 create table pdk(
 a int primary key,
 b nvarchar(250) unique)



 alter table pdk
 add constraint nn_pdk   unique(a,b)

 alter table pdk
 drop constraint nn_pdk


 select count(a),b
 from pdk group by b
 having count(a)>1
;



 select count(id),name
 from demo group by name   having count(id)>1
 order by count(id) 
;


create table qq(
a int ,
b varchar(225) default 'allok' );
insert into qq(a) values (2)
select * from qq
create table qq1(
a int ,
b varchar(225) default 'allok',
c int not null);
insert into qq1(a,c) values (2,4)


select * from demo where exists(select *from remo where id=1);

select * from demo where id =any (select id from remo where id =1);

select * from demo where id = all  (select id from remo where id =1);

select * from demo where id = some  (select id from remo where id =1);

select id,doj into memo from demo where doj > '2020-12-01'

insert into remo select * from memo;


select id,name     from demo
order by 
 CASE 
 when id > 111 then id
 else '000'
 END 
 ;


 select * from demo order by  case
 when name <> 'e' then id
 else '000'
 end 
 ;

create table products2 (productid int,unitprise int  ,unitsinstock int , unitsonorder int);
select productid ,unitprise*(unitsinstock+unitsonorder)
insert into products2 values (1,200,20,5)

select productid,unitprise*(unitsinstock+unitsonorder) from products2;

-----------
select a,b*(c+coalesce(d,0);

select a,b*(c+ifnull(d,0)

select a,b*(c+isnull(d,0)       from products
---------------------
create procedure spdemo
as
begin 
select *from demo

go;


CREATE PROCEDURE abay
as
BEGIN
select *from demo
END;
 exec abay




 create procedure abay1 @puri int
 as
 begin
 select *from demo where id = @puri  
  exec abay1 11


  ----fgsdfg


  drop database test;

  backup database test_1
  to disk='filepath'with differnetial 


  creATE table adda (a int not null,b varchar (225),c date,d datetime);
  alter table adda
  add e int default 'werey';
  alter table adda
  add constraint uk_adda unique(a);
    alter table adda
drop constraint uk_adda ;


create table qwer (a int  primary key,b int not null)

alter table qwer
drop constraint p_k primary key (a)


alter table qwer
add primary key (b);

create table asdf(a int ,b int foreign key references emp(b) );


alter table qwer
add foreign key references primary key (b);
 
 alter table qwer
drop foreign key fk_key ;

  create table tyui
  (a int check (a>100));


  insert into tyui values(111)


  create table asas(q int ,b varchar (215) 
  default'weww');


   alter table asas
DROP CONSTRAINT  ;


CREATE INDEX IN_NMAE
ON DEMO(ID,NAME,DOJ)

DROP INDEX DEMO.IN_NMAE


CREATE TABLE BABA (A INT IDENTITY(1,1)  NOT NULL ,B NVARCHAR(225);

ALTER TABLE BABA 
ALTER A INTS


CREATE VIEW [SENIOR] AS
SELECT * FROM DEMO WHERE 1<>2; 

SELECT * FROM [SENIOR];

drop view spt_values
select * from spt_values

use test
---------------------------------------
create procedure spo_2 @a date
as 
begin
select * from demo where doj >@a
end

EXEC spo_2 @a ='2020-12-19'
-------------------
CREATE TRIGGER TR_ALTERTABLE ON DATABASE
FOR ALTER_TABLE
AS
BEGIN
 
INSERT INTO TableSchemaChanges
SELECT EVENTDATA(),GETDATE()
 
END

/*Syntax for creating DDL trigger
CREATE TRIGGER [Trigger_Name]
ON [Scope (Server|Database)]
FOR [EventType1, EventType2, EventType3, ...],
AS
BEGIN
   -- Trigger Body
END*/

DISABLE TRIGGER  tr_AuditTableChanges ON DATABASE


/*ALTER TRIGGER DDA
ON server
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN

 DECLARE @EventData XML
 SELECT @EventData = EVENTDATA()
  INSERT INTO [dbo].[TableEEE]
 (DatabaseName, TableName, EventType, LoginName, SQLCommand, AuditDateTime)
 VALUES
 (
  @EventData.value('(/EVENT_INSTANCE/DatabaseName)[1]', 'varchar(250)'),
  @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(250)'),
  @EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(250)'),
  @EventData.value('(/EVENT_INSTANCE/LoginName)[1]', 'varchar(250)'),
  @EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(2500)'),
  GetDate()
 ) 
END/
*/

USE SRIEE;  
Create Table TableEEE (DatabaseName VARCHAR (225), TableName VARCHAR (225), EventType VARCHAR (225), LoginName VARCHAR (225), SQLCommand VARCHAR (225), AuditDateTime DATETIME);
;
 
 -----------------xml--------------------
 CREATE TRIGGER DDA ON ALL SERVER 
  FOR CREATE_TABLE ,DROP_TABLE
  AS
  BEGIN
 SELECT  EVENTDATA()
 END



 SELECT * FROM SYS.DM_EXEC_SESSIONS



 ALTER TRIGGER tr_LogonAuditTriggers
ON ALL SERVER
FOR LOGON
AS
BEGIN
 DECLARE @LoginName NVARCHAR(100)

 Set @LoginName = ORIGINAL_LOGIN()

 IF (SELECT COUNT(*) FROM sys.dm_exec_sessions
  WHERE is_user_process = 1 
  AND original_login_name = @LoginName) >= 10
 BEGIN
  Print 'Fourth connection of ' + @LoginName + ' blocked'
  ROLLBACK
 END*/
END


EXECUTE SP_READERRORLOG

-----------------------------------------------------------
CREATE TABLE A(B INT,C VARCHAR(100))
CREATE TABLE D(E INT,F VARCHAR(100))

CREATE VIEW ASDF
AS
SELECT* FROM A JOIN D ON A.B=D.E

SELECT* FROM ASDF



CREATE TRIGGER INTRI ON ASDF
INSTEAD OF INSERT
AS
BEGIN
SELECT* FROM INSERTED
SELECT* FROM DELETED
END


INSERT INTO ASDF  VALUES (1,'PAPA',4,'MAMA')

---------------------------

Create Table TableA
(
    Id int,
    Name nvarchar(50),
    Gender nvarchar(10)
)
Go

Insert into TableA values (1, 'Mark', 'Male')
Insert into TableA values (2, 'Mary', 'Female')
Insert into TableA values (3, 'Steve', 'Male')
Insert into TableA values (3, 'Steve', 'Male')
Go

Create Table TableB
(
    Id int primary key,
    Name nvarchar(50),
    Gender nvarchar(10)
)
Go

Insert into TableB values (2, 'Mary', 'Female')
Insert into TableB values (3, 'Steve', 'Male')
Insert into TableB values (4, 'John', 'Male')
Go

select* from TableA union select* from TableB

select* from TableA union all select* from TableB

select* from TableA intersect select* from TableB

select* from TableA Except select* from TableB

Insert into TableA values (1, 'Mark', 'Male')

select* from TableA where Id not in (select id from TableB);

EXEC sp_rename 'tableA', 'test';  

CREATE TRIGGER tr_AuditTableChanges
ONdatabase
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
 DECLARE @EventData XML
 SELECT @EventData = EVENTDATA()






-----------------------
 use demo1
--JOINS
SELECT * FROM    demo1.dbo.employees     AS   E
		 JOIN    demo1.dbo.salaries      AS   S  ON S.emp_NO    = E.emp_no
		 JOIN    demo1.dbo.dept_emp      AS   DE ON DE.emp_no   = S.emp_no	
		 JOIN    demo1.dbo.departments   AS   D  ON D.dept_no   = DE.dept_no	
		 JOIN    demo1.dbo.titles        AS   T  ON T.emp_no    = E.emp_no	




SELECT * FROM employees
SELECT * FROM  demo1.dbo.dept_emp
SELECT * FROM  demo1.dbo.salaries
SELECT * FROM  demo1.dbo.titles



SELECT * FROM employees AS  E
LEFT JOIN  salaries AS S  ON  E.emp_no = S.emp_no
RIGHT JOIN  dept_emp AS DE ON DE.emp_no = S.emp_no


---	SUBQUERY  TO FIND THIRD  HEIGHEST SAL
 SELECT * FROM salaries E1 
			WHERE 3 =( SELECT COUNT(DISTINCT(E2.SALARY)) FROM salaries E2
								WHERE  E2.salary >= E1.SALARY  )






		SELECT * FROM salaries WHERE salary = 
         (
            SELECT MIN(salary) FROM salaries 
            WHERE  salary IN (
                                 SELECT DISTINCT TOP 3
                                     SALARY FROM salaries 
                                         ORDER BY  salary DESC
                             )
        )


		WITH Q1
		 AS
		 (
		 SELECT *,DENSE_RANK() OVER(ORDER BY salary)DRK FROM salaries
		 )SELECT * FROM Q1 WHERE DRK=3
		  
		  
		  
		  WITH Q2
		   AS(
		   SELECT *,DENSE_RANK() OVER(PARTITION BY emp_NO ORDER BY salary) DRK,RANK() OVER (PARTITION BY EMP_NO ORDER BY SALARY)RK FROM salaries
		   )SELECT * FROM Q2



		   create function masked1( @a varchar(50))
returns varchar(50)

begin

declare
@eml varchar(50);

set @eml=  STUFF(@a,2,CHARINDEX('@',@a)-2,'*****') 

return @eml

end;


		   ALTER function masked2( @a varchar(50))
returns varchar(50)

begin

declare
@eml varchar(50);

set @eml=  STUFF(@a,2,CHARINDEX('@',@a),'*****') 

return @eml

end;
select demo1.dbo.masked1('asFFFFsa@gmail.com')
select demo1.dbo.masked2('asFFFFsa@gmail.com')
SELECT CHARINDEX('@','asFFFFsa@gmail.com',1)
   
   
   
   
  ALTER FUNCTION MASKEMAIL(@EL VARCHAR(50))
   RETURNS VARCHAR(50)
   BEGIN
   DECLARE
   @EMAIL VARCHAR(50)
	SET @EMAIL=STUFF(@EL,3,CHARINDEX('@',@EL)-3,'^^^^^')
	RETURN @EMAIL
	END


	------------------
use demo1
select * from employees
select * from departments
select * from salaries
select * from dept_emp


WITH sri AS(
			SELECT
				 E.emp_no
				 , E.first_name
				 , D.dept_name
				 , DEP.dept_no
				 , S.salary
				 , DENSE_RANK() OVER (PARTITION BY D.dept_name ORDER BY S.salary DESC)AS rnk
					 FROM [demo1].[dbo].[employees]    AS  E
					 JOIN demo1.dbo.dept_emp           AS  DEP  ON DEP.emp_no= E.emp_no
					 JOIN demo1.dbo.departments        AS  D    ON D.dept_no= DEP.dept_no
					 JOIN demo1.dbo.salaries	       AS  S    ON S.emp_no= E.emp_no
				  )
	  SELECT *
	  FROM  sri
	  where rnk = 3


	  WITH sri1 AS(
			SELECT
				 E.emp_no
				 , E.first_name
				 , D.dept_name
				 , DEP.dept_no
				 , S.salary
				 , row_number () OVER (PARTITION BY D.dept_name ORDER BY S.salary DESC)AS rnk
				 FROM [demo1].[dbo].[employees]    AS  E
				 JOIN demo1.dbo.dept_emp           AS  DEP  ON DEP.emp_no= E.emp_no
				 JOIN demo1.dbo.departments        AS  D    ON D.dept_no= DEP.dept_no
				 JOIN demo1.dbo.salaries	       AS  S    ON S.emp_no= E.emp_no
				  )
	  SELECT *
	  FROM  sri1
	  where rnk = 3




	  select * ,rank() over (partition by emp_no ORDER BY salary DESC )rnk1,
	  row_number() over (partition by emp_no ORDER BY salary DESC )rnk3,
	  dense_rank() over (partition by emp_no ORDER BY salary DESC )rnk2
	  from salaries




	  create function fun_3(@id int)
	  returns money
	  as
	  begin
	  declare @basic money,@hra money,@pf money,@da money,@gross money
	  Select distinct @basic = salary from salaries where emp_no = @id
	  set @hra=@basic*0.3
	  set @da= @basic*0.1
	  SET @pf=@basic*0.18
	  SET @gross=@hra+@basic+@da+@pf
	  RETURN @GROSS
	  END


	  
select dbo.fun_3(10003)


create FUNCTION Age4(@DOB Date)  
RETURNS INT  
AS  
BEGIN  
 DECLARE @Age INT  
 SET @Age = DATEDIFF(YEAR, @DOB, GETDATE()) - CASE WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())) THEN 1 ELSE 0 END  
  
 RETURN @Age  
END

 select dbo.age3 ('2020-12-28')


 select

 create table  orders (ord_no int,purch_amt money,ord_date date,customer_id int,salesman_id int)
 
 create table  customer (customer_id int,cust_name varchar(200),city varchar(20),grade int,saleesman_id int)
  create table  salesman (salesman_id int,name varchar(200),city varchar(20),commission int)

 SELECT   a.ord_no,a.purch_amt,b.cust_name as 'customer name' ,b.grade,c.name AS 'salesman' ,c.commission
		FROM orders AS a 
		JOIN customer AS b ON  a.customer_id = b.customer_id
		JOIN  salesman AS c ON  b.saleesman_id = c.salesman_id




		select * from customer where grade in( 100,500)
		select * from customer where cust_name not between  'a' and 'l'

		select * from customer where cust_name like  '%n' 
		
			---------------
			-----------------------------------------------DCL====DATA CONTROL LANGUAGE------------------------------------------
-----------usually DONE BY ADMIN
>>>>>>>>>Used to CONTROL ACCESS to the data stored in DATABASE
>>>>>>>>>>security related
>>>>>>>>>>>to prevent unauthorized access to tha data
----commands-----1) GRANT    2)REVOKE


--------------system privileges
includes -- CREATE /Drop / alter(database objects)


----------object privileges
includes --(select,insert,update,delete/execute)


GRANT--to give the access
REVOKE-to cancel  the access



  
  syntax
  
  GRANT privilege_type(select,insert)
ON object_name(table)
TO {user_name }

--WITH GRANT OPTION;----by using this user can also pass the privilege 

REVOKE---removing the privileges\ */
  

  REVOKE privilege_type
ON object_name
FROM {user_name }


---- Creates an application role called "dev_1" that has
the password "dede1" and 'db_datareader' as its default schema.  

CREATING UD ROLES

USE DEMO1

CREATE APPLICATION ROLE dev_14   
    WITH PASSWORD = 'dede1'   , 
	DEFAULT_SCHEMA = [db_datareader]
GO  


alter role oldname with new_name = new_name

 
-------------Syntax to create a role
CREATE ROLE dev_1
-----------granting to create table 
GRANT CREATE TABLE TO dev_1;
-------------REVOKE 
REVOKE CREATE TABLE FROM dev_1;  

---------or---------

GRANT ROLE dev_1 TO USER 1,USER 2;

---------The Syntax to drop a role
drop ROLE userdifined_role()

------------------------4 types of roles in sql server------------------------------         
>>>>>>>>>fixed database roles
>>>>>>>>>user  defined database roles
----------->fixed server roles
.............user defined server roles
----------->fixed server roles
SYNTAX
CREATE SERVER ROLE role_name [ AUTHORIZATION server_principal ]  

EX---
CREATE SERVER ROLE auditors AUTHORIZATION securityadmin;  
GO  

DROP SERVER ROLE auditors





-------------------->>>>>>>>>fixed database roles
-------------------------------------------------[db_owner]
can perform all configuration and maintenance activities on the database, and can also drop the database in SQL Server
   --also some maintenance activities require server-level permissions and cannot be performed by db_owners
   
   
   ---------------------------------------------[db_securityadmin]
    can modify role membership for custom roles only and manage permissions. 


-------------------------------------.[db_accessadmin]

 can add or remove access to the database for Windows logins, and SQL Server logins.

-------------------------------------[db_backupoperator]
Members of the [db_backupoperator] fixed database role can back up the database.


------------------------------------------[db_denydatawriter]

 cannot add, modify, or delete any data in the user tables within a database.

---------------[db_ddladmin]

can run any Data Definition Language (DDL) command in a database.



---------------------------[db_datawriter]

can add, delete, or change data in all user tables.

----------------------------[db_datareader]
can read all data from all user tables and views. User objects can exist in any schema except sys and INFORMATION_SCHEMA.

----INFORMATION_SCHEMA --- information about the MySQL server
such as the name of a database or table, the data type of a column, or access privileges.

--sys. tables is a system table and is used for maintaining information on tables in a database




 deny insert on [dbo].[tab1] TO [loginname]

-------------------------------------------------------------[public]
-------------NO DATABASE  LEVEL PERMISSIONS 
BUT ADMIN CAN ADD 


 ----stored procedure to add roles


 EXEC sp_addrole 'Managers';

-------------------------adding user as database reader

 /*ALTER ROLE db_datareader
    ADD MEMBER ram;  
GO
*/
---[bulkadmin] 
can run the BULK INSERT statement.
---[dbcreator]
 can create, alter, drop, and restore any database.
---[diskadmin]
 used for managing disk files.
---[processadmin]
can end processes that are running in an instance of SQL Server.
----[public]
--Every SQL Server login belongs to the public server role.
Only assign public permissions on any object when you want the object to be available to all users
You cannot change membership in public.

---[securityadmin]
 manage logins and their properties. They can GRANT, DENY, and REVOKE server-level & database-level permissions 
& they can reset passwords for SQL Server logins.
---[serveradmin]
 change server-wide configuration options and shut down the server.
---[setupadmin]
can add and remove linked servers by using Transact-SQL statements.
[sysadmin]
can perform any activity in the server.
-----------------------------------------------------transactions-----------------------------------------

A GROUP OF STATEMENTS  THAT CHANGE THE DATA IN THE DATABSE(DML STATEMENTS)


--------*********************************************************------------

A TRANSACTION STARTS WITH
 BEGIN TRANSACTION

 AND 
 SINGL OR MULTIPLE SAVEPOINTS OR SAVE TRANSACTIONS 
 ENDS WITH ROLLBACK OR COMMIT


 -------------
 SET TRANSACTION-==TO GIVE A NAME ON TRANCTION

 =-----------------------TYPES OF TRANSACTIONS      
 

 ----->>>>>>>Autocommit transactions---------EVERY STATEMENT IS A TRANCTATION >>>>>>>>>>>(SQL SERVER)


>-------}-----------> Explicit transactions

>-------}-----------> IMPLICIT transactions


-----------------to ensure correctness and consistency of a database
   TRANSACTION MANAGEMENT FOLLOWS

Atomicity: EITHER ALL NOR NULL....
Consistency: all the data will be consistent BEFORE & after a transaction 
Isolation: All transactions are isolated from other transactions(NO INTERFERENCE BTW TRANSACTION)
Durable:  commited transactions becomes PERMINANT in the database


---------------------------
EX---
 
  Begin TRANSACTION



  UPDATE [dbo].[a] SET name = 'NO NAME' WHERE NAME IS NULL;
   SAVE TRANSACTION SAVEPOINT
   UPDATE [dbo].[a] SET name = 'ID' WHERE NAME IS NULL;  

  Commit Transaction

ROLLBACK  

End

USE master
