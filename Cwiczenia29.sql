-- Subqueries inside WHERE and SELECT // Data Camp // PostgreSQL

-- Your goal is to figure out which countries had high average life expectancies in 2015.
--You can use SQL to do calculations for you. Suppose you only want records from 2015 with life_expectancy above 1.15 * avg_life_expectancy. You could use the following SQL query.

SELECT *
FROM populations
WHERE year = 2015
-- Filter for only those populations where life expectancy is 1.15 times higher than average
  AND life_expectancy > 1.15*
  (SELECT AVG(life_expectancy)
   FROM populations
   WHERE year = 2015);

-- Return the name, country_code and urbanarea_pop for all capital cities (not aliased).

-- Select relevant fields from cities table
SELECT  name, country_code, urbanarea_pop
FROM cities
-- Filter using a subquery on the countries table
WHERE name IN ( SELECT capital
    FROM countries)
ORDER BY urbanarea_pop DESC;


--In this exercise, you'll go further in exploring how some queries can be written using either a join or a subquery.

-- Find top nine countries with the most cities
SELECT c1.name as country_name, COUNT(c2.name) as cities_num
FROM countries AS c1
LEFT JOIN cities AS c2
ON c1.code = c2.country_code
GROUP BY c1.name
-- Order by count of cities as cities_num
ORDER BY cities_num DESC, country ASC
-- Limit the results
LIMIT 9;

--Complete the subquery to return a result equivalent to your LEFT JOIN, counting all cities in the cities table as cities_num.
SELECT countries.name AS country,
-- Subquery that provides the count of cities   
  (SELECT  COUNT(name)
   FROM cities
   WHERE cities.country_code = countries.code) AS cities_num
FROM countries
ORDER BY cities_num DESC, country
LIMIT 9;
