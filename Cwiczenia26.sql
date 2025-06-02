-- UNION vs UNION ALL // Data Camp // PostgreSQL


	 -- Begin your query by selecting all fields from economies2015.
	 --Create a second query that selects all fields from econom
	 --Perform a set operation to combine the two queries you just created, ensuring you do not return duplicates.

 -- Select all fields from economies2015
SELECT *
-- Set operation
FROM economies2015
-- Select all fields from economies2019
UNION
SELECT *
FROM economies2019
ORDER BY code, year;


    --Perform an appropriate set operation that determines all pairs of country code and year (in that order) from economies and populations, excluding duplicates.
    --Order by country code and year.

	
SELECT code, year
FROM economies
UNION
SELECT country_code, year
FROM populations

-- Amend the query to return all combinations (including duplicates) of country code and year in the economies or the populations tables.

SELECT code, year
FROM economies
-- Set theory clause
UNION ALL
SELECT country_code, year
FROM populations
ORDER BY code, year;