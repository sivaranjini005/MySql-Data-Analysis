# MySql-Data-Analysis
This repository gives a view of data analysis in mysql.
First of all we need a database that we will import our data into it, we can either create or use already existing one. I have created a database Project


![Database creation](https://github.com/sivaranjini005/MySql-Data-Analysis/blob/main/Screenshot%20_databse.png?raw=true)


Lets look into our csv file 'call_center'
![Screenshot of the csv file](https://github.com/sivaranjini005/MySql-Data-Analysis/blob/main/Screenshot%20.png?raw=true)


Now we need a table that fit our data and match it, the csv file has 12 columns so i have created table calls with 12 columns and turned on global local infile into 1 to load our csv file into mysql
![Table creation](https://github.com/sivaranjini005/MySql-Data-Analysis/blob/main/Screenshot%20_table.png?raw=true)


Let's see how to upload local data file into MySQL Workbench
![Data load query](https://github.com/sivaranjini005/MySql-Data-Analysis/blob/main/Screenshot%20_upload.png?raw=true)

Now lets look into our table calls

![select query](https://github.com/sivaranjini005/MySql-Data-Analysis/blob/main/Screenshot1.png?raw=true)

![calls table](https://github.com/sivaranjini005/MySql-Data-Analysis/blob/main/Screenshot%202.png?raw=true)

Let's clean our data

The call_timestamp column is in string format so we use str_to_date() function by giving the format of the string to convert it into date format like 'YYYY-MM-DD' but before updating the column we need to set safe_sql_updates to 0 to make sql allow updates and also we are ensuring null values in csat_score column

![update Table](https://github.com/sivaranjini005/MySql-Data-Analysis/blob/main/UPDATE%20.png?raw=true)

Now lets see how many rows and columns we have
![Rows & columns](https://github.com/sivaranjini005/MySql-Data-Analysis/blob/main/Screenshot%20_ROWS.png?raw=true)

![No.of.rows](https://github.com/sivaranjini005/MySql-Data-Analysis/blob/main/rows.png?raw=true)               ![No.of.columns](https://github.com/sivaranjini005/MySql-Data-Analysis/blob/main/columns.png?raw=true)


We can see that we have 32941 rows and 12 columns.

Now lets look into the percentage and count of distinct values .
![Percent](https://github.com/sivaranjini005/MySql-Data-Analysis/blob/main/Screenshot%20_PERCENT.png?raw=true)

We are going to see which day has most calls and which day has least call
![Calls by Day](https://github.com/sivaranjini005/MySql-Data-Analysis/blob/main/Screenshot%20_calldays.png?raw=true)

let's look into some aggregated values
![Aggregate query](https://github.com/sivaranjini005/MySql-Data-Analysis/blob/main/Screenshot%20_aggregate.png?raw=true)
![Aggregate result](https://github.com/sivaranjini005/MySql-Data-Analysis/blob/main/Screenshot_last.png?raw=true)

This is how our aggregate function result looks, here we are checking how many calls are within / below or above Service Level Agreement (SLA).For example we see that Chicago/IL call center has around 3359 calls Within SLA , and then Denver/CO has 692 calls below SLA
