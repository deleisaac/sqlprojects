/*
Question : What are the top-paying data analyst jobs?
-Identify the top 10 highest-paying Data Analyst roles that are available remotely.
-Focuses on job postings with specified salaries (remove nulls).
-why? Highlight the top-paying opportunities for data analyst, offering insights intoemployment
*/



select job_location
from job_postings_fact


SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type, 
    salary_year_avg,
    job_posted_date,
    name as company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
where 
     job_title_short = 'Data Analyst' and 
    job_location  = 'Anywhere'  and 
    salary_year_avg is not NULL
order by 
    salary_year_avg DESC
limit 10;


