CREATE TABLE Orders
(
	order_id INT,
	order_date DATE,
	customer_name VARCHAR(250),
	city VARCHAR(100),	
	order_amount MONEY
)

INSERT INTO [dbo].[Orders]
SELECT '1001','04/01/2017','David Smith','GuildFord',10000
UNION ALL	  
SELECT '1002','04/02/2017','David Jones','Arlington',20000
UNION ALL	  
SELECT '1003','04/03/2017','John Smith','Shalford',5000
UNION ALL	  
SELECT '1004','04/04/2017','Michael Smith','GuildFord',15000
UNION ALL	  
SELECT '1005','04/05/2017','David Williams','Shalford',7000
UNION ALL	  
SELECT '1006','04/06/2017','Paum Smith','GuildFord',25000
UNION ALL	 
SELECT '1007','04/10/2017','Andrew Smith','Arlington',15000
UNION ALL	  
SELECT '1008','04/11/2017','David Brown','Arlington',2000
UNION ALL	  
SELECT '1009','04/20/2017','Robert Smith','Shalford',1000
UNION ALL	  
SELECT '1010','04/25/2017','Peter Smith','GuildFord',500

SELECT * FROM Orders

---aggregate windows function

SELECT city ,SUM(order_amount) total 
FROM Orders 
GROUP BY city

SELECT * ,SUM(order_amount) OVER(PARTITION BY city) AS Total
FROM Orders

---ranking windows function

SELECT *,RANK() OVER( ORDER BY order_amount DESC) Ranking  
FROM Orders

SELECT *,DENSE_RANK() OVER( ORDER BY order_amount DESC) Ranking  
FROM Orders

SELECT *,ROW_NUMBER() OVER( ORDER BY order_amount DESC) Ranking  
FROM Orders

SELECT *,ROW_NUMBER() OVER(PARTITION BY city ORDER BY order_amount DESC) Ranking  
FROM Orders

SELECT * ,NTILE(4) OVER(PARTITION BY city ORDER BY order_amount DESC) percentile 
FROM Orders

---value based window function

SELECT order_id,customer_name,city, order_amount,order_date,
 --in below line, 1 indicates check for previous row of the current row
 LAG(order_date,1) OVER(ORDER BY order_date) prev_order_date
FROM [dbo].[Orders]

SELECT *,LEAD(order_date,1) OVER(ORDER BY order_date) next_date
FROM Orders

SELECT *, FIRST_VALUE(order_date) OVER(PARTITION BY city ORDER BY city) first_val,
LAST_VALUE(order_date) OVER(PARTITION BY city ORDER BY city ) last_val
FROM Orders

CUME_DIST

/* ranking function */

SELECT * FROM Orders

SELECT *,NTILE(4) OVER (ORDER BY order_amount DESC) percentile
FROM Orders

/* analytics function */

SELECT * FROM Orders

SELECT *,CUME_DIST() OVER (ORDER BY order_amount) percentile
FROM Orders


SELECT *,FIRST_VALUE(customer_name) OVER (ORDER BY order_amount) percentile
FROM Orders

SELECT *

FROM Orders

SELECT *,LAG(order_date) OVER(ORDER BY city) previous
FROM Orders

SELECT *,LEAD(order_date) OVER(ORDER BY city) previous
FROM Orders

PERCENTILE_CONT ( numeric_literal )   
    WITHIN GROUP ( ORDER BY order_by_expression [ ASC | DESC ] )  
    OVER ( [ <partition_by_clause> ] )  

SELECT * ,PERCENTILE_CONT(1)
WITHIN GROUP (ORDER BY order_amount DESC)
OVER (PARTITION BY city) res
FROM Orders


SELECT *,PERCENT_RANK() OVER(ORDER BY order_amount) percent_count,CUME_DIST() OVER (ORDER BY order_amount) percentile
FROM Orders

PERCENTILE_DISC 


SELECT *,PERCENT_RANK() OVER(ORDER BY order_amount) percent_count
,CUME_DIST() OVER (ORDER BY order_amount) percentile
,PERCENTILE_DISC(1)
WITHIN GROUP (ORDER BY order_amount DESC)
OVER (PARTITION BY city) res
FROM Orders

SELECT required_date,LAST_VALUE(order_date) OVER (PARTITION BY order_status ORDER BY order_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING ) as frst
FROM sales.orders