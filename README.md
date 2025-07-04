# alx_data_analysis_projects
This repository includes my data analysis projects throughout my studies at Alx academy. DA is a subset of Data science. The dataset is called INTEGRATED PROJECT: ACCESS TO DRINKING WATER.

**Understanding the Dataset: WHO/UNICEF JMP (2020)**
This project uses data from the WHO/UNICEF Joint Monitoring Programme (JMP) for Water Supply, Sanitation, and Hygiene. The dataset provides estimates on access to water services for the year 2020.

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
