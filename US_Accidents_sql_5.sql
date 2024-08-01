---Basic Queries----
--1.Count the total number of accidents:
SELECT COUNT(*) AS Total_Accidents
FROM us_accidents;

--2.Find the total number of accidents in a specific state (e.g., California):
SELECT COUNT(*) AS Total_Accidents_California
FROM us_accidents
WHERE state = 'CA';

--3.Retrieve all unique accident severity levels:
SELECT DISTINCT severity
FROM us_accidents;

--4.List the top 5 cities with the most accidents:
SELECT city, COUNT(*) AS Total_Accidents
FROM us_accidents
GROUP BY city
ORDER BY Total_Accidents DESC
LIMIT 5;


---Intermediate Queries---
--1.Find the average number of accidents per day:
SELECT AVG(daily_accidents) AS Average_Accidents_Per_Day
FROM (
    SELECT DATE(start_time) AS accident_date, COUNT(*) AS daily_accidents
    FROM us_accidents
    GROUP BY accident_date
) AS daily_stats;

--2.Calculate the total number of accidents for each severity level:
SELECT severity, COUNT(*) AS Total_Accidents
FROM us_accidents
GROUP BY severity
ORDER BY Total_Accidents DESC;

--3.Find the percentage of accidents that occurred at night (assuming night is between 6 PM and 6 AM):
SELECT 
    (COUNT(*) FILTER (WHERE EXTRACT(HOUR FROM start_time) >= 18 OR EXTRACT(HOUR FROM start_time) < 6) * 100.0 / COUNT(*)) AS Night_Accident_Percentage
FROM us_accidents;

--4.List the top 10 most common weather conditions during accidents:
SELECT weather_condition, COUNT(*) AS Total_Accidents
FROM us_accidents
GROUP BY weather_condition
ORDER BY Total_Accidents DESC
LIMIT 10;


---Advanced Queries---
--1.Identify the month with the highest number of accidents in the year 2020:
SELECT EXTRACT(MONTH FROM start_time) AS Month, COUNT(*) AS Total_Accidents
FROM us_accidents
WHERE EXTRACT(YEAR FROM start_time) = 2020
GROUP BY Month
ORDER BY Total_Accidents DESC
LIMIT 1;

--2.Determine the average accident duration in minutes:
SELECT AVG(EXTRACT(EPOCH FROM (end_time - start_time)) / 60) AS Average_Duration_Minutes
FROM us_accidents;

--3.Find the city with the highest average accident severity:
SELECT city, AVG(severity) AS Average_Severity
FROM us_accidents
GROUP BY city
ORDER BY Average_Severity DESC
LIMIT 1;

--4.Calculate the correlation between accident severity and temperature:
SELECT CORR(severity, temperature) AS Severity_Temperature_Correlation
FROM us_accidents
WHERE temperature IS NOT NULL;

--5.Identify trends in accident occurrences over the years:
SELECT EXTRACT(YEAR FROM start_time) AS Year, COUNT(*) AS Total_Accidents
FROM us_accidents
GROUP BY Year
ORDER BY Year;

--6.Find the top 5 states with the longest average accident duration:
SELECT state, AVG(EXTRACT(EPOCH FROM (end_time - start_time)) / 60) AS Average_Duration_Minutes
FROM us_accidents
GROUP BY state
ORDER BY Average_Duration_Minutes DESC
LIMIT 5;

--7.Determine if there is a significant increase in accidents during weekends compared to weekdays:
SELECT 
    CASE 
        WHEN EXTRACT(DOW FROM start_time) IN (0, 6) THEN 'Weekend'
        ELSE 'Weekday'
    END AS Day_Type,
    COUNT(*) AS Total_Accidents
FROM us_accidents
GROUP BY Day_Type
ORDER BY Day_Type;


---Summary---
--This set of SQL queries progressively increases in complexity, starting with basic data retrieval and aggregation, 
--moving to intermediate analysis, and concluding with advanced statistical and trend analysis.
--Each query provides insights into different aspects of the US accident dataset, from counting total accidents 
--to determining correlations and trends.