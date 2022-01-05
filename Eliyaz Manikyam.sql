
CREATE TABLE Employee 
(EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)

CREATE TABLE EmployeeSalary
(EmployeeID int,
jobTitle varchar(50),
Salary int
)

INSERT INTO Employee VALUES 
(1 , 'Eliyaz' , 'Manikyam',23,'M')

INSERT INTO Employee VALUES 
(2, 'Hemanth' , 'Gondhi' , 23,'M'),
(3, 'Srujan' , 'Marhtati' , 23,'M'),
(4, 'Sai' , 'Nutan' , 23,'M'),
(5, 'Rohit' , 'Golla' , 23,'M'),
(6, 'Khadar' , 'Syed' , 23,'M'),
(7, 'Ganesh' , 'Kuruba' , 23,'M')

--It is used to see the structure of the table
SP_HELP Employee;


Create table Practicealter
(empid int , empname char(10), salary int , age int);

----SUB commands of ALTER 
-- 1. Alter Alter column
-- 2. Alter Add
-- 3.SP_RENAME
-- 4.Alter Drop

--This command is used to change the DATATYPE and SIZE of the DATATYPE 
ALTER TABLE Practicealter ALTER COLUMN empname varchar(50);

--This command is use to ADD a new column to a table
ALTER TABLE Practicealter ADD EAddress varchar(30);

--This command is use to change the column name and table name 
    --1.To change the column name 
SP_RENAME 'Practicealter.empname','ename';

   --2.To change the table name
SP_RENAME 'Practicealter','practicealtercommand';

--This command is used to drop the column
ALTER TABLE Practicealtercommand DROP COLUMN EAddress;

-->WORKING WITH DML COMMANDS
    --INSERT
	--UPDATE
	--DELETE

-- 1.) INSERT :INSERT new values into the TABLE
 
 CREATE TABLE STUDENTS 
 (StId int , SName varchar(30), Age int , Gender varchar(10));

 --We have two methods to insert values into the table 
 --METHOD 1 :-
 INSERT INTO STUDENTS VALUES
 (1,'Bell',10,'M')  
                  --(like this we can enter values with proper order)

--METHOD 2:-
INSERT INTO STUDENTS
(StId,SName,Gender) VALUES (2,'Sam','M');
                 --(With the help of this menthod we can insert only the values which we would like to insert)


SELECT * from STUDENTS;


-- 2) UPDATE : THIS commmand is used to update the records in the TABLE

UPDATE STUDENTS SET Age=11 where StId=1;

SELECT * from STUDENTS;
   --  Here we are using WHERE condition to specifically change the prefered row

   -- . UPDATE STUDENTS SET Age=11 where Age=NULL ;  (This Doesnot work ) insted we have to use an operation
   
UPDATE STUDENTS SET Age=11 where Age is NULL;
SELECT * from STUDENTS;

  -- If we want to update entire column at once , WE need to specify the comdition

UPDATE STUDENTS SET Age = 13;
SELECT * from STUDENTS;

INSERT INTO STUDENTS VALUES      --	we'll insert some more records in the table
 (3,'Ben',10,'M'),
 (4,'Stella',14,'F')
 SELECT * from STUDENTS;

 -- 3) DELETE : THIS command is used to delete all rows at a time or can specifically delete selected row with condition

DELETE FROM STUDENTS WHERE SName = 'Sam';
SELECT * from STUDENTS;


INSERT INTO STUDENTS                            --	we'll insert some more records in the table
(StId,SName,Gender) VALUES (5,'Elli','M');
SELECT * from STUDENTS;

DELETE FROM STUDENTS WHERE Age IS NULL;
SELECT * from STUDENTS;

DELETE FROM STUDENTS;   -- > This command will help in deleting all records from Table
SELECT * from STUDENTS;


CREATE Table  Customers
( CustomerID INT,	CustomerName VARCHAR(20),PostalCode INT,Country CHAR(10) ,Birth_Date DATE )

INSERT INTO Customers Values
(1, 'Maria Anders' , 12209 , 'Germany' , '10/06/1997' )

INSERT INTO Customers Values
(2, 'Sunny' , 12209 , 'Germany' , '10/06/1997' ),
(3, 'Eliyaz' , 12203 , 'india' , '10/02/1997' ),
(4, 'Merry' , 12204, 'srilanka' , '10/06/1997' ),
(5, 'srujan' , 12205 , 'india' , '10/09/1997' ),
(6, 'Rohit' , 12208 , 'Germany' , '10/02/1997' )
 
 ----------------------------------------------------
SELECT * FROM Customers;

-- 1. How to SELECT DISTINCT VALUES FROM A TABLE

SELECT DISTINCT Country FROM Customers;

SELECT COUNT(DISTINCT Country) FROM Customers; --If we want to see count the distinct number from a coulumn of a table

-------------------------------------------------------
--2. HOW TO USE Where Condition
SELECT * FROM Customers WHERE Country='india';

SELECT Birth_Date,CustomerName FROM Customers WHERE Country='india'; 
                                 -- This command is to write specific columns

  --ON the top of it , we can use operatures as well ,Like
  SELECT * FROM Customers WHERE CustomerID=1;
  SELECT * FROM Customers WHERE CustomerID<2;
  SELECT * FROM Customers WHERE CustomerID>2;
  SELECT * FROM Customers WHERE CustomerID>=1;
  SELECT * FROM Customers WHERE CustomerID<=2;
  SELECT * FROM Customers WHERE CustomerID<>2;
  SELECT * FROM Customers WHERE CustomerID BETWEEN 2 AND 5;
  SELECT * FROM Customers WHERE CustomerID<=2;
  SELECT * FROM Customers WHERE CustomerName LIKE 's%' ;
  SELECT * FROM Customers WHERE Country IN ('india','srilanka');


--------------------------------------------------------
--3.AND , OR, NOT OPERATERS
SELECT * FROM Customers WHERE Country='india' AND CustomerId= '2';
SELECT * FROM Customers WHERE Country='india' OR CustomerId= '2';
SELECT * FROM Customers WHERE Country='india' AND NOT CustomerId= '2';

--------------------------------------------------------
--4.ORDER BY 
SELECT * FROM Customers ORDER BY Country;
                                 --  Here initially evn if we wont specify , by default it will ASC
SELECT * FROM Customers ORDER BY Country DESC;

