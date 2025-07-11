-- Custom type, custom function // DataCamp // PostgreSQL

-- Create an enumerated data type, compass_position
CREATE TYPE compass_position AS ENUM (
  	-- Use the four cardinal directions
  	'North', 
  	'West',
  	'East', 
  	'South'
);

-- Confirm the new data type is in the pg_type system table
SELECT *
FROM pg_type
WHERE typname='compass_position';



-- Select the column name, data type and udt name columns
SELECT column_name, data_type, udt_name
FROM INFORMATION_SCHEMA.COLUMNS 
-- Filter by the rating column in the film table
WHERE column_name ='rating' AND table_name = 'film';

SELECT *
FROM pg_type 
WHERE typname ='mpaa_rating'



-- Select the film title and inventory ids
SELECT 
	f.title, 
    i.inventory_id,
    -- Determine whether the inventory is held by a customer
    inventory_held_by_customer(i.inventory_id) as held_by_cust
FROM film as f 
	INNER JOIN inventory AS i ON f.film_id=i.film_id 
WHERE
	-- Only include results where the held_by_cust is not null
    inventory_held_by_customer(i.inventory_id) IS NOT NULL