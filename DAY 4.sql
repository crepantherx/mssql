INSERT INTO Details values (11,'dolly',23,'sql analyst',2,'abc','hgf')

SELECT * FROM Details

CREATE TABLE t
( id int not null,
 name nvarchar(20))

 INSERT INTO t values 
 (1,'abs'),
 (2,'klm'),
 (3,'vgh'),
 (3,'vgh')

 select * from t

 with cte
 AS 
 (

  SELECT *,ROW_NUMBER() OVER( ORDER BY id) ro
  FROM t
 )
 DELETE FROM cte WHERE ro>1

 ------------------------------------------
 -------ROW_NUMBER--- FUNCTION-------
 /* 1. Return the sequential number of row starting at 1
    2. order by clause is required, partition by clause is optional
	3. when the data is partitioned,row_number is reset to 1 when the partion changes */
	
create table Emp  
(  
   ID int,  
   Name nvarchar(50),  
   Gender char(10),  
   Salary int  
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

SELECT * FROM Emp

SELECT * ,ROW_NUMBER() OVER(ORDER BY ID) as rownum
FROM Emp 

--we can remove dublicates from table by using partition by in row_number function 
with cte
 AS 
 (
    SELECT *,ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID) rownum
    FROM Emp
 )
   DELETE FROM cte WHERE rownum>1

SELECT * FROM Emp

-------------RANK AND DENSE_RANK--------------
/*1. Return a rank starting at 1 based on the ordering of rows imposed by order by clause
  2. Order by clause is required
  3. partition by clause is optional
  4. when the data is partitioned ,rank is reset to 1 when partition changes 

  --difference between rank and dense_rank-----
  rank function skips ranking when there is tie where is dense_rank will not */

  SELECT *,RANK() OVER(ORDER BY ID) AS RNK FROM Emp
  SELECT *,DENSE_RANK() OVER(ORDER BY ID) AS DENS_RNK FROM Emp

  ---use of rank and dense_rank to find nth salary------
  
  With cte_on_emp_for_ranking_with_rank
  AS
  ( SELECT *,RANK() OVER(ORDER BY Salary DESC) sal_rank
  FROM Emp
  )
  SELECT * FROM cte_on_emp_for_ranking_with_rank WHERE sal_rank = 3 

  ----dense_rank----------------------
  
  With cte_on_emp_for_ranking
  AS
  ( SELECT *,DENSE_RANK() OVER(ORDER BY Salary DESC) sal_rank
  FROM Emp
  )
  SELECT DISTINCT * FROM cte_on_emp_for_ranking WHERE sal_rank = 3 

  SELECT TOP 1* FROM(SELECT distinct TOP 3 Salary FROM Emp ORDER BY Salary DESC) tbl ORDER BY Salary ASC

  
  With cte_on_emp_for_ranking
  AS
  ( SELECT *,RANK() OVER(ORDER BY Salary DESC) sal_rank
  FROM Emp
  )
  SELECT DISTINCT * FROM cte_on_emp_for_ranking WHERE sal_rank = 3 


  --similarties between row_number,dense_rank,rank--------
  /* 1. all rows have same increasing number integer staring from 1 if 
  there are no tie
  2. order by clause required
  3. partition by is optional
  4. when partition changes squential number reset to 1 again

  if there are no duplicates records on that column which we use in
  order by clause then all three functions going to give same sequential number

  ----remove duplicates first to see the effect--------- */
  with cte
 AS 
 (
    SELECT *,ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID) rownum
    FROM Emp
 )
   DELETE FROM cte WHERE rownum>1


  SELECT *,ROW_NUMBER() OVER(ORDER BY ID) rownum,
  DENSE_RANK() OVER( ORDER BY ID) AS DENS_RNK,
  RANK() OVER( ORDER BY ID) AS RNK FROM Emp



  ------difference between row_number and dense_rank- and rank------
  SELECT *,ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID) rownum FROM Emp
  SELECT *,DENSE_RANK() OVER(PARTITION BY ID ORDER BY ID) AS DENS_RNK FROM Emp

  SELECT *,ROW_NUMBER() OVER( ORDER BY ID) rownum,
  DENSE_RANK() OVER(ORDER BY ID) AS DENS_RNK,
  RANK() OVER(ORDER BY ID) AS RNK FROM Emp



  ------ROWS/RANGE------------------------------
  /* ROWS/RANGE that limits the rows within the partition by specifying start 
  and end points within the partition. It requires ORDER BY argument and
  the default value is from the start of partition to the current element
  if the ORDER BY argument is specified.*/

  SELECT *,ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID ) rownum,
  DENSE_RANK() OVER(PARTITION BY ID ORDER BY ID ) AS DENS_RNK,
  RANK() OVER(PARTITION BY ID ORDER BY ID ) AS RNK ,
  AVG(Salary) over(order by Salary ROWS BETWEEN
  UNBOUNDED PRECEDING AND CURRENT ROW) as avgsal,
  AVG(Salary) over(order by Salary ) as avgsal_default FROM Emp