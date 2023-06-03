SELECT users.id, users.name
FROM users
WHERE users.id NOT IN
(SELECT DISTINCT user_id FROM trips WHERE fare_amount >= 200)
ORDER BY user_id;
