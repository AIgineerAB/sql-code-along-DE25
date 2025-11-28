/* Task 2 */
-- find invalid emails
-- use LIKE operator with wildcards for the old data
SELECT * FROM staging.crm_old_raw
WHERE NOT email LIKE '%@%.%';

-- use REGEXP functions for the new data
-- because the above query cannot deal with the new data
SELECT * FROM staging.crm_new_raw
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+');

-- combine all three conditions
SELECT * FROM staging.crm_old_raw
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+') OR
      NOT region IN ('EU', 'US') OR
      NOT status IN ('active', 'inactive');

SELECT * FROM staging.crm_new_raw
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+') OR
      NOT region IN ('EU', 'US') OR
      NOT status IN ('active', 'inactive');

/* Task 3 */