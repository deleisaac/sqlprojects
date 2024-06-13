/* what are the most optimal skill to learn (ie high demand and a high paying skill) for a data analyst role
*/



with skills_demand as (
select 
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count
    from job_postings_fact
inner JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where 
    job_title_short = 'Data Analyst' and job_work_from_home = TRUE and salary_year_avg is not NULL
GROUP BY
    skills_dim.skill_id
)
,average_salary as (
select 
    skills_job_dim.skill_id,
    avg(salary_year_avg) as salary_average
    from job_postings_fact
inner JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where 
    job_title_short = 'Data Analyst' and salary_year_avg is not NULL
GROUP BY
    skills_job_dim.skill_id
)
select
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    average_salary
from 
    skills_demand
inner join average_salary on skills_demand.skill_id = average_salary.skill_id
ORDER BY
    demand_count DESC,
    average_salary
LIMIT 10