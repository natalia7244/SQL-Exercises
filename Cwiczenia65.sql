-- Exploratory Date Analysis in SQL // PostgreSQL // DataCamp

-- Count the number of null values in the ticker column
SELECT count(*) - Count(ticker) AS missing
  FROM fortune500;



  SELECT company.name
-- Table(s) to select from
  FROM company
       INNER JOIN fortune500
       ON company.ticker = fortune500.ticker
	   

-- Count the number of tags with each type
SELECT type, count(tag) AS count
  FROM tag_type
 -- To get the count for each type, what do you need to do?
 GROUP BY type
 -- Order the results with the most common tag types listed first
 ORDER BY count DESC;


 -- Use coalesce
SELECT coalesce(industry, sector, 'Unknown') AS industry2,
       -- Don't forget to count!
       count(*)
  FROM fortune500
-- Group by what? (What are you counting by?)
 GROUP BY industry2
-- Order results to see most common first
 ORDER BY count(*) DESC
-- Limit results to get just the one value you want
LIMIT 1;