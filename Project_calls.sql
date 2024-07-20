-- creating a database Project 
create database Project;
Use Project;

-- creating table calls based on the columns in the call center csv file

create table calls( 
Id varchar(50), customer_name varchar(50), sentiment varchar(30), csat_score int default null,
call_timestamp char(10), reason varchar(30), city varchar(50), state varchar(50),
channel varchar(30), response_time varchar(30), call_duration_in_minutes int, call_center varchar(30));

-- setting global variable 'on' to load local csv data file into the table 

set global local_infile = 1;

-- check the variable is turned on or not

show variables like 'local_infile';

-- loading local data file into calls table

LOAD DATA LOCAL INFILE 'D:\\kumar\\Download\\Call Center.csv'
INTO TABLE CALLS
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ID, customer_name, sentiment, csat_score, call_timestamp, reason, city, state, channel, response_time, call_duration_in_minutes, call_center);

set global local_infile = 0;
-- let's take look at our table

select * from calls limit 10;

-- now we are going to clean the data
-- call_timestamp field is in string format so we need to convert it into a date format

set sql_safe_updates = 0;
update calls set call_timestamp = str_to_date(call_timestamp, '%d-%m-%Y');

--  updating csat_score value which is equal to 0 as the minimum value is 1 and we are converting 0 into null 

update calls set csat_score = NULL where csat_score = 0;
set sql_safe_updates = 1;
select * from calls limit 10;

-- let's see what is the shape of our table i.e the number of rows and number of columns

select count(*) as no_of_rows from calls;
select count(*) as no_of_columns from information_schema.columns where table_name = 'calls';

-- now we are going to see distinct values of some columns

select distinct sentiment from calls;
select distinct reason from calls;
select distinct channel from calls;
select distinct response_time from calls;
select distinct call_center from calls;

--  lets look into the count and percentage of each distinct values

select sentiment, count(*) as count, round((count(*)/(select count(*) from calls))*100, 1) as sentiment_percent
from calls group by 1 order by 3 desc;

select reason, count(*) as count, round((count(*)/(select count(*) from calls))*100,1) as reason_percent
from calls group by 1 order by 3 desc;

select channel, count(*) as count, round((count(*)/(select count(*) from calls))*100, 1) as channel_percent
from calls group by 1 order by 3 desc;

select response_time, count(*) as count, round((count(*)/(select count(*) from calls))*100,1) as resp_percent 
from calls group by 1 order by 3 desc;

select call_center, count(*), round((count(*)/(select count(*) from calls))*100, 1) as call_percent from calls group by 1 order by 3 desc;

select state, count(*) as statewise_count from calls group by 1 order by 2 desc;

-- see which day has the most calls

select dayname(call_timestamp) as day_of_call, count(*)  as no_of_calls from calls group by 1 order by 2 desc;
-- Friday has the most no_of_calls and sunday has the least

-- now lets look into some aggregated values 

select min(csat_score) as min_score, max(csat_score) as max_score, round(avg(csat_score), 1) as avg_score from calls;

select min(call_timestamp) as earliest_date, max(Call_timestamp) as most_recent from calls;

select min(call_duration_in_minutes) as min_duration, max(call_duration_in_minutes) as max_duration, avg(call_duration_in_minutes) as avg_duration from calls;

select call_center, response_time, count(*) as total_count from calls group by 1,2 order by 1,3 desc;

select call_center, avg(call_duration_in_minutes) as avg_duration from calls group by call_center order by 2 desc;

select channel, avg(call_duration_in_minutes) as avg_duration from calls group by 1 order by 2 desc;

select state, count(*) as count from calls group by 1 order by 2 desc;

select state, reason, count(*) as count from calls group by 1, 2 order by 1,2,3 desc;

select state, sentiment, count(*) as count from calls group by 1, 2 order by 1,3 desc;

select state, avg(csat_score) as avg_score from calls group by 1 order by 2 desc;

select sentiment, avg(call_duration_in_minutes) as avg_duration from calls group by 1 order by 2 desc;

select call_timestamp, max(call_duration_in_minutes)as max_duration from calls group by call_timestamp order by 2 desc;

