--Classes More Than 5 Students

WITH Tab1 AS (SELECT
 class,
 COUNT(student) AS stud_count
 FROM Courses
 GROUP BY class)

 SELECT Tab1.class
 FROM Tab1
 WHERE Tab1.stud_count >= 5;


-- Even better one 

SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;
