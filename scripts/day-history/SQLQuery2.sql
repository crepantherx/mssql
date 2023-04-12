--table
select * from tblPerson
select * from tblGender

--insert into
insert into tblPerson values (2,'ani','ani@a.com',1)
insert into tblPerson values (3,'priya','pri@a.com',2)
insert into tblPerson values (4,'guru','guru@g.com',3)
insert into tblPerson values (5,'reta','re@a.com',2)
insert into tblPerson values (6,'kanti','ka@a.com',NULL)


insert into tblGender values (1,'Male')
insert into tblGender values (2,'Female')
insert into tblGender values (3,'Unkown')

--like
select * from tblPerson where Name LIKE 'a%'
select * from tblPerson where Name LIKE '%a'
select * from tblPerson where Name LIKE '_r%'
select * from tblPerson where Name LIKE 'k%i'
select * from tblPerson where Name LIKE '%a%'
select * from tblPerson where Name LIKE '[ask]%'
select * from tblPerson where Name LIKE '[^ask]%'
select * from tblPerson where Name LIKE '[a-r]%'
select * from tblPerson where Name LIKE '_an_i%'
select * from tblPerson where Name LIKE 's___%'

--between
select * from tblPerson where Name BETWEEN 'ani' AND 'reta'
order by Name 
select * from tblPerson where Name  NOT BETWEEN 'ani' AND 'reta'
order by Name 

--in
select * from tblPerson where Name IN ('ani','reta')
select * from tblPerson where Name NOT IN ('ani','reta')

--Alias
select Name AS PersonName From tblPerson
select Name AS PersonName From tblPerson where GenderID=2

--joins
select tblPerson.Name,tblPerson.Email,tblGender.Gender from tblGender inner join tblPerson on tblGender.ID=tblPerson.GenderID
select tblPerson.Name,tblPerson.Email,tblGender.Gender from tblGender left join tblPerson on tblGender.ID=tblPerson.GenderID
select tblPerson.Name,tblPerson.Email,tblGender.Gender from tblGender right join tblPerson on tblGender.ID=tblPerson.GenderID
select tblPerson.Name,tblPerson.Email,tblGender.Gender from tblGender full outer join tblPerson on tblGender.ID=tblPerson.GenderID
select A.Name AS PersonName1,B.Name AS PersonName2,A.Email from tblPerson A ,tblPerson B where A.ID <> B.ID

select * from tblPerson inner join tblGender on 1=1
select * from tblPerson cross join tblGender 

select * from tblPerson inner join tblGender on tblGender.ID=tblPerson.GenderID
select * from tblPerson left join tblGender on tblGender.ID=tblPerson.GenderID
select * from tblPerson right join tblGender on tblGender.ID=tblPerson.GenderID
select * from tblPerson full outer join tblGender on tblGender.ID=tblPerson.GenderID


select * from tblPerson join tblGender on tblGender.ID=tblPerson.GenderID