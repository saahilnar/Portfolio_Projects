# Global COVID-19 Data Analysis & Visualization

## Project Overview

This project analyzes global COVID-19 data using **SQL Server** and **Tableau** to explore infection trends, mortality, geographic differences, and vaccination progress.

The project demonstrates an end-to-end analytics workflow:

**Raw COVID-19 Data → SQL Server EDA → Analytical Queries → Tableau Visualization**

The analysis covers global data across **200+ countries** and includes both COVID-19 death/case data and vaccination data.

## Objectives

- Analyze global COVID-19 case and death trends
- Compare cases and deaths across countries and continents
- Calculate infection rates relative to population
- Examine mortality as a percentage of reported cases
- Analyze vaccination progress
- Create rolling vaccination metrics
- Build interactive Tableau visualizations for geographic and time-based analysis

## Technology Stack

| Technology | Purpose |
|---|---|
| SQL Server | Data exploration, transformation and aggregation |
| SQL | KPI calculations, grouping, joins and window functions |
| Tableau | Interactive visualization and dashboarding |
| Excel | Source data files |

## Project Structure

```text
Covid19/
├── data/
│   ├── Deaths.xlsx
│   ├── Table1.xlsx
│   ├── Table2.xlsx
│   ├── Table3.xlsx
│   ├── Table4.xlsx
│   └── Vaccinated.xlsx
├── sql/
│   └── Covid19 EDA.sql
└── dashboard/
    └── Covid 19 Tableau Visualization.twbx
```

## SQL Analysis

The SQL analysis includes:

### Global Analysis

- Total cases
- Total deaths
- Death percentage
- Country-level case comparisons
- Country-level death comparisons
- Continental comparisons

### India Analysis

- Total cases over time
- Total deaths over time
- Death percentage
- Cases relative to population

### Infection Rate Analysis

Countries are compared using maximum reported cases relative to population.

### Vaccination Analysis

COVID-19 death data is joined with vaccination data using:

- Location
- Date

A window function is then used to calculate a rolling vaccination count by country.

## Tableau Dashboard

The Tableau workbook is designed to visualize:

- Geographic COVID-19 patterns
- Case trends
- Mortality trends
- Country comparisons
- Vaccination progress
- Time-based changes

## Key Analytical Questions

1. How did reported COVID-19 cases evolve over time?
2. How did reported deaths compare with reported cases?
3. Which countries recorded higher reported case counts?
4. How did reported cases compare with population size?
5. How did reported deaths vary across countries and continents?
6. How did vaccination activity progress over time?
7. How can rolling vaccination metrics help understand vaccination progress?

## Important Limitations

COVID-19 reporting varies across countries and over time. Differences in testing, reporting definitions, data revisions, and vaccination reporting can affect comparisons.

The SQL analysis is descriptive and should not be interpreted as establishing causal relationships.

The mortality percentage calculated in this project is based on reported deaths divided by reported cases; it should not automatically be interpreted as a clinical infection fatality rate.

## Skills Demonstrated

- SQL Server
- SQL aggregation
- Joins
- Window functions
- CTE-style analytical thinking
- KPI development
- Time-series analysis
- Geographic analysis
- Tableau
- Data visualization
- Data storytelling
