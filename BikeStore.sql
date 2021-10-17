USE BikeStores

SELECT *
FROM production.brands

SELECT 
    coalesce(phone, 'na') hell, 
    last_name, 
    first_name,
    email
FROM 
    sales.customers
ORDER BY 
    first_name, 
    last_name;




SELECT 
    first_name, 
    last_name, 
    phone,
    email
FROM 
    sales.customers
ORDER BY 
    first_name, 
    last_name;