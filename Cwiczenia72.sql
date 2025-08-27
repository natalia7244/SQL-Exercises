-- DataCamp PostgreSQL

SELECT TRUNC(34.4564564, 2);
SELECT TRUNC(34.4564564, -2);

-- Truncate employees
SELECT trunc(employees, -5) AS employee_bin,
       -- Count number of companies with each truncated value
       count(trunc(employees, -5))
  FROM fortune500
 -- Use alias to group
 GROUP BY trunc(employees, -5)
 -- Use alias to order
 ORDER BY trunc(employees, -5);

 -- Repeat step 1 for companies with < 100,000 employees (most common). This time, truncate employees to the 10,000s place.
 
-- Truncate employees
SELECT trunc(employees, -4) AS employee_bin,
       -- Count number of companies with each truncated value
       count(trunc(employees, -4))
  FROM fortune500
 -- Limit to which companies?
 WHERE trunc(employees, -4)  < 100000
 -- Use alias to group
 GROUP BY employee_bin
 -- Use alias to order
 ORDER BY employee_bin;

 --Summarize the distribution of the number of questions with the tag "dropbox" on Stack Overflow per day by binning the data.

 -- Bins created in Step 2
WITH bins AS (
      SELECT generate_series(2200, 3050, 50) AS lower,
             generate_series(2250, 3100, 50) AS upper),
     -- Subset stackoverflow to just tag dropbox (Step 1)
     dropbox AS (
      SELECT question_count 
        FROM stackoverflow
       WHERE tag='dropbox') 
-- Select columns for result
-- What column are you counting to summarize?
SELECT lower, upper, count(question_count) 
  FROM bins  -- Created above
       -- Join to dropbox (created above), keeping all rows from the bins table in the join
       LEFT JOIN dropbox
       -- Compare question_count to lower and upper
         ON question_count >= lower 
        AND question_count < upper
 -- Group by lower and upper to count values in each bin
 GROUP BY lower, upper
 -- Order by lower to put bins in order
 ORDER BY lower;
