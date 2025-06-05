-- Semi join // Data Camp // PostgreSQL

--Create a semi join out of the two queries you've written, which filters unique languages returned in the first query for only those languages spoken in the 'Middle East'.
SELECT DISTINCT name
FROM languages
-- Add syntax to use bracketed subquery below as a filter
WHERE code IN
    (SELECT code
    FROM countries
    WHERE region = 'Middle East')
ORDER BY name;


-- Begin by writing a query to return the code and name (in order, not aliased) for all countries in the continent of Oceania from the countries table.
-- Observe the number of records returned and compare this with the provided INNER JOIN, which returns 15 records.

-- Select code and name of countries from Oceania
-- Select code and name of countries from Oceania
SELECT code, name
FROM countries 
WHERE continent = 'Oceania'

--Now, build on your query to complete your anti join, by adding an additional filter to return every country code that is not included in the currencies table.
SELECT code, name
FROM countries
WHERE continent = 'Oceania'
-- Filter for countries not included in the bracketed subquery
  AND code NOT IN 
    (SELECT code
    FROM currencies);