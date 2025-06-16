-- Subqueries in SELECT statment // Data Camp // PostgreSQL

--In the following exercise, you will construct a query that calculates the average number of goals per match in each country's league.

SELECT 
	l.name AS league,
    -- Select and round the league's total goals
    ROUND(AVG(m.home_goal + m.away_goal), 2) AS avg_goals,
    -- Select & round the average total goals for the season
    (SELECT ROUND(AVG(home_goal + away_goal), 2) 
     FROM match
     WHERE season LIKE '2013/2014') AS overall_avg
FROM league AS l
LEFT JOIN match AS m
ON l.country_id = m.country_id
-- Filter for the 2013/2014 season
WHERE m.season LIKE '2013/2014'
GROUP BY l.name;

--In this exercise, you will add a column that directly compares these values by subtracting the overall average from the subquery.

SELECT
	-- Select the league name and average goals scored
	l.name AS league,
	ROUND(AVG(m.home_goal + m.away_goal),2) AS avg_goals,
    -- Subtract the overall average from the league average
	ROUND(AVG(m.home_goal + m.away_goal) - 
		(SELECT AVG(home_goal + away_goal)
		 FROM match 
         WHERE season LIKE '2013/2014'),2) AS diff
FROM league AS l
LEFT JOIN match AS m
ON l.country_id = m.country_id
-- Only include 2013/2014 results
WHERE m.season LIKE '2013/2014'
GROUP BY l.name;

--ALL the subqueries EVERYWHERE

--1
SELECT 
	-- Select the stage and average goals for each stage
	m.stage,
    ROUND(AVG(m.home_goal + m.away_goal),2) AS avg_goals,
    -- Select the average overall goals for the 2012/2013 season
    ROUND((SELECT AVG(home_goal+ away_goal) 
           FROM match 
           WHERE season LIKE '2012/2013'),2) AS overall
FROM match AS m
-- Filter for the 2012/2013 season
WHERE season LIKE '2012/2013'
-- Group by stage
GROUP BY m.stage;

--2
SELECT 
	-- Select the stage and average goals from the subquery
	s,stage,
	ROUND(avg_goals,2) AS avg_goals
FROM 
	-- Select the stage and average goals in 2012/2013
	(SELECT
		 stage,
         AVG(home_goal+ away_goal) AS avg_goals
	 FROM match
	 WHERE season LIKE '2012/2013'
	 GROUP BY stage) AS s
WHERE 
	-- Filter the main query using the subquery
	s.avg_goals > (SELECT AVG(home_goal+ away_goal) 
                    FROM match WHERE season LIKE '2012/2013');

--3
SELECT 
	-- Select the stage and average goals from s
	s.stage,
    ROUND(avg_goals,2) AS avg_goal,
    -- Select the overall average for 2012/2013
    (SELECT AVG(home_goal + away_goal) FROM match WHERE season LIKE '2012/2013') AS overall_avg
FROM 
	-- Select the stage and average goals in 2012/2013
	(SELECT
		 stage,
         AVG(home_goal+ away_goal) AS avg_goals
	 FROM match
	 WHERE season LIKE '2012/2013'
	 GROUP BY stage) AS s
WHERE 
	-- Filter the main query using the subquery
	s.avg_goals > (SELECT AVG(home_goal+ away_goal) 
                    FROM match WHERE season LIKE '2012/2013');