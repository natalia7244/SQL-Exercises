-- Subqueries in the FROM statment // Data Camp // 

--Create the subquery to be used in the next step, which selects the country ID and match ID (id) from the match table.

SELECT 
	-- Select the country ID and match ID
    country_id
FROM match 
-- Filter for matches with 10 or more goals in total
WHERE (home_goal+ away_goal) >= 10;

--You'll generate a count of matches in each country where the total goals is higher than 10. 
	
	-- Select country name and the count match IDs
    SELECT c.name AS country_name,
    COUNT(sub.id) AS matches
FROM country AS c
-- Inner join the subquery onto country
-- Select the country id and match id columns
INNER JOIN (SELECT  country_id, id 
           FROM match
           -- Filter the subquery by matches with 10+ goals
           WHERE (home_goal + away_goal) >= 10) AS sub
ON c.id = sub.country_id
GROUP BY country_name;

--Let's find out some more details about those matches -- when they were played, during which seasons, and how many of the goals were home versus away goals.

SELECT
	-- Select country, date, home, and away goals from the subquery
    country,
    date,
    home_goal,
    away_goal
FROM 
	-- Select country name, date, home_goal, away_goal, and total goals in the subquery
	(SELECT c.name AS country, 
     	    m.date, 
     		m.home_goal, 
     		m.away_goal,
           (m.home_goal + m.away_goal) AS total_goals
    FROM match AS m
    LEFT JOIN country AS c
    ON m.country_id = c.id) AS subq
-- Filter by total goals scored in the main query
WHERE total_goals >= 10;

