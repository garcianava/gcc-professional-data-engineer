SELECT c.id AS city_id, c.name AS city_name, SUM(t.fare_amount) AS total_fare
FROM trips t
JOIN cities c ON t.city_id = c.id
GROUP BY c.id, c.name;
