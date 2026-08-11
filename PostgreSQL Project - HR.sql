CREATE TABLE human_resources (
    id TEXT,
    first_name TEXT,
    last_name TEXT,
    birthdate DATE,
    gender TEXT,
    race TEXT,
    department TEXT,
    jobtitle TEXT,
    location TEXT,
    hire_date DATE,
    termdate TEXT,
    location_city TEXT,
    location_state TEXT
);

SELECT COUNT(*)
FROM human_resources;

-----------------Explore the data

SELECT * FROM human_resources;

----------------- Q2: What's the gender breakdown in the company?
-- Description: Total headcount count grouped by gender for active employees.
SELECT
    gender,
    COUNT(*) AS count
FROM human_resources
WHERE termdate IS NULL
GROUP BY gender
ORDER BY gender ASC;

------------------ Q3: How does gender vary across departments and job titles?
-- Description: Counts active employees across each department broken down by gender.
SELECT 
    department, 
    gender, 
    COUNT(*) AS count
FROM human_resources
WHERE termdate IS NULL
GROUP BY department, gender
ORDER BY department, gender;

------ Description: Counts active employees across departments and specific job titles by gender.
SELECT 
    department, 
    jobtitle,
    gender,
    COUNT(*) AS count
FROM human_resources
WHERE termdate IS NULL
GROUP BY department, jobtitle, gender
ORDER BY department, jobtitle, gender ASC;

-------------- Q4: What's the race distribution in the company?
-- Description: Counts active employees grouped by racial background, sorted highest to lowest./ How many active employees belong to each racial background?	
SELECT	
race,
COUNT(*) AS count
FROM human_resources
WHERE termdate is NULL
GROUP BY race
ORDER BY count DESC;

--------------- Q5: What's the average length of employment (tenure) for departed employees?
-- Description: Calculates average tenure in years for employees who have left the company.
SELECT
    ROUND(
        AVG(
            (TO_DATE(termdate, 'YYYY-MM-DD') - hire_date) / 365.25
        ),
        2
    ) AS avg_tenure_years
FROM human_resources
WHERE termdate IS NOT NULL
  AND TRIM(termdate) <> '';

  ------------------ Q6: Which department has the highest turnover rate?
-- Description: Calculates turnover percentage per department (terminated staff / total department staff).
SELECT
    department,
    ROUND(
        SUM(CASE WHEN termdate IS NOT NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS turnover_rate
FROM human_resources
GROUP BY department
ORDER BY turnover_rate DESC
LIMIT 1;

----------------------- Q7: What is the tenure range (earliest hire to latest departure span) per department?
-- Description: Finds time elapsed between the earliest hire date and most recent termination per department.
SELECT
    department,
    DATE_PART('year', AGE(MAX(termdate::DATE), MIN(hire_date::DATE))) AS tenure_years
FROM human_resources
WHERE termdate IS NOT NULL
GROUP BY department
ORDER BY tenure_years DESC;

----------------------- Q8: How many active employees work remotely vs. on-site across departments?
-- Description: Counts active staff per work location type (e.g., Remote / Headquarter).
SELECT
    location,
    COUNT(*) AS count
FROM human_resources
WHERE termdate IS NULL
GROUP BY location;

----------------------- Q9: What's the distribution of active employees across different states?
-- Description: Aggregates active employee count geographically by state location.
SELECT
    location_state,
    COUNT(*) AS count
FROM human_resources
WHERE termdate IS NULL
GROUP BY location_state
ORDER BY count DESC;

------------------------- Q10: How are job titles distributed in the company?
-- Description: Ranks job titles by active employee count from most common to least common.
SELECT 
    jobtitle,
    COUNT(*) AS count
FROM human_resources
WHERE termdate IS NULL
GROUP BY jobtitle
ORDER BY count DESC;

--------------------------- Q11: How have employee hire counts, terminations, and net changes varied over time?
-- Description: Aggregates hires, terminations, net growth, and percent turnover change by year (safely handles division by zero).
SELECT
    EXTRACT(YEAR FROM hire_date::DATE) AS hire_year,
    COUNT(*) AS hires,
    COUNT(termdate) AS terminations,
    COUNT(*) - COUNT(termdate) AS net_change,
    ROUND(((COUNT(*) - COUNT(termdate)) * 100.0 / COUNT(*)), 2) AS percent_change
FROM human_resources
GROUP BY hire_year
ORDER BY hire_year;	













