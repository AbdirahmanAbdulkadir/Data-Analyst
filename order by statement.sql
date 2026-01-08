
select gender
from employee_demographics
group by gender
;

# group by statement groups the data based on the paramaters so since we said gender it puts all of th males under one column
# the group by needs to be something which can be grouped otherwise it doesnt help
select gender , avg(age), max(age), min(age) 
from employee_demographics
group by gender
;

#order by statement
# order is default in asc but u can specifiy to change it by adding asc after 
# when you order the first things after the statement is the thing thats being ordered
# so if u have gender then all female together then their ages 
# if u order age then it will be in order but then the gender colum can be ordered.  so tts IMPORTANT


select *
from employee_demographics
order by gender asc, age desc
;