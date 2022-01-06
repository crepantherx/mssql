
--Analytical and ranking functions----

SELECT * FROM employees.employees
SELECT emp_no,name,gender,  
FIRST_VALUE(name) OVER(PARTITION BY gender ORDER BY emp_no ROWS BETWEEN UNBOUNDED PRECEDING 
AND CURRENT ROW ) AS FIRST_NAME,
LAST_VALUE(name) OVER(ORDER BY emp_no ROWS BETWEEN UNBOUNDED PRECEDING 
AND UNBOUNDED FOLLOWING) AS LAST_NAME,
LEAD(emp_no,1,-1) over(order by emp_no) as [lead],
LAG(emp_no,1,-1) over(order by emp_no) as [lag]
FROM employees.employees

