CREATE TABLE air_quality (
	unique_id bigserial,
	indicator bigserial,
	name varchar(200),
	measure varchar(200),
	measure_info varchar(200),
	geo_type varchar(200),
	geo_join_id numeric,
	geo_place_name varchar(200),
	time_period varchar(200),
	start_date date,
	data_value numeric,
	message varchar(200)
);

COPY air_quality
FROM 'C:\Github\nyc-data-playground\data\air_quality.csv'
WITH (FORMAT CSV, HEADER);

CREATE TABLE water_consumption (
	year int,
	new_york_city_population numeric,
	nyc_consumption_million_gallons_per_day numeric,
	per_capita_gallons_per_person_per_day numeric
);

COPY water_consumption
FROM 'C:\Github\nyc-data-playground\data\water_consumption.csv'
WITH (FORMAT CSV, HEADER);

CREATE TABLE residential_consumption (
	year int,
	consumption numeric
);
COPY residential_consumption
FROM 'C:\Github\nyc-data-playground\data\residential.csv'
WITH (FORMAT CSV, HEADER);

CREATE TABLE commercial_consumption (
	year int,
	consumption numeric
);
COPY commercial_consumption
FROM 'C:\Github\nyc-data-playground\data\commercial.csv'
WITH (FORMAT CSV, HEADER);

CREATE TABLE total_consumption (
	year int,
	consumption numeric
);
COPY total_consumption
FROM 'C:\Github\nyc-data-playground\data\total.csv'
WITH (FORMAT CSV, HEADER);
