/* Maximum Salary Per Department */

WITH DMAXSAL AS (
SELECT
	D.dept_name
	, S.salary
	, DE.emp_no
	, DENSE_RANK() OVER (PARTITION BY D.dept_name ORDER BY salary) as RK
FROM Employee.employees.departments AS D
JOIN Employee.employees.dept_emp AS DE ON D.dept_no=DE.dept_no
JOIN Employee.employees.salaries AS S ON S.emp_no = DE.emp_no
)
SELECT emp_no, salary, dept_name
FROM DMAXSAL
WHERE RK=3


/* Joined in 1998 */
ALTER USER sudhir WITH DEFAULT_SCHEMA=employees

SELECT * FROM (
	SELECT birth_date, first_name, last_name, gender, hire_date 
	FROM employees
) AS Duplicate
GROUP BY birth_date, first_name, last_name, gender, hire_date
HAVING COUNT(*)>1


/* Fetch Odd records */

SELECT *
FROM employees
WHERE emp_no % 2 <> 0

/* create a table and copy structure from some other table */ 
/* Not working in sql */

CREATE TABLE TEMP_employees AS 
SELECT * FROM employees
WHERE 1=0;

/* use concat */

SELECT REPLACE(CONCAT(first_name,' ', last_name), 'S', 's') AS 'Full Name'
FROM employees
WHERE first_name = 'Sudhir'


/* handling null */

SELECT COALESCE(NULL, NULL, NULL, 'W3Schools.com', NULL, 'Example.com'); 

