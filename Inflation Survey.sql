create database inflation_survey
use inflation_survey

select * from [dbo].[report]
order by [Round No],city
EXEC sp_rename '[dbo].[report].Sr# No#', 'S.No.', 'COLUMN';
EXEC sp_rename '[dbo].[report].Gender Of Respondent', 'Gender', 'COLUMN';
EXEC sp_rename '[dbo].[report].City Name', 'City', 'COLUMN';
EXEC sp_rename '[dbo].[report].Category Of Respondent', 'Category', 'COLUMN';


alter table [dbo].[report] drop column [S.No.]
update [dbo].[report] set city='Bengaluru' where city='Bangalore'
update [dbo].[report] set category='Homemaker' where category='HOMEMAKER'
update [dbo].[report] set period='01-JAN-2025' where Period='Jan-2025'
update [dbo].[report] set period='01-JAN-2024' where Period='Jan-2024'
update [dbo].[report] set period='01-MAR-2024' where Period='Mar-2024'
update [dbo].[report] set period='01-MAY-2024' where Period='May-2024'
update [dbo].[report] set period='01-JUL-2024' where Period='Jul-2024'
update [dbo].[report] set period='01-SEP-2024' where Period='Sep-2024'
update [dbo].[report] set period='01-NOV-2024' where Period='Nov-2024'

ALTER TABLE [dbo].[report]
ALTER COLUMN period DATE;

alter table report 
add [View on Current Inflation Rate Group] nvarchar(50) 

alter table report 
add [View on 3 Months ahead Inflation Rate Group] nvarchar(50) 

alter table report 
add [View on 1 Year ahead Inflation Rate Group] nvarchar(50) 

UPDATE report
SET [View on Current Inflation Rate Group] = CASE 
    WHEN [View on Current Inflation Rate] LIKE '<1' OR [View on Current Inflation Rate] = '1-2' THEN 'Very Low Inflation'
    WHEN [View on Current Inflation Rate] IN ('2-3', '3-4', '4-5') THEN 'Low Inflation'
    WHEN [View on Current Inflation Rate] IN ('5-6', '6-7', '7-8', '8-9') THEN 'Moderate Inflation'
    WHEN [View on Current Inflation Rate] IN ('9-10', '10-11', '11-12', '12-13', '13-14', '14-15') THEN 'High Inflation'
    WHEN [View on Current Inflation Rate] LIKE '>=16' OR [View on Current Inflation Rate] = '15-16' THEN 'Extreme Inflation'
    ELSE 'No idea'
END;

UPDATE report
SET [View on 1 Year ahead Inflation Rate Group] = CASE 
    WHEN [View on 1 Year ahead Inflation Rate] LIKE '<1' OR [View on 1 Year ahead Inflation Rate] = '1-2' THEN 'Very Low Inflation'
    WHEN [View on 1 Year ahead Inflation Rate] IN ('2-3', '3-4', '4-5') THEN 'Low Inflation'
    WHEN [View on 1 Year ahead Inflation Rate] IN ('5-6', '6-7', '7-8', '8-9') THEN 'Moderate Inflation'
    WHEN [View on 1 Year ahead Inflation Rate] IN ('9-10', '10-11', '11-12', '12-13', '13-14', '14-15') THEN 'High Inflation'
    WHEN [View on 1 Year ahead Inflation Rate] LIKE '>=16' OR [View on 1 Year ahead Inflation Rate] = '15-16' THEN 'Extreme Inflation'
    ELSE 'No idea'
END;

UPDATE report
SET [View on 3 Months ahead Inflation Rate Group] = CASE 
    WHEN [View on 3 Months ahead Inflation Rate] LIKE '<1' OR [View on 3 Months ahead Inflation Rate] = '1-2' THEN 'Very Low Inflation'
    WHEN [View on 3 Months ahead Inflation Rate] IN ('2-3', '3-4', '4-5') THEN 'Low Inflation'
    WHEN [View on 3 Months ahead Inflation Rate] IN ('5-6', '6-7', '7-8', '8-9') THEN 'Moderate Inflation'
    WHEN [View on 3 Months ahead Inflation Rate] IN ('9-10', '10-11', '11-12', '12-13', '13-14', '14-15') THEN 'High Inflation'
    WHEN [View on 3 Months ahead Inflation Rate] LIKE '>=16' OR [View on 3 Months ahead Inflation Rate] = '15-16' THEN 'Extreme Inflation'
    ELSE 'No idea'
