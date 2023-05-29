# You happened to see that the fastest lap time recorded for the 800 M race was 23.2 seconds,
# but you did not see which runner ran that particular lap.
# Create a query that returns that result.

#standardSQL
SELECT
  p.name,
  split_time
FROM racing.race_results AS r
, UNNEST(r.participants) AS p
, UNNEST(p.splits) AS split_time
WHERE split_time = 23.2;
