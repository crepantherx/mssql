/*****************************
 
 FUNCTION ( ... ) OVER (
 PARTITION BY ...
 ORDER BY ...
 ROW BETWEEN ... AND ...
 )
 
 *****************************/
SELECT
    *
FROM
    Employees.Employees
    JOIN employees.salaries ON employees.emp_no = salaries.emp_no
    JOIN employees.dept_emp ON employees.emp_no = dept_emp.emp_no
    JOIN employees.departments ON dept_emp.dept_no = departments.dept_no
    JOIN employees.dept_manager ON dept_emp.dept_no = dept_manager.dept_no
    JOIN employees.titles ON employees.emp_no = titles.emp_no
    /* TOTAL EXPENSE PER DEPARTMENT */
    /********************************/
SELECT
    DISTINCT dept_emp.dept_no,
    SUM(CONVERT(BIGINT, salaries.salary)) OVER (PARTITION BY dept_emp.dept_no) as Dept_Expense
FROM
    Employees.Employees
    JOIN employees.salaries ON employees.emp_no = salaries.emp_no
    JOIN employees.dept_emp ON employees.emp_no = dept_emp.emp_no
ORDER BY
    dept_no
    /********************************/
;

GO
;

CREATE PROCEDURE SelectAllCustomers AS
SELECT
    DISTINCT dept_emp.dept_no,
    SUM(CONVERT(BIGINT, salaries.salary)) OVER (PARTITION BY dept_emp.dept_no) as Dept_Expense
FROM
    Employees.Employees
    JOIN employees.salaries ON employees.emp_no = salaries.emp_no
    JOIN employees.dept_emp ON employees.emp_no = dept_emp.emp_no
ORDER BY
    dept_no;

GO;

exec sp_rename 'SelectAllCustomers', 'EachDepartmentExpenses'

/* 
    11th max salary in each department
*/;
go;
