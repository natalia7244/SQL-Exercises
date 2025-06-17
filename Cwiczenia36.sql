-- Getting started with corralated subqueries & Nested subqueries // Data Camp // PostgreSQL

--In this exercise, you will practice using correlated subqueries to examine matches with scores that are extreme outliers for each country—above 3 times the average score!

SELECT 
	main.country_id,
    main.date,
    main.home_goal,
    main.away_goal
FROM match AS main
WHERE 
	-- Filter the main query by the subquery
	(home_goal + away_goal) > 
        (SELECT AVG((sub.home_goal + sub.away_goal) * 3)
         FROM match AS sub
         -- Join the main query to the subquery in WHERE
         WHERE main.country_id = sub.country_id);

-- In this exercise, you're going to add an additional column for matching to answer the question—what was the highest scoring match for each country, in each season?

SELECT 
	main.country_id,
    main.date,
    main.home_goal,
    main.away_goal
FROM match AS main
WHERE 
	-- Filter for matches with the highest number of total goals scored
	(home_goal + away_goal) = 
        (SELECT MAX(sub.home_goal + sub.away_goal)
         FROM match AS sub
         -- Join the main query to the subquery in WHERE
         WHERE main.country_id = sub.country_id
               AND main.season = sub.season);

--You'll compare the maximum number of goals scored in a single match across each season against the maximum for the England Premier League.

SELECT 
    season,
    MAX(home_goal + away_goal) AS max_goals,
    (SELECT MAX(home_goal + away_goal) 
     FROM match 
     WHERE season = main.season
     -- Subquery to get the max goals in a Premier League match for the same season
     AND country_id IN (SELECT country_id
                        FROM league
                        WHERE name ='England Premier League' 
                        AND season = main.season)
    ) AS pl_max_goals
FROM match AS main
GROUP BY season;

--What's the average number of matches per season where a team scored 5 or more goals? How does this differ by country?

SELECT
	c.name AS country,
    -- Calculate the average matches per season
	AVG(outer_s.matches) AS avg_seasonal_high_scores
FROM country AS c
-- Left join outer_s to country
LEFT JOIN (
  SELECT country_id, season,
         COUNT(id) AS matches
  FROM (
    SELECT country_id, season, id
	FROM match
	WHERE home_goal >= 5 OR away_goal >= 5) AS inner_s
  -- Close parentheses and alias the subquery
  GROUP BY country_id, season) AS outer_s
ON c.id = outer_s.country_id
GROUP BY country;