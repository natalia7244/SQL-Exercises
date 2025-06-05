-- Subqueries inside FROM // Data Camp // PostgreSQL

SELECT DISTINCT sub.continent, sub.most_recent
FROM monarchs, (
    SELECT continent, MAX(independence_year) AS most_recent
    FROM countries
    GROUP BY continent
) AS sub
WHERE monarchs.continent = sub.continent
ORDER BY sub.continent;

--Say you are interested in determining the number of languages spoken for each country. You want to present this information alongside each country's local_name, 
--which is a field only present in the countries table and not in the languages table.
--You'll use a subquery inside FROM to bring information from these two tables together!

-- Select local_name and lang_num from appropriate tables
SELECT countries.local_name, sub.lang_num
FROM countries,(
  SELECT code, COUNT(*) AS lang_num
  FROM languages
  GROUP BY code) 
  AS sub
-- Where codes match
WHERE countries.code = sub.code
ORDER BY lang_num DESC;

--Suppose you're interested in analyzing inflation and unemployment rate for certain countries in 2015. You are interested in countries with "Republic" or "Monarchy" as their form of government.

-- Select relevant fields
SELECT code, inflation_rate, unemployment_rate
FROM economies
WHERE year = 2015 
  AND code IN
-- Subquery returning country codes filtered on gov_form
	(SELECT code
  FROM countries 
  WHERE gov_form IN ('Republic', 'Monarchy'))
ORDER BY inflation_rate;

--Your task is to determine the top 10 capital cities in Europe and the Americas by city_perc, a metric you'll calculate. 
--city_perc is a percentage that calculates the "proper" population in a city as a percentage of the total population in the wider metro area, as follows:
-- city_proper_pop / metroarea_pop * 100

-- Select fields from cities
SELECT name, country_code, city_proper_pop, metroarea_pop, city_proper_pop / metroarea_pop * 100 AS city_perc
FROM cities,
-- Use subquery to filter city name
(SELECT capital
FROM countries
WHERE continent IN ('Europe', 'America') ) AS name
WHERE name.capital = cities.name
-- Add filter condition such that metroarea_pop does not have null values
AND metroarea_pop IS NOT NULL
-- Sort and limit the result
ORDER BY city_perc DESC
LIMIT 10

-- Select fields from cities
SELECT name, country_code, city_proper_pop, metroarea_pop, city_proper_pop / metroarea_pop * 100 AS city_perc
FROM cities
-- Use subquery to filter city name
WHERE name IN (
    SELECT capital
FROM countries
WHERE continent IN ('Europe', 'America') 
)
-- Add filter condition such that metroarea_pop does not have null values
AND metroarea_pop IS NOT NULL
-- Sort and limit the result
ORDER BY city_perc DESC
LIMIT 10