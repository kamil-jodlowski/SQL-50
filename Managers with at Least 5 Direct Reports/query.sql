--Managers with at Least 5 Direct Reports

WITH RaportingToo AS (
    SELECT 
        x.id,
        x.name, 
        COALESCE(y.name, 'No Manager') AS Raporting_too
    FROM 
        Employee x
    LEFT JOIN 
        Employee y ON x.managerId = y.id
),
NumberOfRaports AS (
    SELECT 
        Raporting_too,
        COUNT(*) AS ile
    FROM 
        RaportingToo
    GROUP BY 
        Raporting_too
) 
SELECT 
    Raporting_too AS name
FROM 
    NumberOfRaports
WHERE 
    ile >= 5;
