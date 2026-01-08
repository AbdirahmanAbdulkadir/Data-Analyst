
#subqueries
# we have the in operator and whats in the brackets is what's being referred to  which is called the operand
# so we check thr employee id inside the employee salary but only show the  particular department.

select *
from employee_demographics
where employee_id in 
                   (select employee_id
                    from employee_salary
                    where dept_id= 1)
                    
;


# you could just call the subquery in the () to show you the average salaries
# however you wont see the salary of each person to compary their salary to the average.alter
# you can do this by the below statement and so you call that subquery and put it alongside the bigger query 
select  first_name, salary ,
(select avg(salary)
from employee_salary
)
from employee_salary
;

select  avg(`max(age)`)
from
(
select gender, avg(age), max(age), min(age) , count(age)
from employee_demographics
group by gender
) as agg_table

;


