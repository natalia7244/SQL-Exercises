-- LIKE, TSVECTOR, TSQUERY

-- Select all columns
SELECT *
FROM film
-- Select only records that begin with the word 'GOLD'
WHERE title LIKE 'GOLD%';

SELECT *
FROM film
-- Select only records that end with the word 'GOLD'
WHERE title LIKE '%GOLD';

SELECT *
FROM film
-- Select only records that contain the word 'GOLD'
WHERE title LIKE '%GOLD%';

-- Select the film description as a tsvector
SELECT to_tsvector(description)
FROM film;

-- Select the title and description
SELECT title,description
FROM film
-- Convert the title to a tsvector and match it against the tsquery 
WHERE to_tsvector(title) @@ to_tsquery('elf');