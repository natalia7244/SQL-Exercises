-- CROSS JOIN AND SELF JOIN//  Data Camp // PostgreSQL

-- Complete the code to perform an INNER JOIN of countries AS c with languages AS l using the code field to obtain the languages currently spoken in the two countries.

SELECT c.name AS country, l.name AS language
-- Inner join countries as c with languages as l on code
FROM countries c
INNER JOIN languages AS L
USING (code)
WHERE c.code IN ('PAK','IND')
	AND l.code in ('PAK','IND');

-- Change your INNER JOIN to a different kind of join to look at possible combinations of languages that could have been spoken in the two countries given their history.
SELECT c.name AS country, l.name AS language
FROM countries AS c        
-- Perform a cross join to languages (alias as l)
CROSS JOIN languages l
WHERE c.code in ('PAK','IND')
	AND l.code in ('PAK','IND');


-- Complete the join of countries AS c with populations as p.
-- Filter on the year 2010.
-- Sort your results by life expectancy in ascending order.
-- Limit the result to five countries.

SELECT 
	c.name AS country,
    region,
    life_expectancy AS life_exp
FROM countries AS c
-- Join to populations (alias as p) using an appropriate join
INNER JOIN populations p
ON c.code = p.country_code
-- Filter for only results in the year 2010
WHERE p.year = 2010
-- Sort by life_exp
ORDER BY life_expectancy ASC
-- Limit to five records
LIMIT 5;


-- Perform an inner join of populations with itself ON country_code, aliased p1 and p2 respectively.
-- Select the country_code from p1 and the size field from both p1 and p2, aliasing p1.size as size2010 and p2.size as size2015 (in that order).

-- Select aliased fields from populations as p1
SELECT p1.country_code, p1.size AS size2010, p2.size AS size2015
-- Join populations as p1 to itself, alias as p2, on country code
FROM populations as p1
INNER JOIN populations as p2
ON p1.country_code = p2.country_code

-- Since you want to compare records from 2010 and 2015, eliminate unwanted records by extending the WHERE statement to include only records where the p1.year matches p2.year - 5.

SELECT 
	p1.country_code, 
    p1.size AS size2010, 
    p2.size AS size2015
FROM populations AS p1
INNER JOIN populations AS p2
ON p1.country_code = p2.country_code
WHERE p1.year = 2010
-- Filter such that p1.year is always five years before p2.year
    AND p2.year = p1.year +5