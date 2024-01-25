use stolen_vehicles_db;

-- 1. Total number of tables in database--
show tables;

-- 2. Total number of rows in each table --
SELECT 
    COUNT(*) as 'Count'
FROM
    locations;
    
SELECT 
    COUNT(*) as 'Count'
FROM
    stolen_vehicles;
    
SELECT 
    COUNT(*) as 'Count'
FROM
    make_details;

-- 3. Structure and description of each table
DESCRIBE locations;
DESCRIBE stolen_vehicles;
DESC make_details;

-- 4. What are the car types present?
SELECT 
    *
FROM
    stolen_vehicles;
SELECT DISTINCT
    (vehicle_type)
FROM
    stolen_vehicles;

-- 5.	What are the top ten most occurring car types
SELECT 
    vehicle_type , COUNT(vehicle_type) as 'Count'
FROM
    stolen_vehicles
GROUP BY vehicle_type
ORDER BY COUNT(vehicle_type) DESC
LIMIT 10;

-- 6.	What is the number of each car type stolen (a comparison)?
SELECT 
    vehicle_type, COUNT(vehicle_type) as 'Count'
FROM
    stolen_vehicles
GROUP BY vehicle_type;

-- 7.	What model year are most popular among stolen vehicles (a comparison)?
SELECT 
    model_year, COUNT(model_year) as 'Count'
FROM
    stolen_vehicles
GROUP BY model_year
ORDER BY COUNT(model_year) DESC;

-- 8.	What model year are most popular among stolen vehicles (a comparison), 
-- considering only models from year 2000 and above?
SELECT 
    model_year, COUNT(model_year) as 'Count'
FROM
    stolen_vehicles
WHERE
    model_year >= 2000
GROUP BY model_year
ORDER BY COUNT(model_year) DESC;

-- 9.	What color of vehicles are mostly stolen?
SELECT 
    *
FROM
    stolen_vehicles;
SELECT 
    color, COUNT(color)
FROM
    stolen_vehicles
GROUP BY color
ORDER BY COUNT(color) DESC;

-- bonus
SELECT 
    model_year, color, COUNT(*) as 'Count'
FROM
    stolen_vehicles
GROUP BY model_year , color
ORDER BY model_year DESC;

-- 10.	Retrieve all information about stolen vehicles, 
-- including the vehicle type, make name, model year, color, and date stolen.
SELECT 
    *
FROM
    stolen_vehicles;

-- 11.	Find the total number of stolen vehicles in each region
SELECT 
    sv.location_id, lc.region, COUNT(*) AS 'Count'
FROM
    stolen_vehicles sv
        JOIN
    locations lc ON lc.location_id = sv.location_id
GROUP BY location_id
ORDER BY COUNT(*) DESC;

-- 12.	List the unique vehicle types present in the ‘stolen_vehicles’ table.
SELECT DISTINCT(vehicle_type)
FROM
    stolen_vehicles;

-- 13.	Count the total number of stolen vehicles for each make type.
SELECT 
    vehicle_type, COUNT(*) as 'Count'
FROM
    stolen_vehicles
GROUP BY vehicle_type;

-- 14.	Retrieve the details of stolen vehicles with a model year greater than 2010,
-- ordered by date stolen in descending order.
SELECT 
    *
FROM
    stolen_vehicles
WHERE
    model_year > 2010;

-- 15.	Find the top 5 regions with the highest population density.
SELECT 
    *
FROM
    locations
ORDER BY density DESC
LIMIT 5;

-- 16.	List the makes with more 
-- than 50 stolen vehicles and the total count of stolen vehicles for each
SELECT 
    nt.make_id, nt.occurence
FROM
    (SELECT 
        make_id, COUNT(make_id) AS 'Occurence'
    FROM
        stolen_vehicles
    GROUP BY make_id) nt
WHERE
    nt.occurence > 50
ORDER BY nt.occurence DESC;

-- 17.	Determine the average population density for each country.
SELECT 
    country, AVG(density)
