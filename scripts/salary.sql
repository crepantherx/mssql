
USE Employee;

WITH 
    award (id, name, salary, Class)
    AS (
    SELECT employees.emp_no as id
        , first_name as name
        , salary
        , DENSE_RANK() OVER( ORDER BY salaries.salary ) AS Class
    FROM employees.employees
        JOIN employees.salaries ON employees.emp_no = salaries.emp_no
    ) 
select top 1 * from award where Class = 2 order by Class ;

/*
SELECT TOP 1 *  from 
(
SELECT TOP 7 Employees.emp_no, first_name, salary
FROM Employees.employees
JOIN Employees.salaries
ON Employees.emp_no = salaries.emp_no
ORDER BY salary
) Result 
ORDER BY salary desc
*/


SELECT MAX(salary)
FROM Employees.employees
JOIN Employees.salaries
ON Employees.emp_no = salaries.emp_no where salary < (
SELECT MAX(salary)
FROM Employees.employees
JOIN Employees.salaries
ON Employees.emp_no = salaries.emp_no
)


/****Department wise male and female***/




SELECT dept_name, M, F
FROM (
    SELECT E.gender, D.dept_name, E.emp_no
    FROM Employee.employees.employees AS E
    JOIN Employee.employees.dept_emp AS DE ON E.emp_no=DE.emp_no
    JOIN Employee.employees.departments AS D ON D.dept_no = DE.dept_no
    JOIN Employee.employees.salaries AS S ON E.emp_no = S.emp_no
) as DB
PIVOT ( COUNT(emp_no) FOR gender IN (M, F)) as pV
ORDER BY dept_name


/*****/
GO

SELECT E.emp_no,E.first_name, D.dept_name
FROM Employee.employees.employees AS E
JOIN Employee.employees.dept_emp AS DE ON DE.emp_no = E.emp_no
JOIN Employee.employees.departments AS D ON D.dept_no = DE.dept_no




