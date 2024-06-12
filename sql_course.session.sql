SELECT * 
from job_postings_fact
limit 100


select '2023-02-19':: DATE,
        '123':: INTEGER,
        'true':: BOOLEAN,
        '3.14':: REAL;



select
    job_title_short as title,
    job_location as location,
     extract(MONTH from job_posted_date) as  date_month,
      extract(YEAR from job_posted_date) as  date_year,
    job_posted_date at time zone 'UTC' at time zone 'EST'
from
    job_postextractings_fact
limit 10;

select
    count(job_id),
     extract(MONTH from job_posted_date) as  date_month
from 
    job_postings_fact
where 
    job_title_short = 'Data Analyst'
group by 
    date_month
order by 
    count(job_id) desc




select
    avg(salary_year_avg) as year_average,
    avg(salary_hour_avg) as hour_average
from 
    job_postings_fact
where
    job_posted_date < '2023-06-01'



select
     extract(MONTH from job_posted_date at time zone 'UTC' at time zone 'EST') as date_month,
    extract(YEAR from job_posted_date at time zone 'UTC' at time zone 'EST') as date_year,
    count(job_id) as job_posts
from 
    job_postings_fact
where 
    extract(YEAR from job_posted_date at time zone 'UTC' at time zone 'EST') >= '2023'
group by date_year, date_month
order by date_year, date_month


select
    company_dim.company_id,
    company_dim.name as company_name,
    job_postings_fact.job_health_insurance,
    extract(MONTH from job_posted_date at time zone 'UTC' at time zone 'EST') as date_month,
    extract(YEAR from job_posted_date at time zone 'UTC' at time zone 'EST') as date_year
   
from 
    job_postings_fact
join 
    company_dim on job_postings_fact.company_id = company_dim.company_id
where
    job_postings_fact.job_health_insurance = TRUE and 
    extract(year from job_postings_fact.job_posted_date at time zone 'UTC' at time zone 'EST') = 2023
    and extract(QUARTER from job_posted_date at time zone 'UTC' at time zone 'EST') = 2


create table january_jobs as
select *
from job_postings_fact
where 
    extract(year from job_postings_fact.job_posted_date at time zone 'UTC' at time zone 'EST') = 2023
    and extract(MONTH from job_posted_date at time zone 'UTC' at time zone 'EST') = 01;




create table february_jobs as
select *
from job_postings_fact
where 
    extract(year from job_postings_fact.job_posted_date at time zone 'UTC' at time zone 'EST') = 2023
    and extract(MONTH from job_posted_date at time zone 'UTC' at time zone 'EST') = 02;


create table march_jobs as
select *
from job_postings_fact
where 
    extract(year from job_postings_fact.job_posted_date at time zone 'UTC' at time zone 'EST') = 2023
    and extract(MONTH from job_posted_date at time zone 'UTC' at time zone 'EST') = 03;


select
    count(job_id) as number_of_jobs,
    job_title_short,
    case
        when job_location = 'Anywhere' then 'Remote'
        when job_location = 'New York, NY' then 'local'
        else 'Onsite'
    end as location_category
from
    job_postings_fact
where job_title_short =  'Data Analyst'
group by
    location_category,
    job_title_short
order by number_of_jobs desc




select
    count(salary_year_avg) as Salary,
    job_title_short as job_name,
    case
        when salary_year_avg <= 75000 then 'low salary'
        when salary_year_avg > 75000 and salary_year_avg <= 160000 then 'standard'
        else 'high salary'
    end as salary_category
from 
    job_postings_fact
where
     job_title_short = 'Data Analyst'
group by
   salary_category,
   job_title_short




select*
from ( --subQuery starts here
    select *
    from job_postings_fact
    where extract(month from job_posted_date) = 1) as january_jobs;
-- SubQuery ends here


with january_jobs as (--CTE definition starts here)
    select * 
    from job_postings_fact
    where extract(month from job_posted_date) = 1
) -- CTE definition ends here

select *
from january_jobs



select name as company_name,
    company_id
from company_dim
where company_id in (
select
    company_id
from
    job_postings_fact
where
    job_no_degree_mention = TRUE
order by company_id 
);




with company_job_count as (
select 
    company_id,
    count(*) as total_jobs
from

    job_postings_fact
group by
    company_id
)
select company_dim.name as company_name,
    company_job_count.total_jobs
from company_dim
left join company_job_count on company_job_count.company_id = company_dim.company_id
order by total_jobs desc






select 
    job_title_short,
    job_location,
    job_via,
    job_posted_date::date ,
    salary_year_avg
from(
select *
from january_jobs
union all
select *
from february_jobs
union all
select *
from march_jobs
) as quarter1_job_postings
where quarter1_job_postings.salary_year_avg > 70000 and job_title_short = 'Data Analyst'
order by 
salary_year_avg desc




