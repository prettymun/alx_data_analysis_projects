# 🌍 Access to Drinking Water (2020) — Data Analysis Project

This project explores the 2020 dataset from the WHO/UNICEF Joint Monitoring Programme (JMP) to understand global access to drinking water. It is part of an integrated project for the ALX Data Science course.

# alx_data_analysis_projects
This repository includes my data analysis projects throughout my studies at Alx academy. DA is a subset of Data science. The dataset is called INTEGRATED PROJECT: ACCESS TO DRINKING WATER.

**Access to Drinking Water – Data Analysis Project**
This repository contains my integrated data analysis project completed during my studies at ALX Academy. The project investigates global access to safe and affordable drinking water using data from the WHO/UNICEF Joint Monitoring Programme (JMP). This work supports Sustainable Development Goal 6: Clean Water and Sanitation.

**Project Summary**
The analysis is divided into two main parts:
- Understanding the Data (Part 1) – In-depth exploration of the 2020 JMP dataset, analyzing access to drinking water by area, population size, and income group.
- Transforming the Data (Part 2) – A longitudinal analysis of access from 2000 to 2020 using calculated metrics like Annual Rates of Change (ARC) to assess progress over time by region and population type.


**PART 1**

**Understanding the Dataset: WHO/UNICEF JMP (2020)**
This project uses data from the WHO/UNICEF Joint Monitoring Programme (JMP) for Water Supply, Sanitation, and Hygiene. The dataset provides estimates on access to water services for the year 2020.

**Part 1 – Understanding the Data (2020)**
**Key Analyses:**
Population Coverage: Compared the dataset population to global estimates.
Urban vs. Rural Access: Assessed disparities using charts.
Service Levels: Analyzed national water service distribution using 100% stacked charts.
Income Groups: Used pivot tables to relate income to access.

**Tools Used:**
Google Sheets (Formulas, Charts, Pivot Tables)
Box & Whisker Plots
Stacked Bar Charts

**Dataset Features**
name - Name of the country or region.

income_group - The income classification of the country (e.g., low, middle, or high income).

pop_n - National population estimate (in thousands).

pop_u - Urban population share (as a percentage of the total population).

wat_bas_n - Percentage of the national population with access to at least basic water services.

wat_lim_n - Percentage of the national population with access to limited water services.

wat_unimp_n - Percentage of the national population using unimproved water services.

wat_sur_n - Percentage of the national population relying on surface water sources.

⚠️ Note: While JMP defines five levels of water service, this dataset includes only four: at least basic, limited, unimproved, and surface services. The "at least basic" category includes both safely managed and basic levels.



**PROCESS**
1. Project Overview
2. Becoming familiar with the dataset
3. Importing the data
4. Investigating population size
5. Investigating access by area
6. Investigating access by population
7. Investigating access by income group


**DATA CLEANING - NEW COLUMNS - AGGREGATED COLUMNS**
value_cnt = COUNTA (A2:P2) --- counts the number of columns per row. Helps identify any missing data in a column


**INVESTIGATING POPULATION SIZE**
- We want to summarize the national population size to better understand how the dataset represents the entire world population.
  **Additional data: In 2020, the world population was estimated to be 7.821 billion, 55% of which lived in urban areas.**
  
A. How do the world population estimates compare to the provided dataset populations?
B. How does the urban population share compare to the rural population?

**1. Created a new sheet ( Global Report 2020)**
* Total pop_n = SUM('Estimates-on-the-use-of-water-(2020)-a-3712'!C2:C214) = 7,786,695.108
* Converting it into billions for easier comparison with the universal population: divide by 1,000,000, converted to 7.7867 billion.
  
**2. New variable**
  pop_u_val - The number of people living in urban areas per country
  = pop_u/100 * pop_n (pop_u is a percentage, thus dividing by 100)
  = (C2/100) * D2

* Total pop_u_val = 
=SUM('Estimates-on-the-use-of-water-(2020)-a-3712'!R2:R214) = 4,375,308.463

**3. Comparing worldwide statistics to our data**
- 55% of the total world population lives in urban areas ( 55/100 * 7,821,000) = 4,301,550
- Urban share in our data = (pop_u_val / pop_n) * 100
  4,375,308.463 / 7,786,695.108 * 100 = **56.18954386**
- Rural share in our data
pop_r = 100 - pop_u
pop_n(m) = ROUNDUP( C2/1000 ,0)

