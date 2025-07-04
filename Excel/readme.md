# 🌍 Access to Drinking Water (2020) — Data Analysis Project

This project explores the 2020 dataset from the WHO/UNICEF Joint Monitoring Programme (JMP) to understand global access to drinking water. It is part of an integrated project for the ALX Data Science course.

---

## 📊 Project Overview

We analyze global access to drinking water across multiple dimensions including:
- National, urban, and rural service levels
- Population size and urbanization
- Income group classification

The goal is to investigate how factors like urban share, income levels, and population size impact access to clean and safe water.

---

## 🧮 Dataset

**Source**: WHO/UNICEF JMP — Estimates on the Use of Water (2020)  
**File**: `Estimates-on-the-use-of-water-(2020)-a-3712.csv`  
**Columns Include**:
- `pop_n` — National population size (in thousands)
- `pop_u` — Urban population share (%)
- `_wat_bas_n_`, `_wat_lim_n_`, `_wat_unimp_n_`, `_wat_sur_n_` — Water access types
- Similar metrics for urban (`_u`) and rural (`_r`) areas
- `income_group` — Country income classification

---

## 🧹 Data Cleaning & Transformation

- Repaired broken imports caused by semicolon-separated values
- Created new calculated columns:
  - `pop_u_val`, `pop_r`, `pop_n (m)`
  - Rounded % access values to remove invalid (>100%) entries
  - Grouped population shares into buckets for visualization

---

## 📈 Key Analyses & Visualizations

- **Urban vs Rural Share Comparison**
- **Access to Water by Population Size**
- **Box & Whisker Plots** showing spread of water access levels
- **Stacked Column Charts** for service level distribution
- **Pivot Table Analysis** by Income Group

---

## 💡 Insights

- Countries with higher urbanization and income levels tend to have better access to basic water services.
- Outliers in population size distort visualizations — addressed by aggregation and axis unit changes.
- Most national access levels are heavily skewed toward basic service, but rural areas still lag behind.

---

## 📁 Files

- `Estimates-on-the-use-of-water-(2020)-a-3712.csv`: Raw dataset
- `Access to Drinking Water.pdf`: Full project with explanations, formulas, and visualizations

---

## 🛠 Tools Used

- Google Sheets
- Basic statistical functions
- Charts: Line, Column (100% stacked), Box & Whisker
- Pivot tables

---

## 📚 References

- [UN Sustainable Development Goal 6](https://sdgs.un.org/goals/goal6)
- [JMP Official Website](https://washdata.org/)

---
## 👩‍💻 Author

**Purity Musambi**  
Aspiring Data Scientist | ALX Learner  
📫 [avulamusipurity@gmail.com](mailto:avulamusipurity@gmail.com)

---

