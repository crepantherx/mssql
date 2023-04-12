
CREATE TABLE Student
(Name VARCHAR(10))

CREATE TABLE Marks
(roll_number int)

--add a column in an existing table using ALTER clause

ALTER TABLE Student 
ADD marks_obtained int;

ALTER TABLE Student 
ADD roll_num int;

--to modify existing column using ALTER command
ALTER TABLE Student
ALTER COLUMN marks_obtained DECIMAL (5, 2);

ALTER TABLE Student 
ALTER COLUMN roll_number int NOT NULL;


--to drop an existing column from the table using ALTER command
ALTER TABLE Student 
DROP column marks_obtained;

--to add primary key constraints using ALTER command
ALTER TABLE Student
ADD Constraint pk_roll_num  PRIMARY KEY(roll_number)

--to drop Primary Key Constraint using ALTER command
ALTER TABLE Student 
DROP CONSTRAINT pk_roll_num

--to add foreign key Constraints using alter command
ALTER TABLE Marks
ADD Constraint fk_roll_num FOREIGN KEY (roll_number) 
REFERENCES Student (roll_number)

--to drop foreign key Constraint using Alter command:
ALTER TABLE Marks 
DROP CONSTRAINT fk_roll_num;

--to add unique key Constraints using ALTER command
ALTER TABLE Student 
ADD CONSTRAINT unique_roll_no UNIQUE (roll_Number);

--to drop unique Key Constraint using ALTER command
ALTER TABLE Student 
DROP CONSTRAINT unique_roll_no

--to add check Constraint using ALTER command
ALTER TABLE table_name
ADD CONSTRAINT MyUniqueConstraint CHECK (CONDITION);

--to add default constraint using alter command
ALTER TABLE Student
ADD DEFAULT 'SUDHIR' FOR Name

SELECT * FROM Student









 