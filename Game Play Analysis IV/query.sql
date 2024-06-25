--Game Play Analysis IV

WITH First_Log_In AS (
  SELECT player_id, MIN(event_date) AS First_log
  FROM Activity
  GROUP BY player_id
),

Double_tab AS (
  SELECT x.player_id, x.device_id, x.event_date, y.event_date AS event_date_3, x.games_played
  FROM Activity x
  JOIN Activity y ON x.player_id = y.player_id AND x.device_id = y.device_id AND x.games_played = y.games_played
),

Final AS (SELECT
  Double_tab.player_id,
  Double_tab.device_id,
  First_Log_In.First_log,
  Double_tab.event_date_3 AS Sec_Log,
  Double_tab.games_played
  
FROM Double_tab
JOIN First_Log_In ON Double_tab.player_id = First_Log_In.player_id
WHERE Double_tab.event_date_3 = DATE_ADD(First_Log_In.First_log, INTERVAL 1 DAY)),

Zestawienie AS(SELECT 
  (SELECT COUNT(*) FROM Final) AS rodzyny,
   (SELECT COUNT(DISTINCT player_id) FROM Activity) AS alll
)
                
SELECT ROUND(rodzyny/alll,2) AS fraction
FROM Zestawienie;


--EVEN BETTER ONE 

SELECT
  ROUND(
    COUNT(A1.player_id)
    / (SELECT COUNT(DISTINCT A3.player_id) FROM Activity A3)
  , 2) AS fraction
FROM
  Activity A1
WHERE
  (A1.player_id, DATE_SUB(A1.event_date, INTERVAL 1 DAY)) IN (
    SELECT
      A2.player_id,
      MIN(A2.event_date)
    FROM
      Activity A2
    GROUP BY
      A2.player_id
  );
