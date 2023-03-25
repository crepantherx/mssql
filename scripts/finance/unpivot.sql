

CREATE VIEW finance.vw_sales AS 
SELECT 
    [Monthly sales] AS year
    , months AS month
    , CAST(REPLACE(REPLACE(sales,'$', ''), ',', '') AS float) AS sales
FROM Finance.finance.sales s
UNPIVOT(
    sales FOR months IN (
        January
        , February
        , March
        , April
        , May
        , June
        , July
        , August
        , September
        , October
        , November
        , December
    )
) u


WITH cte_sales AS (
    SELECT year, SUM(sales) as agg_sales
    FROM finance.vw_sales s
    GROUP BY year
)
SELECT year, agg_sales
    , (agg_sales - LAG(agg_sales, 1)) OVER(ORDER BY year)
FROM cte_sales