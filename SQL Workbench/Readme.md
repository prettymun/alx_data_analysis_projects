Project Summary: Maji Ndogo - Part 1
- This project is based on a data exploration initiative for Maji Ndogo, a fictional community facing a water crisis. A large-scale survey was conducted, resulting in a rich database of over 60,000 records collected by engineers, field workers, scientists, and analysts. The goal of the project was to extract meaningful insights from the data to support data-driven decisions for improving water access and quality.
- As part of the analysis, I used SQL Workbench. I applied basic SQL commands, including SELECT, WHERE, UPDATE, SET, LIKE, LIMIT, CREATE TABLE, and DROP TABLE to explore and manipulate the dataset.

Key tasks and objectives:
- Get to Know the Data: Identified all foundational tables in the database and explored their structure using SHOW TABLES and SELECT * queries.
- Dive into Water Sources: Queried water source types to understand the categories and accessibility of water sources in Maji Ndogo.
- Unpack Visits: Analyzed the visits table to discover visit patterns, particularly focusing on visit frequency and queue times.
- Assess Water Quality: Evaluated the quality of water sources based on subjective scores, identifying those frequently visited with varying quality levels.
- Investigate Pollution Issues: Queried contamination data in wells to detect inconsistencies, corrected errors in descriptive fields using string operations, and updated inaccurate classifications using conditional logic.

This project demonstrates how SQL can be used to explore real-world survey data, clean and correct errors, and derive actionable insights in the context of public resource management.

**
Project Summary: Maji Ndogo – Part 2 (SQL Implementation)**
- This project continues the data analysis of Maji Ndogo, a fictional community facing a water crisis. The focus in this phase was on using SQL Workbench to clean, explore, and analyze the data. The SQL file includes practical applications of basic SQL concepts and commands to uncover insights and support informed decision-making.
Tools and Skills Used
Tool: SQL Workbench
Key SQL Commands: SELECT, WHERE, UPDATE, SET, LIKE, TRIM, GROUP BY, ORDER BY, LIMIT, JOIN, CREATE TABLE, RANK(), DATEDIFF(), AVG(), NULLIF(), CASE, TIME_FORMAT()

Project Breakdown
**Data Cleaning**
- Standardized email addresses by formatting names and appending a domain.
- Trimmed phone numbers to remove trailing spaces.
- Ensured consistent data formatting across employee records.
**Honoring the Workers**
- Counted the number of employees per town.
- Identified top field surveyors by number of visits.
- Retrieved full employee details for the top performers.
**Location Analysis**
- Aggregated and ranked records per town and province using GROUP BY.
- Counted different location types to understand geographic distribution.
**Water Source Insights**
- Calculated the total number of people surveyed.
- Counted different types of water sources (e.g., taps, wells, rivers).
- Averaged and summed up the number of people served per source type.
- Used window functions (RANK()) to rank water sources by population served.
**Visit Analysis**
- Calculated total survey duration using DATEDIFF().
- Analyzed average queue time, excluding zero entries using NULLIF().
- Examined average queue times across days of the week.
- Analyzed hourly trends in queue time using TIME_FORMAT() and CASE.

This structured SQL walkthrough provides a solid foundation in applying SQL for real-world public utility and resource management cases, using only fundamental SQL syntax in a practical, end-to-end project.
