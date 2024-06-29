--Last Person to Fit in the Bus

WITH tab_asc AS (
    SELECT *
    FROM Queue
    ORDER BY turn ASC
),
total_weight AS (
    SELECT 
        tab_asc.person_id, 
        tab_asc.person_name, 
        tab_asc.weight, 
        tab_asc.turn,
        SUM(weight) OVER (ORDER BY turn) AS tot_weight
    FROM tab_asc
)
SELECT person_name
FROM total_weight
WHERE tot_weight <= 1000
ORDER BY tot_weight DESC
LIMIT 1;
