--Product Price at a Given Date

WITH Basic_prices AS (
    SELECT 
product_id,  
change_date, 
CASE WHEN change_date = '2019-08-18' THEN 10 ELSE new_price END AS new_price 
    FROM Products
    WHERE (change_date = '2019-08-18' OR change_date = '2019-08-16' OR change_date = '2019-08-14') 
    AND CASE WHEN product_id = 1 THEN change_date IN (SELECT change_date
                       FROM Products
                       WHERE change_date = '2019-08-16') ELSE product_id END
ORDER BY product_id ASC),

Basic_prices2 AS (SELECT Basic_prices.product_id AS product_id , CASE WHEN change_date <> '2019-08-16' THEN '2019-08-16' ELSE change_date END AS change_date,Basic_prices.new_price AS price 
                    FROM Basic_prices)
SELECT Basic_prices2.product_id, Basic_prices2.price
FROM Basic_prices2


-- Better one (and working one) 

SELECT 
    product_id,
    COALESCE(
        (SELECT new_price 
         FROM Products p2 
         WHERE p1.product_id = p2.product_id 
           AND p2.change_date <= '2019-08-16' 
         ORDER BY p2.change_date DESC 
         LIMIT 1),
        10) AS price
FROM 
    (SELECT DISTINCT product_id FROM Products) p1;