**Visualized charts** ( Line Chart) ---- National population living in Rural vs Urban.png


**INVESTIGATING ACCESS BY AREA**
We want to investigate what access to water at the different service levels looks like for people in specific types of areas (national, urban, and rural).
Investigating access by area

01. Understanding the data
What is the tendency and spread of the different water access features?
A. How do these measures of water access compare across different types of areas?
B. We’ll use the measures of central tendency and spread.

wat_bas_n(rounded) = IF( ROUNDUP (G2,0) > 100, 100 , ROUNDUP ( G2,0))

-Calculated the minimum, maximum, mean, mode, quartile 1, quartile 3, interquartile range, and standard deviation of water access values in different areas...: wat_bas_n, wat_lim_n, wat_unimp_n, wat_sur_n, wat_bas_r, wat_lim_r, wat_unimp_r, wat_sur_r, wat_bas_u, wat_lim_u, wat_unimp_u, wat_sur_u. 
- Used the results to create **BOX AND WHISKER PLOT.**

  **Visualized charts** ( Box and whisker plot chart ) ----- Access to water 2020.png



** INVESTIGATING ACCESS BY POPULATION SIZE**
A. What does the national access to water look like based on national population size?
B. What does urban access to water look like based on urban population size?
C. What does rural access look like?

**Visualize the national access to water on all four levels based on the national population size.**
- In our previously created Global 2020 report sheet, create a bar chart. Since we want to Investigate how population size affects access levels, population size (pop_n) will be our independent variable (the cause), and our four access features (_wat_bas_n_, _wat_lim_n_, _wat_unimp_n_, and _wat_sur_n_) will be the dependent variables (the effects).
- Because our access levels are percentages and we know that an individual or household can only be at one of those levels, we’ll change our bar chart to a 100% stacked column chart.

**Visualized cahrts** - (A 100% stacked column chart) ---------- National distribution of water by service levels.png



**Visualize the urban access to water on all four levels based on the urban population.**
- In our previously created Global 2020 report sheet, let’s create another 100% stacked column chart, similar to what we created in A, but only for urban areas. Let’s use urban population share (pop_u in percentage) as our independent variable.
- In order to avoid a messy bar chart, we are going to create a new feature called pop_u (rounded), which is the urban population share (pop_u) rounded to the nearest whole number. Use this new feature as the x-axis in the 100% stacked column chart, and set the aggregations to Average.
- We notice that our x-axis isn’t arranged from zero to a hundred, as expected. Let’s order our dataset based on pop_u (rounded) before we consider any insights.

  **Visualized chart** - ( A 100% stacked column chart) ---  Access of water by urban population.png


**INVESTIGATING ACCESS BY INCOME GROUP**

- We want to investigate the relationship between GNI (gross national income) or income group, population size, urbanization, and national water access.
01. Understanding the data
a. What is the effect of national population size and urbanization on GNI and water access?

- Economies are classified into four income groups based on gross national income (GNI) per capita.
- In our previously created Global 2020 report sheet, let’s create a pivot table. Because we want to group by income group, we will set our rows to the income group feature, income_group.
- Our values are the sum of the population size (pop_n), the average urban share (pop_u), and the average national share of basic (_wat_bas_n_), limited (_wat_lim_n_), unimproved (_wat_unimp_n_), and surface (_wat_sur_n_) access.
- Let’s also visualize our summary data. In order to better investigate the link between income group and the other features, it would be useful if we could sort our x-axis on income groups more appropriately.
- Let’s convert our text column income_group in the dataset sheet to numbers, where NAN is 0, Low income is 1, Lower middle income is 2, Upper middle income is 3, and High income is 4.

Formula :

= IF(B2 = "NAN" , 0, IF( B2 = "Low income" , 1 , IF( B2 = "Lower middle income" , 2 , IF(B2 = "Upper middle income", 3 , IF(B2 = "High income", 4 )))))


**PART 2**
**Part 2 – Transforming the Data (2000–2020)**
**Objectives:**
Track water access trends over time.
Calculate Annual Rates of Change (ARC) for basic water access.
Compare performance by area (national/rural/urban) and region.

**Key Transformations:**
- Created y_diff column to capture time intervals between observations per country.
- Calculated ARC values (ARC_n, ARC_r, ARC_u) using:

