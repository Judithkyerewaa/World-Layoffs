-- Data Cleaning /* Investigating into trends and factors Contributing to Global Layoffs and Identifying Vulnerable Industries and Regions*/

USE world_layoffs;

SELECT *
FROM layoffs;
 
-- 1. REMOVE DUPLICATES
-- 2. STANDARDIZE THE DATA ( IF THERE ARE ISSUES WITH THE DATA LIKE SPELLINGS AND CORRECT THEM)
-- 3. NULL VALUES OR BLANK VALUES
-- 4. REMOVE ANY COLUMNS OR ROWS THAT ARE NOT NECESSARY FOR OUR ANALYSIS


CREATE TABLE layoffs_staging
LIKE layoffs;


SELECT *
FROM layoffs_staging;


INSERT INTO layoffs_staging
SELECT *
FROM layoffs;


-- REMOVING DUPLICATES FROM THE DATA BY ASSIGNING ROW NUMBERS (if the generated row number is 2 or above it means there are duplicates)
-- WE CREATED A ROW NUMBER BECAUSE THERE WAS NO UNIQUE COLUMN IN OUR DATA
WITH duplicate_cte AS (
SELECT *,
ROW_NUMBER () 
OVER( PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, 'date',
stage, country,funds_raised_millions) AS row_num
FROM layoffs_staging)
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;

SET SQL_SAFE_UPDATES = 0;

WITH duplicate_cte AS (
SELECT *,
ROW_NUMBER () 
OVER( PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, 'date',
stage, country,funds_raised_millions) AS row_num
FROM layoffs_staging)
DELETE
FROM duplicate_cte
WHERE row_num > 1;



-- CREATING A TABLE FOR THE DISTINCT VALUES IN THE DATA
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



select * from layoffs_staging2
WHERE row_num>1;



INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER () 
OVER( PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, 'date',
stage, country,funds_raised_millions) AS row_num
FROM layoffs_staging;


-- DELETING DUPLICATES FROM THE DATA
DELETE from layoffs_staging2
WHERE row_num>1;


select * from layoffs_staging2
WHERE row_num>1;


select * from layoffs_staging2;




-- STANDARDIZING DATA ( FINDING ISSUES IN THE DATA AND CLEANING THEM)
-- TRIMMING WHITE SPACES IN THE COMPANY NAMES

SELECT company, TRIM(company) 
FROM layoffs_staging2;


UPDATE layoffs_staging2
SET company = TRIM(company);


SELECT *
FROM layoffs_staging2
WHERE industry LIKE "Crypto%";

UPDATE layoffs_staging2
SET industry = "Crypto"
WHERE industry LIKE "Crypto%";


SELECT DISTINCT industry
FROM layoffs_staging2;


SELECT DISTINCT location
FROM layoffs_staging2;


SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;


SELECT DISTINCT country, TRIM(TRAILING "." FROM country)
FROM layoffs_staging2
ORDER BY 1;


UPDATE layoffs_staging2
SET country= TRIM(TRAILING "." FROM country)
WHERE country LIKE "United States%";



select date from layoffs_staging2;


SELECT date,
STR_TO_DATE(date, "%m/%d/%Y")
FROM layoffs_staging2;


UPDATE layoffs_staging2
SET date = STR_TO_DATE(date, "%m/%d/%Y");



ALTER TABLE layoffs_staging2
MODIFY COLUMN date DATE;





-- WORKING WITH NULL AND BLANK VALUES

SELECT * FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;



SELECT * FROM layoffs_staging2
WHERE industry IS NULL OR  industry ='';


SELECT * FROM layoffs_staging2
WHERE COMPANY = 'Airbnb';


SELECT * FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;



-- UPDATING BLANKS TO NULL VALUES
UPDATE layoffs_staging2
SET industry =  NULL
WHERE industry = '';


-- POPULATING NULL VALUES IN THE INDUSTRY COLUMN INTO THEIR APPROPRIATE INDUSTRIES

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL)
AND t2.industry IS NOT NULL;



SELECT * FROM layoffs_staging2
WHERE company LIKE 'Bally%';


SELECT * FROM layoffs_staging2;


-- DELETING ROWS WITH NULL VALUES FOR TOTAL LAID OFFS AND PERCENTAGE LAID OFFS

SELECT * FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;




DELETE FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


SELECT distinct industry FROM layoffs_staging2;



ALTER TABLE layoffs_staging2
DROP COLUMN row_num;




