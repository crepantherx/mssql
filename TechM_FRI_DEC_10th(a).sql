
Create Table Employeee
(ID INT , Name varchar(20), Gender varchar(10),DepartmantID int)

INSERT INTO Employeee Values
(1,'Sam','Male',1),
(2,'Ram','Male',1),
(3,'Sana','FeMale',3),
(4,'Sara','FeMale',2),
(5,'Todd','Male',3),
(6,'John','Male',2),
(7,'James','Male',1),
(8,'Rob','Male',2),
(9,'Steve','Male',1),
(10,'Pam','FeMale',2)

SELECT *  FROM Employeee;

--------------------------------------------------------------------------- 

ALTER PROCEDURE spgetEmployeees
AS
BEGIN
    SELECT NAME, GENDER FROM Employeee
	order by Name
END
-----------------------------------------------------------------------
spgetEmployeees
Exec spgetEmployeees
execute spgetEmployeees
----------------------------------------------------------------------------

CREATE PROCEDURE spGetEmployeeeByGenderandDepartment
@Gender varchar(10),
@DepartmentID int
AS
Begin
	Select * from Employeee where Gender =@Gender AND DepartmantID = @DepartmentID
END

-----------------------------------------------------------------------------
 exec spGetEmployeeeByGenderandDepartment @DepartmentID=1,@Gender='Male'

 