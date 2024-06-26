--The Number of Employees Which Report to Each Employee

SELECT x.employee_id,
x.name,
COUNT(y.reports_to) AS reports_count,
ROUND(AVG(y.age)) AS average_age
FROM Employees x
JOIN Employees y ON x.employee_id = y.reports_to
GROUP BY x.employee_id, x.name
HAVING COUNT(x.reports_to) IS NOT NULL
ORDER BY x.employee_id;