-------------------------------------------------------
--5.INSERT INTO
       -- WE have already covered it on TOP

-----------------------------------------------------
--6.NULL VALUES
SELECT CustomerNamE FROM Customers WHERE Country IS NULL;
                          -- The result got Empty , Because der were no NULL values in it
SELECT CustomerNamE, Country FROM Customers WHERE Country IS NOT NULL;	

-----------------------------------------------------
--7.UPDATE COMMAND
UPDATE Customers SET CustomerName = 'Alfred Schmidt', Country= 'England' WHERE CustomerID = 1;
                                         -- will make affect only 1 row , v=because we have specified where we need to change
SELECT * FROM Customers;

  --If we want to update the whole column, no need of specifying the condition
UPDATE Customers SET CustomerName = 'Alfred Schmidt', Country= 'England' ;

---------------------------------------------------
--8.DELETE COMMAND
DELETE FROM Customers WHERE CustomerName='rohit';
                    -- it is when you want to delete specific record
DELETE FROM Customers;
                    -- This will delete all the records  

SELECT * FROM Customers;

---------------------------------------------------
--9.SELECT TOP 
SELECT TOP 3 * FROM Customers;
 ------------------------------------------------
--10. Aliases

CREATE TABLE CUS 
(CustomerID INT	,CustomerName VARCHAR(20),City CHAR(10)	,PostalCode INT	,Country VARCHAR(20) );

INSERT INTO CUS VALUES
(1,'Ana', 'MCITY',05021, 'Mexico');


INSERT INTO CUS VALUES
(2,'Vna', 'ACITY',05022, 'Wexico'),
(3,'Ena', 'BCITY',05023, 'Eexico'),
(4,'Cna', 'CCITY',05024, 'Vexico')

SELECT * FROM CUS;

CREATE TABLE CUST
(CustomerID INT	,CustomerName VARCHAR(20),City CHAR(10)	,PostalCode INT	,Country VARCHAR(20) );

INSERT INTO CUST VALUES
(1,'ELI', 'MCITY',05025, 'Gexico'),
(2,'BLI', 'ACITY',05022, 'Wexico'),
(3,'GIL', 'BCITY',05023, 'Eexico'),
(4,'CIL', 'CCITY',05024, 'Vexico')

SELECT * FROM CUST;

SELECT CustomerName , city +',' + Country AS City_Country from cus;
   OR
SELECT CustomerName , CONCAT (city,',' ,Country) AS City_Country from cust;

------------------------------------------------
--11.JOINS 

SELECT * FROM CUS
INNER JOIN
CUST ON CUS.CustomerID = CUST.CustomerID;

SELECT * FROM CUS C
LEFT OUTER JOIN
CUST T ON C.CustomerID = T.CustomerID;

----------------------------------------------------

-- CASE --
CREATE TABLE OrderDetails
(OrderDetailID	INT ,OrderID INT,ProductID INT,	Quantity INT )

INSERT INTO OrderDetails VALUES
(1,10248,11,12),
(2,10248,42,10),
(3,10248,72,5),
(4,10249,14,9),
(5,10249,72,40)

SELECT * FROM OrderDetails;

 --SYNTAX --

 
 SELECT OrderDetailID , Quantity ,
 CASE
    WHEN Quantity > 30 THEN 'The Quality is greater than 30'
	WHEN Quantity < 30 THEN 'The Quality is less than 30'
    ELSE 'The Quality is equal to 30'
END AS QuantityTest
FROM OrderDetails;
	
------------------------------------------------------
 --SQL NULL FUNCTIONS --
 CREATE  TABLE NULLFUNCTION
 (ID INT , FiRSTNAME Varchar(30),MIDDLENAME VARCHAR(30), LASTNAME VARCHAR(30))

 INSERT INTO NULLFUNCTION VALUES
 (1,'SAM',NULL,NULL)

 INSERT INTO NULLFUNCTION VALUES
 (2,NULL,'TODD','TANZAN'),
 (3,NULL,NULL,'ELLI'),
 (4,'ANDY','MAD','BOY')

 SELECT * FROM NULLFUNCTION;

  --Trying coalesce function --

 SELECT ID , COALESCE(FIRSTNAME,MIDDLENAME,LASTNAME) AS NAMEID
 FROM NULLFUNCTION;

 -- trying isnull function --
 
  SELECT ID , ISNULL(FIRSTNAME,'BECCA') AS NAMEID
 FROM NULLFUNCTION;

 ------------------------------------------------------
 -- STORED PROCEDURE --

 CREATE TABLE SPexample
 (id int, NameID Varchar(30),Gender Char(10),Dept int)

 select * from SPexample;
  ----
  CREATE PROCEDURE SPexampleALL --  Without parameterd
  as
  select * from SPexample
  GO 

  EXEC SPexampleALL

  --------
  CREATE PROCEDURE spNameIDandGender
  @Gender char(10),
  @Dept int
  as
  SELECT NameID,Gender,Dept from SPexample where Gender =@Gender AND Dept = @Dept
  go

  EXEC spNameIDandGender @Gender = f, @Dept = 1

  -----------------------------------------------------------------------------
  ------------------------------------------------------------------------------
  -- CONSTRAINS --

  CREATE TABLE PP
  (ID INT PRIMARY KEY)

  CREATE TABLE PP
  (ID INT ,
  CONSTRAINT LAST_NAME )


  CREATE TABLE SESSION
  ( NAME INT, ADDRESS )
  -------------------------------------
  CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    CONSTRAINT PK_Person PRIMARY KEY (ID,LastName)
);
SELECT * FROM Persons;


-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
  -- CREATING TWO TABLES --
  CREATE TABLE tblperson 
  (ID INT NOT NULL, NAME VARCHAR(20) , EMail varchar(20) , GenderID int )
                              -- we are creating this table to add Foreign key constrain 
  select * from tblperson;

   --we'll create another table for primary key constrain 
  
  CREATE TABLE tblGender
  (ID INT , Gender INT ) ;       --		This table is to add primary key constrain

  ALTER TABLE tblGender alter column Gender char(10)

  ALTER TABLE tblGender ALTER COLUMN ID int NOT NULL;

  INSERT INTO tblGender VALUES 
  (1,'Male'),
  (2,'Female'),
  (3,'Unknown')            
  
  Select * from tblGender;

    -- Now we"ll add primary key and foreign key 

 ALTER TABLE tblGender ADD PRIMARY KEY (ID);
                       -- I GOT an Error showing it should be NOT NULL first while altering ADD PRIMARY CONSTRAINT
					   -- SO, i altered the column NOT NULL first AND again ALtred PRIMARY KEY

		-- SYNTAX --