FROM
    locations
GROUP BY country;

-- 18.	Identify the country with the highest percentage of stolen
-- vehicles compared to its total population.
SELECT 
    *
FROM
    stolen_vehicles;

SELECT 
    location_id,
    ((COUNT(location_id) / (SELECT COUNT(*) FROM stolen_vehicles)) * 100) AS 'Percentage'
FROM
    stolen_vehicles
GROUP BY location_id
ORDER BY ((COUNT(location_id) / (SELECT COUNT(*) FROM stolen_vehicles)) * 100) DESC;


SELECT 
    sv.location_id,
    lc.region,
    ((COUNT(sv.location_id) / (SELECT COUNT(*) FROMvstolen_vehicles)) * 100) AS 'Percentage',
    lc.population
FROM
    stolen_vehicles sv
        JOIN
    locations lc ON lc.location_id = sv.location_id
GROUP BY location_id
ORDER BY ((COUNT(sv.location_id) / (SELECT COUNT(*) FROMvstolen_vehicles)) * 100) DESC;

-- 19.	Find the region where the highest number of vehicles of a 
-- specific color have been stolen: say, silver.
SELECT 
    sv.location_id,
    lc.region,
    COUNT(*) AS 'Total Number',
    sv.color
FROM
    stolen_vehicles sv
        JOIN
    locations lc ON lc.location_id = sv.location_id
WHERE
    sv.color = 'silver'
GROUP BY location_id
ORDER BY COUNT(*) DESC;

-- 20.	Retrieve the details of the oldest stolen vehicle for each make type. ***

SELECT DISTINCT
    (vehicle_type), MIN(date_stolen)
FROM
    stolen_vehicles
GROUP BY vehicle_type; 

-- 21.	Calculate the average number of stolen vehicles per year for each vehicle type. ***
SELECT 
    vehicle_type, YEAR(date_stolen), COUNT(*) AS 'Count'
FROM
    stolen_vehicles
GROUP BY YEAR(date_stolen) , vehicle_type;

-- 22.	Retrieve the total number of stolen vehicles for each make name.
SELECT 
    mk.make_name, COUNT(*) AS 'Count'
FROM
    stolen_vehicles sv
        JOIN
    make_details mk ON mk.make_id = sv.make_id
GROUP BY sv.make_id;

-- 23.	List the regions and countries with no reported stolen vehicles. ***

-- 'Structure of database does not allow for the above query to be logical.'


-- 24.	Find the most recent stolen vehicle for each vehicle type. ***

SELECT DISTINCT
    (vehicle_type), MAX(date_stolen)
FROM
    stolen_vehicles
GROUP BY vehicle_type;


-- 25.	Count the total number of stolen vehicles for each color. (Done Above)
SELECT 
    *
FROM
    stolen_vehicles;
SELECT 
    color, COUNT(color)
FROM
    stolen_vehicles
GROUP BY color
ORDER BY COUNT(color) DESC;

-- 26.	List the make names along with the number of distinct models for each.
SELECT 
    sv.vehicle_type, mk.make_name, COUNT(*)
FROM
    stolen_vehicles sv
        JOIN
    make_details mk ON mk.make_id = sv.make_id
GROUP BY sv.vehicle_type , mk.make_name
ORDER BY vehicle_type DESC;

-- 27.	Retrieve the details of stolen vehicles with a specific color (black), ordered by date stolen.
SELECT 
    *
FROM
    stolen_vehicles
WHERE
    color = 'black'
ORDER BY date_stolen DESC;


-- 28.	Find the top 3 countries with the highest number of stolen vehicles.
SELECT 
    sv.location_id,
    lc.region,
    COUNT(*) AS 'Total Number',
    sv.color
FROM
    stolen_vehicles sv
        JOIN
    locations lc ON lc.location_id = sv.location_id
GROUP BY location_id
ORDER BY COUNT(*) DESC
LIMIT 3;

