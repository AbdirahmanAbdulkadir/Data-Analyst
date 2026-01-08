
#union statement allows you to combine rows.
# so a join will combine columbs and full tables 
# but union will combine columns. from 2 tables
# to do this union you need to select the rows you want to combine so belowe i chose 
# the age and gender from the employee dem and then i selected the first and second name from employee sal.
# 
select age, gender
from employee_demographics
  union 
 select first_name, last_name
from employee_salary
;

# union doesnt work for everythign only data thats the same.
# lets use first and last name from 2 rows from 2 tables
# union is types we have union distinct which is the base for union and union all.
# union is distinct so that it doesnt repeat things which are repeated.
# this is why u doesn't see 2 sets of name if you want that then say union all so it won't remove repeaated things 
select first_name, last_name
from employee_demographics
  union 
 select first_name, last_name
from employee_salary
;

select first_name, last_name
from employee_demographics
  union all 
 select first_name, last_name
from employee_salary
;


# lets say the company wants to identify people they want out because they are old or too much money

select first_name, last_name, "old man" as label
from employee_demographics
where age > 40 and gender = "male"
union
  select first_name, last_name, "old lady" as label
from employee_demographics
where age > 40 and gender = "female"
  union 
 select first_name, last_name, "salary too high" as label
from employee_salary
where salary > 60000
;

# we have some people who re old and high salary so lets order so we get them first on the table 
select first_name, last_name, "old man" as label
from employee_demographics
where age > 40 and gender = "male"
union
  select first_name, last_name, "old lady" as label
from employee_demographics
where age > 40 and gender = "female"
  union 
 select first_name, last_name, "salary too high" as label
from employee_salary
where salary > 60000
order by first_name, last_name
;