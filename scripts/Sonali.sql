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

