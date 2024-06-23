--Confirmation Rate

WITH Action AS (
    SELECT 
        Signups.user_id,
        Confirmations.time_stamp,
        Confirmations.action
    FROM Signups
    LEFT JOIN Confirmations ON Signups.user_id = Confirmations.user_id
),
Average AS (
    SELECT
        Action.user_id, 
        CASE WHEN Action.action = 'confirmed' THEN 1 ELSE 0 END AS num_action
    FROM Action
)
SELECT Average.user_id, ROUND(AVG(num_action),2) as confirmation_rate
FROM Average
GROUP BY Average.user_id;
