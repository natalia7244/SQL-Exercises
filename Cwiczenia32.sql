-- Data Manipulation // Data Camp // PostgreSQL

-- Create a CASE WHEN statement counting the matches played in the "2012/2013" season.

SELECT 
	c.name AS country,
    -- Count matches in 2012/13
	COUNT(CASE WHEN m.season = '2012/2013' THEN 1 END) AS matches_2012_2013,
    -- Count matches in 2013/14
	COUNT(CASE WHEN m.season = '2013/2014' THEN 1  END) AS matches_2013_2014
FROM country AS c
LEFT JOIN match AS m
ON c.id = m.country_id
GROUP BY country;

--Create a CASE statement to calculate the total number of home goals where the hometeam_id is 8560.
SELECT season,
	-- SUM the home goals
    SUM(CASE WHEN hometeam_id = 8560 THEN home_goal END) AS home_goals,
    -- SUM the away goals
    SUM(CASE WHEN awayteam_id = 8560 THEN away_goal END) AS away_goals
FROM match
-- Group the results by season
GROUP BY season

--Your task is to examine the number of wins, losses, and ties in each country. The matches table is filtered to include all matches from the 2013/2014 and 2014/2015 seasons.

SELECT 
	c.name AS country,
    -- Calculate the percentage of tied games in each season
	AVG(CASE WHEN m.season='2013/2014' AND m.home_goal = m.away_goal THEN 1
			WHEN m.season='2013/2014' AND m.home_goal != m.away_goal THEN 0
			END) AS ties_2013_2014,
	AVG(CASE WHEN m.season='2014/2015'AND m.home_goal = m.away_goal THEN 1
			WHEN m.season='2014/2015' AND m.home_goal != m.away_goal THEN 0
			END) AS ties_2014_2015
FROM country AS c
LEFT JOIN matches AS m
ON c.id = m.country_id
GROUP BY country;