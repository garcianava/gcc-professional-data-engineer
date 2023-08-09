UPDATE
   `covid19.analytics` t0
SET
   t0.country_area = t1.country_area
FROM
   `bigquery-public-data.census_bureau_international.country_names_area` t1
WHERE
   t0.country_name = t1.country_name
