/**
Quering data -> select
sorting data -> order by
limiting rows -> offset,fetch,select top
filtering data -> distict ,where,and,or,in,between,like,alias
joining tables -> joins,inner,outer,left,right,full,self
grouping data-> group by, having,grouping set,cube,rollup
subquery -> corealated subquery,exists,any,all
set operaters -> union,intersect,except
cte--> cte ,recursive cte
pivot -> rows to columns

modifying data -> insert ,insert into multiple,insert into select,update,update join,delete,merge

ddl-> create database,drop db,create schm,alter schm,drop schma,create table,identity column,sequence,alter table
add column,alter table alter column,alter table drop column,computed columns,drop table,truncate table,select into
,rename a table,temprorary tables,synonyms

data types-> bit ,int,decimal,char,varchar,nvarchar,datetime2,date,time,datetime,offset,guid
constraints ->p.k,f.k,not null,unique,check
expressions -> case,coalesce,nullif
find duplicates,delete duplicates

views
indexes
store procedure
user defined functions
triggers

--sql server functions----
agrregate functions
date functions
string functions
system functions
window functions
*/



SELECT 
TABLE_CATALOG,
TABLE_SCHEMA,
TABLE_NAME, 
COLUMN_NAME, 
DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'brands' 

SELECT TABLE_SCHEMA,TABLE_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
where TABLE_CATALOG = 'BikeStores' 

SELECT * FROM production.products

-----remove duplicates-----
SELECT category_id ,count(*) AS num
FROM production.products
GROUP BY category_id
HAVING COUNT(*)>1

-----select----
SELECT city,COUNT(*) AS number 
FROM sales.customers
WHERE state='CA'
GROUP BY city
HAVING COUNT(*)>5
ORDER BY city

----SORTING DATA----
---order by---
SELECT
    city,
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    city,
    first_name;


SELECT
    city,
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    city DESC,
    first_name ASC;


SELECT
    city,
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    state;

SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    LEN(first_name) DESC;


-----LIMITING ROWS------
-----offset fetch------
SELECT
product_name,list_price 
FROM
production.products
ORDER BY
product_name,list_price DESC
OFFSET 5 ROWS
FETCH NEXT 10 ROWS ONLY

------SELECT TOP---
SELECT TOP 5 
product_name,list_price
FROM 
production.products
ORDER BY 
product_name,list_price

SELECT TOP 1 PERCENT 
product_name,list_price
FROM 
production.products
ORDER BY 
product_name,list_price

SELECT TOP 5 WITH TIES 
product_name,list_price
FROM 
production.products
ORDER BY 
list_price DESC


----FILTERIND DATA-------
---DISTINCT----
SELECT DISTINCT
    city
FROM
    sales.customers
ORDER BY
    city


SELECT DISTINCT
    city,
    state
FROM
    sales.customers

	------GROUP BY VS DISTINCT
	SELECT 
	city, 
	state, 
	zip_code
FROM 
	sales.customers
GROUP BY 
	city, state, zip_code
ORDER BY
	city, state, zip_code


SELECT 
	DISTINCT 
       city, 
       state, 
       zip_code
FROM 
	sales.customers;

---WHERE ,AND,OR-----
SELECT
    *
FROM
    production.products
WHERE
    category_id = 1
AND list_price > 400
AND brand_id = 1
ORDER BY
    list_price DESC;

SELECT
    *
FROM
    production.products
WHERE
    (brand_id = 1 OR brand_id = 2)
AND list_price > 1000
ORDER BY
    brand_id;


-----IN----
SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price IN (89.99, 109.99, 159.99)
ORDER BY
    list_price;

SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price NOT IN (89.99, 109.99, 159.99)
ORDER BY
    list_price;


SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    product_id IN (
        SELECT
            product_id
        FROM
            production.stocks
        WHERE
            store_id = 1 AND quantity >= 30
    )
ORDER BY
    product_name;


----BETWEEN----

SELECT
    product_id,
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price BETWEEN 149.99 AND 199.99
ORDER BY
    list_price;


SELECT
    product_id,
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price NOT BETWEEN 149.99 AND 199.99
ORDER BY
    list_price;

----LIKE----
SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE 'z%'
ORDER BY
    first_name;

SELECT 
   feedback_id, 
   comment
FROM 
   sales.feedbacks
WHERE 
   comment LIKE '%30!%%' ESCAPE '!';

