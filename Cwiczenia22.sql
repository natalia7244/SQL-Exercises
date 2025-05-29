-- Joining Data in SQL / Data Camp (PostreSQL)


-- Explore and analyze the students data to see how the length of stay (stay) impacts the average mental health diagnostic scores of the international students present in the study.

SELECT stay, COUNT(inter_dom) AS count_int, ROUND(AVG(todep),2) AS average_phq, ROUND(AVG(tosc),2) AS average_scs, ROUND(AVG(toas),2) AS average_as
FROM students
WHERE (stay IS NOT NULL) AND (Inter_dom LIKE 'Inter' )
GROUP BY stay
ORDER BY stay desc;

-- Join ON the country_code and code columns, making sure you identify them with the correct table.
SELECT * 
FROM cities
-- Inner join to countries
INNER JOIN countries
-- Match on country codes
ON cities.country_code = countries.code

-- Select name fields (with alias) and region 
SELECT cities.name AS city, countries.name AS country, countries.region
FROM cities
INNER JOIN countries
ON cities.country_code = countries.code;

-- Select fields with aliases
SELECT c.code AS country_code, name, year, inflation_rate
FROM countries AS c
-- Join to economies (alias e)
INNER JOIN economies AS e
-- Match on code field using table aliases
ON c.code = e.code

SELECT c.name AS country, l.name AS language, official
FROM countries AS c
INNER JOIN languages AS l
-- Match using the code column
USING (code)  -- PostreSQL, MySQL

-- Select country and language names (aliased)
SELECT c.name AS country, l.name as language
-- From countries (aliased)
FROM countries c
-- Join to languages (aliased)
JOIN languages l
-- Use code as the joining field with the USING keyword
USING (code)  --PostreSQL
-- Filter for the Bhojpuri language
WHERE l.name = 'Bhojpuri';

-- Select relevant fields
SELECT c.name, p.fertility_rate
-- Inner join countries and populations, aliased, on code
FROM countries AS c
INNER JOIN populations as p
ON c.code = p.country_code;

-- Select fields
SELECT c.name, e.year, p.fertility_rate,e.unemployment_rate
FROM countries AS c
INNER JOIN populations AS p
ON c.code = p.country_code
-- Join to economies (as e)
INNER JOIN economies e
-- Match on country code
ON p.country_code = e.code;

SELECT name, e.year, fertility_rate, unemployment_rate
FROM countries AS c
INNER JOIN populations AS p
ON c.code = p.country_code
INNER JOIN economies AS e
ON c.code = e.code
-- Add an additional joining condition such that you are also joining on year
	AND e.year = p.year ;