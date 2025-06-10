-- Filtering using scalar subqueries // Data Camp // PostgreSQL

-- Calculate triple the average home + away goals scored across all matches in a subquery.
SELECT 
	-- Select the date, home goals, and away goals scored
    date,
	home_goal,
	away_goal
FROM matches_2013_2014
-- Filter for matches where total goals exceeds 3x the average
WHERE (home_goal + away_goal) > 
       (SELECT 3 * AVG(home_goal + away_goal)
        FROM matches_2013_2014); 

-- Create a subquery in the WHERE clause that retrieves all unique hometeam_ID values from the match table.
-- Select the team_long_name and team_short_name from the team table. Exclude all values from the subquery in the main query.

SELECT 
	-- Select the team long and short names
	team_long_name,
	team_short_name
FROM team
-- Exclude all values from the subquery
WHERE team_api_id NOT IN
     (SELECT DISTINCT hometeam_id FROM match);

--  Create a subquery in WHERE clause that retrieves all hometeam_ID values from match with a home_goal score greater than or equal to 8.
--  Select the team_long_name and team_short_name from the team table. Include all values from the subquery in the main query.

SELECT
	-- Select the team long and short names
	team_long_name,
	team_short_name
FROM team
-- Filter for teams with 8 or more home goals
WHERE team_api_id IN
	  (SELECT hometeam_id
       FROM match
       WHERE home_goal >= 8);