-- RAW DATA 
select * from layoffs ;

-- CREATE ANOTHER TABLE SAME AS LAOFFS
create table layoffs_staging
like layoffs;
select * from layoffs_staging;
insert layoffs_staging
select * from layoffs;

-- FINDING OUT DUPLICATES THROUGH ASSIGNING ROW NUMBER
select *,
row_number() over 
(partition by company,location,industry,total_laid_off, percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from layoffs_staging;
with duplicate_cte as 
(select *,
row_number() over (partition by company,location,industry,total_laid_off, percentage_laid_off,`date`,stage,country,funds_raised_millions)
from layoffs_staging
)
select * from duplicate_cte 
where row_num > 1; 
select * from layoffs_staging where company = 'casper';

-- CREATING ANOTHER TABLE LIKE LAYOFFS STAGING WITH ROW NUMBER TO PERFORM DELETE OPERATI0NS
CREATE TABLE `layoffs_staging_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` date DEFAULT NULL,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
select * from layoffs_staging_2;
insert into layoffs_staging_2
select *,
row_number() over (partition by company,location,industry,total_laid_off, percentage_laid_off,`date`,stage,country,funds_raised_millions)
from layoffs_staging;
select * from layoffs_staging_2
where row_num > 1; 
delete from layoffs_staging_2
where row_num > 1; 

-- STANDARDIZING DATA 
select company, trim(company)
from layoffs_staging_2;
update layoffs_staging_2
set company = trim(company);

select distinct industry 
from layoffs_staging_2 order by 1;
select * from layoffs_staging_2
where comapany like 'crypto%';
update layoffs_staging_2
set industry ='crypto'
where industry like 'crypto';

select distinct location 
from layoffs_staging_2 order by 1;

select distinct country 
from layoffs_staging_2 order by 1;
select * from layoffs_staging_2
where country like 'united states%'
order by 1;
select distinct country, trim(trailing '.' from country)
from layoffs_staging_2 order by 1;
update layoffs_staging_2
set country = trim(trailing '.' from country)
where country like 'united sates%';

select `date`,
str_to_date(`date`,'%m/%d/%Y')
from layoffs_staging_2;
update layoffs_staging_2
set `date` = str_to_date(`date`,'%m/%d/%Y');
alter table layoffs_staging_2
modify column `date` date;

select * from layoffs_staging_2;

-- POPULATING OR UPDATING OR DELETING THE NULL VALUES 
select * from layoffs_staging_2
where total_laid_off is null
and percentage_laid_off is null;
delete from layoffs_staging_2
where total_laid_off is null
and percentage_laid_off is null;

select * from layoffs_staging_2 
where industry is null 
or industry like '';
update layoffs_staging_2
set industry = null
where industry like '';

select * from layoffs_staging_2
where company like 'E Inc.';
update layoffs_staging_2 
set industry = 'Transportation'
where company like 'E Inc.';

select * from layoffs_staging_2 t1
join layoffs_staging_2 t2 
on t1.company = t2.company
where t1.industry is null and t2.industry is not null;
update layoffs_staging_2 t1
join layoffs_staging_2 t2 
set t1.company = t2.company
where t1.industry is null and t2.industry is not null;

alter table layoffs_staging_2
drop column row_num;

select * from layoffs_staging_2;





 



  
