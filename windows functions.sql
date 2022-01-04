CREATE VIEW vw_emp_sal AS
	SELECT E.emp_no, D.dept_name, S.salary, S.from_date, S.to_date
	FROM Employee.employees.employees AS E
	JOIN Employee.employees.salaries AS S ON E.emp_no = S.emp_no
	JOIN Employee.employees.dept_emp AS DE ON DE.emp_no = E.emp_no
	JOIN Employee.employees.departments AS D ON D.dept_no = DE.dept_no
GO

SELECT *, 
	FIRST_VALUE(emp_no) OVER(PARTITION BY dept_name ORDER BY salary DESC) as FV
FROM vw_emp_sal

SELECT *, 
	LAST_VALUE(emp_no) OVER(PARTITION BY dept_name ORDER BY salary DESC
	RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	) as FV
FROM vw_emp_sal
go


SELECT *, 
	movi=LAST_VALUE(emp_no) OVER w
FROM vw_emp_sal
window w as (PARTITION BY dept_name ORDER BY salary DESC
	RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
	) 


	Go


SELECT *, 
	DENSE_RANK() OVER (PARTITION BY dept_name ORDER BY salary DESC) as RK
FROM vw_emp_sal
go

SELECT
CASE WHEN X.RK = 1 THEN 'classA'
	WHEN X.RK=2 THEN 'classB'
	END
FROM
(
SELECT *, 
	NTILE(3) OVER (PARTITION BY dept_name ORDER BY salary DESC) as RK
FROM vw_emp_sal
) AS X

go
143950