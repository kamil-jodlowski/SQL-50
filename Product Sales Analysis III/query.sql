--Product Sales Analysis III

SELECT 
    Sales.product_id, 
    Sales.year AS first_year, 
    Sales.quantity, 
    Sales.price
FROM 
    Sales
JOIN 
    (SELECT product_id, MIN(year) AS first_year
     FROM Sales
     GROUP BY product_id) sub
ON 
    Sales.product_id = sub.product_id AND Sales.year = sub.first_year;
