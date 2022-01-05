
use Employee;

SELECT *
FROM (
    VALUES (1, 'a') , (2, 'c')
) as t(k,m)

SELECT * 
FROM (
    SELECT 1 as a, 'a' as b from dual
    UNION ALL 
    SELECT 2, 'b' FROM dual
) t