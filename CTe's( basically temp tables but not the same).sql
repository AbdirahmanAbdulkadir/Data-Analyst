#CTes
#they are basically temp table made up of 2 joined tables with a group by and then you want the total avg or want
# to do more complex maths
# you cannot save cte's you just call them directly after .

# if you want to name the coloumn names without ailising after the select then just add a ()n after you cte_example name so 
# it would be cte_example( insert name of each column that you want)
with CTE_example as 
(
select gender, avg(salary) avg_sal , max(salary) max_sal , min(salary) min_sal , count(salary) count_sal 
from employee_demographics dem
join employee_salary sal
 on dem.employee_id = sal.employee_id
 group by gender
 )
 select avg(avg_sal)
 from CTE_example
 ;
 
 
 #creating more than 1 cte
 with cte_example1 as
 (select employee_id, gender, birth_date 
 from employee_demographics
 where birth_date > " 1985-01-01"
 ),
 cte_2 as 
 ( select employee_id, salary
 from employee_salary
 where salary> 50000
 )
 select *
 from cte_example1
 join cte_2
  on cte_example1.employee_id = cte_2.employee_id
 ;
 # use case for this how many 25 yrs are earning this much 
 
# 