-- 29.	Calculate the average model year of stolen vehicles for each region.
SELECT 
    sv.location_id,
    lc.region,
    ROUND(AVG(sv.model_year)) AS 'Total Number'
FROM
    stolen_vehicles sv
        JOIN
    locations lc ON lc.location_id = sv.location_id
GROUP BY lc.region
ORDER BY AVG(sv.model_year) DESC;

-- 30.	List the top 10 most stolen vehicle types and their total count. (done above)
SELECT 
    vehicle_type, COUNT(*) AS 'Count'
FROM
    stolen_vehicles
GROUP BY vehicle_type
ORDER BY COUNT(*) DESC
LIMIT 10;

-- 31.	Determine the percentage of stolen vehicles for each make type.
SELECT 
    vehicle_type,
    ((COUNT(vehicle_type) / (SELECT 
            COUNT(*)
        FROM
            stolen_vehicles)) * 100) AS Percentage
FROM
    stolen_vehicles
GROUP BY vehicle_type
ORDER BY ((COUNT(vehicle_type) / (SELECT 
        COUNT(*)
    FROM
        stolen_vehicles)) * 100) DESC;


-- 32.	Identify the country with the highest total number of stolen vehicles per capita.
with cte_one as
(SELECT 
    lc.region, COUNT(sv.location_id) AS 'Count', lc.population
FROM
    stolen_vehicles sv
        JOIN
    locations lc ON lc.location_id = sv.location_id
GROUP BY sv.location_id)
select region, Count, population, (Count/population) as 'Car Stolen Per Capita' from cte_one;


-- 33.	Find the regions where the number of stolen vehicles is above the average for that region.
 with cte_two as
 (SELECT 
    sv.location_id, lc.region, lc.country, COUNT(*) AS 'Count'
FROM
    stolen_vehicles sv
        JOIN
    locations lc ON sv.location_id = lc.location_id
GROUP BY lc.region)
 select * from cte_two where Count>(select avg(Count) from cte_two);
 

-- 34.	Retrieve the details of the oldest stolen vehicle for each color.
SELECT DISTINCT
    (color), MIN(date_stolen) as 'Date'
FROM
    stolen_vehicles
GROUP BY color;

-- 35.	Calculate the average population density for regions with more than 100 stolen vehicles.
with cte_two as
 (SELECT 
    sv.location_id as 'Location ID',
    lc.region,
    lc.country,
    COUNT(*) AS 'Count',
    density
FROM
    stolen_vehicles sv
        JOIN
    locations lc ON sv.location_id = lc.location_id
GROUP BY lc.region)
 select * from cte_two where Count>100;
 
-- 36.	Identify the country with the highest percentage increase in stolen vehicles compared to the previous year.

-- 'Structure of database does not allow for the above query to be logical.'


-- 37.	List the top 10 vehicle types with the highest average model year.
SELECT DISTINCT
    (vehicle_type) AS 'Vehicle Type',
    MAX(model_year) AS 'Model Year'
FROM
    stolen_vehicles
GROUP BY vehicle_type
ORDER BY MAX(model_year) DESC
LIMIT 10;

-- 38.	Retrieve the count of stolen vehicles for each model year above 2000

SELECT 
    model_year AS 'Model Yaer', COUNT(vehicle_id) AS 'Count'
FROM
    stolen_vehicles
WHERE
    model_year >= 2000
GROUP BY model_year
ORDER BY model_year DESC;

-- 39. Calculate the standard deviation of the population density for the country.

SELECT 
    STDDEV(density) as 'STDEV of Population Density'
FROM
    locations;

-- 40.	is there any correlation between day of month and number of vehicles stolen?

SELECT DISTINCT
    (DAYOFMONTH(date_stolen)) as 'Day of Month', COUNT(*) as 'Count'
FROM
    stolen_vehicles
GROUP BY DAYOFMONTH(date_stolen)
ORDER BY DAYOFMONTH(date_stolen) ASC;










