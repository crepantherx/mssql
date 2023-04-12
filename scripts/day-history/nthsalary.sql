Go;

/*
    sp_helptext nth_SPD
    Use above line to verify encryption of SP
*/

ALTER PROCEDURE nth_SPD (@nth int = 1, @name varchar(20)="raj" output)
WITH ENCRYPTION
AS
    WITH ranked AS (
    SELECT
        dept_emp.dept_no,employees.emp_no, employees.first_name, salary,
        DENSE_RANK() OVER (PARTITION BY dept_emp.dept_no ORDER BY salary) as RK
    FROM
        Employees.Employees
        JOIN employees.salaries ON employees.emp_no = salaries.emp_no
        JOIN employees.dept_emp ON employees.emp_no = dept_emp.emp_no
    ) SELECT * from ranked where RK = @nth;
    SET @name='sudhir'
GO

declare @name varchar(20);
EXEC nth_SPD @name OUTPUT;
SELECT @name;