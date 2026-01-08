
# case statements is like if statements in other languages
select first_name , last_name , age ,
case
   when age<= 30 then "young"
   when age between 31 and 50 then "old"
   when age > 55 then " very old"

end as age_bracket
from employee_demographics
;

# the council said that its time for end of year bonus
# if they made less than 50000 then 5% bounus
# if they made more than 50000 than 7% bonus
# if they work in finance then they get 10% bonus.

select first_name, last_name , salary, dept_id,
case  
    when salary< 50000 then salary + ( salary * 0.05)
    when salary > 50000 then salary + ( salary * 0.07)
    when dept_id = 6 then salary*0.10

end as new_salary,
case
    when dept_id = 6 then salary*0.10
end as bonus 
from employee_salary
;

