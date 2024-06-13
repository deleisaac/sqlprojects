/* What are the top skills based on salary */



select 
    skills,
    round(avg(salary_year_avg),0) as salary_average
    from job_postings_fact
inner JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where 
    job_title_short = 'Data Analyst' and salary_year_avg is not NULL
GROUP BY
    skills
order BY
    salary_average DESC
limit 25
