-- EXPLORATY DATA ANALYSIS


select *
from layoffs_staging2;

select MAX(total_laid_off),max(percentage_laid_off)
from layoffs_staging2;

select  *
from layoffs_staging2
where percentage_laid_off=1;


select  count(company)
from layoffs_staging2
where percentage_laid_off=1;

select min(date),max(date)
from layoffs_staging2;

select *
from layoffs_staging2
where percentage_laid_off=1
order by total_laid_off desc;


select *
from layoffs_staging2
where percentage_laid_off=1
order by funds_raised_millions desc;



select company , sum(total_laid_off)
from layoffs_staging2
group by company 
order by 2 desc;

select industry, sum(total_laid_off)
from layoffs_staging2
group by industry  
order by 2 desc;


select  country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

select  year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 desc;


select  year(`date`),country, sum(total_laid_off)
from layoffs_staging2
group by year(`date`),country
order by 1 desc;

select company,avg(percentage_laid_off)
from layoffs_staging2
group by company
order by 1 desc;

select substring(`date`,6,2) as month,sum(total_laid_off)
from layoffs_staging2
group by `month` 
order by `month` desc;

select month(`date`),sum(total_laid_off)
from layoffs_staging2
group by month(`date`) 
order by 1 desc;

select substring(`date`,1,7) as month,sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month` 
order by `month` ;

select month(`date`),sum(total_laid_off)
from layoffs_staging2
where `date` is not null
group by month(`date`)
order by 1 ;

with rolling_total as (
select substring(`date`,1,7) as month,sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month` 
order by `month` 
)
select `month`,total_off,sum(total_off) over(order by `month`) as rolling_total
from rolling_total;


select company ,year(`date`) ,sum(total_laid_off)
from layoffs_staging2
group by company ,year(`date`)
order by 3 desc ;



with company_year(company,`year`,total_laid_off) as(
select company ,year(`date`) ,sum(total_laid_off)
from layoffs_staging2
group by company ,year(`date`)
order by 3 desc )
select *,dense_rank() over(partition by `year` order by total_laid_off desc) as layoff_rank
from company_year
where `year` is not null
order by layoff_rank ;

with company_year(company,`year`,total_laid_off) as(
select company ,year(`date`) ,sum(total_laid_off)
from layoffs_staging2
where year(`date`) is not null 
group by company ,year(`date`)
order by 3 desc 
), 
top5_layoff as(
select *,dense_rank() over(partition by `year` order by total_laid_off desc) as layoff_rank
from company_year
)
select *
from top5_layoff
where layoff_rank <6;









