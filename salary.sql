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
SELECT emp_no, salary, dept_name, RK
FROM DMAXSAL
WHERE RK=3