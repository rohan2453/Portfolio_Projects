
-- 1. Create a staging table for cleaning
DROP TABLE IF EXISTS lifestyle_staging;

CREATE TABLE lifestyle_staging AS
SELECT *
FROM student_lifestyle_dataset;

-- 2. Remove Duplicates
WITH duplicate_cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY Student_ID, Study_Hours_Per_Day, Extracurricular_Hours_Per_Day, 
                            Sleep_Hours_Per_Day, Social_Hours_Per_Day, Physical_Activity_Hours_Per_Day, 
                            GPA, Stress_Level
               ORDER BY Student_ID
           ) AS row_num
    FROM lifestyle_staging
)
DELETE FROM lifestyle_staging
WHERE Student_ID IN (
    SELECT Student_ID FROM duplicate_cte WHERE row_num > 1
);

-- 3. Standardize Column Names
ALTER TABLE lifestyle_staging RENAME COLUMN Physical_Activity_Hours_Per_Day TO PhysicalActivity_Hours_PerDay;

-- 4. Standardize Data Format and Trim Whitespaces
-- First, convert study hours to consistent format (optional if needed)
-- UPDATE statements for trimming whitespace (if any string columns exist)
-- Assuming GPA is decimal, convert column
ALTER TABLE lifestyle_staging MODIFY GPA DECIMAL(10,2);

-- If column types are already appropriate, this step can be skipped
-- Example: Clean column names for clarity (rename other columns if needed)
-- Standardizing selected column names (optional)
-- Use aliases in SELECT for future use
SELECT 
    Study_Hours_Per_Day AS Study_Hours_PerDay, 
    Extracurricular_Hours_Per_Day AS Extra_Activities_PerDay
FROM lifestyle_staging;

-- 5. Handle NULL or Blank Values
-- Example: Replace NULL or '' in Stress_Level with 'Unknown'
UPDATE lifestyle_staging
SET Stress_Level = 'Unknown'
WHERE Stress_Level IS NULL OR Stress_Level = '';

-- Handle other columns similarly if needed
-- Example for numeric columns
UPDATE lifestyle_staging
SET GPA = 0.00
WHERE GPA IS NULL;

-- 6. Drop unnecessary columns (if any)
-- Example:
-- ALTER TABLE lifestyle_staging DROP COLUMN Unwanted_Column;

-- 7. Final Clean Data Output
SELECT * FROM lifestyle_staging;
