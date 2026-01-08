#where clause

select *
from employee_salary
where salary >= 50000
;


select *
from employee_demographics
where birth_date > "1985-01-01"
 ;

#logical operators

select *
from employee_demographics
where birth_date > "1985-01-01"
and gender = "male"
 ;
 
 
 select *
from employee_demographics
where birth_date > "1985-01-01"
or  gender = "female"
;


select *
from employee_demographics
where (first_name = "leslie" and age = "44") or age > "36" 
;


select *
from employee_demographics
where first_name like "A%"
;

select *
from employee_demographics
#a with 2 __ means a name with a at begining then any 2 letters 
# if i put %a% before the letter and after it then it means that letter at any point in the name.
# the like statement will just look for that thing 
# i can even use it for dates "1985%. this will look for anyone born in that year and i could even do months as well. ect
where first_name like "A__" and  "1985%" 
;