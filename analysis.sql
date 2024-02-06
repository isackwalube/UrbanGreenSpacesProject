--selected the largest 20 parks in the area of interest(Washington DC)
SELECT osm_id, name, ST_Area(way) as area
FROM planet_osm_polygon
WHERE leisure = 'park'
ORDER BY area DESC
Limit 20;

--total green space area from the downloaded data
SELECT SUM(ST_Area(way)) as total_green_space_area
FROM planet_osm_polygon
WHERE leisure = 'park';

--created the table(green_spaces),and set the columns to be included
CREATE TABLE green_spaces (
id SERIAL PRIMARY KEY,
name VARCHAR(255),
location GEOMETRY(Polygon, 3857),
area_sq_m NUMERIC
);

--populated the new table with data from the donloaded osm data
INSERT INTO green_spaces (name, location, area_sq_m)
SELECT name, ST_Centroid(way), ST_Area(way)
FROM planet_osm_polygon
WHERE leisure = 'park'

--show the table contents of the table created
SELECT*FROM green_spaces
ORDER BY name

--deleted the parks without names(null)
DELETE FROM green_spaces
WHERE name IS NULL;

--select the boundary for Washington
SELECT osm_id, name, way as city_boundary
FROM planet_osm_polygon
WHERE place = 'city'
and name ='Washington'
ORDER BY name;


--shows the total number of parks, and total area in miles
SELECT COUNT(*) AS total_parks, 
ROUND((SUM(area_sq_m)), 2) AS total_area_sq_m
FROM green_spaces
WHERE name <> 'Washington';









