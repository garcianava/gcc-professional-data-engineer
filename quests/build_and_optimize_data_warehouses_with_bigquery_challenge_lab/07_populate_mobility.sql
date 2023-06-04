UPDATE
   `covid19.analytics` t0
SET
   t0.mobility.avg_retail      = t1.avg_retail,
   t0.mobility.avg_grocery     = t1.avg_grocery,
   t0.mobility.avg_parks       = t1.avg_parks,
   t0.mobility.avg_transit     = t1.avg_transit,
   t0.mobility.avg_workplace   = t1.avg_workplace,
   t0.mobility.avg_residential = t1.avg_residential
FROM
  covid19.analytics AS t0
JOIN
  (SELECT
    country_region, date,
    AVG(retail_and_recreation_percent_change_from_baseline) as avg_retail,
    AVG(grocery_and_pharmacy_percent_change_from_baseline)  as avg_grocery,
    AVG(parks_percent_change_from_baseline) as avg_parks,
    AVG(transit_stations_percent_change_from_baseline) as avg_transit,
    AVG(workplaces_percent_change_from_baseline) as avg_workplace,
    AVG(residential_percent_change_from_baseline)  as avg_residential
    FROM `bigquery-public-data.covid19_google_mobility.mobility_report`
    GROUP BY country_region, date
   ) AS t1
ON
   t0.country_name = t1.country_region
AND t0.date = t1.date
