--Friend Requests II: Who Has the Most Friends


WITH FriendCounts AS (
    SELECT person_id, COUNT(*) AS num_friends
    FROM (
        SELECT requester_id AS person_id
        FROM RequestAccepted
        UNION ALL
        SELECT accepter_id AS person_id
        FROM RequestAccepted
    ) AS AllFriends
    GROUP BY person_id
)

SELECT person_id AS id, num_friends AS num
FROM FriendCounts
WHERE num_friends = (SELECT MAX(num_friends) FROM FriendCounts);
