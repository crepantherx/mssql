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

			
