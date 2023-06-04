# Write a query that will list the total race time for racers whose names begin with R.
# Order the results with the fastest total time first.
# Use the UNNEST() operator.

#standardSQL
SELECT
  p.name,
  SUM(split_times) as total_race_time
FROM racing.race_results AS r
, UNNEST(r.participants) AS p
, UNNEST(p.splits) AS split_times
WHERE p.name LIKE 'R%'
GROUP BY p.name
ORDER BY total_race_time ASC;
