SELECT I.ID AS PERS_ID,ISNULL( g.Gender_id,0) as gender
FROM employees.tbl_person I
left join employees.tbl_person g
on I.ID= g.Gender_id

SELECT I.ID AS PERS_ID,COALESCE( g.Gender_id,0) as gender
FROM employees.tbl_person I
left join employees.tbl_person g
on I.ID= g.Gender_id


SELECT I.ID AS PERS_ID,
CASE when g.Gender_id IS NULL then 0 else  g.Gender_id END as gender
FROM employees.tbl_person I
left join employees.tbl_person g
on I.ID= g.Gender_id

--coalesce returns first not null value 
select ID,coalesce(Gender_id ,Age) as res
from employees.tbl_person

select * from ipl.deliveries
  union
  select * from ipl.matches

  select * from ipl.deliveries
  union all
  select * from ipl.matches

  --stored procedure
  CREATE PROCEDURE sp_Get_IPL_Detail 
  AS
  BEGIN 
  SELECT * FROM ipl.matches
  END

  sp_Get_IPL_Detail

  ALTER PROCEDURE sp_Get_IPL_Detail_withpara 
  @team1 varchar(64),@team2 varchar(64)
  AS
  BEGIN 
  SELECT  team1,team2 from ipl.matches
  where team1=@team1 AND team2=@team2
  END

  sp_Get_IPL_Detail_withpara 'Kolkata Knight Riders','Royal Challengers Bangalore'
  
 

   ALTER PROCEDURE sp_Get_IPL_Detail_withpara 
  @team1 varchar(64),@team2 varchar(64),@id int output
  AS
  BEGIN 
  SELECT  @id = count(id) from ipl.matches
  where team1=@team1 AND team2=@team2
  END

  declare @idcount int
  execute sp_Get_IPL_Detail_withpara 'Kolkata Knight Riders','Royal Challengers Bangalore',@id=@idcount output
  print @idcount


  --string functions
  select ascii('A')

  declare @a int
  set @a=65
  while(@a<91)
  begin
  print char(@a)
  set @a=@a+1
  end

  select reverse(UPPER(RTRIM(LTRIM('   abc   ' ))))as upeercse

  SELECT LEFT('HELLOWORLD',5)
  SELECT RIGHT('HELLOWORLD',5)
  SELECT CHARINDEX('W','HELLOWORLD')
  SELECT SUBSTRING('HELLOWORLD',CHARINDEX('W','HELLOWORLD')+1,LEN('HELLOWORLD')-CHARINDEX('W','HELLOWORLD'))

   SELECT SUBSTRING(Email,CHARINDEX('@',Email),LEN(Email)-CHARINDEX('@',Email)),
   count(Email) as total
   from employees.tbl_person
   group by SUBSTRING(Email,CHARINDEX('@',Email),LEN(Email)-CHARINDEX('@',Email))


   --Replicate 
   select Name,Email,SUBSTRING(Email,1,2) + replicate('*',3) + SUBSTRING (Email,CHARINDEX('@',Email),len(Email)- CHARINDEX('@',Email)) as replicate
   from employees.tbl_person 

   --space
   select SUBSTRING(Name,1,2) + space(4) + Email as spc_ex
   from employees.tbl_person

   --