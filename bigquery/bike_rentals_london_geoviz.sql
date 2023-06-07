WITH staging AS (
  SELECT
    STRUCT(
      start_stn.name,
      ST_GEOGPOINT(start_stn.longitude, start_stn.latitude) AS point,
      start_stn.docks_count,
      start_stn.install_date
    ) AS starting,
    STRUCT(
      end_stn.name,
      ST_GEOGPOINT(end_stn.longitude, end_stn.latitude) AS point,
      end_stn.docks_count,
      end_stn.install_date
    ) AS ending,
    STRUCT(
      rental_id,
      bike_id,
      duration, -- seconds
      ST_DISTANCE(
        ST_GEOGPOINT(start_stn.longitude, start_stn.latitude),
        ST_GEOGPOINT(end_stn.longitude, end_stn.latitude)
      ) AS distance, -- meters
      ST_MAKELINE(
        ST_GEOGPOINT(start_stn.longitude, start_stn.latitude),
        ST_GEOGPOINT(end_stn.longitude, end_stn.latitude)
      ) AS trip_line, -- straight line (for GeoViz)
      start_date,
      end_date
    ) as bike
  FROM `bigquery-public-data.london_bicycles.cycle_stations` AS start_stn
  LEFT JOIN `bigquery-public-data.london_bicycles.cycle_hire` AS b
  ON start_stn.id = b.start_station_id
  LEFT JOIN `bigquery-public-data.london_bicycles.cycle_stations` AS end_stn
  ON end_stn.id = b.end_station_id
)
-- Find the fastest avg biking pace for rides over 30 mins
SELECT
  starting.name AS starting_name,
  ending.name AS ending_name,
  ROUND(bike.distance/1000, 2) AS distance_km,
  ST_UNION_AGG(bike.trip_line) AS trip_line,
  COUNT(bike.rental_id) AS total_trips,
  ROUND(
    AVG(
      (bike.distance / 1000) -- meters to km
      / (bike.duration / 60 / 60) -- seconds to hr
      )
    ,2) AS avg_kmph
FROM staging
WHERE bike.duration > (30*60) -- at least 30 minutes
GROUP BY
  starting.name,
  ending.name,
  bike.distance
HAVING total_trips > 100
ORDER BY avg_kmph DESC
LIMIT 100;

