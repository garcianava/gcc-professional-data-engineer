CREATE OR REPLACE TABLE taxirides.2015_fare_amount_predictions
AS
SELECT * FROM ML.PREDICT(MODEL taxirides.<Model Name_as_mention_in_lab>,(
SELECT * FROM taxirides.report_prediction_data)
)
