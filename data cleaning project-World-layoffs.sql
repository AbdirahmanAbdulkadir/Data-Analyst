#Data Cleaning project

select* 
from layoffs;

#step 1; remove duplicate
# step 2; standardise the data
#step 3; check null values or blank values ( we want to see if we can populate it or we should leave it as it is )
# step 4; remove any coloumns that are not neccessary  but with 
# with step 4 in the real workplace we shouldnt work on raw data like we have here
# so in fact the first thing we do is that we create a staging table which is a copy of the raw.alter
# this way we preserve the raw and can work freely and mistakes don't affect the raw data.

# lets create the staging table

create table Layoffs_staging
like layoffs
;

select *
from layoffs_staging;

insert layoffs_staging
select * 
FROM layoffs
;

#we want to remove duplicates but there isn't a unique iq coloumn or something to just remove the dupicates.
#this means we have to do a work around
# we could add a row number and partion by all the coloumbs to find the duplicates

select *,
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_numb
from layoffs_staging
;

#lets put this in a cte to find duplicates
with duplicate_cte as 
(
select *,
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_numb
from layoffs_staging

)
select*
from duplicate_cte
where row_numb > 1;

;

#let's check that everything is actually a double
select *
from layoffs_staging
where company= "casper"
;

#now we know the duplicates how do we remove them without actually deleting the orignal row.
# we cannot update a cte so a straight forward delete doesnt work
# so we could just create a new table with this row column added so lets do that 
# so i right clicked on the layoff staging and copied to clipboard a create statement

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
  `row_numb` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


#let's check this table was created 
select* 
from layoffs_staging2
;

insert into layoffs_staging2
select *,
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_numb
from layoffs_staging
;

# now we have new table with row number and we just delete it 

delete 
from layoffs_staging2
where row_numb > 1;

select* 
from layoffs_staging2
where row_numb >1;

#now we could remove the row but we can do that at the end of the project.

#lets do step 2 which is standardising the data
# i made a mistake i worked on the layoff_staging instead of layoff_staging2

select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company)
;

select *
from layoffs_staging2;

select distinct industry
from layoffs_staging2
order by 1
;
#noticed from the above statement that crypto is repeated becasue their all spelt differently but are the same thing

select *
from layoffs_staging2
where industry like "Crypto%"
;

#lets update it all to crypto so they come under one industry

update layoffs_staging2
set industry = "Crypto"
where industry like "Crypto%"
;

#lets check some of the other columns to see if there is any issues that need standardising

select distinct country
from layoffs_staging2
order by 1
;
#found a duplicate of united states
# a simple trim wont do it so  we will us trailing "."

select distinct country, trim(Trailing (".") from country)
from layoffs_staging2
order by 1
;

update layoffs_staging2
set country = trim(Trailing (".") from country)
where country like "United States%"
;

select *
from layoffs_staging2;

# lets change the date coloumn to a date format as its currently string

select `date`,
str_to_date(`date`,"%m/%d/%Y")
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`,"%m/%d/%Y")
;
#now lets modify the date coloumb to be in date type

Alter table layoffs_staging2
modify column `date` date
;

#now lets go to Nulls and blank values and what to do
# first thing to do is to make the blanks all nulls as this makes it easier since their the same


select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

update layoffs_staging2
set industry = null 
where industry = "";

select *
from layoffs_staging2 
where industry is null
or industry = "";

#we always first try to populate any nulls if possible from other parts of the data.
#lets try airbnb and see if there is a industry
select*
from layoffs_staging2
where company = "Airbnb";

#so we can fill the other blank airbnb with travel as its the same industry and so let's check if we find more like this.
#lets join the table on itself to compare alter

select* 
from layoffs_staging2 as t1
join layoffs_staging2 as t2
     on t1.company = t2.company
     
     where (t1.industry is null )
     and t2.industry is not null 
     ;
     
     #lets update this now
     
     update layoffs_staging2 as t1
      join layoffs_staging2 as t2
     on t1.company = t2.company
     set t1.industry =t2.industry
     where (t1.industry is null or t1.industry = "")
     and t2.industry is not null 
     ;
     
     
     #step 4 dealing with coloums that have no way to populate unless we scrape the data elsewhere which is something different
     # if thats the case then we could delete it 
     # always confirm before doing this though.
     
     select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;


delete
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select* 
from layoffs_staging2;

#now this is the end of this basic data cleaning project. 

#now lets remove the row numb since we don't need it anymore. 
Alter table layoffs_staging2
drop column row_numb;

