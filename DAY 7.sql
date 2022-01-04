/*
JOINS
1.Nested joins :-It is best when we want to join few records of data from large tables
                 and we can optimize it by creating index on table 
2.Merge joins:- It is useful when our data is already sort but sorting is slow operation
                so this is rare operation
3.Hash joins:- hash join is best wwhen we want to join large records from large tables
               indexing is not useful here ,
*/

SET SHOWPLAN_ALL ON
SET SHOWPLAN_ALL OFF
SELECT  d.dept_name,de.dept_no,dm.emp_no
FROM    Employee.employees.departments d
JOIN    Employee.employees.dept_emp de      ON d.dept_no= de.dept_no
JOIN    Employee.employees.dept_manager dm  ON dm.emp_no=de.emp_no

SELECT *
FROM Employee.employees.employees e
JOIN Employee.employees.dept_emp de
ON e.emp_no = de.emp_no


SELECT a.dept_no,b.dept_no
FROM Employee.employees.departments a
JOIN Employee.employees.departments b
ON a.dept_name = b.dept_name

SELECT *
FROM Employee.employees.departments a
JOIN Employee.employees.departments b
ON a.dept_name = b.dept_name

SELECT * FROM Employee.employees.departments a , Employee.employees.departments b

SELECT * FROM INTERNS.dbo.Emp
ALTER TABLE Emp
DROP COLUMN age 

CREATE TABLE Emp
(

)

insert into Emp values(1,'Farhan Ahmed','Male',60000),  
(5,'Monika','Female',25000) , 
(2,'Abdul Raheem','Male',30000),  
(4,'Rahul Sharma','Male',60000) , 
(1,'Farhan Ahmed','Male',60000),  
(2,'Abdul Raheem','Male',30000),  
(5,'Monika','Female',25000) , 
(4,'Rahul Sharma','Male',60000),  
(1,'Farhan Ahmed','Male',60000),  
(3,'Priya','Female',20000) , 
(5,'Monika','Female',25000) , 
(4,'Rahul Sharma','Male',60000),  
(5,'Monika','Female',25000)  ,
(2,'Abdul Raheem','Male',30000),  
(1,'Farhan Ahmed','Male',60000) , 
(4,'Rahul Sharma','Male',60000) 

SELECT a.ID FROM Emp a,Emp b

SELECT a.ID FROM Emp a
INNER JOIN Emp b
ON a.ID = b.ID

CREATE INDEX Ix_on_ID
ON Emp(ID)

DROP INDEX Emp.Ix_on_ID

SELECT * INTO NewEmp
FROM Employee.employees.employees

SELECT * FROM NewEmp

-----HASH join-----because it does not have index and have big data 
SELECT * FROM NewEmp a
JOIN 
NewEmp b
ON a.emp_no = b.emp_no

--merge join--because it have clustered index and big data
SELECT * FROM Employee.employees.employees a
JOIN 
Employee.employees.employees b
ON a.emp_no = b.emp_no


SELECT TOP 10 * INTO NewEmp1
FROM Employee.employees.employees

-----Nested join because it have few data-----
SELECT TOP 5 * FROM NewEmp1 a
JOIN 
NewEmp1 b
ON a.emp_no = b.emp_no

CREATE TABLE A (ID INT)
INSERT INTO A VALUES(1),(1),(0),(1),(NULL)

SELECT * 
FROM A a join A b
ON a.ID = b.ID


SELECT a.name,count(*) as number_of_records FROM Employee.employees.employees a
JOIN 
Employee.employees.employees b
ON a.emp_no = b.emp_no
GROUP BY a.name

SELECT a.name,count(*) as number_of_records FROM NewEmp a
JOIN 
NewEmp b
ON a.emp_no = b.emp_no
GROUP BY a.name