ALTER TABLE tblperson add constraint tblperson_GenderID_FK
FOREIGN KEY (GenderID) references tblGender(ID) ;
                      
					  -- THINGS TO REMEMBER
					    --1.We cannot give any such value as we wish to Foreign key column 
						--  it should refer some value with associate primary key column table
						--  evn if you try it , it throughs an error
 
 =---------------------------------------------------------------------------------------------------
 --------------------------------------------------------------------------------------------------

  --- Default CONSTRAINT --

  ALTER TABLE tblperson
  add constraint DF_tblperson_GenderID
  DEFAULT 3 FOR GenderID

  INSERT INTO tblperson (ID,NAME,EMail) VALUES (7,'MAYA','MAYA@GMAIL.COM')

  SELECT * FROM tblperson;
          -- if you just see , the default values that we ahve assigned to genderid column has displayed 3

 -- NOW we'll check how to drop DEfault constraint
 
 ALTER TABLE tblperson
 DROP constraint DF_tblperson_GenderID ;

 ---------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------

  -- INDEXS --
   -- Indexs are used by QUERIES to find the data Quickly
   -- Indexs are created on tables and views 
   -- These are simmilar the an INDEX THAT WE FIND IN A BOOK

   -- If we dont have a right indexes , then the QUERY ENGINE ,Check every row in each table
   -- This is called as ' TABLE SCAN '

-- First we'll create a table to perform some operations on INDEXS

 CREATE TABLE tblEmployee 
 (ID INT, NAME VARCHAR(20), Salary INT ,GENDER CHAR(10))

 INSERT INTO tblEmployee Values
 (1,'sam',2500,'Male'),
 (2,'pam',6500,'Female'),
 (3,'John',4500,'Male'),
 (4,'Sara',5500,'Female'),
 (5,'Todd',3100,'Male')

 SELECT * FROM tblEmployee;

  -- Now we'll see HOw to Create Index With Query

  CREATE INDEX IX_tblEmployee_Salary
  ON tblEmployee (Salary ASC);
   
   -- WE can check weather we have created a index on not in Two ways 
   -- 1. Go to OBJECT Explorer guite through where you have created
   -- 2.WE can use one of the built in stored procedude  '' sp_helpindex table name "

   sp_helpindex tblEmployee

    -- it SHOws on which table it has created as well

  -- IF we want to DRop the INDEX

  -- SYNTAX --
  -- drop index table_nmae.index_nmae --

  DROP INDEX tblEmployee.IX_tblEmployee_Salary;

  -- WE can create the index with the help of grafically as well 
     -- Right click on the index --> go to new_index --> give the name of index --> specify on which column --> add

----------------------------------------------------------------------------------------------

  -- Now we'll see What are the Diff Types of INdex
  -- We have so many types of index , Manly
    -- CLUSTERED
	-- NONCLUSTERED
	-- UNIQUE
	-- FILTERED
	-- XML
	-- FULL TEXT   ... ETC 

  -- 1.CLUSTERED INDEX 

   -- A CLUSTERED INDEX IS A PHYSICAL ODER OF DATA  IN A  TABLE --

   -- NOW we'll create table for better understanding

   CREATE TABLE [tblEmployee1]
   (ID INT PRIMARY KEY ,
   NAME VARCHAR(20),
   SALARY INT,
   GENDER VARCHAR(10),
   CITY VARCHAR(10));

   execute sp_helpindex tblEmployee1 ;

    -- A CLUSTERED INDEX WILL B AUTOMATICALLY CREATERD IN A TABLE WHEN WE GIVE PRIMARY KEY TO ANY COLUMN 
	-- WE CAN N0T HAVE TWO CLUSTERED INDEX IN A SINGLE TABLE 

	-- NOW we'll insert some values in the table 


	INSERT INTO tblEmployee1 Values (1,'sam',2500,'female','new york'),
	INSERT INTO tblEmployee1 Values (3,'john',2500,'Male','London'),
	INSERT INTO tblEmployee1 Values (2,'sara',2500,'female','Sydney'),
	INSERT INTO tblEmployee1 Values (5,'todd',2500,'Male','Tokya'),
	INSERT INTO tblEmployee1 Values (4,'pam',2500,'fwmale','Toronto')

	SELECT * FROM tblEmployee1;

	-- if we can notice , evn if we insert the recoreds un order , it will automatically comes up with order

	--'' Here, The INDEX can have multiple columns ( it is called ""  composite clustered index "" )

	CREATE CLUSTERED INDEX IX_tblEmployee1_Gender_Salary
	on tblEmployee (Gender DESC , Salary Asc )

	 -- This Again wont works as it arleady have an index  

	 DROP INDEX tblEmployee1.IX_tblEmployee1_Gender_Salary

	  -- Again we cannot do it this way , as dont have permission , SO
	  -- WE can make use of graphical interphase to delete , When we try again 

    CREATE CLUSTERED INDEX IX_tblEmployee1_Gender_Salary
	on tblEmployee (Gender DESC , Salary Asc )
                                             -- This works ( Composite Clustered Index)

        SELECT * FROM tblEmployee1;

		----------------------------------------------------------------------------------

		-- NON CLUSTERED INDEX --

 -- SYNTAX --
    -- CREATE NONCLUSTERED INDEX < INDEX NAME > ON <TABLE_NAME><COLUMN_NMAE>

	-- It is like the index page in a book , which have a separate page to store what is der in what
	-- we can have as many non clustered index  in a table
	-- clustered indexex are faster than nonclustered

	----------------------------------------------------------------------------------------

	   -- UNIQUE INDEX --

  -- IT ENFORCE UNIQUENESS OF KEY VALUE IN THE INDEX
  
  CREATE TABLE [tblEmployee2]
   (ID INT PRIMARY KEY ,
   FIRSTNAME VARCHAR(20),
   LASTNAME VARCHAR(20),
   SALARY INT,
   GENDER VARCHAR(10),
   CITY VARCHAR(10));

   SELECT * FROM tblEmployee2;

   sp_helpindex tblEmployee2

   -- by default primary key constraint create a unique clustered index

   drop index tblEmployee2.PK__tblEmplo__3214EC27B8CEB2AE

    it wont works 

	-- if you try to delete unique index , it will automnatically delete the primary key as well
	
	--when , you try to add 2 duplicate rows , it will take
	 
	INSERT INTO tblEmployee2 Values (1,'sam','sagar',2500,'female','new york');
	INSERT INTO tblEmployee2 Values (1,'john','peter',3500,'Male','London');

	select * from tblEmployee2;

	ALTER TABLE tblEmployee2
	add constraint UQ_tblEmployee_city
	UNIQUE CLUSTERED (City)

	--------------------------------------------------------------------

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

 -- CURSORS --

