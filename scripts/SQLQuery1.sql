
/*2.	You are asked to inform your manager if the least-paid employee in 
the company has more than 3 years of experience. Find out the name, age,

employee ID, Manager ID and for how long the employee has been working in the
company of the least paid employee from the Employee database.
*/



with cte
as
(
    SELECT
     E.name 
    ,DATEDIFF(YEAR,birth_date,GETDATE()) AS Age
	,E.emp_no as emp_id
	,M.emp_no as manager_id
    ,DATEDIFF(YEAR,hire_date,GETDATE()) AS Experience
	,DENSE_RANK() OVER(ORDER BY salary) AS rk
	FROM employees.employees E
	JOIN employees.dept_manager M
	ON M.emp_no =E.emp_no
	JOIN employees.salaries S
	ON S.emp_no = M.emp_no
)SELECT * FROM  cte
WHERE rk = 1

SELECT * 
FROM 
(
	 SELECT D.dept_name
	       ,S.salary,DE.emp_no 
		   ,DENSE_RANK() over(PARTITION BY dept_name ORDER BY Salary) AS [RANK] 
	 FROM  employees.departments D
	 JOIN  employees.dept_emp DE
	 ON    DE.dept_no = D.dept_no
	 JOIN  employees.salaries S
	 ON    S.emp_no = DE.emp_no
 )result  WHERE [RANK] =9 AND dept_name ='Production'





--********************************************************************************************
SELECT * 
FROM 
(
	 SELECT D.dept_name
	       ,S.salary,DE.emp_no 
		   ,DENSE_RANK() over(PARTITION BY dept_name ORDER BY Salary) AS [RANK] 
	 FROM  employees.departments D
	 JOIN  employees.dept_emp DE
	 ON    DE.dept_no = D.dept_no
	 JOIN  employees.salaries S
	 ON    S.emp_no = DE.emp_no
 )result  WHERE [RANK] =9 AND dept_name ='Production'






Select  *
From    employees.salaries E1
JOIN employees.dept_emp DE
ON E1.emp_no = DE.emp_no
JOIN employees.departments D
ON DE.dept_no = D.dept_no
WHERE 9 = ( 
            SELECT Count(DISTINCT(E2.salary)) 
            FROM employees.salaries E2
			WHERE E2.Salary >= E1.Salary 
			)
AND dept_name = 'Production'


join employees.dept_emp DE
			ON E2.emp_no = DE.emp_no
			join employees.departments D
			ON DE.dept_no = D.dept_no



  
  
  
  
/*  DATEDIFF(YEAR,birth_date,GETDATE()) -
 case 
		    WHEN (MONTH(birth_date)> MONTH(GETDATE())) OR
			     (MONTH(birth_date)= MONTH(GETDATE()) AND DAY(birth_date) > DAY(GETDATE())
				 THEN 1 ELSE 0
            END
			4.	Your manager has asked you to give him/her a printout of how many
			employees are there in each department
			and how much the company has spent on these employees in terms of salary
			
			
			
			*/ 

----*********************************************************************---

SELECT 
        D.dept_name
	   ,COUNT(S.emp_no) OVER(PARTITION BY dept_name ORDER BY dept_name) as ls
	   
	 FROM  employees.departments D
	 JOIN  employees.dept_emp DE
	 ON    DE.dept_no = D.dept_no
	 JOIN  employees.salaries S
	 ON    S.emp_no = DE.emp_no

go;















SELECT 
	D.dept_name as Department_name
	, COUNT(S.emp_no) as Number_of_employees
	, SUM(CAST(salary as BIGINT)) as Total_salary
FROM  employees.departments D
JOIN  employees.dept_emp DE ON    DE.dept_no = D.dept_no
JOIN  employees.salaries S ON    S.emp_no = DE.emp_no
GROUP BY D.dept_name

--**************************************************--
















go;
WITH cte
 AS 
 (
    SELECT *,ROW_NUMBER() OVER(PARTITION BY column_name ORDER BY column_name) rownum
    FROM Table_name
 )
   DELETE FROM cte WHERE rownum>1


  --“Tech Mahindra,,,, Google,,Yahoo,,,,,,,,,,,,Twitter,,Orcale,,,,,,”---
  DECLARE @Exp nvarchar(50)
  SET @Exp = '“Tech Mahindra,,,, Google,,Yahoo,,,,,,,,,,,,Twitter,,Orcale,,,,,,”'

  select concat(SUBSTRING(@Exp,1,15) 
               ,SUBSTRING(@Exp,19,7)
			   ,SUBSTRING(@Exp,27,6)
			   ,SUBSTRING(@Exp,44,11)
			   ,SUBSTRING(@Exp,57,7)
			   ,SUBSTRING(@Exp,70,1))




  DECLARE @Exp nvarchar(50)
  SET @Exp = '“Tech Mahindra,,,, Google,,Yahoo,,,,,,,,,,,,Twitter,,Orcale,,,,,,”'

  select concat(SUBSTRING(@Exp,1,15) 
               ,SUBSTRING(@Exp,19,7)
			   ,SUBSTRING(@Exp,27,6)
			   ,SUBSTRING(@Exp,48,8)
			   ,SUBSTRING('“Tech Mahindra,,,, Google,,Yahoo,,,,,,
  ,,,,,,Twitter,,Orcale,,,,,,”',57,7),SUBSTRING('“Tech Mahindra,,,, Google,,Yahoo,,,,,,
  ,,,,,,Twitter,,Orcale,,,,,,”',70,1))
  

  SELECT * FROM INFORMATION_SCHEMA.D