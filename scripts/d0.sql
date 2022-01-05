SELECT *
FROM employees.employees

SELECT 
	gender
	, count(*)
FROM Employee.employees.employees 
GROUP BY gender;


SELECT *
FROM Employee.employees.employees 
WHERE birth_date != '1953-09-02'

SELECT *
FROM Employee.employees.employees 
WHERE NOT birth_date = '1953-09-02'

SELECT *
FROM Employee.employees.employees 
WHERE birth_date <> '1953-09-02'

SELECT *
FROM Employee.employees.employees 
WHERE NOT (birth_date = '1953-09-02' AND gender= 'M')

SELECT *
FROM Employee.employees.employees 
WHERE NOT (birth_date = '1953-09-02' OR gender= 'M')


SELECT *
FROM Employee.employees.employees 
WHERE NOT (birth_date = '1953-09-02' OR gender= 'M') AND first_name LIKE 'SUD%' AND last_name LIKE 'SI%';



SELECT *
FROM employees.employees
WHERE first_name = 'Leon'

CREATE INDEX IX_Employees_firstName
ON Employee.employees.employees(first_name)


SELECT * FROM Employee.employees.employees



SELECT * FROM employees.employees ORDER BY emp_no



CREATE UNIQUE INDEX IX_Employees_PempNo
ON Employee.employees.employees(emp_no)


GO


CREATE PROCEDURE get_detail AS 
BEGIN
	SELECT *
	FROM Employee.employees.employees
	WHERE birth_date = '1953-09-02'
END

















GO



ALTER PROCEDURE get_detail 
@dt DATE
AS 
BEGIN
	SELECT *
	FROM Employee.employees.employees
	WHERE birth_date = @dt
END


GO


ALTER PROCEDURE get_detail 
@dt DATE,
@gn varchar(10)
AS 
BEGIN
	SELECT *
	FROM Employee.employees.employees
	WHERE birth_date = @dt AND gender = @gn
END


EXEC get_detail @gn='M', @dt='1953-09-02'


UPDATE Employee.employees.employees
SET first_name = 'Sudhir'
WHERE first_name = 'Georgi'


ALTER TABLE employees.employees
ADD gf varchar(10)




SELECT * FROM Employee.employees.employees;






ALTER TABLE Employee.employees.employees
ALTER COLUMN last_name varchar(64)



sp_rename 'employees.employees.first_name', 'name'





