UPDATE
    covid19.analytics t0
SET
    t0.population = t2.pop_data_2019
FROM
    (SELECT DISTINCT country_territory_code, pop_data_2019 FROM `bigquery-public-data.covid19_ecdc.covid_19_geographic_distribution_worldwide`) AS t2
WHERE t0.alpha_3_code = t2.country_territory_code;
