# Inflation-Expectations-Survey-Analysis

The Reserve Bank of India (RBI) has been conducting the Inflation Expectations Survey of Households (IESH) since 2005 with the objective to capture households’ expectations on prices in the next three months and one year period, using qualitative and quantitative responses.

This project analyzes inflation expectations across different cities in India using SQL. 
The data is sourced from the Inflation Expectations Survey of Households (Jan 2024 - Jan 2025).

## Project Overview
Inflation affects household budgets, financial planning, and economic stability. This project investigates:
* How inflation expectations have changed over time
* Which cities have the highest inflation concerns?
* How inflation perception differs across occupations?
* Comparison of inflation trends in Jan 2024 vs. Jan 2025
* Correlation between past inflation sentiment & future expectations

## Dataset Information
**Data Source:** Inflation Expectations Survey of Households (Jan 2024 - Jan 2025)

**Format:** Excel (.xlsx), processed into SQL

**Columns Included:** 
 * City, Period (Month & Year), Inflation Expectations (3 months & 1 year ahead)
 * Occupation, Age Group, Inflation Concern Levels

##  SQL Analysis Performed
### 1️) Basic Analysis
* Find all responses where inflation expectation for the next 3 months is "Increase".
* Get the number of unique cities surveyed.
* Retrieve top 5 cities with the highest number of responses.

### 2️) Inflation Trends & Concerns
* City-wise analysis: Which cities reported the highest inflation concerns?
* Time-series trend: How do inflation expectations fluctuate over time?
* Year-over-Year comparison:
   * Compared Jan 2024 vs. Jan 2025 inflation expectations
   * Identified cities where inflation concerns increased or decreased
* Occupation-based concerns:
   * Do business owners have different inflation concerns than salaried individuals?

### 3️) Predicting Future Inflation Concerns
* Does past inflation sentiment correlate with future expectations?
* Trend classification: "Increasing Concern", "Decreasing Concern", or "Stable"
* Comparison of future (1-year ahead) inflation vs. current inflation rates

## Technologies Used

### * SQL Server (SSMS) - Querying & analysis
### * Excel - Data cleaning & formatting
### * Git & GitHub - Version control & documentation

## Results & Key Findings
* Cities with the highest inflation concerns: **Bhubaneswar, Kolkata, Chandigarh**
* Cities with a YoY increase in inflation sentiment: **Jammu, Thiruvananthapuram, Hyderabad**
* Most inflation-sensitive occupations: **Homemakers, Self-Employed individuals**
* Overall trend: **Mixed expectations with rising concerns in some cities**

## How to Use This Project
### 1️) Clone this repository:
  ***git clone https://github.com/rakesh1251/Inflation-Survey-Analysis.git***
### 2️) Open the SQL file in SSMS (SQL Server Management Studio)
### 3️) Run the queries on your dataset

## Contributing
* Add new queries & insights
* Suggest improvements

## Contact & Connect
### LinkedIn: [rakesh ranjan](https://www.linkedin.com/in/rakesh-ranjan-83a56a166/)
### Email: ranjan.rakesh51@gmail.com
