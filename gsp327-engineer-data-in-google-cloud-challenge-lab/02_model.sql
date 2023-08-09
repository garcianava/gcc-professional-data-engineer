CREATE OR REPLACE MODEL taxirides.<Model Name_as_mention_in_lab>
TRANSFORM(
* EXCEPT(pickup_datetime)
 
, ST_Distance(ST_GeogPoint(pickuplon, pickuplat), ST_GeogPoint(dropofflon, dropofflat)) AS euclidean
, CAST(EXTRACT(DAYOFWEEK FROM pickup_datetime) AS STRING) AS dayofweek
, CAST(EXTRACT(HOUR FROM pickup_datetime) AS STRING) AS hourofday
)
OPTIONS(input_label_cols=['<Fare Amount_as_mention_in_lab>'], model_type='linear_reg')
AS
 
SELECT * FROM taxirides.<Table_Name_as_mention_in_lab>
