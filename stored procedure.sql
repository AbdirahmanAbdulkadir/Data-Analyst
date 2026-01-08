
# stored procedure
# its a code that is stored and you can call it whenever
# kind of like adding your own statement which is exceuted when you call it 
#very simplistic eample of stored procedure.
# you refresh the schemas and you will see your stored procedue under stored prcedure

create procedure large_salaries()
select* 
from employee_salary
where salary > 50000
;
call large_salaries();

#sometimes you need to have 2 full seperate statement to be under one procedure 
# to do this you change the demilliter
# a demilitter is the thing thing that tells us the end of a stateemnt and the default demilliter is a ;
# so you change it to $$
# then add a begin and end.
delimiter $$
create procedure large_salaries3()
begin
   select* 
   from employee_salary
   where salary > 50000;
   select *
   from employee_salary
   where salary >10000;
end $$
delimiter ;

call large_salaries3();
call large_salaries2();
