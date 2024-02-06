# UrbanGreenSpacesProject
OBJECTIVES:

1. To find out the number of parks in Washington DC

2. To find out the total green space area in Washington DC



METHODOLOGY

A new database(Urban_green_spaces) was created on PgAdmin.

A repository was created(UrbanGreenSpacesProject) was created on GitHub, where the gitignore file was also added and committed.

Open street map data downloaded from BBBike was then imported into PgAdmin using the osm2pgsql tool in Command Prompt.

A new table (green_spaces) was then created and populated with green spaces(parks) data from the osm data downloaded.

`CREATE TABLE green_spaces (
id SERIAL PRIMARY KEY,
name VARCHAR(255),
location GEOMETRY(Polygon, 3857),
area_sq_m NUMERIC
);`


`INSERT INTO green_spaces (name, location, area_sq_m)
SELECT name, ST_Centroid(way), ST_Area(way)
FROM planet_osm_polygon
WHERE leisure = 'park'`


The parks without names(null) were deleted using 
`DELETE FROM green_spaces
WHERE name IS NULL;`

The cleaned data was added to QGIS for visualization purposes.

ANALYSIS and FINDINGS

The number of parks and total area of green space were obtained by:

`SELECT COUNT(*) AS total_parks, 
ROUND((SUM(area_sq_m)), 2) AS total_area_sq_m
FROM green_spaces
WHERE name <> 'Washington';`



![image](https://github.com/isackwalube/UrbanGreenSpacesProject/assets/156945477/270b4d46-4b9e-41f4-9337-9f762d4899dd)

visually, the parks tally with the green spaces on the map.

Conclusion:

To my opinion, if polygon data instead of point data was inserted in the newly created tables(green_spaces), it would better serve visual analysis on the map as far as size and coverage context are concerned.











