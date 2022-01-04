---cursor-----use to fetch result set on row by row basis

DECLARE @name nvarchar(14),
        @sur_name nvarchar(16)

DECLARE my_cursorrr CURSOR
FOR SELECT name,sur_name
    FROM employees.employees

OPEN my_cursorrr
FETCH NEXT FROM my_cursorrr
INTO @name,@sur_name;

WHILE @@FETCH_STATUS = 0
  BEGIN
  PRINT @name +'  '+ @sur_name;
  FETCH NEXT FROM my_cursorrr
  INTO @name,@sur_name;
  END
CLOSE my_cursorrr
DEALLOCATE my_cursorrr


----functions-------
/* 
two types
1. USER DEFINED
2. SYSTEM DEFINED

1. USER DEFINED CAN BE OF 3 TYPES
 -> inline Table valued functions
 ->multi statement table valued function
 -> Scalar valued functions

 inline table valued -- in this we select a table data it returns a table
 */

 CREATE FUNCTION Table_vaued()
 returns table
 as
  return(select * from employees.employees)
  
  select * from Table_vaued()
   
--sql server treats inline table valued as a view internally and
--we can also update it---

update Table_vaued()
set name = 'dolly'
where emp_no=10001



----multistatement table valued----------
/* have to define structure of table ,begin and end complusory */

CREATE FUNCTION FUN()
returns @table TABLE(emp_no int,name nvarchar(14))
as
begin 
	 insert into @table
	 select emp_no,name from employees.employees
	 return
end

	select * from FUN()

--sql server treats multistatement table valued as a strore procedure internally and
--we can not edit or update it---
 
update FUN()
set name = 'dolly'
where emp_no=10001
 
 
---scalar valued functions--
  /* it should return single scalar value*/

CREATE FUNCTION Scalar_valued(@name nvarchar(14),@sur_name nvarchar(16))
returns nvarchar(100)
AS
   begin
   return (select @name + ' '+ @sur_name)
   end

   
   
select [dbo].[Scalar_valued](name,sur_name) from employees.employees