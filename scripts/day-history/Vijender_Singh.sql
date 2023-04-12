use Practice1
--ascii-> corresponding integer value for a character
print ascii('Ab');
--will return ascii value of A

--char-> converts the integer value to the corresponding ascii value, =< 0 and >= 255
print char(65);
print char(97);

--LTRIM-> removes the spaces/blanks on left side
print '   wind    turbine   ';
print LTRIM('   wind    turbine   ');

--TTRIM-> removes the spaces/blanks on the right side
print '   wind    turbine   '+'as';
print RTRIM('   wind    turbine   ')+'as';


--To print from a to z
declare @start int
set @start = 97
while(@start < 122)
	begin
		print char(@start)
		set @start = @start + 1
	end;
--to lower case
declare @string varchar(50)
set @string = 'asdsdsas'
begin
print upper(@string)
end;

--reverse a string
declare @string1 varchar(50)
set @string1 = 'qwerty'
begin
print reverse(@string1)
end;

--length of a string
declare @string3 varchar(50)
set @string1 = 'qwerty'
begin
print len(@string3)
end;


select name, len(name) as length_of_name from Employee.employees.employees;
select * from Employee.employees.employees;

--left -> gives a substring of specific lenght starting from left
select * from Practice2.dbo.Person_Table;

print left('asdasdasd', 4);

select left(email, 2) from Practice2.dbo.Person_Table

--right -> reverse of left

print right('asdasdasd', 4);

select right(email, 2) from Practice2.dbo.Person_Table

--char index-> find the index of the particular element
print charindex('@', 'vj@gmail.com'  , 0);--> output 3

--substring->returns a part of a string
print substring('vj@gmail', 1,3);

print substring('vj@gmail.com', charindex('@', 'vj@gmail.com')+1, len('vj@gmail.com') )

-->replicate
print replicate('haha' , 5);
select  ID, name, SUBSTRING(email, 1, charindex('@',email) -1 )+ replicate('*',5)+ SUBSTRING(email, charindex('@',email)+1, len(email) ) as email
from Practice2.dbo.Person_Table;

--space to specify the number of spaces between 2 strings/words
print 'ha'+space(10)+'ha';

--patindex - > can use wildcards, similar to charindex
print patindex('%@gmail.com%', 'v@gmail.comasdfgmail.com'); 

--replace function -> replace(string, pattern, replacement) replace pattern with replacement

print replace('vjsa@gmail.com','gmail.com','@outlook.com'); 

--stuff function-> stuff(string, start,length,replacement)
print stuff('vj@gmail.com', 3, 2, '@outlook.com');--vj@outlook.commail.com


create table t6(
	ti time(7) 
);

use Practice1
CREATE TABLE [tblDateTime]
(
 [c_time] [time](7) NULL,
 [c_date] [date] NULL,
 [c_smalldatetime] [smalldatetime] NULL,
 [c_datetime] [datetime] NULL,
 [c_datetime2] [datetime2](7) NULL,
 [c_datetimeoffset] [datetimeoffset](7) NULL
)

select * from tblDateTime;

INSERT INTO tblDateTime VALUES (GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE())

select * from tblDateTime;

print current_timestamp;

print getdate();

print isdate('asd');
print isdate(getdate() );

--temprory table
use practice1
create table #t6(
	id int,
	name varchar(50)
);

select name from tempdb..sysobjects
where name like '#t6%';

--procedure

/*
05-01-2021
*/

select isdate('string'); -- returns 0 i.e false

select isdate(getdate()); --returns 1 i.e. true

select isdate('2021'); -- returns 1

select SYSDATETIMEOFFSET();

select SYSDATETIME();

select isdate( '2022-01-05 11:34:21.1918447' );

select isdate(SYSDATETIME());--showing error

declare @sysdate nvarchar(100)--this does not
set @sysdate = SYSDATETIME()
begin
	print isdate(@sysdate)
end;

--order->'MM/DD/YYYY'

select day( getdate() ); -- current day

select month(getdate() );-- current month

select year(getdate() );--current year


select day( SYSDATETIME() ); -- current day

select month(SYSDATETIME() );-- current month

select year(SYSDATETIME() );--current year

select day('52/24/9999');

print datename(dayofyear, '2022/02/01' );--gives the day of the month

select * from Employee.employees.employees;

--datename, dateadd, datediff

select a.emp_no, (a.name + ' ' + a.sur_name ) as FullName, datename(year,a.birth_date) as BirthYear,
month(a.birth_date) as monthNumber, datename(month, a.birth_date) as month,
datename(day,a.birth_date) as date, datename(weekday, a.birth_date) as day
from Employee.employees.employees a;