-- EXPLORATORY DATA ANALYSIS

SELECT * FROM layoffs_staging2;


SELECT MAX(total_laid_off), MAX(percentage_laid_off)
 FROM layoffs_staging2;
 
 
 
 SELECT * FROM layoffs_staging2
 WHERE percentage_laid_off = 1
 ORDER BY total_laid_off DESC;
 
 
 
 
 SELECT * FROM layoffs_staging2
 WHERE percentage_laid_off = 1
 ORDER BY funds_raised_millions DESC;
 
 
 SELECT company, SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY company
 ORDER BY SUM(total_laid_off) DESC;
 
 
SELECT MIN(date), MAX(date)
FROM layoffs_staging2;


SELECT industry, SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY industry
 ORDER BY SUM(total_laid_off) DESC;
 
 
 
SELECT country, SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY country
 ORDER BY SUM(total_laid_off) DESC;
 
 
 
SELECT date, SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY date
 ORDER BY date DESC;
 
 
 SELECT YEAR(date), SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY YEAR(date)
 ORDER BY YEAR(date) DESC;
 
 
 
SELECT stage, SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY stage
 ORDER BY SUM(total_laid_off) DESC;
 
 
 SELECT * FROM layoffs_staging2;
 
 
 -- AN INVESTIGATION INTO THE SUM OF LAYOFFS FOR EACH MONTH IN A YEAR
 SELECT SUBSTRING( date,1,7) AS MONTH, 
 SUM(total_laid_off)
 FROM layoffs_staging2
 WHERE SUBSTRING( date,1,7) IS NOT NULL
 GROUP BY MONTH
 ORDER BY MONTH ASC;
 
 
 
 
-- calculating the rolling sum of total layoffs over time to observe trends or changes in layoffs over a moving time window
 WITH Rolling_total AS
 (
 SELECT SUBSTRING( date,1,7) AS MONTH, SUM(total_laid_off) AS total_off
 FROM layoffs_staging2
 WHERE SUBSTRING( date,1,7) IS NOT NULL
 GROUP BY MONTH
 ORDER BY MONTH ASC
 )
 SELECT MONTH, (total_off), SUM(total_off) OVER(ORDER BY MONTH) AS rolling_total
 FROM Rolling_total;
 
 
 
 
