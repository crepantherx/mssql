/*

CREATE TRIGGER tr_table_forWhat ON [TABLE | DATABASE | ALL SERVER] FOR CREATE_TABLE AS
BEGIN
    ...
END

*/













ALTER TRIGGER tr_logTransaction ON DATABASE FOR CREATE_TABLE, ALTER_TABLE AS
BEGIN
    PRINT 'You are not allowed to create table'
END
use learn
DROP TRIGGER tr_logTransaction ON DATABASE
ENABLE TRIGGER tr_logTransaction ON DATABASE
DISABLE TRIGGER tr_logTransaction ON DATABASE

GO


CREATE TRIGGER tr_logTransaction ON ALL SERVER FOR CREATE_TABLE, ALTER_TABLE AS
BEGIN
    ROLLBACK
    PRINT 'You are not allowed to create table'
END

Go

CREATE TRIGGER tr_logTransaction ON ALL SERVER FOR CREATE_TABLE, ALTER_TABLE AS
BEGIN
    SELECT EVENTDATA()
END

Go

CREATE TRIGGER tr_ITAudit ON ALL SERVER FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE AS
BEGIN
    
    DECLARE @EventData XML
    SELECT @EventData = EVENTDATA()

    INSERT INTO audit.dbo.logs 
    (db,tb,event,login,query,time)
    VALUES(
        @EventData.value('(/EVENT_INSTANCE/DatabaseName)[1]', 'varchar(250)'),
        @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(250)'),
        @EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(250)'),
        @EventData.value('(/EVENT_INSTANCE/LoginName)[1]', 'varchar(250)'),
        @EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'varchar(2500)'),
        GETDATE()

    )

END
GO

/*************************************/
/*





*/
CREATE DATABASE audit
Go
USE audit

CREATE TABLE logs 
(
    db nvarchar(250),
    tb nvarchar(250),
    event nvarchar(250),
    login nvarchar(250),
    query nvarchar(2500),
    time datetime
)


CREATE TABLE learn.db.bugati (id varchar(20))

SELECT * FROM audit.dbo.logs