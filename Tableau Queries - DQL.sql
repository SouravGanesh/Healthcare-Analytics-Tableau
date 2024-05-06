/*
Objectives
Come up with flu shots dashboard for 2022 that does the following

1.) Total % of patients getting flu shots stratified by
   a.) Age
   b.) Race
   c.) County (On a Map)
   d.) Overall
2.) Running Total of Flu Shots over the course of 2022
3.) Total number of Flu shots given in 2022
4.) A list of Patients that show whether or not they received the flu shots
   
Requirements:

Patients must have been "Active at our hospital"
Age to receive shot is 6 month or older
*/

/*
Step 1: Have a look at each table and see which relavent informations we need.
	->patients table
		
		select pat.birthdate
		  ,pat.race
		  ,pat.county
		  ,pat.id
		  ,pat.first
		  ,pat.last
		 from patients as pat
		
		
	-> immunization table: we are mainly intrested in Seasonal flu shots so filter out the rest. 
	   and we can see a single person has taken shot more than one time in a year so take the earliest shot received only.
	   and we are manily intrsted in 2022 year so finter only that.
	   we did this to make sure we have 1:1 map and dont have repeted rows.
	   
	  	select patient, min(date) as earliest_flu_shot_2022 
		from immunizations
		where code = '5302'
		  and date between '2022-01-01 00:00' and '2022-12-31 23:59'
		group by patient
		
	-> We are mainly conserned about the active patients only.
	   we are considering if they have atleast come to hospital in last 2-3 years they are active 
	   and also they are not dead :)
	   age > 6 months
	   
	   	select distinct patient
		from encounters as e
		join patients as pat
		  on e.patient = pat.id
		where start between '2020-01-01 00:00' and '2022-12-31 23:59'
		  and pat.deathdate is null
		  and extract(month from age('2022-12-31',pat.birthdate)) >= 6
	   
		
		
	-> we can use sub-query or comman table expression to have a query in side a query.	
			these comman table expressions exist only at the time we run the query.
			its the query which referes to another query.
				with comman_table_expression_name as( query )
				
			when we are using series of common table expressions, we have to use 'with' keyword onlt for the first one.
			the rest will just start after comma:
				with comman_table_expression_name_1 as( query ),
					 comman_table_expression_name_2 as( query )
					 
			sub-query looks likr this:
				your query where 1=1 and column in (query)
				
				
	-> now lets put everything togeter
*/


with active_patients as
(
	select distinct patient
	from encounters as e
	join patients as pat
	  on e.patient = pat.id
	where start between '2020-01-01 00:00' and '2022-12-31 23:59'
	  and pat.deathdate is null
	  and extract(month from age('2022-12-31',pat.birthdate)) >= 6
),

flu_shot_2022 as
(
select patient, min(date) as earliest_flu_shot_2022 
from immunizations
where code = '5302'
  and date between '2022-01-01 00:00' and '2022-12-31 23:59'
group by patient
)

select pat.birthdate
      ,pat.race
	  ,pat.county
	  ,pat.id
	  ,pat.first
	  ,pat.last
	  ,pat.gender
	  ,extract(YEAR FROM age('12-31-2022', birthdate)) as age
	  ,flu.earliest_flu_shot_2022
	  ,flu.patient
	  ,case when flu.patient is not null then 1 
	   else 0
	   end as flu_shot_2022
from patients as pat
left join flu_shot_2022 as flu
  on pat.id = flu.patient
where 1=1
  and pat.id in (select patient from active_patients)
