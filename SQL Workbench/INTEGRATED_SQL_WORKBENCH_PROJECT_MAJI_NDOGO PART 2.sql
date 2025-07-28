-- PART 1/; CLEANING OUR DATASET // WE WILL BE USING THE EMPLOYEE TABLE FOR MOST OF THE PTOJECT
SELECT *
FROM employee;

-- First up, let's remove the space between the first and last names using REPLACE(). You can try this:
SELECT
REPLACE(employee_name, ' ','.') -- Replace the space with a full stop
FROM employee;

-- Then we can use LOWER() with the result we just got. Now the name part is correct.
SELECT
LOWER(REPLACE(employee_name, ' ','.')) -- Make it all lower case
FROM employee;

-- We then use CONCAT() to add the rest of the email address:
SELECT
CONCAT(LOWER(REPLACE(employee_name, ' ', '.')), '@ndogowater.gov') AS new_email -- add it all together
FROM employee;

-- Updating the table
UPDATE 
	employee
SET 
	email = CONCAT(LOWER(REPLACE(employee_name, ' ', '.')),'@ndogowater.gov');
    
-- Confirming
SELECT *
FROM employee;

-- Checking the phone number column include the employee name and position for errors
SELECT 
	phone_number,
    employee_name,
    position
FROM employee
WHERE length(phone_number) > 12;

-- The extra character seems to just be a space after the phone numbers so we will trim the extra space.
SELECT
	TRIM(
	phone_number)
FROM employee;

-- updating in the table
UPDATE employee
SET phone_number = TRIM(phone_number);

-- confirming
SELECT 
	phone_number,
    employee_name,
    position
FROM employee
WHERE length(phone_number) > 12; -- zero columns returned


-- PART 2: HONOURING THE WORKERS
-- How many employees per town
SELECT 
	COUNT(employee_name)AS employee_per_town,
    town_name
FROM employee
GROUP BY town_name;

-- Top 3 field surveyors 
-- Find those with the most number of locations visited
SELECT *
FROM visits;
SELECT
	assigned_employee_id,
    COUNT(visit_count) AS number_of_visits
FROM visits
GROUP BY assigned_employee_id
ORDER BY number_of_visits DESC
LIMIT 10;

-- Back to the employee table to identify the employees by their assigned_employee_id

SELECT
	employee_name,
    email,
    phone_number
FROM employee
WHERE assigned_employee_id	IN ( 1,30,34);

-- PART 3: ANALYSING LOCATIONS
-- Using the location table
-- Number pf records per town

SELECT 
	town_name,
    COUNT(location_type) AS records_per_town
FROM location
GROUP BY town_name
ORDER BY records_per_town DESC;

-- per province
SELECT 
	province_name,
    COUNT(location_type) AS records_per_province
FROM location
GROUP BY province_name
ORDER BY records_per_province DESC;

-- From this query, it's pretty clear that most of the water sources in the survey are situated in small rural communities, scattered across Maji Ndogo.
-- If we count the records for each province, most of them have a similar number of sources, so every province is well-represented in the survey.

-- EXERCISE
/*1. Create a result set showing:
• province_name
• town_name
• An aggregated count of records for each town (consider naming this records_per_town).
• Ensure your data is grouped by both province_name and town_name.
2. Order your results primarily by province_name. Within each province, further sort the towns by their record counts in descending order. */

SELECT
	province_name,
	town_name,
    COUNT(location_type) AS records_per_town
FROM location
GROUP BY town_name, province_name
ORDER BY province_name, records_per_town DESC;
-- This shows us that there is enough data to analyse our water crisis per town and province.

-- Number of records for each loaction type
SELECT
	DISTINCT(location_type),
	COUNT(address) AS records_per_location_type
FROM location
GROUP BY location_type;

-- From the query above we see that 60% of our water sources is in rural areas.

-- PART 4: DIVING INTO SOURCES
-- Using the water_source table
-- Number of people we surveyed in total

SELECT 
	SUM(number_of_people_served)
FROM water_source;

-- How many taps, wells and rivers are there
SELECT 
	type_of_water_source,
	COUNT(type_of_water_source) AS count_of_source_type
