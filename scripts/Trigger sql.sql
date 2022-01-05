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

select * from emp2
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
instead of update
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
	 original_login_name= @loginname) > 4
	 begin
		print 'fourth connection attempt by ' + @loginname +'blocked'
		rollback;
	 end
end

DROP TRIGGER tr_logon_activity

USE [master]
GO
/****** Object:  DdlTrigger [tr_logon_activity]    Script Date: 12-12-2021 19:30:46 ******/
DROP TRIGGER [tr_logon_activity] ON ALL SERVER
GO


 
