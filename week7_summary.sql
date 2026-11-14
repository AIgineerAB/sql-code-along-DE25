CREATE TABLE
    IF NOT EXISTS food AS (
SELECT
	*
FROM
	read_csv_auto('data/food_search_google.csv'));

--create a refined schema!!!

CREATE TABLE
    IF NOT EXISTS cleaned_food AS ( 
        SELECT
            id as food,
            week_id as week,
            SUBSTRING(week, 1, 4) as year,
            value as number_of_seraches --change to average!!!
        FROM
            food
    );

SELECT
    food,
    SUM(number_of_seraches) AS total_searches
FROM
    cleaned_food
GROUP BY
    food
ORDER BY
    total_searches DESC
LIMIT
    10;

SELECT
    year,
    SUM(number_of_seraches) AS total_searches
FROM
    cleaned_food
GROUP BY
    year
ORDER BY
    year;

SELECT
    year,
    SUM(number_of_seraches) AS total_searches
FROM
    cleaned_food
GROUP BY
    year
HAVING
    total_searches > 300_000
ORDER BY
    year;

-- group by 2 cols
SELECT
    year,
    food,
    SUM(number_of_seraches) AS total_searches
FROM
    cleaned_food
GROUP BY
    food,
    year
HAVING 
    food IN ('pizza', 'sushi')
ORDER BY food, year;

