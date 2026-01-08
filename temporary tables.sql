 # temp tables
 #temp tables are used more so than cte's when its more advaned as with ctes' it can get too complex in one statement
 #aslo temp table last for as long as the session is going on. until you leave mysql
 
 create temporary table temp_table
 ( first_name varchar (50),
 last_name varchar (50),
 fav_surah varchar( 100) 
 )
 ;
 select *
 from temp_table
 ;
 insert into temp_table
 values ( "alex", "freburg", "surah al baqarah")
 ;
 select* 
 from temp_table
 ;
 
 create  temporary table salary_over_50k
 select*
 from employee_salary
 where salary > 50000
 ;
 select* 
 from salary_over_50k
 ;