FROM water_source
GROUP BY type_of_water_source;

-- Number of people that share the water sources on average

SELECT
	type_of_water_source,
    ROUND(AVG(number_of_people_served))AS avg_people_served_per_water_source
FROM water_source
GROUP BY type_of_water_source
ORDER BY avg_people_served_per_water_source DESC;

-- Total number of people sharing
SELECT
	type_of_water_source,
    SUM(number_of_people_served) AS people_served_per_water_source
FROM water_source
GROUP BY type_of_water_source
ORDER BY people_served_per_water_source DESC;

-- - A rank based on the total people served, grouped by the types.

USE md_water_services;

SELECT 
    type_of_water_source,
    people_served_per_water_source,
    RANK() OVER (ORDER BY people_served_per_water_source DESC) AS rank_based_on_people_served
FROM (
    SELECT
        type_of_water_source,
        SUM(number_of_people_served) AS people_served_per_water_source
    FROM water_source
    GROUP BY type_of_water_source
) AS aggregated_data
ORDER BY rank_based_on_people_served;



-- // Question 1
/*To calculate how long the survey took, we need to get the first and last dates (which functions can find the largest/smallest value), and subtract
them. Remember with DateTime data, we can't just subtract the values. We have to use a function to get the difference in days.*/

SELECT 
	DATEDIFF(MAX(time_of_record),MIN(time_of_record)) AS survey_duration
FROM visits;

-- // Question 2
/*Let's see how long people have to queue on average in Maji Ndogo. Keep in mind that many sources like taps_in_home have no queues. These
are just recorded as 0 in the time_in_queue column, so when we calculate averages, we need to exclude those rows. Try using NULLIF() do to
this.*/

SELECT 
    AVG(NULLIF(time_in_queue, 0)) AS avg_queue_time
FROM visits;

-- // Question 3 - queue times aggregated across the different days of the week.

SELECT 
	DAYNAME(time_of_record) AS Day_of_the_week,
   ROUND( AVG(NULLIF(time_in_queue, 0))) AS avg_queue_time
FROM visits
GROUP BY Day_of_the_week;

-- Question 4 // We can also look at what time during the day people collect water. Try to order the results in a meaningful way.
SELECT 
TIME_FORMAT(TIME(time_of_record), '%H:00') AS hour_of_day,
   ROUND( AVG(NULLIF(time_in_queue, 0))) AS avg_queue_time
FROM visits
GROUP BY hour_of_day
ORDER BY hour_of_day ASC;

/*By adding AVG() around the CASE() function, we calculate the average, but since all of the other days' values are 0, we get an average for Sunday
only, rounded to 0 decimals. To aggregate by the hour, we can group the data by hour_of_day, and to make the table chronological, we also order
by hour_of_day.*/

SELECT
TIME_FORMAT(TIME(time_of_record), '%H:00') AS hour_of_day,
-- Sunday
ROUND(AVG(
CASE
WHEN DAYNAME(time_of_record) = 'Sunday' THEN time_in_queue
ELSE NULL
END
),0) AS Sunday,
-- Monday
ROUND(AVG(
CASE
WHEN DAYNAME(time_of_record) = 'Monday' THEN time_in_queue
ELSE NULL
END
),0) AS Monday
-- Tuesday
-- Wednesday
FROM
visits
WHERE
time_in_queue != 0 -- this excludes other sources with 0 queue times
GROUP BY
hour_of_day
ORDER BY
hour_of_day;

/*We create separate columns for each day with a CASE() function.*/ 
SELECT
TIME_FORMAT(TIME(time_of_record), '%H:00') AS hour_of_day,
-- Sunday
ROUND(AVG(
CASE
WHEN DAYNAME(time_of_record) = 'Sunday' THEN time_in_queue
ELSE NULL
END
),0) AS Sunday,
-- Monday
ROUND(AVG(
CASE
WHEN DAYNAME(time_of_record) = 'Monday' THEN time_in_queue
ELSE NULL
END
),0) AS Monday
-- Tuesday
-- Wednesday
FROM
visits
WHERE
time_in_queue != 0 -- this excludes other sources with 0 queue times
GROUP BY
hour_of_day
ORDER BY
hour_of_day;
