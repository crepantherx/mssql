ALTER TABLE Details
ADD DEFAULT 'SUDHIR' FOR Name

ALTER TABLE Details
DROP CONSTRAINT [DF__Details__NAME__2C3393D0]

SELECT * FROM Details

INSERT INTO Details(ID,Age,Profession)
VALUES 
(5,67,'dbms')

sp_rename 'Details.NAME','Name'

ALTER TABLE Details
DROP CONSTRAINT [PK__Details__3214EC2716AB0D65]

ALTER TABLE Details
ADD PRIMARY KEY (ID)

ALTER TABLE Details
ADD FOREIGN KEY(Intern_ID) references Details(ID)


ALTER TABLE Salary
DROP CONSTRAINT [FK__Salary__Intern_I__31EC6D26]

----Caution: Changing any part of an object name could break scripts and stored procedures.--

CREATE TABLE tbStudent
(
 StudentId  INT NOT NULL PRIMARY KEY IDENTITY(1,1),
 FirstName  VARCHAR(50),
 MiddleName VARCHAR(50),
 LastName   VARCHAR(50),
)


INSERT INTO tbStudent (FirstName,MiddleName,LastName)
VALUES
('Ankit',NULL,NULL),
(NULL,'Rahul','Singh'),
(NULL,NULL,'Rawat'),
('Rajesh','Singh','Thakur'),
('Narender','Kumar',NULL),
('Puneet','Kumar','Verma')

SELECT * FROM tbStudent

SELECT StudentId, COALESCE(FirstName,MiddleName,LastName) AS Name
FROM tbStudent

SELECT CASE WHEN  CONCAT (FirstName ,' ', MiddleName) = ' ' THEN 'ABCD' 
ELSE CONCAT (FirstName ,' ', MiddleName)
END
AS  MIX_NAME
FROM tbStudent




--------------------------------------------------

WITH cte
AS 
(
    SELECT FirstName,MiddleName,LastName,
	ROW_NUMBER() OVER (
            PARTITION BY 
                FirstName,MiddleName,LastName
            ORDER BY 
                FirstName,MiddleName,LastName
        ) row_num
     FROM 
        tbStudent
)
DELETE FROM cte
WHERE row_num > 1;


---------------case-----------------
SELECT FirstName,MiddleName,LastName
FROM tbStudent
ORDER BY 
(CASE
 WHEN FirstName IS NULL THEN MiddleName
 ELSE FirstName
 END)

 ------store procedure--------------
 CREATE PROCEDURE SP_ON_Deatials
 AS
 SELECT * FROM Details

 EXEC SP_ON_Deatials

 -----with input parameter-------------
 ALTER PROCEDURE SP_ON_Deatials
 @id int
 AS
 BEGIN
   SELECT * FROM Details
   WHERE ID = @id
 END

 EXEC SP_ON_Deatials @id = 1


 -------NOT NULL CONSTRAINT----------
ALTER TABLE Details
ALTER COLUMN Profession nvarchar(50) NOT NULL;

--------UNIQUE-----------
ALTER TABLE Details
ADD UNIQUE (Name)

-------other way to add uniue with name-----
ALTER TABLE Details
ADD CONSTRAINT uni_name UNIQUE (Name)

---------check constraint-----
ALTER TABLE Details
ADD CHECK(LEN(Name)<20) 

------INDEX-------
CREATE INDEX IX_ON_Detail_age 
ON Details(Age)

DROP INDEX Details.IX_ON_Detail_age

ALTER TABLE dbo.Demo
ADD Names NVARCHAR(20)

ALTER TABLE dbo.Demo
ADD sal INT

INSERT INTO Demo(sal)
VALUES (6)

SELECT * FROM Demo 

SELECT constraint FROM SYS.tables


EXEC sp_pkeys '<Details>'
EXEC sp_helpconstraint '<dbo.Details>'
	
SELECT CONSTRAINT FROM SYS.objects