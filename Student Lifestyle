-- Data Cleaning
-- 1. Remove Duplicates

CREATE TABLE lifestyle_stagging
LIKE student_lifestyle_dataset;

SELECT * 
FROM student_lifestyle_dataset;

INSERT lifestyle_stagging
SELECT *
FROM student_lifestyle_dataset;

SELECT *,
ROW_NUMBER() OVER(
Study_Hours_Per_Day) AS row_num
FROM lifestyle_stagging;

SELECT *
FROM duplicate_cte
WHERE row_num>1;

SELECT * FROM lifestyle_stagging;

-- 2. Standardize the Data 

SELECT Study_Hours_Per_Day AS Study_Hours_PerDay, Extracurricular_Hours_Per_Day AS Extra_Activities_PerDay
FROM lifestyle_stagging;
 
 
UPDATE lifestyle_stagging
SET Study_Hours_PerDay = trim(Study_Hours_Per_Day);

SELECT DISTINCT Study_Hours_Per_Day, trim(TRAILING '.' FROM Study_Hours_Per_Day)
FROM lifestyle_stagging;

SELECT CONVERT(Study_Hours_per_Day, DECIMAL(10, 2)) AS Study_Hours_Per_Day_in_decimal
FROM lifestyle_stagging;

ALTER TABLE lifestyle_stagging MODIFY GPA DECIMAL(10,2);

SELECT * FROM lifestyle_stagging;

SELECT * FROM student_lifestyle_dataset;

ALTER TABLE lifestyle_stagging
RENAME COLUMN Physical_Activity_Hours_Per_Day TO PhysicalActivity_Hours_PerDay;
