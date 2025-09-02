-- Spotting character data problems // DataCamp // PostgreSQL

-- Start by examining the most frequent values in some of these columns to get familiar with the common categories.

-- Select the count of each level of priority
SELECT priority, count(*)
  FROM evanston311
 GROUP BY priority;

 -- Find values of zip that appear in at least 100 rows
-- Also get the count of each value
SELECT zip, count(*)
  FROM evanston311
 GROUP BY zip
HAVING count(*) > 100; 

-- Find values of source that appear in at least 100 rows
-- Also get the count of each value
SELECT source, count(*)
  FROM evanston311
 GROUP BY source
HAVING count(*) >= 100

-- Find the 5 most common values of street and the count of each
SELECT street, count(*)
  FROM evanston311
 GROUP BY street
 ORDER BY count(*) DESC
 LIMIT 5;