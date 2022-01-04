CREATE DATABASE Practice
ALTER DATABASE Practice MODIFY NAME = practice
EXEC sp_renameDB 'practice','Pro'
DROP DATABASE Pro

 USE [Practice]
 GO
CREATE TABLE tbl_person 
(
ID INT NOT NULL PRIMARY KEY,
Name nvarchar (50) NOT NULL ,
Email nvarchar(20) NOT NULL,
Gender nvarchar (5) 
)
 
 CREATE DATABASE PRO
 
 CREATE TABLE Table1 
(
ID INT NOT NULL PRIMARY KEY,
Name nvarchar (50) NOT NULL ,
Email nvarchar(20) NOT NULL,
Gender nvarchar (5) 
)

alter table tbl_gender
alter column ID  nvarchar(5 )

alter table Employee.employees.tbl_gender
ADD PRIMARY KEY (ID) 

ALTER TABLE Employee.employees.Table1
ADD CONSTRAINT Table_GenderID_FK 
FOREIGN KEY (GenderID) references Employee.employees.tbl_gender(ID)

select * from Employee.employees.tbl_gender

alter table Employee.employees.employees
add constraint employees_emp_no_FK 
foreign key (emp_no) references Employee.employees.departments(dept_no)

drop table table1
DROP TABLE tbl_gender






CREATE TABLE tbl_person 
(
ID INT NOT NULL PRIMARY KEY,
Name nvarchar (50) NOT NULL ,
Email nvarchar(20) NOT NULL,
Gender_Id int 
)

CREATE TABLE Tbl_gender
(
ID int not null PRIMARY KEY,
Gender nvarchar(50) NOT NULL
)

SELECT * FROM tbl_person

INSERT INTO tbl_person
values
(1,'john','a@a',3),
(2,'smith','s@a',1),
(3,'harry','h@a',2)

INSERT INTO Tbl_gender
values
(1,'M'),
(2,'F'),
(3,'UNKNOWN')

ALTER TABLE tbl_person
ADD CONSTRAINT person_Gender_Id_FK 
FOREIGN KEY (Gender_Id) references Tbl_gender(ID)

INSERT INTO tbl_person (ID,Name,Email)
values
(4,'sweety','a@a')

ALTER TABLE tbl_person
ADD CONSTRAINT person_gender_DF
DEFAULT 2 FOR  Gender_Id 

INSERT INTO tbl_person (ID,Name,Email)
values
(5,'sudhir','s@d')

INSERT INTO tbl_person (ID,Name,Email)
values
(6,'abc','b@a'),
(7,'abd','d@a')

SELECT * FROM tbl_person
SELECT * FROM Tbl_gender

DELETE FROM Tbl_gender
where ID = 3

INSERT INTO Tbl_gender
values
(5,'M'),
(6,'F'),
(7,'UNKNOWN'),
(4,'M')

ALTER TABLE tbl_person
ADD  Age int 

INSERT INTO  tbl_person(ID,Name,Email,Age)
values(9,'anu','@bn',23),
(8,'radha','@cn',-13)

ALTER TABLE tbl_person
ADD CONSTRAINT CK_person_Age
CHECK (Age >0 AND Age <150)

DELETE  FROM tbl_person
where ID = 8

INSERT INTO  tbl_person(ID,Name,Email,Age)
values
(11,'radha','@cn',13)

INSERT INTO  tbl_person VALUES (0,'hii','df',1,8)

CREATE TABLE TEST1
( ID INT identity(1,1),
value nvarchar(20)
)

CREATE TABLE TEST2
( ID INT identity(1,1),
value nvarchar(20)
)

INSERT INTO TEST1 VALUES('D')
SELECT * FROM TEST1
select * from TEST2

CREATE TRIGGER TR_FOR_INSERT ON TEST1 FOR INSERT
AS
BEGIN

INSERT INTO TEST2 VALUES('ANY')
END

SELECT SCOPE_IDENTITY()
SELECT @@IDENTITY
SELECT IDENT_CURRENT('TEST2')

INSERT INTO TEST2 VALUES('AAA')