-- DEFINE :
   --> CURSOR IS A TEMP.MEMORY / TEMP.WORK STATION
   --> IT WILL ALLOCATE BY DB SERVER AT THE TIME OF DML OPERATIONS BY USER ON DB TABLES
   --> THESE ARE USED FOR STORING TABLES 

 -- TYPES OF CURSORS :
    -- 1. Implicit
	      -- Def : Default Cursors of SQL SERVER DataBase
		  --       This cursors memory is allocate by DB memory , when we perform DML operations

	-- 2. Explicit
	      -- Def : Thses Cursours are created by User 
		  --       Fetch Data from table in Row -by - Row Mannar

 -- WORKING WITH EXPLICIT CURSORS --
   
   -- > For working with Explicit cursors we hav to follow some steps
    
	--STEP 1 : DECLARE CURSOR OBJECT
	           -- Syntax : DECLARE <CURSOR NAME> CURSOR FOR SELECT * FROM <TABLE_NAME>

	--STEP2  : OPEN CURSOR CONNECTION 
	           -- Syntax : Open < cursor connection>

	--STEP3  : FETCH DATA FROM CURSOR
	           -- Syntax : Fetch Next/first/Last/Prior/Absolute n /Relative n from <Cursor Name> [Into variables] 

	--STEP4  : CLOSE CURSOR CONNECTION
	           -- Syntax : Close <Cursor connection >
			   
	--STEP5  : DEALLOCATE CURSOR MEMORY
               -- Syntax : Deallocate < CURSOR NAME >

                          -- These are the 5 steps wn we are following Explicit CURSOR 

 ------------------------------------------------------------------------------------------------

  -- Now we'll Create Table For Practice 

  CREATE TABLE CURSORPRACTICE
  (EID INT , ENAME VARCHAR(50), SALARY INT)

  -- We'll INSERT Records with the help of Graphical method for our convenince

  SELECT * FROM CURSORPRACTICE;

  UPDATE CURSORPRACTICE SET ENAME = 'FINCH' WHERE EID = 103;

   SELECT * FROM CURSORPRACTICE;

   -- NOW WE'LL WRITE PROGRAM WITHOUT VARIABLES --

   DECLARE C1 CURSOR SCROLL FOR SELECT * FROM CURSORPRACTICE
   OPEN C1
   FETCH LAST FROM C1
   CLOSE C1
   DEALLOCATE C1 ;
                     -- LAST METHOD

   DECLARE C1 CURSOR SCROLL FOR SELECT * FROM CURSORPRACTICE
   OPEN C1
   FETCH PRIOR FROM C1
   CLOSE C1
   DEALLOCATE C1 ;
                  -- PRIOR METHOD

   DECLARE C1 CURSOR SCROLL FOR SELECT * FROM CURSORPRACTICE
   OPEN C1
   FETCH ABSOLUTE 7 FROM C1
   CLOSE C1
   DEALLOCATE C1 ;
                 -- ABSALUTE N METHOD 

   DECLARE C1 CURSOR SCROLL FOR SELECT * FROM CURSORPRACTICE
   OPEN C1
   FETCH RELATIVE -2 FROM C1
   CLOSE C1
   DEALLOCATE C1 ;
                -- RELATIVE N 

  DECLARE C1 CURSOR SCROLL FOR SELECT * FROM CURSORPRACTICE
   OPEN C1
   FETCH FIRST FROM C1
   CLOSE C1
   DEALLOCATE C1 ;
               -- FIRST METCHOD

  DECLARE C1 CURSOR SCROLL FOR SELECT * FROM CURSORPRACTICE
   OPEN C1
   FETCH NEXT FROM C1
   CLOSE C1
   DEALLOCATE C1 ;
               -- NEXT METCHOD

   DECLARE C1 CURSOR SCROLL FOR SELECT * FROM CURSORPRACTICE
   OPEN C1
   FETCH LAST FROM C1
   FETCH PRIOR FROM C1
   FETCH ABSOLUTE 7 FROM C1
   FETCH RELATIVE -2 FROM C1
   FETCH FIRST FROM C1
   FETCH NEXT FROM C1
   CLOSE C1
   DEALLOCATE C1 ;
             -- WHAT DO WE GET IF WE COMBINE ALL

