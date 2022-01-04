
ALTER TRIGGER Tr_intervall
ON Details
INSTEAD OF INSERT
AS
BEGIN
     IF( CONVERT(TIME, GETDATE())  between  '22:00:00' AND '23:00:00')
           select 'we can not insert this day' as important
END


 
insert into Details values(27,'khj',76,'gh',9)

 declare @timeinterval time
		   set @timeinterval= CONVERT(TIME, GETDATE()) 

SELECT CONVERT(TIME, GETDATE()) 
select getdate()
select DATENAME(MINUTE, GETDATE())

SELECT CONVERT(TIME, GETDATE()) 