SELECT id, name
FROM users
WHERE id NOT IN
(SELECT DISTINCT user_id FROM trips WHERE fare_amount >= 200)
ORDER BY id;
