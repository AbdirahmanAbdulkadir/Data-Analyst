select gender , avg(age), max(age), min(age) 
from employee_demographics
group by gender
;

# having vs where statment
# the avg() only is created after group by occures
# having statement is after group by statement runs and should alwayas come after

select gender , avg(age) 
from employee_demographics
group by gender
having avg(age) > "40"
;


select occupation , avg(salary)
from employee_salary
group by occupation
having  avg(salary) > "75000"
;
