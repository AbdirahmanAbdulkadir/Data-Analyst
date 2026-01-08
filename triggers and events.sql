#triggers and events

#a trigger means an update of one table automatically trigerrs a update into another table
# this automates tedious things

select*
from employee_demographics
;
#we want a new employee in the salary table gets added to the demographic table automatically
delimiter $$
create trigger employee_insert
       after insert on employee_salary
       for each row 
begin
      insert into employee_demographics(employee_id, first_name,last_name)
      values ( new.employee_id, new.first_name,new.last_name);

end $$
delimiter ;

insert into employee_salary ( employee_id, first_name,last_name,occupation, salary, dept_id)
values ( 13,"jean ralphio"," saperstien", "entertainment", 90000, null)
;

#events
# a trigger happens when a event happens
# events are scheduled changes
# in this example we schedule that when a worker is above 60 they retire 

select* 
from employee_demographics;

delimiter $$
create event delete_retirees
         on schedule every 30 second
        do 
begin
 delete
 from employee_demographics
 where age >=60 ;

end $$
delimiter ;

#troubleshooting if this didnt work could be that some variables are off
# to check you do a show statement
show variables ;
# to check something in particulae just add( like "event%";)