--Count Salary Categories

WITH Acc_seg AS (
    SELECT
        CASE
            WHEN income < 20000 THEN 'Low Salary'
            WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
            ELSE 'High Salary'
        END AS category
    FROM Accounts
)
SELECT 'Low Salary' AS category, COUNT(*) AS accounts_count
FROM Acc_seg
WHERE category = 'Low Salary'
UNION
SELECT 'Average Salary' AS category, COUNT(*) AS accounts_count
FROM Acc_seg
WHERE category = 'Average Salary'
UNION
SELECT 'High Salary' AS category, COUNT(*) AS accounts_count
FROM Acc_seg
WHERE category = 'High Salary';