ARC_x = (wat_bas_x(n+1) - wat_bas_x(n)) / (year(n+1) - year(n))

- Managed missing and invalid values using IFERROR and logical conditions

**Regional Analysis:**
- Merged region metadata via LOOKUP.
- Created summaries of ARC averages by region and area type.
- Visualized relationships between ARC, region, and population size.

**Key Insights:**
- Sub-Saharan Africa shows slower progress, with full access projected around 2080 if trends persist.
- Rural areas often saw higher ARC than urban, but many had lower starting access levels.
- Some countries had negative or zero ARC despite no full access.

** Visualizations**
Line Charts: Urban vs Rural population
Box Plots: Water access by area
Stacked Column Charts: National & Urban Access Breakdown
Histograms: Year representation, ARC differences
Region-based plots: ARC vs Population size

**Features added**
| Feature               | Purpose                                      |                                         
| --------------------- | -------------------------------------------- |-----------------------------------------
| `y_diff`              | Year difference between observations         | =IF(EQ(A2, A3), B3 - B2, "")
| `ARC_n/r/u`           | Annual rate of change (national/rural/urban) |= IFERROR (IF (EQ(A2,A3), (E3-E2)/(B3-B2)," "),"null")
| `ARC_diff`            | ARC difference between rural and urban       |
| `wat_bas_x (rounded)` | Corrected percentages over 100               |=IF(ISNUMBER(E68), ROUNDUP(E68, 0), "null")
| `ARC_x_full`          | Flags for full access in both observed years |=IF(AND(EQ(A2, A3), F2 >= 99, F3 >= 99), "Full access", "")
| `region`              | Added region classification for analysis     |=VLOOKUP(A2,Regions!$A$2:$B$233,2, FALSE)


**y_diff**
Pseudocode
START
If name(n+1) == name(n), then
- y_diff = year(n+1) - year(n)
Else
- y_diff = “”
End if
END

Flowchart
+--------+
| START  |
+--------+
     |
     v
+----------------------------+
| Is name(n+1) == name(n)?  |
+----------------------------+
     |                      |
     | Yes                  |
     v                      v
+------------------+    +------------------------+
| y_diff =           |   | y_diff = ""            |
| year(n+1) - year(n)|  | (Leave cell blank)     |
+------------------+    +------------------------+
     \                /
      \              /
       v            v
     +----------------+
     |      END       |
     +----------------+


**ARC_u/r/n**
- The United Nations (UN) uses Annual Rates of Change (ARC) to see whether the proportion of access to drinking water is declining or increasing. The Annual Rates of Change (ARC) is a statistical measure used to express the average yearly change rate of a variable over a certain period.
- It's calculated by taking the difference between the end and start values of the dataset and dividing the result by the number of years that separate the two values:

- Where ARCx is the annual rate of change for the indicator x, Px,y1, and Px,y2 are the estimates for indicator x about year 1 (Y1) and year 2 (Y2) in percentage.
- In Google Sheets, we need to do a row calculation between two years for the same country to calculate the ARC. Based on our column names, our ARC equation is*:

**ARC_x = (wat_bas_x(n+1) - wat_bas_x(n))/(year(n+1) - year(n))**

Where _x represents the different areas, ARC_n (national) we calculate using wat_bas_n, ARC_r (rural) using wat_bas_r and ARC_u (urban) using wat_bas_u. Remember, our wat_bas_x values are already in percentages.



**Deliverables**
- Summary Sheet: Metrics, distributions, counts by region, ARC, and access
- MCQs: Evaluation of conceptual and analytical understanding
- Dashboards: Interactive and static visual insights

** Lessons Learned**
- Real-world datasets often have inconsistencies (e.g., “null” vs blank).
- Time-based comparisons require data preprocessing (sorting, deduplication).
- Statistical averages like ARC must be contextualized (e.g., saturation effects).
- Storytelling with data is key for actionable insights, especially in global issues.

**Tools**
Google Sheets (Formulas, LOOKUP, Pivot Tables, Charts)
JMP Dataset
Data Cleaning Techniques


**References**
WHO/UNICEF JMP 2020 Dataset
UN SDG Goal 6: Clean Water and Sanitation
ALX Data Analysis Curriculum







**Author**
Purity Musambi
Data Analyst | Forensic Science Graduate | ALX Data Science Fellow
Email: avulamusipurity@gmail.com
Phone: +254 769 573 987
Location: Kenya



