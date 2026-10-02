# Business Insights

## Global COVID-19 Data Analysis & Visualization

### Executive Summary

This project transforms global COVID-19 case, death, and vaccination data into an analytical framework for monitoring the pandemic across countries, continents, and time.

The analysis focuses on:

- Infection levels
- Reported mortality
- Population-adjusted case rates
- Geographic comparisons
- Vaccination progress
- Rolling vaccination activity

The project is primarily descriptive and is intended to demonstrate data analysis and visualization skills.

---

## 1. Global Case & Death Monitoring

The SQL analysis calculates global reported cases, reported deaths, and the ratio of deaths to reported cases.

This creates a high-level framework for monitoring how reported COVID-19 outcomes changed over the analyzed period.

### Business Insight

A combined view of cases and deaths provides more context than either metric independently.

Case volume indicates the scale of reported infections, while reported deaths provide an outcome measure that can be compared with case activity.

---

## 2. Country-Level Comparison

Countries are compared using:

- Total reported cases
- Total reported deaths
- Maximum reported cases
- Reported cases relative to population

### Business Insight

Absolute case counts can be strongly influenced by population size.

For that reason, the project also calculates reported cases as a percentage of population to provide a population-adjusted perspective.

---

## 3. India Analysis

The SQL workflow includes a dedicated analysis of India covering:

- Cases over time
- Deaths over time
- Death percentage
- Reported cases relative to population

### Business Insight

Separating India from the global analysis allows country-specific trends to be examined without losing the broader international context.

---

## 4. Continental Analysis

The project aggregates maximum reported case counts by continent.

### Business Insight

Continental aggregation helps provide a higher-level geographic view and can be used as a starting point for identifying differences in the scale of reported COVID-19 activity.

---

## 5. Vaccination Progress

COVID-19 death data is joined with vaccination data using location and date.

A rolling vaccination count is calculated using a SQL window function partitioned by country.

### Business Insight

Rolling vaccination measures allow vaccination activity to be evaluated cumulatively over time rather than looking only at individual daily values.

This is useful for understanding the progression of vaccination programs across countries.

---

## 6. Tableau Visualization

The Tableau workbook provides an interactive layer over the SQL analysis.

The visual analysis supports:

- Geographic exploration
- Trend analysis
- Country comparison
- Mortality analysis
- Vaccination monitoring

### Business Insight

Interactive visualization makes it easier to move between global patterns and individual-country trends and provides a more accessible way to communicate analytical findings.

---

## 7. Analytical Framework

The project connects four major dimensions:

```text
COVID Cases
     ↓
COVID Deaths
     ↓
Population Context
     ↓
Vaccination Progress
```

This framework supports a broader view of pandemic activity than looking at case counts alone.

---

## 8. Limitations

- COVID-19 reporting methodologies differed across countries.
- Testing availability varied over time.
- Reported cases do not necessarily represent all infections.
- Reported deaths may be affected by reporting and classification differences.
- Vaccination reporting can vary by source and date.
- The analysis is descriptive and does not establish causal relationships.
- Reported death percentage is not equivalent to infection fatality rate.

## Conclusion

This project demonstrates an end-to-end SQL Server and Tableau workflow for analyzing large-scale public-health data.

It demonstrates the ability to combine:

**Data Exploration → SQL Analytics → Population-Adjusted Metrics → Window Functions → Geographic Analysis → Tableau Storytelling**