---------------------------------------------------------------------------------------------------
 -- CURSOR WITH VARIABLE --

  DECLARE C1 CURSOR SCROLL FOR SELECT EID,ENAME FROM CURSORPRACTICE
  DECLARE @EID INT,@ENAME VARCHAR(20) 
  OPEN C1
  FETCH LAST FROM C1 INTO @EID,@ENAME
  PRINT 'THE EMPLOYEE'+''+ @ENAME+'ID IS'+CAST(@EID AS VARCHAR)
   FETCH PRIOR FROM C1 INTO @EID ,@ENAME
  PRINT 'THE EMPLOYEE'+''+ @ENAME+'ID IS'+CAST(@EID AS VARCHAR)
   FETCH ABSOLUTE 7 FROM C1 INTO @EID ,@ENAME
  PRINT 'THE EMPLOYEE'+''+ @ENAME+'ID IS'+CAST(@EID AS VARCHAR)
   FETCH RELATIVE 2 FROM C1 INTO @EID ,@ENAME
  PRINT 'THE EMPLOYEE'+''+ @ENAME+'ID IS'+CAST(@EID AS VARCHAR)
   FETCH FIRST  FROM C1 INTO @EID ,@ENAME
  PRINT 'THE EMPLOYEE'+''+ @ENAME+'ID IS'+CAST(@EID AS VARCHAR)
   FETCH NEXT FROM C1 INTO @EID ,@ENAME
  PRINT 'THE EMPLOYEE'+''+ @ENAME+'ID IS'+CAST(@EID AS VARCHAR)
  CLOSE C1
  DEALLOCATE C1

  ---------------------------------------------------------------------------------------------
  --------------------------------------------------------------------------------------------

   -- USER DEFINED FUNCTIONS --

   -- DEF :
           -- Same like other functions in P	rogramming language , SQL also Have this to accept parameters
		   -- perform an action
		   -- Wn we cant reach our requirement by using pre defined functions , we'll go with this

		   -- WE HAVE MAINLY 2 TYPES OF FUNCTIONS IN SQL SERVER
		      -- 1. PRE DEFINED 
			  -- 2. USER DEFINED FUNCTIONS 

			  -- USER DEFINED FUNCTIONS AGAIN CLASSIFIED INTO 2 TYPES
			  -- a) SCALAR VALUED 
			  -- b) TABLE VALUED
			  
  -- A) THIS FUNCTION WILL ALWAYS RETURNS A SINGLE VALUE 

  CREATE TABLE SCLARVF
  (ID INT, NAME VARCHAR(40), GENDER VARCHAR(40), AGE INT)

  INSERT INTO SCLARVF VALUES 
  (1, 'SAM','F',24),
  (2, 'RAM','M',22),
  (3, 'EAM','M',23),
  (4, 'TAM','F',24),
  (5, 'HAM','M',24),
  (6, 'JAM','F',21),
  (7, 'DAM','M',20)

  SELECT * FROM SCLARVF;

  -- SCLAR VALUED FUNCTION --
  
  CREATE FUNCTION add_five(@num int)
  RETURNS INT
  AS 
  BEGIN 
  RETURN (@NUM+5)
  END

  SELECT dbo.add_five(10);
  SELECT dbo.add_five(100);

   -- TABLE valued functions --
   
   CREATE FUNCTION TABLEVF (@GENDER AS VARCHAR(20))
   RETURNS TABLE
   AS 
   RETURN
   (
   SELECT * FROM SCLARVF WHERE GENDER = @GENDER
   )


  SELECT * FROM dbO.TABLEVF('M')



  -- SYNTAX :
  /*
   
   CREATE FUNCTION <FNAME> (@<PARAMETER_NAME<DATA_TYPE>....) 
   RETURNS <return PARAMETER /VARIBLE < DATA_TYPE>
   AS
   BEGIN
   <FUNCTION BODY /STATEMENT >
   RETURN <return parameter /variable name>
   end */
   
 -- SYNTAX FOR CALLING FUNCTION :
  -- SELECT dbo>FUNCTIONNAME(VALUE)


  CREATE TABLE UDFUNCTION 
  (EID INT, ENAME VARCHAR(50),SALARY INT)

  INSERT INTO UDFUNCTION VALUES 
  (101, 'JONES',25000),
  (102, 'SCOTT',15000),
  (103,'ALLEN',30000)

  SELECT * FROM UDFUNCTION;

  CREATE FUNCTION F_GRSAL(@EID INT)
  RETURNS MONEY
  AS
  BEGIN
  DECLARE @BASIC MONEY,@HRA MONEY,@DA MONEY,@PF MONEY ,@GROSS MONEY
  SELECT @BASIC = SALARY FROM UDFUNCTION WHERE EID = @EID 
  SET @HRA = @BASIC*0.1
  SET @DA = @BASIC*0.2
  SET @PF =@BASIC*O.1
  SET @GROSS =@BASIC+@DA+@PF+@HRA
  RETURN @GROSS
  END


  SELECT dbo.F_GRSAL(102)

  --*****************************************************************************************

   -- Task is to find N'th Heighest Salary fromeach Department --
 
SELECT * FROM employees.departments;

SELECT * FROM employees.dept_emp;

SELECT * FROM employees.dept_manager;

SELECT * FROM employees.employees;
SELECT COUNT(emp_no) FROM  employees.employees;
                              -- 300024 Records 


SELECT * FROM employees.salaries;
SELECT COUNT(emp_no) FROM  employees.salaries;
                                    -- 2844047 Records 

 
  -- If we want to join two Tables 

  SELECT * FROM employees.employees AS E
  JOIN
  employees.salaries AS S
  ON 
  E.emp_no = S.emp_no ;
                     -- With just JOIN term we'll get all the Records
					 
 SELECT * FROM employees.employees AS E
  JOIN
  employees.salaries AS S
  ON 
  E.emp_no = S.emp_no ;

  SELECT E.name , E.emp_no , S.salary FROM employees.employees AS E
  JOIN
  employees.salaries AS S 
  ON 
  E.emp_no = S.emp_no ;
                   -- Here , we are just specifing the columns we required with the help of ALLIES prefix

 -- JOING 3 TABLES  --

 SELECT 
 * FROM employees.employees AS E
 JOIN employees.dept_emp     AS  DE   ON   DE.emp_no = E.emp_no
 JOIN employees.departments  AS  D    ON   D.dept_no = DE.dept_no
 JOIN employees.salaries     AS  S    ON   S.emp_no  = E.emp_no
                           
						   -- By this Query we'll get all the records 


	-- For Being more specific 
SELECT 
 E.emp_no,D.dept_name,DE.dept_no,S.salary
 FROM employees.employees AS E
 JOIN employees.dept_emp     AS  DE   ON   DE.emp_no = E.emp_no
 JOIN employees.departments  AS  D    ON   D.dept_no = DE.dept_no
 JOIN employees.salaries     AS  S    ON   S.emp_no  = E.emp_no
                           
						   -- Here we have selected only specified columns 
						   
SELECT 
 E.emp_no,D.dept_name,DE.dept_no,S.salary ,
 DENSE_RANK() OVER (PARTITION BY D.dept_name ORDER BY S.salary DESC) AS DRank
 FROM employees.employees AS E
 JOIN employees.dept_emp     AS  DE   ON   DE.emp_no = E.emp_no
 JOIN employees.departments  AS  D    ON   D.dept_no = DE.dept_no
 JOIN employees.salaries     AS  S    ON   S.emp_no  = E.emp_no

  -- We'll Check the COLUMNS in DEPARTMENT

  SELECT * FROM employees.departments;

           -- ** Have a doubt here why it is not generating same unique ID from only departments we have 
		   -- Actually , we supposed to get only 1 to 9 only noe ???
		   -- Let me check with dept_no as well now 

