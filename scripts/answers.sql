https://console.cloud.google.com/bigquery?project=intern-335207&orgonly=true&supportedpurview=project,organizationId,folder

Question: Calculate what percentage of the orders are fulfilled by each warehouse. Basically, we're interested in knowing which warehouses are delivering the most orders
SELECT
    Warehouse.warehouse_id
    , CONCAT(Warehouse.state, ':', Warehouse.warehouse_alias) AS warehouse_name
    , COUNT(Orders.order_id) AS number_of_orders
    , ( SELECT
            COUNT(*)
        FROM warehouse_orders.orders Orders
        ) AS total_orders,
        CASE
            WHEN COUNT(Orders.order_id)/(SELECT COUNT(*) FROM warehouse_orders.orders Orders) <= 0.20
            THEN "fulfilled 0-20% of Orders"
            WHEN COUNT(Orders.order_id)/(SELECT COUNT(*) FROM warehouse_orders.orders Orders) > 0.20
            AND COUNT(Orders.order_id)/(SELECT COUNT(*) FROM warehouse_orders.orders Orders) < 0.60
            THEN "fulfilled 21-60% of Orders"
        ELSE "fulfilled more than 60% of Orders"
        END AS fulfilment_summary
FROM warehouse_orders.warehouse Warehouse
LEFT JOIN warehouse_orders.orders Orders 
ON Orders.warehouse_id = Warehouse.warehouse_id
GROUP BY 
    Warehouse.warehouse_id
    , warehouse_name
HAVING
    COUNT(Orders.order_id) > 0

go;

WITH Employee_CTE(emp_id, name, manager_id) AS  
(  
   SELECT 
        emp_id
        , name
        , manager_id 
   FROM dbo.level
   WHERE emp_id=1
   
   UNION ALL  
   
   SELECT 
        e.emp_id
        , e.name
        , e.manager_id  
   FROM dbo.level e   
   INNER JOIN Employee_CTE c ON e.emp_id = c.manager_id

)  
SELECT * FROM Employee_CTE order by manager_id

WITH revenue AS (
    SELECT Monthly_sales as month, (January + February+ March+ April+ May+ June+ July+ August+ September+ October+ November+ December) AS revenue
    FROM `intern-335207.sales.Sales`
)
SELECT 
    month
    , revenue
    , revenue - LAG (revenue) OVER (ORDER BY month ASC) AS revenue_growth
    , LEAD (revenue, 12) OVER (ORDER BY month ASC) AS next_year_revenue
FROM revenue

WITH rvn AS (
    SELECT Monthly_sales as month, (January + February+ March+ April+ May+ June+ July+ August+ September+ October+ November+ December) AS revenue
    FROM `intern-335207.sales.Sales`
)
SELECT 
    month AS year
    , revenue
    , round((revenue - LAG (revenue) OVER (ORDER BY month ASC))/revenue*100, 2) AS Percentage_growth
FROM rvn
ORDER BY year