SELECT company, YEAR(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(date) 
ORDER BY SUM(total_laid_off) DESC;



-- RANKING COMPANIES BY THEIR TOTAL LAYOFFS.

WITH company_year (company, years, total_laid_off)  AS
(
SELECT company, YEAR(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(date) 
)
SELECT *,
       DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS rank_by_laid_off
FROM company_year
WHERE years IS NOT NULL
ORDER BY rank_by_laid_off ASC;


-- INVESTIGATING INTO THE TOP 5 COMPANIES WITH THE HIGHEST LAYOFFS PER YEAR.

WITH company_year (company, years, total_laid_off)  AS
(
SELECT company, YEAR(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(date) 
), Company_year_rank AS
(SELECT *,
       DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS rank_by_laid_off
FROM company_year
WHERE years IS NOT NULL
)
SELECT * FROM Company_year_rank
WHERE rank_by_laid_off <=5;




SELECT * FROM layoffs_staging2;


SELECT industry,percentage_laid_off, SUM(total_laid_off), YEAR(date)
FROM layoffs_staging2
GROUP BY industry, percentage_laid_off, YEAR(date)
ORDER BY SUM(total_laid_off) DESC;



-- ANALYSIS INTO THE AVERAGE PERCENTAGE LAID OFF BY INDUSTRY

SELECT industry, AVG(percentage_laid_off) AS avg_percentage_laid_off
FROM layoffs_staging2
GROUP BY industry
ORDER BY avg_percentage_laid_off DESC;



SELECT company, SUM(funds_raised_millions) AS total_funds_raised, SUM(total_laid_off), YEAR(date)
FROM layoffs_staging2
GROUP BY company, YEAR(date)
ORDER BY total_funds_raised DESC;



-- AN ANALYSIS INTO THE MONTHLY LAYOFF TRENDS

SELECT YEAR(date) AS year, MONTH(date) AS month, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY YEAR(date), MONTH(date)
ORDER BY YEAR(date), MONTH(date);



-- INVESTIGATING INTO THE TOTAL LAYOFFS BY INDUSTRY PER YEAR
SELECT industry, YEAR(date) AS year, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY industry, YEAR(date)
ORDER BY industry, year;


-- GEOGRAPHICAL ANALYSIS
-- INVESTIGATING INTO TOTAL LAYOFFS BY COUNTRY

SELECT country, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY country
ORDER BY total_laid_off DESC;


-- AN ANALYSIS INTO THE PERCENTAGE LAID OFF BY COUNTRY AND LOCATION
SELECT location,country, AVG(percentage_laid_off) AS avg_percentage_laid_off
FROM layoffs_staging2
GROUP BY location, country
ORDER BY avg_percentage_laid_off DESC;



-- TOTAL LAYOFFS BY STAGE OF COMPANY

SELECT stage,company, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL
GROUP BY stage, company
ORDER BY total_laid_off DESC;


-- TOTAL FUNDS RAISED BY STAGE OF THE COMPANY

SELECT stage, SUM(funds_raised_millions) AS total_funds_raised
FROM layoffs_staging2
GROUP BY stage
ORDER BY total_funds_raised DESC;



-- A DIVE INTO THE YEAR WITH THE HIGHEST TOTAL LAYOFFS GLOBALLY (2022)

SELECT SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE YEAR(date) = 2022;


SELECT company, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE YEAR(date) = 2022
GROUP BY company
ORDER BY total_laid_off DESC;


SELECT industry, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE YEAR(date) = 2022
GROUP BY industry
ORDER BY total_laid_off DESC;





-- AN ANALYSIS INTO THE YEAR WITH THE SECOND HIGHEST LAYOFFS GLOBALLY (2023)
-- ALTHOUGH 2023 HAS DATA FOR ONLY THREE MONTHS.

SELECT SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE YEAR(date) = 2022;



SELECT YEAR(date), MONTH(date), SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE YEAR(date) = 2023
GROUP BY YEAR(date), MONTH(date)
ORDER BY total_laid_off DESC;





SELECT company, industry, country, 
       SUM(funds_raised_millions) AS total_funds_raised,
       SUM(total_laid_off) AS total_laid_off,
       (SUM(total_laid_off) / SUM(funds_raised_millions)) AS layoffs_per_million_raised
FROM layoffs_staging2
WHERE funds_raised_millions > 0 
GROUP BY company, industry, country
ORDER BY layoffs_per_million_raised DESC;










-- CALCULATING FOR THE CHANGE IN TOTAL LAYOFFS OVER TIME SHOWING AN INCREASE AND DECREASE IN TOTAL LAID OFF BY COMPANIES OVER TIME.
-- CHANGE IN TOTAL LAYOFFS OVER THE YEAR ( WITH A NEGATIVE CHANGE IN LAID OFF SHOWING A DECREASE AND A POSITIVE NUMBER SHOWING AND INCREASE). 
WITH layoffs_per_year AS (
    SELECT YEAR(date) AS year, SUM(total_laid_off) AS total_laid_off
    FROM layoffs_staging2
    WHERE YEAR(date) IS NOT NULL
    GROUP BY YEAR(date)
)
SELECT year, 
       total_laid_off, 
       LAG(total_laid_off, 1) OVER (ORDER BY year) AS previous_year_laid_off,
       (total_laid_off - LAG(total_laid_off, 1) OVER (ORDER BY year)) AS change_in_laid_off
FROM layoffs_per_year
ORDER BY year;



-- A CHANGE OR DIFFERENCES IN TOTAL LAYOFFS OVER THE MONTHS ( SHOWING AN INCREASE AND DECREASE IN THE TOTAL LAID OFF OF EMPLOYEES BY COMPANIES).

WITH layoffs_per_month AS (
    SELECT YEAR(date) AS year, MONTH(date) AS month, SUM(total_laid_off) AS total_laid_off
    FROM layoffs_staging2
    WHERE MONTH(date) IS NOT NULL
    GROUP BY YEAR(date), MONTH(date)
)
SELECT year, 
       month, 
       total_laid_off, 
       LAG(total_laid_off, 1) OVER (ORDER BY year, month) AS previous_month_laid_off,
       (total_laid_off - LAG(total_laid_off, 1) OVER (ORDER BY year, month)) AS change_in_laid_off
FROM layoffs_per_month
ORDER BY year, month;




SELECT * FROM layoffs_staging2;


SELECT sum(total_laid_off) FROM layoffs_staging2;

SELECT AVG(total_laid_off) FROM layoffs_staging2; 