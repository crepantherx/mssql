
SELECT 
	e.emp_no
	, e.name
	, de.dept_no
	, s.salary
	, DENSE_RANK() OVER (PARTITION BY dept_no ORDER BY salary DESC) AS rk
FROM Employee.employees.employees AS e
JOIN Employee.employees.dept_emp AS de ON e.emp_no=de.emp_no
JOIN Employee.employees.salaries AS s ON e.emp_no=s.emp_no


SELECT *
FROM (
SELECT 
	e.emp_no
	, e.name
	, de.dept_no
	, s.salary
	, DENSE_RANK() OVER (PARTITION BY dept_no ORDER BY salary DESC) AS rk
FROM Employee.employees.employees AS e
JOIN Employee.employees.dept_emp AS de ON e.emp_no=de.emp_no
JOIN Employee.employees.salaries AS s ON e.emp_no=s.emp_no
) AS temp
WHERE rk=3



WITH temp AS (
SELECT 
	e.emp_no
	, e.name
	, de.dept_no
	, s.salary
	, DENSE_RANK() OVER (PARTITION BY dept_no ORDER BY salary DESC) AS rk
FROM Employee.employees.employees AS e
JOIN Employee.employees.dept_emp AS de ON e.emp_no=de.emp_no
JOIN Employee.employees.salaries AS s ON e.emp_no=s.emp_no
)
SELECT * FROM temp WHERE rk=2

correlated subquery - same 

SELECT *
FROM
(SELECT 
	e.emp_no
	, e.name
	, de.dept_no
	, s.salary
FROM Employee.employees.employees AS e
JOIN Employee.employees.dept_emp AS de ON e.emp_no=de.emp_no
JOIN Employee.employees.salaries AS s ON e.emp_no=s.emp_no



SELECT *
FROM sal
WHERE 1 = (
SELECT COUNT(*)
FROM sal AS oq
WHERE oq.salary > sal.salary
)




CREATE VIEW sal
AS
(
SELECT
	 emp_no
	 , max(salary) AS salary
FROM Employee.employees.salaries
GROUP BY emp_no
)


SELECT TOP 1 *
FROM
(
SELECT TOP 4 *
FROM Employee.employees.salaries
ORDER BY salary DESC
) AS tm
ORDER BY salary


SELECT count(e.emp_no) AS No_of_Employee,de.dept_no,sum(cast(s.salary as bigint)) AS Total_Salary
FROM Employee.employees.employees AS e
JOIN Employee.employees.dept_emp AS de
ON e.emp_no=de.emp_no
JOIN Employee.employees.salaries AS s
ON e.emp_no=s.emp_no
GROUP BY de.dept_no