-- ARRAY data types // PostgreSQL

--Select all films that have a special feature Trailers by filtering on the first index of the special_features ARRAY.

-- Select the title and special features column 
SELECT 
  title, 
  special_features 
FROM film
-- Use the array index of the special_features column
WHERE special_features[1] = 'Trailers';


-- Select all films that have Deleted Scenes in the second index of the special_features ARRAY.

-- Select the title and special features column 
SELECT 
  title, 
  special_features 
FROM film
-- Use the array index of the special_features column
WHERE special_features[2] = 'Deleted Scenes';

--Match 'Trailers' in any index of the special_features ARRAY regardless of position.

SELECT
  title, 
  special_features 
FROM film 
-- Modify the query to use the ANY function 
WHERE 'Trailers' = ANY(special_features)

--Use the contains operator to match the text Deleted Scenes in the special_features column.

SELECT 
  title, 
  special_features 
FROM film 
-- Filter where special_features contains 'Deleted Scenes'
WHERE special_features @> ARRAY['Deleted Scenes'];