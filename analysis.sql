
SELECT name, ST_Area(way) as area
FROM planet_osm_polygon
WHERE leisure = 'park'
ORDER BY area DESC
LIMIT 10;