SELECT 
 E.emp_no,D.dept_name,DE.dept_no,S.salary ,
 DENSE_RANK() OVER (PARTITION BY DE.dept_no ORDER BY S.salary DESC) AS DRank
 FROM employees.employees AS E
 JOIN employees.dept_emp     AS  DE   ON   DE.emp_no = E.emp_no
 JOIN employees.departments  AS  D    ON   D.dept_no = DE.dept_no
 JOIN employees.salaries     AS  S    ON   S.emp_no  = E.emp_no

                               -- Probably it is shuffeling , so that we cannot see them in order

	-- We'll check CTE 
	-- DEF : 
	         -- A common Table Expression , is a temporary named result set that you can reference within 
			 -- SELECT,INSERT,UPDATE 
			 
 WITH SalaryByDept AS (
 SELECT 
 E.emp_no,D.dept_name,DE.dept_no,S.salary ,
 DENSE_RANK() OVER (PARTITION BY D.dept_name ORDER BY S.salary DESC) AS DRank
 FROM employees.employees AS E
 JOIN employees.dept_emp     AS  DE   ON   DE.emp_no = E.emp_no
 JOIN employees.departments  AS  D    ON   D.dept_no = DE.dept_no
 JOIN employees.salaries     AS  S    ON   S.emp_no  = E.emp_no )
 SELECT * FROM SalaryByDept
 WHERE DRank = 1

		
		-- This we will partition by DE.dept_no -- AND ll check the result
		-- We , Had got 144434 for Department 

WITH SalaryByDept2 AS (
 SELECT 
 E.emp_no,D.dept_name,DE.dept_no,S.salary ,
 DENSE_RANK() OVER (PARTITION BY DE.dept_no ORDER BY S.salary DESC) AS DRank
 FROM employees.employees AS E
 JOIN employees.dept_emp     AS  DE   ON   DE.emp_no = E.emp_no
 JOIN employees.departments  AS  D    ON   D.dept_no = DE.dept_no
 JOIN employees.salaries     AS  S    ON   S.emp_no  = E.emp_no )
 SELECT * FROM SalaryByDept2
 WHERE DRank = 1
                  -- Correct , its giving the same result 

 WITH SalaryByDept2 AS (
 SELECT 
 E.emp_no,D.dept_name,DE.dept_no,S.salary ,
 DENSE_RANK() OVER (PARTITION BY DE.dept_no ORDER BY S.salary DESC) AS DRank
 FROM employees.employees AS E
 JOIN employees.dept_emp     AS  DE   ON   DE.emp_no = E.emp_no
 JOIN employees.departments  AS  D    ON   D.dept_no = DE.dept_no
 JOIN employees.salaries     AS  S    ON   S.emp_no  = E.emp_no )
 SELECT *  FROM SalaryByDept2
 WHERE DRank = 2


 -- Now we'll check without CTE n See weather it will work or not

  
 SELECT 
 D.dept_name,S.salary ,
 ROW_NUMBER() OVER (PARTITION BY D.dept_name ORDER BY S.salary DESC) AS DRank
 FROM (employees.employees AS E
 JOIN employees.dept_emp     AS  DE   ON   DE.emp_no = E.emp_no
 JOIN employees.departments  AS  D    ON   D.dept_no = DE.dept_no
 JOIN employees.salaries     AS  S    ON   S.emp_no  = E.emp_no )
 WHERE DRank = 1
                 --This Where clause  is'nt working here know why ? 
				 -- without CTE the query is running but ,i cannot able to fetch exact value by using where



                          --                                                                --
                          --  WE WILL LEARN MORE ABOUT RANK,ROW_NUMBER,DENCE_RANK,PARTITION --

 -- Nth Heighest Salary --

  WITH NthSalaryByDept AS (
 SELECT 
 E.emp_no,D.dept_name,DE.dept_no,S.salary ,
 DENSE_RANK() OVER (PARTITION BY D.dept_name ORDER BY S.salary DESC) AS DRank
 FROM employees.employees AS E
 JOIN employees.dept_emp     AS  DE   ON   DE.emp_no = E.emp_no
 JOIN employees.departments  AS  D    ON   D.dept_no = DE.dept_no
 JOIN employees.salaries     AS  S    ON   S.emp_no  = E.emp_no )
 SELECT * FROM NthSalaryByDept
 WHERE DRank = 3

  -- NOTE :
           -- 1. We cannot use Rank function der ,Because when there is tie in 1st height salary
		   --    the rank function will leave the gap at 2Nd position and writes 3 
		   --     <LIKE>
		   --     RANK       : 1 1 3 4 4 6
		   --     DENSE_RANK : 1 1 2 2 3
		   --     Row_number : 1 2 3 1 2 3
		   --     By seeing this , we should get to know why we used DENSE_RANK


  -- IF we want department alone and Nth Height Salary then 

  WITH NthSalaryByDeptwithDept AS (
 SELECT 
 E.emp_no,D.dept_name,DE.dept_no,S.salary ,
 DENSE_RANK() OVER (PARTITION BY D.dept_name ORDER BY S.salary DESC) AS DRank
 FROM employees.employees AS E
 JOIN employees.dept_emp     AS  DE   ON   DE.emp_no = E.emp_no
 JOIN employees.departments  AS  D    ON   D.dept_no = DE.dept_no
 JOIN employees.salaries     AS  S    ON   S.emp_no  = E.emp_no )
 SELECT * FROM NthSalaryByDeptwithDept
 WHERE DRank = 10 AND dept_name ='Marketing'

   -- we can specify the term we want in WHERE condition 

 
  WITH NthSalaryByDeptwithDept AS (
 SELECT 
 E.emp_no,D.dept_name,DE.dept_no,S.salary ,
 ROW_NUMBER() OVER (PARTITION BY D.dept_name ORDER BY S.salary DESC) AS DRank
 FROM employees.employees AS E
 JOIN employees.dept_emp     AS  DE   ON   DE.emp_no = E.emp_no
 JOIN employees.departments  AS  D    ON   D.dept_no = DE.dept_no
 JOIN employees.salaries     AS  S    ON   S.emp_no  = E.emp_no )
 SELECT * FROM NthSalaryByDeptwithDept
 WHERE DRank = 10
                  -- FOR Marketing when we use ROW_NUMBER = 143086
                  -- WE can either use Row_number or Dense_rank here

 WITH NthSalaryByDeptwithDept AS (
 SELECT 
 E.emp_no,D.dept_name,DE.dept_no,S.salary ,
 DENSE_NUMBER() OVER (ORDER BY S.salary DESC) AS DRank
 FROM employees.employees AS E
 JOIN employees.dept_emp     AS  DE   ON   DE.emp_no = E.emp_no
 JOIN employees.departments  AS  D    ON   D.dept_no = DE.dept_no
 JOIN employees.salaries     AS  S    ON   S.emp_no  = E.emp_no )
 SELECT * FROM NthSalaryByDeptwithDept
 WHERE DRank = 10
              -- trying it with not specifying with partition
			  
