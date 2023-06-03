SELECT t.city_id, c.name AS city_name, t.user_sum_fare_rank_desc, t.user_id, u.name, t.user_sum_fare,
  (SELECT SUM(fare_amount) FROM trips WHERE city_id = t.city_id) AS city_sum_fare
FROM (
  SELECT city_id, user_id, SUM(fare_amount) AS user_sum_fare,
         ROW_NUMBER() OVER (PARTITION BY city_id ORDER BY SUM(fare_amount) DESC) AS user_sum_fare_rank_desc
  FROM trips
  GROUP BY city_id, user_id
) AS t
JOIN cities c ON t.city_id = c.id
JOIN users u ON t.user_id = u.id
WHERE t.user_sum_fare_rank_desc <= 3
ORDER BY city_sum_fare DESC, user_sum_fare_rank_desc;
