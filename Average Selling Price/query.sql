Average Selling Price

SELECT 
    Prices.product_id, 
    ROUND(SUM(UnitsSold.units * Prices.price) / SUM(UnitsSold.units), 2) AS average_price
FROM 
    UnitsSold
JOIN 
    Prices
ON 
    UnitsSold.product_id = Prices.product_id
AND 
    UnitsSold.purchase_date BETWEEN Prices.start_date AND Prices.end_date
GROUP BY 
    Prices.product_id;
