Create database Company

Create table employee 
( 
ID int not null primary key,
Name nvarchar(50) not null,
Email nvarchar(50) not null,
Position nvarchar(50) not null,
Salary int not null 
)


Create table salary 
( ID int not null primary key,
Salary int not null
)
select*from employee
select*from salary



Insert into employee (ID, Name, Email, Position, Salary)
Values ( 1, 'Sonali', ' sar@aaa.com', ' Intern', 1)

Insert into employee values ( 2, 'Aman', ' ama@aaa.com', ' Intern', 1)


Insert into salary (ID, Salary)
Values (1, 15000)

Alter table employee add constraint
employee_employee_FK
Foreign key (Salary) references salary(ID)  
---Day-2

Select * from employee AS E
join salary AS S ON E.ID =  S.ID


Select E.ID, E. NAME, E. EMAIL, E. POSITION, S.SALARY from employee AS E
join salary AS S ON E.ID =  S.ID

Create table Internship 
(ID int not null,
Name nvarchar(50) not null,
Department nvarchar(50),
Gender nvarchar(30)
)

Insert into internship (ID,Name,Department,Gender)
Values (1, 'aman', 'operations', 'Male'),
(2, 'Sonali', 'marketing', 'Female')

Select*from Internship

Alter table Internship
Add constraint departmnent CHECK (Department IN ('operations', 'marketing'))

Alter table Internship
Drop constraint  Departmnent

Insert into Internship Values (4, 'Alex', 'marketing', 'Male'),
(5, 'Piyush', 'marketing', 'Male')


Alter table Internship
Add constraint Internship_unique UNIQUE (ID)

Alter table Internship
Drop constraint Internship_unique 

-

--DAY-1

create database sampleR

Alter Database simple Modify Name = sampleR

Drop database sampleR
use same 
Go
create table tblgender
(
ID int not null primary key,
Gender nvarchar(50) not null
)


alter table tblperson add constraint tblperson_Gender_FK
foreign key (Gender) REFERENCES tblgender (ID)

Select* from tblgender
Select* from tblperson

Alter table tblperson
add constraint DF_tblperson_gender
default 3 for Gender

insert into tblperson (ID, NAME, Email,Gender)
values (7, 'Harshita', 'Hks@gmail.com', Null)

Alter table tblperson
drop constraint DF_tblperson_gender

Delete from tblgender where ID= 1

create database customers

