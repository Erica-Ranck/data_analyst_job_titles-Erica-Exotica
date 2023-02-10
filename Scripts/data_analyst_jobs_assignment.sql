-- The dataset for this exercise has been derived from the `Indeed Data Scientist/Analyst/Engineer` [dataset](https://www.kaggle.com/elroyggj/indeed-dataset-data-scientistanalystengineer) on kaggle.com. 

-- Before beginning to answer questions, take some time to review the data dictionary and familiarize yourself with the data that is contained in each column.

-- #### Provide the SQL queries and answers for the following questions/tasks using the data_analyst_jobs table you have created in PostgreSQL:

-- 1.	How many rows are in the data_analyst_jobs table?

SELECT COUNT(*)
FROM data_analyst_jobs;

-- 2.	Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT *
FROM data_analyst_jobs
LIMIT 10;

--ExxonMobil

-- 3.	How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location = 'TN';

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location = 'TN' OR location = 'KY';

-- there are 21 postings in Tennessee. There are 27 between TN + KY.

-- 4.	How many postings in Tennessee have a star rating above 4?

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location = 'TN'
	AND star_rating >4;

-- There are 3 TN postings rated above 4

-- 5.	How many postings in the dataset have a review count between 500 and 1000?

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

-- there are 151 postings with a review count between 500-1000.

-- 6.	Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?

SELECT location AS state, ROUND(AVG(star_rating),2) AS avg_rating
FROM data_analyst_jobs
GROUP BY state
ORDER BY avg_rating desc;

-- Nebraska has the highest avg rating.

-- 7.	Select unique job titles from the data_analyst_jobs table. How many are there?

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;

-- there are 881 distinct job titles.

-- 8.	How many unique job titles are there for California companies?

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location = 'CA';

-- there are 230 unique job titles in California

-- 9.	Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?

SELECT company, ROUND(AVG(star_rating),2) AS avg_rating
FROM data_analyst_jobs
WHERE review_count >5000
	AND company IS NOT NULL
GROUP BY company;

-- There are 40 companies with more than 5000 reviews across all locations

-- 10.	Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?

SELECT company, ROUND(AVG(star_rating),2) AS avg_rating
FROM data_analyst_jobs
WHERE review_count >5000
GROUP BY company
ORDER BY avg_rating DESC;

-- The company with the highest avg star rating is GM at 4.2

-- 11.	Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 

SELECT COUNT(title)
FROM data_analyst_jobs
WHERE LOWER(title) LIKE ('%analyst%');

-- there are 1669 jobs with analyst in the title

-- 12.	How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?

SELECT title
FROM data_analyst_jobs
WHERE UPPER(title) NOT LIKE UPPER('%analyst%') 
	AND UPPER(title) NOT LIKE UPPER('%analytics%');
	
-- The word in common with these positions is Tableau

-- **BONUS:**
-- You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 

SELECT *
FROM data_analyst_jobs
LIMIT 10;

SELECT domain AS industry, COUNT(title) as posting_count
FROM data_analyst_jobs
WHERE days_since_posting > 21 
	AND skill LIKE '%SQL%'
	AND domain IS NOT NULL
GROUP BY industry
ORDER BY posting_count DESC;

--  - Disregard any postings where the domain is NULL. 

SELECT domain AS industry, COUNT(title) as posting_count
FROM data_analyst_jobs
WHERE days_since_posting > 21
	AND skill LIKE '%SQL%'
	AND domain IS NOT NULL
GROUP BY industry
ORDER BY posting_count DESC;

--  - Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 

SELECT domain AS industry, COUNT(title) as posting_count
FROM data_analyst_jobs
WHERE days_since_posting > 21
	AND skill LIKE '%SQL%'
	AND domain IS NOT NULL
GROUP BY industry
ORDER BY posting_count DESC;

--   - Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?

-- the top 4 industries are internet and software (62), banks and financial institutions (61), consulting and business services (57), health care (52)

