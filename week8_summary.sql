CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS staging.sql_glossary AS (
	SELECT * FROM read_csv_auto('data/sql_terms.csv')
);

/* duckdb specific, many other SQL dialects don't have these */

-- index
SELECT
	sql_word,
	sql_word[0],  -- count from 1
	sql_word[1], 
	sql_word[-1], 
FROM
	staging.sql_glossary;

-- slicing
SELECT
	sql_word,
	sql_word[:2],
	sql_word[2:5]
FROM
	staging.sql_glossary;

-- removes leading and trailing spaces 
SELECT
	trim(sql_word, ' ') as trimmed_word,
	trimmed_word[1],
	trimmed_word[-1]
FROM
	staging.sql_glossary;

-- transform character to uppercase
SELECT
	upper(trim(sql_word, ' ')) as trimmed_word,
	trimmed_word[1],
	trimmed_word[-1]
FROM
	staging.sql_glossary;

-- replace 2 more spaces with 1 space
SELECT
	description, 
	replace(description, '  ', ' ') as cleaned_description
FROM
	staging.sql_glossary;

-- concatenate strings
SELECT 
	concat(upper(trim(sql_word)), ' command') as sql_command
FROM staging.sql_glossary;

-- extract substrings
SELECT 
	substring(trim(sql_word), 1, 5) as extracted_word
FROM staging.sql_glossary

-- reverse characters
SELECT 
	reverse(substring(trim(sql_word), 1, 5)) as reversed_word
FROM staging.sql_glossary

-- find the position of the first occurence of a substring
-- return zero if the substring is not found
SELECT 
	description, 
	instr(description, 'select') as select_position,
	select_position != 0 as about_select
FROM staging.sql_glossary

-- concatenation
SELECT 'fun' || ' joke'

-- pattern matching - like operator
SELECT
  	example,
  	lower(trim(example)) as cleaned_example
FROM
	staging.sql_glossary
WHERE
	cleaned_example LIKE 'select%';


-- use regexp_matches function with WHERE calsue to filter rows
-- to filter rows starting with c
SELECT
  	lower(trim(description)) as cleaned_description
FROM
	staging.sql_glossary
WHERE 
	regexp_matches(cleaned_description, '^c');

-- [a-f] matches a range of characters
-- ^[a-f] means starting with characters a to f
SELECT
	lower(trim(description)) as cleaned_description
FROM
	staging.sql_glossary
WHERE 
  	regexp_matches (cleaned_description, '^[a-f]')

-- use regexp_replace function to replace a pattern with a string
-- ' +' matches 1 or more spaces
-- 'g' is the global flag to replace all occurences of the pattern
SELECT
	description,
	regexp_replace (description, ' +', ' ', 'g') AS cleaned_description,
FROM
	staging.sql_glossary;