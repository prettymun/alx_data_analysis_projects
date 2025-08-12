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
**Project Summary: Maji Ndogo – Part 2 (SQL Implementation)****
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

# Maji Ndogo — Part 3: Auditor Integration & Data Integrity Check

## Overview

This project is the third phase of the **Maji Ndogo** data analysis initiative.  
In this phase, we integrated an **external auditor’s report** with the existing database to validate surveyor data, identify inconsistencies, and flag potential issues for follow-up.

The work involved:
1. Reviewing and correcting the database ERD.
2. Importing and joining external audit data to internal tables.
3. Identifying mismatches between auditor and surveyor records.
4. Producing a suspect list of employees for further investigation.

---

## Tools & Skills Used

- **Tool:** SQL Workbench / MySQL
- **SQL Concepts:** `SELECT`, `JOIN`, `WHERE`, `GROUP BY`, `ORDER BY`, `AVG()`, `COUNT()`, `DATEDIFF()`, `NULLIF()`, `CASE`, `TIME_FORMAT()`, `CREATE VIEW`, CTEs

---

## Process

### 1. ERD Review
- Corrected the relationship between `visits` and `water_quality` from **many-to-one** to **one-to-one**.
- Confirmed that `record_id` is unique in both tables.

### 2. Auditor Data Integration
- Created a new table `auditor_report` to store the CSV data from the external audit.
- Imported ~1,620 rows containing:
  - `location_id`
  - `type_of_water_source`
  - `true_water_source_score`
  - `statements` (qualitative auditor notes)

### 3. Joining Data
- Joined `auditor_report` → `visits` → `water_quality` to compare `true_water_source_score` (auditor) with `subjective_quality_score` (surveyor).
- Limited to `visit_count = 1` to avoid duplicate visits in comparison.

### 4. Identifying Incorrect Records
- Created a view `Incorrect_records` to store mismatches.
- The view includes:
  - Location details
  - Employee name
  - Auditor score vs. Surveyor score
  - Auditor statements

### 5. Analysis
- Found **102 mismatches** out of **1,518 matched records** (~94% agreement).
- Counted mismatches per employee.
- Identified employees above the average number of mistakes.
- Four employees flagged as suspects:  
  **Zuriel Matembo, Malachi Mavuso, Lalitha Kaburi, Bello Azibo**.

### 6. Contextual Investigation
- Filtered suspect records to view related auditor statements.
- Found repeated mentions of “cash” in notes for these employees, suggesting possible bribery.

---

## Key Findings

- Data integrity issues exist in a small subset of records (102 out of 1,518).
- Errors were concentrated among four employees, all linked to suspicious statements.
- `type_of_water_source` remained consistent between surveyor and auditor data; mismatches were mainly in quality scores.

---

## Recommendations

- Flag the four employees for formal investigation.
- Preserve the `auditor_report` table and mismatch view until investigations are complete.
- Re-run analyses that depend on `subjective_quality_score` to assess the impact of mismatches.
- Document complex queries with comments for reproducibility.

---

## Example SQL Snippets

**Create Auditor Report Table**
```sql
CREATE TABLE auditor_report (
  location_id VARCHAR(32),
  type_of_water_source VARCHAR(64),
  true_water_source_score INT DEFAULT NULL,
  statements VARCHAR(255)
);
```
## Create a view for Incorrect Records
```sql
CREATE VIEW Incorrect_records AS
SELECT
  auditor_report.location_id,
  visits.record_id,
  employee.employee_name,
  auditor_report.true_water_source_score AS auditor_score,
  wq.subjective_quality_score AS surveyor_score,
  auditor_report.statements AS statements
FROM auditor_report
JOIN visits
  ON auditor_report.location_id = visits.location_id
JOIN water_quality AS wq
  ON visits.record_id = wq.record_id
JOIN employee
  ON employee.assigned_employee_id = visits.assigned_employee_id
WHERE visits.visit_count = 1
  AND auditor_report.true_water_source_score != wq.subjective_quality_score;
```
##Generate a suspect list
```sql
WITH error_count AS (
  SELECT employee_name, COUNT(*) AS number_of_mistakes
  FROM Incorrect_records
  GROUP BY employee_name
),
suspect_list AS (
  SELECT employee_name, number_of_mistakes
  FROM error_count
  WHERE number_of_mistakes > (SELECT AVG(number_of_mistakes) FROM error_count)
)
SELECT * FROM suspect_list;
```
Dataset Notes
auditor_report sourced from an external CSV..

Joins are performed on location_id and record_id.

Analysis limited to single-visit records for accuracy.

License
This project is for educational purposes and is based on fictional data (Maji Ndogo case study).
