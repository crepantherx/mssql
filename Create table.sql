--Creating table with all possible constraints---

CREATE TABLE dbo.Sample_Table_1
(
    A INT NOT NULL PRIMARY KEY,
    B VARCHAR(10) NULL DEFAULT 'ABC',
	C INT CHECK(C>10),
	D NVARCHAR(20) UNIQUE
);

--creating table with all possible constraints with their name--
CREATE TABLE dbo.Sample_Table_2
(
    E INT NOT NULL,
    F VARCHAR(10) CONSTRAINT DF_F DEFAULT 'ABC', 
	G INT,
	H NVARCHAR(20),
	I INT,
	CONSTRAINT PK_E PRIMARY KEY(E),
	CONSTRAINT check_G CHECK(G>10),
	CONSTRAINT Unique_H UNIQUE(H),
	CONSTRAINT FK_I FOREIGN KEY(I) REFERENCES Sample_Table_1(A)


);

--Insert records for all column except B to see the effect of default constraint--
INSERT INTO Sample_Table_1(A,C,D)
VALUES
(1,11,'JOHN')

SELECT * FROM Sample_Table_1

INSERT INTO Sample_Table_2(E,G,H,I)
VALUES
(1,11,'JOHN',1)

SELECT * FROM Sample_Table_2