select a.emp_no, a.name, datepart(year, a.hire_date) as hireDate,
datepart(month, a.hire_date) as hireMonth, datepart(DAY, a.hire_date) as hireDay
from Employee.employees.employees a;

select a.emp_no, a.name, DATEADD(year, 2, a.hire_date ) as hireDate
from Employee.employees.employees a;


select a.emp_no, a.name, DATEDIFF(year , a.hire_date, GETDATE()) as experience
from Employee.employees.employees a;

--datailed agg

select * from Employee.employees.employees a;

select a.emp_no, a.name, ( cast(DATEDIFF(year, a.birth_date, getdate() ) as varchar(5)) +'years'
+ cast(datediff(month, a.birth_date, getdate())%12 as varchar(5)) +'month'
+ cast(datediff(day, a.birth_date, getdate())%365 as varchar(5)) + 'days old' )
as age 
from Employee.employees.employees a;

declare @dob datetime, @tempDate datetime, @year int, @month int, @day int
set @dob = '2022/01/05'
begin
select @tempDate = @dob
select @year = datediff(year, @dob, getdate() )
				- case when (month(@tempdate) > month(getdate() ) )or (MONTH(@tempdate) = month(getdate()) and day(@tempDate) >day(getdate() ) ) then 1
						else 0
					end
select @tempDate = DATEADD(year, @year, @tempdate)
select @month = datediff(month, @tempdate, getdate() )
select @day = datediff(day, @tempdate, getdate() )
select @year as years,@month as months, @day as days
end;

go -- user defined function to get the age in detailed view

create function getAgeDetailed(@DOB date)
returns nvarchar(50)
as 
begin
	declare @tempDate date, @year int, @month int, @day int
	select @tempDate = @dob
	select @year = datediff(year, @dob, getdate() )
					- case when (month(@tempdate) > month(getdate() ) )or (MONTH(@tempdate) = month(getdate()) and day(@tempDate) >day(getdate() ) ) then 1
							else 0
						end
	select @tempDate = DATEADD(year, @year, @tempdate)
	select @month = datediff(month, @tempdate, getdate() )
	select @day = datediff(day, @tempdate, getdate() )
	declare @age nvarchar(50)
	set @age = cast(@year as nvarchar(4) ) + ' years '+ cast(@month as nvarchar(2)) + ' months '+ cast(@day as nvarchar(3)) + ' days old '
	return @age
end;

go
select a.name, a.emp_no, a.birth_date, dbo.getAgeDetailed(a.birth_date ) as age from Employee.employees.employees a;

go
create table t6(
	id int
);

insert into t6 values
(1),
(null)

alter table t6 
add constraint ck_t6_id check(id is not null ) nocheck

end

create table #ta(
id int identity(1,1),
name varchar(50)
);

drop table #ta

go
create procedure createLocalTemproryTable
as 
begin
create table #ta3(
	id int not null,
	name varchar(50)
)
insert into #ta3 values
(1,'as'),
(2,'sd'),
(3,'df');
select * from #ta3
end;

exec createLocalTemproryTable;

select * from #ta3--> will show error

create table ##ta4(
	id int,
	name varchar(10) not null
);

drop table ##ta4

use Practice1

create table ##ta4(
	id int,
	name varchar(10) not null
);

--unlike local, it does not get ___no. after table.

--index-> helps in improving the time efficieny, try to avoid table scan every time
--table scan -> when query engine scans every record in the table

create index ix_Employee_employees_salaries_salary
on Employee.employees.salaries(salary )

use Employee

select * from Employee.employees.salaries where salary > 100000;

sp_help T1--for tables

go
use master
go
sp_help
go

use Employee
go
sp_help 'Employee.emplyees.salaries';
go

sp_helptext getAgeDetailed

sp_helpindex employees.salaries---not checking

select * from employees.salaries;

drop index employees.salaries.ix_Employee_employees_salaries_salary;


use Employee

sp_helpindex salaries--showing error

sp_helpindex customers--not showing error

use Practice1

execute sp_helpindex t4

drop table t4
drop table t5
drop table t6 

CREATE TABLE t3
(
 [Id] int Primary Key,
 [Name] nvarchar(50),
 [Salary] int,
 [Gender] nvarchar(10),
 [City] nvarchar(50)
)

Insert into t3 Values(3,'John',4500,'Male','New York')
Insert into t3 Values(1,'Sam',2500,'Male','London')
Insert into t3 Values(4,'Sara',5500,'Female','Tokyo')
Insert into t3 Values(5,'Todd',3100,'Male','Toronto')
Insert into t3 Values(2,'Pam',6500,'Female','Sydney')

select * from t3

