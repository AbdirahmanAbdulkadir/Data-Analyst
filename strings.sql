

#string functions

select length("skyfall")
;

select first_name, length(first_name) 
from employee_demographics
order by length(first_name)
;

select upper("sky")
;
select lower("SKY")
;

select ltrim(  " sky           "   )
;

select Rtrim(  "   sky       "   )
;
#left will start from the beginning of the name and right will start from end of name
# you can use substring to get certain letters with the name or any string.
# good example of substring is finding months only from date birth
select first_name, left(first_name, 4), right(first_name, 3), birth_date,
substring(birth_date, 6,2) as birth_month
from employee_demographics
order by birth_month
;

#replace function
#replaces letters with what u put after it, it is capital sensative
select first_name, replace(first_name,"A","z")
from employee_demographics
;

#locate() this finds the thing u put after it and it tells u its poistion ie letter position
select locate("x", "alexanderx");
# concat() this puts whatever u want to combine.
# so for example first and last name to make full name

select first_name, last_name,
concat(first_name," ",last_name) as full_name
from employee_demographics