END;



ALTER TABLE [dbo].[report]
ADD One_Year_ahead_Inflation FLOAT;

UPDATE [dbo].[report]
SET One_Year_ahead_Inflation =
    CASE 
        WHEN [View on 1 Year ahead Inflation Rate] LIKE '<1' THEN 0.5
        WHEN [View on 1 Year ahead Inflation Rate] LIKE '>=16' THEN [View on 1 Year ahead Inflation Rate - actual rate for above 16%]
        WHEN [View on 1 Year ahead Inflation Rate] LIKE 'No idea' THEN NULL
        ELSE 
            (TRY_CAST(LEFT([View on 1 Year ahead Inflation Rate], CHARINDEX('-', [View on 1 Year ahead Inflation Rate] + '-') - 1) AS FLOAT) +
         TRY_CAST(RIGHT([View on 1 Year ahead Inflation Rate], LEN([View on 1 Year ahead Inflation Rate]) - CHARINDEX('-', [View on 1 Year ahead Inflation Rate])) AS FLOAT)
        ) / 2.0
    END;


ALTER TABLE [dbo].[report]
ADD Current_Inflation FLOAT;

UPDATE [dbo].[report]
SET Current_Inflation =
    CASE 
        WHEN [View on Current Inflation Rate] LIKE '<1' THEN 0.5
        WHEN [View on Current Inflation Rate] LIKE '>=16' THEN [View on Current Inflation Rate - actual rate for above 16%]
        WHEN [View on Current Inflation Rate] LIKE 'No idea' THEN NULL
        ELSE 
            (TRY_CAST(LEFT([View on Current Inflation Rate], CHARINDEX('-', [View on Current Inflation Rate] + '-') - 1) AS FLOAT) +
         TRY_CAST(RIGHT([View on Current Inflation Rate], LEN([View on Current Inflation Rate]) - CHARINDEX('-', [View on Current Inflation Rate])) AS FLOAT)
        ) / 2.0
    END;



--Question 1
/*Retrieve all records where inflation expectation for next 3 months is ‘Increase’.*/

SELECT * FROM [dbo].[report] 
WHERE [Expectations on prices in next 3 months - General] like '%increase%';

--Question 2
/* Find the unique cities surveyed.*/
select distinct City from [dbo].[report]
select COUNT(distinct city) as Number_of_cities from [dbo].[report]

--Question 3
/* Retrieve top 5 cities with the highest number of responses.*/
select City, COUNT(*) as Number_of_responses from report
group by city
order by Number_of_responses Desc
offset 0 rows fetch next 5 rows only

--Question 4
/* Find all records from Bengaluru where inflation expectation is ‘Increase’.`*/
SELECT * FROM [dbo].[report] 
WHERE [Expectations on prices in next 3 months - General] like '%increase%'
      and city like 'Bengaluru';

--Question 5
/* What is the overall trend in inflation expectations over time?*/
SELECT Period,  
       COUNT(*) AS total_responses,  
       SUM(CASE WHEN [Expectations on prices in next 3 months - General] LIKE '%Increase%' THEN 1 ELSE 0 END) AS expecting_increase,  
       SUM(CASE WHEN [Expectations on prices in next 3 months - General] LIKE '%Decline%' THEN 1 ELSE 0 END) AS expecting_decrease,  
       SUM(CASE WHEN [Expectations on prices in next 3 months - General] LIKE '%No Change%' THEN 1 ELSE 0 END) AS expecting_no_change  
FROM [dbo].[report]  
GROUP BY Period  
ORDER BY Period;



--Question 6
/*Which cities have the highest inflation concerns?*/

with cte as (
SELECT City, count(*) as total_responses,   
sum(case when [Expectations on prices in next 3 months - General] like '%increase%' then 1 else 0 end)as expecting_increase
FROM [dbo].[report]
group by city
)

