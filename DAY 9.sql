
--*******FIND NTH HIGHEST SALARY IN DIFFERENT WAYS********************************

--************** 1ST WAY ***************************

SELECT TOP 1 *

FROM
(
SELECT DISTINCT TOP 3*
FROM employees.salaries
ORDER BY salary DESC
)a
Order by salary 
--**************************************


-- ************* 2nd way *************


SELECT * FROM (

SELECT DENSE_RANK() OVER (ORDER BY salary DESC) AS row_rank,salary
FROM employees.salaries ) AS Maxs
WHERE row_rank = 3 
--**************************************



-- ************* 3rd way *************
SELECT * 
FROM employees.salaries 
WHERE salary = 
(
	SELECT MIN(salary) 
	FROM employees.salaries
	WHERE  salary IN 
		(  
			SELECT DISTINCT TOP 3 salary 
			FROM employees.salaries 
			ORDER BY salary DESC
		)
)



--**************************************



-- ************* 4th way *************
WITH cte 
AS
( SELECT *,DENSE_RANK() OVER(ORDER BY Salary DESC) AS rnk 
 FROM employees.salaries)
 SELECT * FROM cte WHERE rnk = 3

--***********************************************************



-- ************* For Second Highest Salary Query *************

SELECT MAX(salary) AS SAL 
FROM employees.salaries
WHERE salary <> (
	SELECT MAX(salary)
	FROM employees.salaries
	)




--**************** 5th way *********************************** 

SELECT * FROM (
SELECT salary,
ROW_NUMBER() OVER (ORDER BY salary DESC) AS rownumber
FROM employees.salaries
) AS result
WHERE rownumber = 3

--************* 6TH way *******************************************

SELECT MAX(salary) 
FROM employees.salaries
WHERE salary <(
	SELECT MAX(salary) AS SAL
	FROM employees.salaries
	WHERE salary<(
		SELECT MAX(salary)
		FROM employees.salaries 
	)
)


--****************  7th way **********************

Select  *
From    employees.salaries E1
Where 3 = ( 
            Select Count(Distinct(E2.salary)) 
            From employees.salaries E2
			Where E2.Salary >= E1.Salary
			)




 --********* with partitions*******************************
 
 with cte AS (
 select D.dept_name,S.salary,DE.emp_no ,DENSE_RANK() over(PARTITION BY dept_name ORDER BY Salary) AS rk 
 from employees.departments D
 join employees.dept_emp DE
 ON DE.dept_no = D.dept_no
 join employees.salaries S
 ON S.emp_no = DE.emp_no
 ) select * from cte where rk =3


 --query for finding duplicate salary----
    
	SELECT
        salary ,
        COUNT(*) occurrences
    FROM employees.salaries
    GROUP BY 
        salary 
        
    HAVING 
        COUNT(*) > 1

--********************************************************
SELECT  *
FROM    employees.salaries E1
WHERE 3 = ( 
            Select Count(Distinct(E2.salary)) 
            From employees.salaries E2
			Where E2.Salary >= E1.Salary
		)



	