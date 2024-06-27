-- complicated

SELECT user_id, name, mail
FROM Users
WHERE mail LIKE '%@leetcode.com'
  AND LEFT(mail, 1) BETWEEN 'a' AND 'z'
  AND LENGTH(mail) - LENGTH(REPLACE(mail, '@', '')) = 1
  AND SUBSTRING(mail, 1, LOCATE('@', mail) - 1) NOT REGEXP '[^a-zA-Z0-9._-]';


--Easy 

SELECT user_id, name, mail
FROM Users
WHERE mail REGEXP '^[a-zA-Z][a-zA-Z0-9._-]*@leetcode\\.com$';
