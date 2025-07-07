-- Date and time data types //PostgreSQL

--Select the rental date and return date from the rental table.
-- Add an INTERVAL of 3 days to the rental_date to calculate the expected return date`.

SELECT
 	-- Select the rental and return dates
	rental_date,
	return_date,
 	-- Calculate the expected_return_date
	rental_date + INTERVAL'3 days' AS expected_return_date
FROM rental;