SELECT 
 E.emp_no,D.dept_name,DE.dept_no,S.salary ,
 ROW_NUMBER() OVER (ORDER BY S.salary DESC) AS DRank
 FROM employees.employees AS E
 JOIN employees.dept_emp     AS  DE   ON   DE.emp_no = E.emp_no
 JOIN employees.departments  AS  D    ON   D.dept_no = DE.dept_no
 JOIN employees.salaries     AS  S    ON   S.emp_no  = E.emp_no 

        -- If we wont mention PARTITION 
		-- We will get the value tht whuch is on that particular position 

--	***************************************************************************************************************8	--


WITH SalaryByDept
 AS(
	 SELECT 
		  E.emp_no
		, D.dept_name
		, DE.dept_no
		, S.salary 
		, DENSE_RANK() OVER (PARTITION BY D.dept_name
		                     ORDER BY S.salary DESC
							 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING ) AS DRank
	 FROM employees.employees    AS E
	 JOIN employees.dept_emp     AS  DE   ON   DE.emp_no = E.emp_no
	 JOIN employees.departments  AS  D    ON   D.dept_no = DE.dept_no
	 JOIN employees.salaries     AS  S    ON   S.emp_no  = E.emp_no 
	 )
	SELECT * FROM SalaryByDept
    WHERE DRank = 10 AND dept_name = 'sales' 

	--------------------------------------------------------------------

	                    -- Rows Between --
						-------------------

                   -- If we have N number of rows in our table 
				   -- Here we'll specify which rows will participate in operation 
				   -- we'll specify the range between the clause and those will participate\

				   -- There are mainly 3 types of this 
				   -- 1) UNBOUNDERD PRECEDING < all rows before current row are considered >
				   -- 2) UNBOUNDERD FOLLOWING < all rows After current row are considered >
				   -- 3) CURRENT ROW          < Range starts or ends at CURRENT ROW >

	CREATE TABLE RowsBetween (ID int );

	INSERT INTO RowsBetween VALUES 
	(1),
	(2),
	(3),
	(4),
	(5)

	SELECT * FROM RowsBetween;

	-- CASE 1 : TO READ PREVIOUS ROW VALUE 

	SELECT 
	      ID , SUM(ID) OVER ( ORDER BY ID
		                      ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING ) AS ID2
    FROM RowsBetween

	-- CASE 2 : TO READ ALL THE PREVIOUS ROWS 

	SELECT 
	      ID , SUM(ID) OVER ( ORDER BY ID
		                      ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING ) AS ID2
    FROM RowsBetween

	-- CASE 3 : TO READ PREVIOUS 2 ROWS ONLY

	SELECT 
	      ID , SUM(ID) OVER ( ORDER BY ID
		                      ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING ) AS ID2
    FROM RowsBetween

	-- CASE 4 : TO READ THE BEXT ROW ONLY 

	SELECT 
	      ID , SUM(ID) OVER ( ORDER BY ID
		                      ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING ) AS ID2
    FROM RowsBetween

	-- CASE 5 : TO READ ALL THE FOLLOWING ROWS 

	SELECT 
	      ID , SUM(ID) OVER ( ORDER BY ID
		                      ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING ) AS ID2
    FROM RowsBetween

	-- CASE 6 : TO READ ONLY NEXT 2 ROWS 

	SELECT 
	      ID , SUM(ID) OVER ( ORDER BY ID
		                      ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING ) AS ID2
    FROM RowsBetween

	-- CASE 7 : IF YOU WANT TO INCLUDE CURRENT ROW 

	SELECT 
	      ID , SUM(ID) OVER ( ORDER BY ID
		                      ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING ) AS ID2
    FROM RowsBetween

	--**************************************************************************************************************


	
-- 1) FIND THE 2rd Height salary from employees table

     METHOD 1 : -
	 ------------

 SELECT MAX(SALARY) FROM employees.salaries where SALARY < ( SELECT MAX(SALARY) FROM employees.salaries) 

 SELECT MAX(SALARY) FROM employees.salaries where SALARY < ( SELECT MAX(SALARY) FROM employees.salaries) 


   METHOD 2 :
   ----------

   SELECT TOP 1 salary FROM (
   SELECT TOP 2 SALARY FROM employees.salaries ORDER BY salary DESC )
   AS EMP ORDER BY salary ASC


   SELECT TOP 1 salary FROM (
   SELECT DISTINCT TOP 2 SALARY FROM employees.salaries ORDER BY salary DESC )
   AS EMP ORDER BY salary ASC


   --**********************************************************************************

   -- 2) FINF Nth Height salary from employees table 

   METHOD 1 :
   ----------
   SELECT TOP 1 salary FROM (
   SELECT DISTINCT TOP 3 -- N --
   SALARY FROM employees.salaries ORDER BY salary DESC )
   AS EMP ORDER BY salary ASC

   METHOD 2 :
   ----------

   WITH RESULT AS
   (
   SELECT SALARY , DENSE_RANK() OVER ( ORDER BY SALARY DESC ) AS DenseRank
   FROM employees.salaries
   )
   SELECT Salary 
   FROM RESULT
   Where RESULT.DenseRank = 4 -- N -- ;

   METHOD 3 :
   ----------
    


	--******************************************************************

	-- 3) FIND ALL THE DUPLICATE ROWS IN TABLE 

	SELECT name FROM employees.employees 
	GROUP BY name 
	HAVING COUNT(name) > 1 ;

	--*****************************************************************

	-- 4) FIND EVEN OR ODD NUMBERS 

	SELECT * FROM employees.dept_emp WHERE emp_no%2 = 0; -- FOR EVEN 

	SELECT * FROM employees.dept_emp WHERE emp_no%2 = 1; -- for ODD

	--******************************************************************

