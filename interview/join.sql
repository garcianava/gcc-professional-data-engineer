SELECT c.id AS city_id, c.name AS city_name, SUM(t.fare_amount) AS city_sum_fare, 
       (SELECT SUM(fare_amount) FROM trips) AS all_cities_sum_fare
FROM trips t
JOIN cities c ON t.city_id = c.id
GROUP BY c.id, c.name
ORDER BY city_sum_fare DESC;
