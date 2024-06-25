--Monthly Transactions

WITH Month AS (
    SELECT
        CASE 
            WHEN trans_date BETWEEN '2018-12-01' AND '2018-12-31' THEN '2018-12'
            WHEN trans_date BETWEEN '2019-01-01' AND '2019-01-31' THEN '2019-01'
            ELSE NULL
        END AS month,
        country,
        amount,
        state
    FROM transactions 
),
approved AS (
    SELECT
        month,
        country,
        COUNT(*) AS approved_count,
        SUM(amount) AS approved_total_amount
    FROM Month
    WHERE state = 'approved'
    GROUP BY month, country
)

SELECT 
    Month.month, 
    Month.country, 
    COUNT(*) AS trans_count, 
    COALESCE(approved.approved_count, 0) AS approved_count, 
    SUM(Month.amount) AS trans_total_amount, 
    COALESCE(approved.approved_total_amount, 0) AS approved_total_amount
FROM Month
LEFT JOIN approved ON Month.month = approved.month AND Month.country = approved.country
GROUP BY Month.month, Month.country, approved.approved_count, approved.approved_total_amount
ORDER BY Month.month, Month.country;



-- EVEN MORE COOL

SELECT
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    COUNT(*) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM
    transactions
GROUP BY
    month,
    country
ORDER BY
    month,
    country;
