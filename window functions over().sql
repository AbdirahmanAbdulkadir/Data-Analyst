
# window functions
# this another way of knowing the average and making it it's own coloumn just like we done in substrings but this is easier
# you just use a windows function which in this case is over()
select gender , avg(salary) over(partition by gender)
from employee_demographics
join employee_salary
     on  employee_demographics.employee_id = employee_salary.employee_id
;



select employee_demographics.first_name, employee_demographics.last_name , employee_salary.salary, sum(salary) over(partition by gender)
from employee_demographics
join employee_salary
     on  employee_demographics.employee_id = employee_salary.employee_id
     
     ;
     
     #rolling table
     # all you do is add that total gradually as opposed to in one go 
     # to do thi we add a order by and then choose the employee id
     select employee_demographics.first_name, employee_demographics.last_name , employee_demographics.gender, employee_salary.salary, 
            sum(salary) over(partition by gender order by employee_demographics.employee_id)
from employee_demographics
join employee_salary
     on  employee_demographics.employee_id = employee_salary.employee_id
     
     ;
     
     #things you can only do with window functions
     #row number
     # rank is same as row but if the value in the order by which in this case is salary is repeated it gives it the same number.
     # as for the next number after it it will give the number position not the next number down.alter
     # if you want the next number after the repeated number  then you use dense rank and that is the only difference between them.
     select employee_demographics.employee_id,employee_demographics.first_name, employee_demographics.last_name , salary ,
            row_number() over(partition by gender order by salary desc),
            rank() over(partition by gender order by salary desc ) as rank_num,
            dense_rank() over(partition by gender order by salary desc ) as rank_dense
from employee_demographics
join employee_salary
     on  employee_demographics.employee_id = employee_salary.employee_id
     
     ;
     