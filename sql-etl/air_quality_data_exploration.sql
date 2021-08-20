SELECT * FROM air_quality;

/* From the latet year of data - grab the PM2.5 metrics for each location */
SELECT geo_place_name geo_location, name measure, data_value latest_data_value
FROM air_quality
WHERE start_date = (SELECT MAX(start_date) FROM air_quality) AND name='Fine Particulate Matter (PM2.5)'
ORDER BY data_value DESC;

/* Find the average PM2.5 value across all NYC for the latest data */
SELECT AVG(data_value)
FROM air_quality
WHERE start_date = (SELECT MAX(start_date) FROM air_quality) AND name='Fine Particulate Matter (PM2.5)'
GROUP BY start_date;

/* Add additional flag to query 1 for above and below avg PPM locations */
SELECT geo_place_name geo_location, name measure, data_value latest_data_value, 
	CASE WHEN  data_value >=
		(SELECT AVG(data_value)
		FROM air_quality
		WHERE start_date = (SELECT MAX(start_date) FROM air_quality) AND name='Fine Particulate Matter (PM2.5)'
		GROUP BY start_date)
	THEN 'ABOVE' ELSE 'BELOW' END flag
FROM air_quality
WHERE start_date = (SELECT MAX(start_date) FROM air_quality) AND name='Fine Particulate Matter (PM2.5)'
ORDER BY data_value DESC;