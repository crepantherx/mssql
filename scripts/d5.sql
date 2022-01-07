--CTE
WITH PERSONCOUNT(ID,NAME,total)
AS 
(
SELECT ID,Name,count(*)  as total
FROM employees.tbl_person
group by ID,Name
)

select Gender_id, total from 
employees.tbl_person
join PERSONCOUNT
on PERSONCOUNT.ID = tbl_person.ID
order by total


WITH update_PERSONCOUNT(ID,NAME)
AS 
(
SELECT ID,Name
FROM employees.tbl_person

)

update  update_PERSONCOUNT
set Name='radha' where ID= 3
select * from employees.tbl_person

---pivot operater

select toss_decision ,Bangalore,Chandigarh
from ipl.matches
pivot
(    sum(win_by_runs)
     for city 
	 IN ([Bangalore],[Chandigarh])
)
as pivottable

--cursor

declare @id int
declare idcursor cursor for
select ID from employees.tbl_person where ID < 4
open idcursor
fetch next from idcursor into @id
while ( @@fetch_status =0)
begin 
 print 'id = ' + cast(@id as nvarchar(10))
 fetch next from idcursor into @id
end

close idcursor
deallocate idcursor

select *  from sysobjects  where xtype ='U'
select * from sys.tables
select * from INFORMATION_SCHEMA.TABLES

--merge in sql

merge into targettable as T
using sourcetable as s
on t.id = s.id
when matched then
update set T.name =s.name
when not matched by target then
insert (ID,Name) values(s.id,s.name) 
when not matched by source then
delete;


--transactions

create table accounts
( id int ,
accountname nvarchar(20),
balance int)

insert into accounts values
(1,'radha',1000),
(2,'krishna',1000)

BEGIN TRY
 BEGIN TRANSACTION 
   UPDATE accounts SET balance = balance - 100 WHERE id=1
   UPDATE accounts SET balance = balance + 100 WHERE id=3
 COMMIT TRANSACTION
 PRINT 'TRANSACTION SUCCESFUL'
END TRY
BEGIN CATCH
 ROLLBACK TRANSACTION
 PRINT 'TRANSACTION FAILED'
END CATCH
 
 SELECT * FROM accounts
