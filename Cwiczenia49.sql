-- ROLLUP and CUBE, COALESCE,  STRING_AGG // Data Camp

--Count the gold medals awarded per country and gender.

SELECT
  Country,
  Gender,
  COUNT(*) AS Gold_Awards
FROM Summer_Medals
WHERE
  Year = 2004
  AND Medal = 'Gold'
  AND Country IN ('DEN', 'NOR', 'SWE')
GROUP BY Country, ROLLUP(Gender)
ORDER BY Country ASC, Gender ASC;

--Generate a breakdown of the medals awarded to Russia per country and medal type, including all group-level subtotals and a grand total.

-- Count the medals per gender and medal type
SELECT
  Gender,
  Medal,
  COUNT(*) AS Awards
FROM Summer_Medals
WHERE
  Year = 2012
  AND Country = 'RUS'
-- Get all possible group-level subtotals
GROUP BY CUBE(Gender, Medal)
ORDER BY Gender ASC, Medal ASC;

--Turn the nulls in the Country column to All countries, and the nulls in the Gender column to All genders.

SELECT
  -- Replace the nulls in the columns with meaningful text
  COALESCE(Country, 'All countries') AS Country,
  COALESCE(Gender, 'All genders') AS Gender,
  COUNT(*) AS Awards
FROM Summer_Medals
WHERE
  Year = 2004
  AND Medal = 'Gold'
  AND Country IN ('DEN', 'NOR', 'SWE')
GROUP BY ROLLUP(Country, Gender)
ORDER BY Country ASC, Gender ASC;

-- Return the top 3 countries by medals awarded as one comma-separated string.

WITH Country_Medals AS (
  SELECT
    Country,
    COUNT(*) AS Medals
  FROM Summer_Medals
  WHERE Year = 2000
    AND Medal = 'Gold'
  GROUP BY Country),

  Country_Ranks AS (
  SELECT
    Country,
    RANK() OVER (ORDER BY Medals DESC) AS Rank
  FROM Country_Medals
  ORDER BY Rank ASC)

-- Compress the countries column
SELECT STRING_AGG(Country, ', ' ORDER BY Rank) AS Countries_Ranked
FROM Country_Ranks
-- Select only the top three ranks
WHERE Rank <= 3;