-----JOINING TABLES----
CREATE SCHEMA hr;
GO
CREATE TABLE hr.candidates(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

CREATE TABLE hr.employees(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

INSERT INTO 
    hr.candidates(fullname)
VALUES
    ('John Doe'),
    ('Lily Bush'),
    ('Peter Drucker'),
    ('Jane Doe');


INSERT INTO 
    hr.employees(fullname)
VALUES
    ('John Doe'),
    ('Jane Doe'),
    ('Michael Scott'),
    ('Jack Sparrow');

SELECT * FROM hr.candidates
SELECT * FROM hr.employees

SELECT e.fullname employee_name,
       e.id employee_id,
	   c.id candidate_id,
	   c.fullname candidate_name
FROM hr.candidates c 
INNER JOIN hr.employees e
ON e.fullname = c.fullname

---left join---
SELECT  
	c.id candidate_id,
	c.fullname candidate_name,
	e.id employee_id,
	e.fullname employee_name
FROM 
	hr.candidates c
	LEFT JOIN hr.employees e 
		ON e.fullname = c.fullname;

SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    LEFT JOIN hr.employees e 
        ON e.fullname = c.fullname
WHERE 
    e.id IS NULL;


----right join-----
SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    RIGHT JOIN hr.employees e 
        ON e.fullname = c.fullname;

SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    RIGHT JOIN hr.employees e 
        ON e.fullname = c.fullname
WHERE
    c.id IS NULL;

---full join----
SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    FULL JOIN hr.employees e 
        ON e.fullname = c.fullname;

SELECT  
    c.id candidate_id,
    c.fullname candidate_name,
    e.id employee_id,
    e.fullname employee_name
FROM 
    hr.candidates c
    FULL JOIN hr.employees e 
        ON e.fullname = c.fullname
WHERE
    c.id IS NULL OR
    e.id IS NULL;


	----------------cross join---------------
SELECT
    s.store_id,
    p.product_id,
    ISNULL(sales, 0) sales
FROM
    sales.stores s
CROSS JOIN production.products p
LEFT JOIN (
    SELECT
        s.store_id,
        p.product_id,
        SUM (quantity * i.list_price) sales
    FROM
        sales.orders o
    INNER JOIN sales.order_items i ON i.order_id = o.order_id
    INNER JOIN sales.stores s ON s.store_id = o.store_id
    INNER JOIN production.products p ON p.product_id = i.product_id
    GROUP BY
        s.store_id,
        p.product_id
) c ON c.store_id = s.store_id
AND c.product_id = p.product_id
WHERE
    sales IS NULL
ORDER BY
    product_id,
    store_id;



---window function---


SELECT list_price,
DENSE_RANK() OVER (ORDER BY list_price DESC)as rnk,
FIRST_VALUE(product_name)
OVER (ORDER BY product_id) frst ,
LAST_VALUE(product_name)
OVER (ORDER BY product_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) LASTVAL
FROM production.products
order by list_price DESC

---system functions----
SELECT  1 + '1' AS RES
SELECT product_name + '_'+ cast(product_id as varchar(20)) FROM production.products

SELECT 
    MONTH(order_date) month, 
    CAST(SUM(quantity * list_price * (1 - discount)) AS INT) amount
FROM sales.orders o
    INNER JOIN sales.order_items i ON o.order_id = i.order_id
WHERE 
    YEAR(order_date) = 2017
GROUP BY 
    MONTH(order_date)
ORDER BY 
    month;

----convert---
SELECT 
    CONVERT(DATETIME, '2019-03-14') result;
SELECT 
    CONVERT(VARCHAR, GETDATE(),13) result;

---choose-----
SELECT 
    CHOOSE(2, 'First', 'Second', 'Third') Result;

	SELECT
    order_id, 
    order_date, 
    order_status,
    CHOOSE(order_status,
        'Pending', 
        'Processing', 
        'Rejected', 
        'Completed') AS order_status
FROM 
    sales.orders
ORDER BY 
    order_date DESC;

	SELECT 
    order_id,
    order_date,
    customer_id,
    CHOOSE(
        MONTH(order_date), 
        'Winter', 
        'Winter', 
        'Spring', 
        'Spring', 
        'Spring', 
        'Summer', 
        'Summer', 
        'Summer', 
        'Autumn', 
        'Autumn', 
        'Autumn', 
        'Winter') month
FROM 
    sales.orders
ORDER BY 
    customer_id;

	-----try cast-
	SELECT 
    CASE
        WHEN TRY_CAST('test' AS INT) IS NULL
        THEN 'Cast failed'
        ELSE 'Cast succeeded'
    END AS Result;

-----aggregate functions
SELECT
    AVG(list_price) avg_product_price
FROM
    production.products;


	SELECT
    COUNT(*) product_count
FROM
    production.products
WHERE
    list_price > 500;

SELECT COUNT(*) OVER (ORDER BY list_price) product_count
FROM production.products
WHERE list_price > 500

SELECT 
    product_id, 
    SUM(quantity) stock_count
FROM 
    production.stocks
GROUP BY
    product_id
ORDER BY 
    stock_count DESC;

SELECT
    CAST(ROUND(STDEV(list_price),2) as DEC(10,2)) stdev_list_price
FROM
    production.products;

-----STRING FUNCTION-----

SELECT 
    ASCII('AB') A, 
    ASCII('Z') Z;

SELECT CHARINDEX('DOLLY','MY NAME IS DOLLY SINGH',1) RES




------view--------
---it is a named query ,which we can save for later 
CREATE VIEW VW_ON_PRO_BRAND
AS
SELECT 
b.brand_id,p.product_name,b.brand_name
FROM production.brands b
INNER JOIN production.products p
ON p.brand_id = b.brand_id

SELECT * FROM VW_ON_PRO_BRAND

ALTER VIEW VW_ON_PRO_BRAND
WITH SCHEMABINDING 
AS
SELECT 
b.brand_id,p.product_name,b.brand_name,product_id
FROM production.brands b
INNER JOIN production.products p
ON p.brand_id = b.brand_id

CREATE UNIQUE CLUSTERED INDEX IX_ON_VW
ON VW_ON_PRO_BRAND(product_id)

EXEC sp_rename
@objname = 'VW_ON_PRO_BRAND',
@newname = 'vw_for_details'

EXEC sp_helptext 'vw_for_details'

DROP VIEW vw_for_details

-------indexs-------
--we use indexes on our table to speed up the query,two types of indexes clustered and non-clustered
CREATE TABLE production.parts(
    part_id   INT NOT NULL, 
    part_name VARCHAR(100)
);
INSERT INTO 
    production.parts(part_id, part_name)
VALUES
    (1,'Frame'),
    (2,'Head Tube'),
    (3,'Handlebar Grip'),
    (4,'Shock Absorber'),
    (5,'Fork');

SELECT 
    part_id, 
    part_name
FROM 
    production.parts
WHERE 
    part_id = 5;

CREATE CLUSTERED INDEX IX_ON_ID 
ON production.parts(part_id)

CREATE INDEX IX_ON_ID_2 
ON production.parts(part_name)

EXEC sp_rename 
        @objname = N'IX_ON_ID_2',
        @newname = N'IX_ON_ID_NONCLUS' ,
        @objtype = N'INDEX';

DROP INDEX IX_ON_ID_2
ON production.parts


------strore procedure---- we save precompiled statements
CREATE PROCEDURE usp_proc 
AS
BEGIN
  SELECT product_id,product_name
  FROM production.products
END

EXEC usp_proc

sp_rename 'usp_proc' ,'usp_proc_products'

DROP PROCEDURE usp_proc_products

CREATE PROCEDURE usp_proc(@min_price int ) 
AS
BEGIN
  SELECT product_id,product_name
  FROM production.products
  WHERE list_price > @min_price
END

EXEC usp_proc '500' 


CREATE PROCEDURE usp_proc1(
@min_price int,
@count int output
) 
AS
BEGIN
  SELECT product_id,product_name
  FROM production.products
  WHERE list_price > @min_price
  SELECT @count = @@ROWCOUNT;
END

DECLARE @OUTPUTCOUNT int
EXEC usp_proc1 @min_price =500,@count = @OUTPUTCOUNT OUTPUT
SELECT @OUTPUTCOUNT AS RESULT


----cursor-------------
DECLARE @product_name varchar(MAX),
@list_price int

DECLARE my_cursors CURSOR 
FOR 
SELECT product_name,list_price
FROM production.products

OPEN my_cursors
FETCH NEXT FROM my_cursors INTO
@product_name,@list_price

WHILE @@FETCH_STATUS =0
BEGIN
PRINT @product_name + CAST(@list_price AS varchar);
FETCH NEXT FROM my_cursors INTO
@product_name,@list_price
END
CLOSE my_cursors


'SELECT * FROM production.products';

EXEC sp_executesql N'SELECT * FROM production.products';

DECLARE 
    @table NVARCHAR(128),
    @sql NVARCHAR(MAX);

SET @table = N'production.products';

SET @sql = N'SELECT * FROM ' + @table;

EXEC sp_executesql @sql;

CREATE FUNCTION fun(@RES int)
RETURNS INT AS
BEGIN
 SELECT @RES * list_price from production.products 
 RETURN 
  
END

exec fun '3'

with cte 
as 
(
select *, DENSE_RANK() OVER (PARTITION BY from_date ORDER BY salary DESC) RNK
FROM employees.salaries
)
SELECT salary,emp_no FROM cte where RNK = 2 

SELECT TOP 1* FROM (SELECT TOP 3 * FROM employees.salaries ORDER BY salary DESC )RESULT ORDER BY salary ASC

CREATE TRIGGER TRR 
ON employees.salaries
FOR INSERT
AS 
BEGIN
SELECT * FROM employees.salaries
END

