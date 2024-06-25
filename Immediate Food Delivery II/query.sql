--Immediate Food Delivery II

WITH Delivery2 AS (
    SELECT customer_id, MIN(order_date) AS Min_date
    FROM Delivery
    GROUP BY customer_id),
If_first_order AS (
    SELECT Delivery2.customer_id, Delivery2.Min_date, Delivery.customer_pref_delivery_date
    FROM Delivery2
    JOIN Delivery ON Delivery2.customer_id = Delivery.customer_id AND Delivery2.Min_date = Delivery.order_date AND Delivery2.Min_date = Delivery.customer_pref_delivery_date
),
Ilsc AS (SELECT
(SELECT COUNT(*) FROM If_first_order) AS liczba_rows_If_first_order,
(SELECT COUNT(*) FROM Delivery2) AS liczba_rows_Delivery2)
         
SELECT ROUND((Ilsc.liczba_rows_If_first_order/Ilsc.liczba_rows_Delivery2) *100,2) AS immediate_percentage
FROM Ilsc
