
SELECT
	e.emp_no
	, SUM(s.salary) AS 'CTC'
	, e.sur_name
	, e.birth_date
	, e.hire_date
	, e.name
	, d.dept_name
FROM 
	Employee.employees.employees AS e
	JOIN Employee.employees.salaries AS s ON e.emp_no=s.emp_no
	JOIN Employee.employees.dept_emp AS de ON e.emp_no=de.emp_no
	JOIN Employee.employees.departments AS d ON de.dept_no=d.dept_no
WHERE
	e.gender = 'M'
	AND e.sur_name LIKE 'Facello'
	AND YEAR(e.birth_date) = 1953
	AND MONTH(e.hire_date) = 6
	AND e.name != 'Arif'
GROUP BY e.emp_no, sur_name, e.birth_date, e.hire_date, e.name, d.dept_name
HAVING SUM(s.salary) > 1300000