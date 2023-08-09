SELECT DISTINCT country_name
FROM `covid19.analytics`
WHERE population is NULL
UNION ALL
SELECT DISTINCT country_name
FROM `covid19.analytics`
WHERE country_area IS NULL
ORDER BY country_name ASC
