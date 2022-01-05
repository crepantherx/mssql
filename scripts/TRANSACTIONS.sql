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
