CREATE OR REPLACE TABLE
taxirides.<Table_Name_as_mention_in_lab> AS
SELECT
(tolls_amount + fare_amount) AS <Fare Amount_as_mention_in_lab>,
pickup_datetime,
pickup_longitude AS pickuplon,
pickup_latitude AS pickuplat,
dropoff_longitude AS dropofflon,
dropoff_latitude AS dropofflat,
passenger_count AS passengers,
FROM
taxirides.historical_taxi_rides_raw
WHERE
RAND() < 0.001
AND trip_distance > 3       [Change_as_mention_in_lab]
AND fare_amount >= 2.0      [Change_as_mention_in_lab]
AND pickup_longitude > -78
AND pickup_longitude < -70
AND dropoff_longitude > -78
AND dropoff_longitude < -70
AND pickup_latitude > 37
AND pickup_latitude < 45
AND dropoff_latitude > 37
AND dropoff_latitude < 45
AND passenger_count > 3     [Change_as_mention_in_lab]
