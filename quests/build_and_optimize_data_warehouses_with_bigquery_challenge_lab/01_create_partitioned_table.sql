#standardSQL
 CREATE OR REPLACE TABLE covid19.analytics
 PARTITION BY date
 OPTIONS (
   partition_expiration_days=720,
   description="analytics challenge table, partitioned by day"
 ) AS
 SELECT *
 FROM `bigquery-public-data.covid19_govt_response.oxford_policy_tracker`
 WHERE alpha_3_code not in ('GBR', 'BRA', 'CAN', 'USA');