alter table t3
drop constraint  PK__t3__3214EC07EE70AF0F;

create clustered index ci_t3_id on t3(id);

drop index t3.ci_t3_id

create clustered index ck_t3_id_name on t3(id asc, city desc);

drop index t3.ck_t3_id_name

create clustered index ck_t3_salary on t3(salary);


select * from t3

drop table t3

CREATE TABLE t3
(
 [Id] int Primary Key,
 [Name] nvarchar(50),
 [Salary] int,
 [Gender] nvarchar(10),
 [City] nvarchar(50)
)

sp_helpindex t3

Insert into t3 Values(3,'John',4500,'Male','New York')
Insert into t3 Values(1,'Sam',2500,'Male','London')
Insert into t3 Values(4,'Sara',5500,'Female','Tokyo')
Insert into t3 Values(5,'Todd',3100,'Male','Toronto')
Insert into t3 Values(2,'Pam',6500,'Female','Sydney')

select * from t3

alter table t3
drop constraint PK__t3__3214EC07673E6E4B;
Insert into t3 Values(2,'Pam',6500,'Female','Sydney')

select * from t3

create unique clustered index uix_t3_id on t3(id);--will show error because duplicate value exist

delete from t3 where id = 2;

create unique clustered index uix_t3_id on t3(id);--will show error

alter table t3
add constraint uq_t3_id UNIQUE(id) where id > 6;--will show error

/*
07-01-2022
Employees Database Task
*/

--creating database
create database TEmployee;

--using it
use TEmployee;


--to create a schema use-> create schema schemaName
go
create schema temployees;

--to check schemas
go
select * from sys.schemas;

/*
creating tables whose columns are used as foreign keys in other tables
order of creating tables
temployees.employees
temployees.salaries
temployees.titles
temployees.departments
temployees.dept_manager
temployees.dept_emp
*/

/*
creating main table employees, because it is used as foreign keys in other tables, we have to create it firt in order to reference it first
primary key on emp_no
which will be referenced by other tables.
*/
go
create table temployees.employees(
	emp_no int,
	birth_date date not null,
	first_name nvarchar(15) not null,
	last_name nvarchar(15) not null,
	gender nvarchar(1) not null,
	hire_date date not null,
	constraint pk_employees_empno  PRIMARY KEY(emp_no)
);
/*
creating table for salaries, 
having primary key as combination  of emp_no and from_date
and foreign key on emp_no from employees table 
*/
go
create table temployees.salaries(
	emp_no int,
	from_date date,
	salary int not null,
	to_date date not null,
	constraint pk_salaries_empno_fromdate primary key(emp_no, from_date),
	constraint fk_salaries_employees_empno foreign key(emp_no) references temployees.employees(emp_no)
);


/*
creating table for employees titles
having primary key on the combination of 3 columns-> emp_no, title, from_date
having foreign key on emp_no from employees table
*/
create table temployees.titles(
	emp_no int,
	title nvarchar(50),
	from_date date,
	to_date date not null,
	constraint pk_titles_empno_title_fromdate primary key(emp_no, title, from_date),
	constraint fk_titles_employees_emp_no foreign key(emp_no) references temployees.employees(emp_no)
);


/*
creating table for departmens, before creating table for dept_emp and dept_manager
having primary key as dept_no
having unique constraint on dept_name
*/
create table temployees.departments(
	dept_no nchar(4),
	dept_name nvarchar(40) not null,
	constraint pk_departments_dept_no primary key(dept_no),
	constraint uq_departments_dept_name unique(dept_name)
);

/*
creating table for department managers
primary key on columns emp_no and dept_no
foreign key on emp_no from employees
foreing key on dept_no from departments
*/
create table temployees.dept_manager(
	emp_no int,
	dept_no nchar(4),
	from_date date not null,
	to_date date not null,
	constraint pk_deptmanager_empno_deptno primary key(emp_no, dept_no),
	constraint fk_deptmanager_employees_empno foreign key(emp_no) references temployees.employees(emp_no),
	constraint fk_deptmanager_departments_deptno foreign key(dept_no) references temployees.departments(dept_no)
);

/*
creating table for details regarding each employee and their department
primary key on columns emp_no and dept_no
foreign key on emp_no from employees
foreing key on dept_no from departments
*/
create table temployees.dept_emp(
	emp_no int,
	dept_no nchar(4),
	from_date date not null,
	to_date date not null,
	constraint pk_deptemp_empno_deptno primary key(emp_no, dept_no),
	constraint fk_deptemp_employees_empno foreign key(emp_no) references temployees.employees(emp_no),
	constraint fk_deptemp_departments_deptno foreign key(dept_no) references temployees.departments(dept_no)
);