CREATE TABLE RowsBetween1 (ID int );

	INSERT INTO RowsBetween1 VALUES 
	(1),
	(2),
	(3),
	(4),
	(5)

	SELECT * FROM RowsBetween1;

	-- CASE 1 : TO READ PREVIOUS ROW VALUE 

	SELECT 
	      ID , SUM(ID) OVER ( ORDER BY ID
		                      ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING ) AS ID2
    FROM RowsBetween1

	-- CASE 2 : TO READ ALL THE PREVIOUS ROWS 

	SELECT 
	      ID , SUM(ID) OVER ( ORDER BY ID
		                      ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING ) AS ID2
    FROM RowsBetween1

	-- CASE 3 : TO READ PREVIOUS 2 ROWS ONLY

	SELECT 
	      ID , SUM(ID) OVER ( ORDER BY ID
		                      ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING ) AS ID2
    FROM RowsBetween1

	-- CASE 4 : TO READ THE BEXT ROW ONLY 

	SELECT 
	      ID , SUM(ID) OVER ( ORDER BY ID
		                      ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING ) AS ID2
    FROM RowsBetween1

	-- CASE 5 : TO READ ALL THE FOLLOWING ROWS 

	SELECT 
	      ID , SUM(ID) OVER ( ORDER BY ID
		                      ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING ) AS ID2
    FROM RowsBetween1

	-- CASE 6 : TO READ ONLY NEXT 2 ROWS 

	SELECT 
	      ID , SUM(ID) OVER ( ORDER BY ID
		                      ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING ) AS ID2
    FROM RowsBetween1

	-- CASE 7 : IF YOU WANT TO INCLUDE CURRENT ROW 

	SELECT 
	      ID , SUM(ID) OVER ( ORDER BY ID
		                      ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING ) AS ID2
    FROM RowsBetween1

	----------------------------------------------------------------------------------
	Create table Practicealter1
(empid int , empname char(10), salary int , age int);

--This command is used to change the DATATYPE and SIZE of the DATATYPE 
ALTER TABLE Practicealter ALTER COLUMN empname varchar(50);

--This command is use to ADD a new column to a table
ALTER TABLE Practicealter1 ADD EAddress varchar(30);

--This command is use to change the column name and table name 
    --1.To change the column name 
SP_RENAME 'Practicealter1.empname','ename';

   --2.To change the table name
SP_RENAME 'Practicealter1','practicealtercommand';

--This command is used to drop the column
ALTER TABLE Practicealtercommand DROP COLUMN EAddress;

------------------------------------------------------------------
CREATE TABLE STUDENTS1 
 (StId int , SName varchar(30), Age int , Gender varchar(10));

 --We have two methods to insert values into the table 
 --METHOD 1 :-
 INSERT INTO STUDENTS1 VALUES
 (1,'Bell',10,'M')  
                  --(like this we can enter values with proper order)

--METHOD 2:-
INSERT INTO STUDENTS1
(StId,SName,Gender) VALUES (2,'Sam','M');
                 --(With the help of this menthod we can insert only the values which we would like to insert)


SELECT * from STUDENTS1;


-- 2) UPDATE : THIS commmand is used to update the records in the TABLE

UPDATE STUDENTS1 SET Age=11 where StId=1;

SELECT * from STUDENTS1;
   --  Here we are using WHERE condition to specifically change the prefered row

   -- . UPDATE STUDENTS SET Age=11 where Age=NULL ;  (This Doesnot work ) insted we have to use an operation
   
UPDATE STUDENTS SET Age=11 where Age is NULL;
SELECT * from STUDENTS1;

  -- If we want to update entire column at once , WE need to specify the comdition

UPDATE STUDENTS SET Age = 13;
SELECT * from STUDENTS1;

INSERT INTO STUDENTS VALUES      --	we'll insert some more records in the table
 (3,'Ben',10,'M'),
 (4,'Stella',14,'F')
 SELECT * from STUDENTS1;

 -- 3) DELETE : THIS command is used to delete all rows at a time or can specifically delete selected row with condition

DELETE FROM STUDENTS WHERE SName = 'Sam';
SELECT * from STUDENTS1;


INSERT INTO STUDENTS1                            --	we'll insert some more records in the table
(StId,SName,Gender) VALUES (5,'Elli','M');
SELECT * from STUDENTS1;

DELETE FROM STUDENTS WHERE Age IS NULL;
SELECT * from STUDENTS1;

DELETE FROM STUDENTS;   -- > This command will help in deleting all records from Table
SELECT * from STUDENTS1;

---------------------------------------------------------------------------------------

/* WITH SalaryByDept
 AS(
	 SELECT 
		  E.emp_no
		, D.dept_name
		, DE.dept_no
		, S.salary 
		, DENSE_RANK() OVER (PARTITION BY D.dept_name
		                     ORDER BY S.salary DESC
							 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING ) AS DRank
	 FROM employees.employees    AS E
	 JOIN employees.dept_emp     AS  DE   ON   DE.emp_no = E.emp_no
	 JOIN employees.departments  AS  D    ON   D.dept_no = DE.dept_no
	 JOIN employees.salaries     AS  S    ON   S.emp_no  = E.emp_no 
	 )
	SELECT * FROM SalaryByDept
    WHERE DRank = 10 AND dept_name = 'sales' */

	------------------------------------------------------------------

	CREATE TABLE organization 
(emp_id int , name varchar(20),manager_id int )

INSERT INTO organization VALUES 
(4, 'SAURAV' ,NULL),
(7, 'Devesh ' ,4),
(10, 'sudhir' ,7),
(1, 'A' ,10),
(2, 'D' ,10),
(3, 'E' ,10),
(5, 'M' ,10),
(6, 'F' ,10),
(8, 'H' ,10),
(9, 'I' ,10)

SELECT * FROM organization

Declare @ID INT 
SET @ID = 1 ;

WITH EmployeeCTE AS
 (
    SELECT emp_id,name , manager_id
    FROM organization
    WHERE emp_id = @ID

    UNION ALL 
    SELECT organization.emp_id,organization.name,organization.manager_id
    FROM organization
    JOIN EmployeeCTE 
    ON organization.emp_id = EmployeeCTE.manager_id
	
 )
 SELECT E1.name,E2.name AS ManagerName
 FROM EmployeeCTE E1 
 JOIN 
 EmployeeCTE E2
 ON E1.manager_id = E2.emp_id