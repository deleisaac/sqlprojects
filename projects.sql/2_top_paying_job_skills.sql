
/*
Question - what skills are required for the top paying data analyst jobs?
 - Use the top 10 highest paying data analyst jobs from the first SubQuery
 - Add the specific skills required for these roles
 -why? it provides a detailed look at which high paying jobs demand certain skills,
 helping job seekers understand which skills to develop that align with top salaries
*/



with top_paying_job AS (
SELECT
    job_id,
    job_title,
    salary_year_avg,
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
limit 10
)

select
    top_paying_job.*,
    skills
from top_paying_job
inner JOIN skills_job_dim on top_paying_job.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC