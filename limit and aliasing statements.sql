
# limit statement basically limits how much coloumbs in ur table you display

select *
from employee_demographics
order by age
limit 3
;


#alising
 # its basicaling making ur own naming for certain functions to make it easier so you use the AS statement when u select it.
select gender , avg(age) as avg_age
from employee_demographics
group by gender
having avg_age > "40"
;

