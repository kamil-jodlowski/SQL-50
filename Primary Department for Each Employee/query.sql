--Primary Department for Each Employee

WITH Tab1 AS (SELECT employee_id, department_id
FROM Employee
WHERE employee_id IN (
    SELECT employee_id
    FROM Employee
    GROUP BY employee_id
    HAVING COUNT(*) = 1)
),

Tab2 AS (SELECT employee_id, department_id
                FROM Employee
                WHERE primary_flag = 'Y')

SELECT Tab1.employee_id, Tab1.department_id
FROM Tab1
UNION
SELECT Tab2.employee_id, Tab2.department_id
FROM Tab2
