-- Data Camp / PostgreSQL

--Compute the average revenue per employee for Fortune 500 companies by sector.

-- Select average revenue per employee by sector
SELECT sector, 
       AVG(revenues/employees::numeric) AS avg_rev_employee
  FROM fortune500
 GROUP BY sector
 -- Use the column alias to order the results
 ORDER BY avg_rev_employee;

 -- Divide unanswered_count by question_count
SELECT unanswered_count/question_count::numeric AS computed_pct, 
       -- What are you comparing the above quantity to?
      unanswered_pct 
  FROM stackoverflow
 -- Select rows where question_count is not 0
 WHERE question_count IS NOT NULL
LIMIT 10;


--Summarize the profit column in the fortune500 table using the functions you've learned.

-- Select sector and summary measures of fortune500 profits
SELECT sector,
      MIN(profits),
       AVG(profits),
       MAX(profits),
       STDDEV(profits)
  FROM fortune500
 -- What to group by?
 GROUP BY sector
 -- Order by the average profits
 ORDER BY AVG;

 -- Compute standard deviation of maximum values
SELECT min(maxval),
	   -- min
       max(maxval),
       -- max
       stddev(maxval),
       -- avg
       avg(maxval)
  -- Subquery to compute max of question_count by tag
  FROM (SELECT max(question_count) AS maxval
          FROM stackoverflow
         -- Compute max by...
         GROUP BY tag) AS max_results; -- alias for subquery