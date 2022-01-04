select  * FROM (

SELECT employees.emp_no,name,dept_name, MAX(salary)as max_sal 

FROM employees.salaries
join employees.employees
on employees.employees.emp_no= employees.salaries.emp_no
join employees.dept_emp
on employees.dept_emp.emp_no= employees.employees.emp_no
join employees.departments
on employees.departments.dept_no=employees.dept_emp.dept_no

GROUP BY employees.emp_no,name,dept_name
) tmp
WHERE max_sal=(
SELECT max(max_sal) FROM (
SELECT employees.emp_no,name,dept_name, MAX(salary)as max_sal 

FROM employees.salaries
join employees.employees
on employees.employees.emp_no= employees.salaries.emp_no
join employees.dept_emp
on employees.dept_emp.emp_no= employees.employees.emp_no
join employees.departments
on employees.departments.dept_no=employees.dept_emp.dept_no

GROUP BY employees.emp_no,name,dept_name
)ge
)


SELECT TOP 1 * FROM (
SELECT TOP 3 E.emp_no, salary
FROM employees.salaries AS S
JOIN employees.employees AS E ON E.emp_no = S.emp_no

ORDER BY salary DESC
) hh
ORDER BY salary




156286



WITH nth AS (
SELECT  E.emp_no, salary,DE.dept_no,
	DENSE_RANK() OVER(PARTITION BY DE.dept_no ORDER BY salary DESC) AS RK
FROM employees.salaries AS S
JOIN employees.employees AS E ON E.emp_no = S.emp_no
JOIN employees.dept_emp AS DE ON DE.emp_no = E.emp_no
) SELECT *
FROM nth 
WHERE RK = 5
