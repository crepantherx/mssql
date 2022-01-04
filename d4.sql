--conversion of datatype in two way cast and convert

SELECT CAST(GETDATE() AS DATE)
SELECT Convert(DATE, GETDATE())

SELECT 'HELLO' + CAST(1 AS NVARCHAR)

select square(5)
select power(2,3)

--user defined function
--scalar function
create function age()
returns date
as 
begin
declare @age date
set @age=getdate()

return @age
end

select   dbo.age()

sp_helptext age

--inline table valued function
create function detail(@genderid int)
returns table
as 
return
(select * from employees.tbl_person where Gender_Id=@gender)

ALTER function detail(@genderid int)
returns table
with encryption
as 
return
(select * from employees.tbl_person where Gender_Id=@genderid)

select * from dbo.detail(2)

sp_helptext detail

---multi staatement function

ALTER function MULTI_detail(@genderid int)
returns @TABLE table(ID int,Gender_id int)
with schemabinding
as 
begin 
insert into @table
select ID,Gender_id from employees.tbl_person where Gender_Id=@genderid
return
end

select * from dbo.MULTI_detail(2)

drop table tbl_person

alter view vw_detail
with schemabinding
as 
select Name,Email,Gender from employees.tbl_person
join employees.Tbl_gender
on employees.tbl_person.Gender_id = employees.Tbl_gender.ID

select * from vw_detail

update  vw_detail 
set Name='dolly' where Email='@a'

create unique clustered index ix_on_view 
on vw_detail(Email)

--trigger
create trigger tr_on_person
on employees.tbl_person
for insert
as 
begin 
       declare @id int
	   select @id = ID from inserted
	   insert into employees.Tbl_gender values(1,'male for'+cast(@id as nvarchar(10))+'belongs to person table')

end
 
insert into employees.tbl_person(ID,Name,Email) 
values(18,'sara','@76')

select * from employees.tbl_person
select * from employees.Tbl_gender

create trigger tr_on_personn11
on employees.TEST1
for insert
as 
begin 
       select 'hello' as msg

end

INSERT INTO employees.TEST1 VALUES('HELLO')

create trigger tr_on_personnn
on employees.tbl_person
for insert
as 
begin 
       declare @id int
	   select @id = ID from inserted
	   insert into employees.Tbl_gender(Gender) values('male for'+cast(@id as nvarchar(10))+'belongs to person table')

end

Select * from employees.tbl_person where Name in ('smith','harry');