select city,total_responses,expecting_increase, (expecting_increase*100/total_responses) as rate_of_increased_responses
from cte
order by rate_of_increased_responses desc

/* Bhubaneswar, Kolkata and Chandigarh have highest inflation concerns*/

--Question 7
/* Are there any increase in response for higher inflation concerns from last year*/

WITH cte AS (
SELECT Period, City, COUNT(*) AS Total_Responses,
SUM(CASE WHEN [Expectations on prices in next 3 months - General] LIKE '%increase%' THEN 1 ELSE 0 END) AS Expecting_Increase,  
(SUM(CASE WHEN [Expectations on prices in next 3 months - General] LIKE '%increase%' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS Rate_Of_Increase
FROM [dbo].[report]
WHERE Period LIKE '%2024-01%' OR Period LIKE '%2025-01%'
GROUP BY City, Period
)
SELECT curr.City,curr.Period AS Present_Year,prev.Period AS Previous_Year,
cast((curr.Rate_Of_Increase) as decimal(10,2)) AS Present_Rate_Of_Increase,
cast((prev.Rate_Of_Increase) as decimal(10,2)) AS Previous_Rate_Of_Increase,
cast((curr.Rate_Of_Increase - prev.Rate_Of_Increase)as decimal(10,2)) AS Difference_In_Rate_Of_Increase
FROM cte AS curr
JOIN 
cte AS prev ON curr.City = prev.City AND curr.Period = '2025-01-01' AND prev.Period = '2024-01-01'
ORDER BY Difference_In_Rate_Of_Increase desc;

/* Jammu,Thiruvananthapuram,Hyderabad has surge in inflation concerns from last year*/

--Question 8
/*How does inflation perception differ across occupations?
Which job categories perceive inflation as high?
Are business owners more concerned than salaried individuals?*/

select * from [dbo].[report]

with cte as(
SELECT Category,[View on Current Inflation Rate Group] as inflation_group,
     COUNT([View on Current Inflation Rate Group]) AS responses
FROM [dbo].[report]  
GROUP BY Category, [View on Current Inflation Rate Group] 
),

cte1 as (
SELECT category ,  
       COUNT(*) AS total_responses
FROM [dbo].[report]  
GROUP BY  category 
)

select a.Category,
       inflation_group,
	   responses,
       total_responses,
       (responses *100/total_responses) as percent_of_response
from cte a
join cte1 b on a.category=b.category
order by percent_of_response desc

/*Homemakers, Self-Employed individuals, and Daily Workers are the most sensitive groups to inflation across all ranges*/
/*While both groups are concerned about inflation, business owners tend to show more consistent concern 
across higher inflation categories (High and Extreme Inflation)*/


--Question 9
/* Are inflation concerns higher in metro cities compared to smaller towns?*/


SELECT 
    CASE 
        WHEN City IN ('Delhi', 'Mumbai', 'Bengaluru', 'Chennai', 'Kolkata', 'Hyderabad') THEN 'Metro City'
        ELSE 'Non-Metro City'
    END AS City_Type,
    COUNT(*) AS Total_Responses,
    SUM(CASE WHEN [Expectations on prices in next 3 months - General] LIKE '%increase%' THEN 1 ELSE 0 END) AS Expecting_Increase,
    (SUM(CASE WHEN [Expectations on prices in next 3 months - General] LIKE '%increase%' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS Rate_Of_Increase
FROM [dbo].[report]
GROUP BY 
    CASE 
        WHEN City IN ('Delhi', 'Mumbai', 'Bengaluru', 'Chennai', 'Kolkata', 'Hyderabad') THEN 'Metro City'
        ELSE 'Non-Metro City'
    END
ORDER BY Rate_Of_Increase DESC;

/*No, The concern is almost similar to both metro cities and smaller town*/

--Question 10
/*Do younger people expect higher inflation than older people?*/
/*Which age group is most concerned about inflation?*/
SELECT [Age Group],  
       COUNT(*) AS Total_Responses,
       SUM(CASE WHEN [Expectations on prices in next 1 year - General] LIKE '%increase%' THEN 1 ELSE 0 END) AS Expecting_Increase,
       (SUM(CASE WHEN [Expectations on prices in next 1 year - General] LIKE '%increase%' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS Rate_Of_Increase
FROM [dbo].[report]
GROUP BY [Age Group]
ORDER BY Rate_Of_Increase DESC;

/* Yes younger people less than 35 years expect higher inflation than older people*/
/* Age group less than 25 years is more concerned about inflation*/

--Question 11
/*How does past inflation sentiment correlate with future expectations?*/

select * from report
-- First, aggregate the data for each city for Jan 2024 and Jan 2025
WITH cte AS (
    SELECT 
        City,
        Period,
        AVG(Current_Inflation) AS Avg_Current_Inflation,
        AVG(One_Year_ahead_Inflation) AS Avg_One_Year_ahead_Inflation
    FROM [dbo].[report]
    WHERE Period IN ('2024-01-01', '2025-01-01')
    GROUP BY City, Period
),
-- Now, self-join to compare the two periods for each city
cte1 as (
SELECT 
    curr.City,
    curr.Avg_Current_Inflation AS Current_Inflation_2025,
    prev.Avg_Current_Inflation AS Current_Inflation_2024,
    curr.Avg_One_Year_ahead_Inflation AS One_Year_Inflation_2025,
    prev.Avg_One_Year_ahead_Inflation AS One_Year_Inflation_2024,
	prev.Avg_One_Year_ahead_Inflation - curr.Avg_Current_Inflation AS comparision_1year_ahead2024_current_inflation_rate2025_JAN,	
    curr.Avg_Current_Inflation - prev.Avg_Current_Inflation AS Diff_Current_Inflation,
    curr.Avg_One_Year_ahead_Inflation - prev.Avg_One_Year_ahead_Inflation AS Diff_One_Year_Inflation
FROM cte curr
JOIN cte prev
  ON curr.City = prev.City
WHERE curr.Period = '2025-01-01'
  AND prev.Period = '2024-01-01'
)

select City,cast((comparision_1year_ahead2024_current_inflation_rate2025_JAN)as decimal(10,2)) 
            as comparision_1year_ahead2024_current_inflation_rate2025_JAN

from cte1
ORDER BY comparision_1year_ahead2024_current_inflation_rate2025_JAN ;

/*
Cities that underestimated inflation:
Bhopal (-4.72), Chandigarh (-2.42), Guwahati (-0.29)
People here expected inflation to be lower, but actual inflation was much higher.

Cities with accurate predictions:

Hyderabad (-0.14), Patna (0.12), Delhi (0.27)
These cities had a balanced view of inflation trends.
 
Cities that overestimated inflation:

Bengaluru (3.88), Chennai (4.82), Nagpur (4.90)
These cities expected higher inflation but faced lower actual inflation.
*/

--Question 12
/*How do inflation perceptions vary across different occupation categories, 
and which groups are most concerned about current inflation rates? */

Objective:
select * from report

with cte as (
SELECT *
FROM (
    SELECT 
        Category,
        [View on Current Inflation Rate Group] AS Inflation_Group,
        1 AS count
    FROM [dbo].[report]
) AS a
PIVOT (
    SUM(count)
    FOR Inflation_Group IN ([Very Low Inflation], [Low Inflation], [Moderate Inflation], [High Inflation],[Extreme Inflation])
) AS b
)


-- Calculate percentages
SELECT 
    Category,
    [Very Low Inflation],
    [Low Inflation],
    [Moderate Inflation],
    [High Inflation],
    [Extreme Inflation],
   cast((([High Inflation] + [Extreme Inflation]) * 100.0 / 
    ([Very Low Inflation] + [Low Inflation] + [Moderate Inflation] + [High Inflation] + [Extreme Inflation]))AS decimal(10,2))
    AS percent_high_extreme
FROM 
cte 
ORDER BY percent_high_extreme DESC;


/*This analysis reveals occupation is a critical lens for understanding inflation pain points,
with retirees and informal workers bearing the heaviest psychological burden.*/
