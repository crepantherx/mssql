/*
*   CREATE DATABASE
*/

IF NOT EXISTS (
    SELECT *
    FROM sys.databases
    WHERE name='learn'
) 
BEGIN
    CREATE DATABASE learn
END

/*
*   Copy Table from other databases
*/

CREATE SCHEMA employees

SELECT *
INTO learn.employees.employees
FROM Employee.employees.employees

/*
    CREATE INDEX
*/

CREATE INDEX IX_Employee_dob ON learn.employees.employees (birth_date ASC)

sp_helpindex 'employees.employees'

DROP INDEX employees.employees.IX_Employee_dob

CREATE TABLE db.contact (
    phone INT PRIMARY KEY,
    name nvarchar(32)
)

ALTER TABLE db.contact
ALTER COLUMN name nvarchar(64)

ALTER TABLE db.contact
DROP CONSTRAINT PK__contact__B43B145E97FACF74

ALTER TABLE db.contact
ALTER COLUMN phone BIGINT NOT NULL

ALTER TABLE db.contact
ADD PRIMARY KEY (phone)

sp_helpindex 'db.contact'

sp_helpindex 'db.contact'

INSERT INTO db.contact VALUES (9891353333, 'Sudhir Singh')
INSERT INTO db.contact VALUES 
(8587001379, 'Navin Singh'),
(6202440101, 'Nr'),
(9891365311, 'Hm')


SELECT *
FROM db.contact

CREATE TABLE db.contactBackup (
    phone BIGINT,
    name nvarchar(32)
)

INSERT INTO db.contactBackup VALUES 
(9891353333, 'Sudhir Singh'),
(8587001379, 'Navin Singh'),
(6202440101, 'Nr'),
(9891365311, 'Hm')

SELECT name
FROM db.contactBackup

CREATE CLUSTERED INDEX IX_contactBackup_phone ON db.contactBackup (phone ASC, name DESC)

DROP INDEX db.contactBackup.IX_contactBackup_phone


/*
    Triggers
*/
Go

CREATE TABLE db.audit (
    id int,
    message nvarchar(128)
)

ALTER TABLE db.audit 
DROP COLUMN id

Go

ALTER TRIGGER db.tr_contactBackup_ForInsert ON db.contactBackup FOR INSERT AS
BEGIN
    DECLARE @name varchar(20)
    DECLARE @phone BIGINT
    
    SELECT @name = name FROM inserted
    SELECT @phone = phone FROM inserted

    INSERT INTO db.audit VALUES
    ('A new contact '+ CAST(@phone AS nvarchar(20)) + ' has been added with the name of "' + @name + '"')
END

INSERT INTO db.contactBackup VALUES 
(8586777, 'steven')

select * from db.audit


select * from inserted