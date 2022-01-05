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

















