-----AUDIT TABLE CHANGES------
/*We can fetch all details of a user who makes any changes to any table
  like login name,time,events,typename,databasename,tablename etc.....
  
  To fetch all the details we have to create a DDL trigger */

  ---TABLE to store details of user----
  CREATE TABLE Capture_details
  (
  DatabaseName NVARCHAR(250),
  TableName NVARCHAR(250),
  LoginName NVARCHAR(250),
  SQLCommand NVARCHAR(2000),
  AuditDateTime datetime
  )

  ALTER TABLE Capture_details
  ADD EventType nvarchar(250)

  SELECT * FROM Capture_details

  ---create trigger for capturing details of user------
  ALTER TRIGGER Tr_on_audit_tablechange
  ON ALL SERVER
  FOR CREATE_TABLE,ALTER_TABLE,DROP_TABLE
  AS
  BEGIN
       DECLARE @eventdata XML
	   SET @eventdata = EVENTDATA()
	   
	   INSERT INTO INTERNS.dbo.Capture_details(DatabaseName,TableName, LoginName,
	   SQLCommand,AuditDateTime,EventType)
	   VALUES
	   (
	     @eventdata.value('(/EVENT_INSTANCE/DatabaseName) [1]','nvarchar(250)'),
		 @eventdata.value('(/EVENT_INSTANCE/ObjectName) [1]','nvarchar(250)'),
		  @eventdata.value('(/EVENT_INSTANCE/LoginName) [1]','nvarchar(250)'),
		 @eventdata.value('(/EVENT_INSTANCE/TSQLCommand)[1]','nvarchar(250)'),
		 GETDATE(),
		 @eventdata.value('(/EVENT_INSTANCE/EventType)[1]','nvarchar(250)')
		 
	   )

	   select 'HEY Someone change something on yourdatabase table' AS Important_information
	   SELECT * FROM INTERNS.dbo.Capture_details
  END

  -----create table,alter,drop to see the effect-------
  CREATE TABLE C
  (ID INT )

  INSERT INTO C(ID) values(1)
  
  ALTER TABLE C
  ADD NAM NVARCHAR(10)

  DROP TABLE C

  
 
  