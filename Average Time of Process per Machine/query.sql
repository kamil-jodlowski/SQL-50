--Average Time of Process per Machine

WITH ProcessTimes AS (
    SELECT machine_id, process_id , MAX(CASE WHEN activity_type = 'end' THEN timestamp END) - MAX(CASE WHEN activity_type = 'start' THEN timestamp END) AS totaltime
    FROM Activity
    GROUP BY machine_id, process_id
),

AverageTimes AS (
    SELECT machine_id, AVG(totaltime) AS avg_processing_time
    FROM ProcessTimes
    GROUP BY machine_id
)
SELECT machine_id, ROUND(avg_processing_time, 3) AS processing_time
FROM AverageTimes
GROUP BY machine_id;

