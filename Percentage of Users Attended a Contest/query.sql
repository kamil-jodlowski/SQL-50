--Percentage of Users Attended a Contest

WITH blabla AS (SELECT Register.contest_id, COUNT(Register.user_id) AS WTF
FROM Users
JOIN Register ON (Users.user_id = Register.user_id)
GROUP BY Register.contest_id),

qwerty AS (SELECT blabla.contest_id, SUM(WTF) AS idk
FROM blabla
GROUP BY blabla.contest_id)

SELECT qwerty.contest_id, ROUND((qwerty.idk/3*100), 2) AS percentage
FROM qwerty
ORDER BY percentage DESC, contest_id ASC
;
