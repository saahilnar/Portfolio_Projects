# Python Analysis — Employee Attrition & Workforce Analytics

## Overview

This folder contains the Python-based exploratory and statistical analysis
performed for the Employee Attrition & Workforce Analytics project.

The analysis focuses on identifying workforce patterns associated with
employee attrition.

## Files

### 01_employee_attrition_eda.py

Performs exploratory data analysis including:

- Dataset structure and data types
- Missing-value checks
- Duplicate checks
- Numerical summaries
- Overall attrition distribution
- Department-level attrition
- Job-role attrition
- Overtime analysis
- Salary-band analysis
- Tenure-band analysis
- Job satisfaction analysis
- Work-life balance analysis
- Income and age distributions
- Correlation analysis
- Workforce visualizations

### 02_attrition_statistical_analysis.py

Performs statistical hypothesis testing using:

- Chi-square tests for categorical variables
- Mann-Whitney U tests for numerical variables
- Cramer's V effect size
- Rank-biserial correlation

The statistical analysis is used to evaluate whether observed differences
between attrition groups are statistically significant.

### statistical_test_results.csv

Contains the output of the statistical tests performed by
`02_attrition_statistical_analysis.py`.

## Key Statistical Findings

At a significance threshold of p < 0.05, the tested variables in this
analysis showed statistically significant associations/differences with
employee attrition.

Variables tested include:

- Overtime
- Job Satisfaction
- Work-Life Balance
- Department
- Business Travel
- Marital Status
- Job Level
- Monthly Income
- Years at Company
- Age
- Total Working Years
- Years Since Last Promotion

## Important Interpretation Note

Statistical significance indicates that the observed relationship is
unlikely to be explained by random sampling variation under the tested
hypothesis.

It does not establish causation.

Effect sizes are therefore included alongside p-values to provide
additional context about the magnitude of the observed relationships.

## Dataset

The project uses the IBM HR Analytics Employee Attrition & Performance
dataset.

The dataset is commonly used for analytics and learning purposes and
represents a fictional workforce dataset.

## Tools

- Python
- Pandas
- NumPy
- SciPy
- Matplotlib
- Seaborn