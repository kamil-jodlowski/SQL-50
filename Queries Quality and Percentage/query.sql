--Queries Quality and Percentage


WITH Ratio AS (
     SELECT query_name, result, (rating/position) AS ratio
    FROM Queries),

Quality AS (
    SELECT Ratio.query_name, SUM(Ratio.ratio)/3 AS quality
    FROM Ratio
    GROUP BY Ratio.query_name
),

Poor_query_percentage1 AS (
    SELECT *
    FROM Queries 
    WHERE rating < 3
),

tabela_robocza AS (
    SELECT
query_name,COUNT(Queries.query_name) AS przeliczenie
FROM Queries
GROUP BY query_name),


Poor_query_percentage2 AS (
    SELECT Poor_query_percentage1.query_name, Poor_query_percentage1.result, ROUND(COUNT(Poor_query_percentage1.rating)/przeliczenie  *100,2) AS poor_query_percentage
    FROM Poor_query_percentage1
    JOIN Queries ON (Poor_query_percentage1.query_name = Queries.query_name and Poor_query_percentage1.result = Queries.result)
    JOIN tabela_robocza ON (tabela_robocza.query_name = Poor_query_percentage1.query_name)
    GROUP BY Poor_query_percentage1.query_name, Poor_query_percentage1.result
)
SELECT Poor_query_percentage2.query_name, ROUND(Quality.quality,2) AS quality,Poor_query_percentage2.poor_query_percentage
FROM Poor_query_percentage2
JOIN Quality ON Quality.query_name = Poor_query_percentage2.query_name;



--Or even better way 

WITH Ratio AS (
    SELECT 
        query_name, 
        (rating * 1.0 / position) AS ratio
    FROM 
        Queries
),

Quality AS (
    SELECT 
        query_name, 
        ROUND(AVG(ratio), 2) AS quality
    FROM 
        Ratio
    GROUP BY 
        query_name
),

PoorQueryCount AS (
    SELECT 
        query_name, 
        COUNT(*) AS poor_query_count
    FROM 
        Queries
    WHERE 
        rating < 3
    GROUP BY 
        query_name
),

TotalQueryCount AS (
    SELECT 
        query_name, 
        COUNT(*) AS total_query_count
    FROM 
        Queries
    GROUP BY 
        query_name
),

PoorQueryPercentage AS (
    SELECT 
        tq.query_name, 
        ROUND((COALESCE(pq.poor_query_count, 0) * 1.0 / tq.total_query_count) * 100, 2) AS poor_query_percentage
    FROM 
        TotalQueryCount tq
    LEFT JOIN 
        PoorQueryCount pq ON tq.query_name = pq.query_name
)

SELECT 
    q.query_name, 
    q.quality, 
    pqp.poor_query_percentage
FROM 
    Quality q
JOIN 
    PoorQueryPercentage pqp ON q.query_name = pqp.query_name
ORDER BY 
    q.query_name;
