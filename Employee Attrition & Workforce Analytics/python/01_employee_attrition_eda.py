"""
===========================================================
Project: Employee Attrition & Workforce Analytics
File: 01_employee_attrition_eda.py
Purpose: Exploratory Data Analysis
===========================================================
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# ---------------------------------------------------------
# 1. Configuration
# ---------------------------------------------------------

CSV_PATH = (
    r"D:\Saahil\Project Work\Employee Attrition & Workforce Analytics"
    r"\data\WA_Fn-UseC_-HR-Employee-Attrition.csv"
)

OUTPUT_PATH = (
    r"D:\Saahil\Project Work\Employee Attrition & Workforce Analytics"
    r""
)

# ---------------------------------------------------------
# 2. Load Dataset
# ---------------------------------------------------------

df = pd.read_csv(CSV_PATH)

print("\n" + "=" * 60)
print("DATASET OVERVIEW")
print("=" * 60)

print(f"Rows: {df.shape[0]}")
print(f"Columns: {df.shape[1]}")

print("\nFirst 5 rows:")
print(df.head())

# ---------------------------------------------------------
# 3. Data Types
# ---------------------------------------------------------

print("\n" + "=" * 60)
print("DATA TYPES")
print("=" * 60)

print(df.dtypes)

# ---------------------------------------------------------
# 4. Missing Values
# ---------------------------------------------------------

print("\n" + "=" * 60)
print("MISSING VALUES")
print("=" * 60)

missing_values = df.isnull().sum()

print(
    missing_values[missing_values > 0]
    if missing_values.sum() > 0
    else "No missing values found."
)

# ---------------------------------------------------------
# 5. Duplicate Records
# ---------------------------------------------------------

print("\n" + "=" * 60)
print("DUPLICATE RECORDS")
print("=" * 60)

print(f"Duplicate rows: {df.duplicated().sum()}")

# ---------------------------------------------------------
# 6. Basic Statistics
# ---------------------------------------------------------

print("\n" + "=" * 60)
print("NUMERICAL SUMMARY")
print("=" * 60)

print(df.describe().T)

# ---------------------------------------------------------
# 7. Attrition Distribution
# ---------------------------------------------------------

print("\n" + "=" * 60)
print("ATTRITION DISTRIBUTION")
print("=" * 60)

attrition_summary = (
    df["Attrition"]
    .value_counts()
    .rename_axis("Attrition")
    .reset_index(name="Employee_Count")
)

attrition_summary["Percentage"] = (
    attrition_summary["Employee_Count"]
    / len(df)
    * 100
)

print(attrition_summary)

# ---------------------------------------------------------
# 8. Attrition Rate
# ---------------------------------------------------------

attrition_rate = (
    df["Attrition"].eq("Yes").mean() * 100
)

print(f"\nOverall Attrition Rate: {attrition_rate:.2f}%")

# ---------------------------------------------------------
# 9. Department Analysis
# ---------------------------------------------------------

department_summary = (
    df.groupby("Department")
    .agg(
        Employees=("EmployeeNumber", "count"),
        Employees_Left=("Attrition", lambda x: (x == "Yes").sum()),
        Average_Income=("MonthlyIncome", "mean"),
        Average_Tenure=("YearsAtCompany", "mean"),
    )
    .reset_index()
)

department_summary["Attrition_Rate"] = (
    department_summary["Employees_Left"]
    / department_summary["Employees"]
    * 100
)

department_summary = department_summary.sort_values(
    "Attrition_Rate",
    ascending=False
)

print("\n" + "=" * 60)
print("DEPARTMENT ATTRITION")
print("=" * 60)

print(department_summary.round(2))

# ---------------------------------------------------------
# 10. Job Role Analysis
# ---------------------------------------------------------

job_role_summary = (
    df.groupby("JobRole")
    .agg(
        Employees=("EmployeeNumber", "count"),
        Employees_Left=("Attrition", lambda x: (x == "Yes").sum()),
        Average_Income=("MonthlyIncome", "mean"),
        Average_Tenure=("YearsAtCompany", "mean"),
    )
    .reset_index()
)

job_role_summary["Attrition_Rate"] = (
    job_role_summary["Employees_Left"]
    / job_role_summary["Employees"]
    * 100
)

job_role_summary = job_role_summary.sort_values(
    "Attrition_Rate",
    ascending=False
)

print("\n" + "=" * 60)
print("JOB ROLE ATTRITION")
print("=" * 60)

print(job_role_summary.round(2))

# ---------------------------------------------------------
# 11. Overtime Analysis
# ---------------------------------------------------------

overtime_summary = (
    df.groupby("OverTime")
    .agg(
        Employees=("EmployeeNumber", "count"),
        Employees_Left=("Attrition", lambda x: (x == "Yes").sum()),
        Average_Income=("MonthlyIncome", "mean"),
        Average_Tenure=("YearsAtCompany", "mean"),
    )
    .reset_index()
)

overtime_summary["Attrition_Rate"] = (
    overtime_summary["Employees_Left"]
    / overtime_summary["Employees"]
    * 100
)

print("\n" + "=" * 60)
print("OVERTIME ATTRITION")
print("=" * 60)

print(overtime_summary.round(2))

# ---------------------------------------------------------
# 12. Salary Band Analysis
# ---------------------------------------------------------

df["Salary_Band"] = pd.cut(
    df["MonthlyIncome"],
    bins=[0, 3000, 5000, 8000, 12000, np.inf],
    labels=[
        "Below 3000",
        "3000-4999",
        "5000-7999",
        "8000-11999",
        "12000+",
    ],
    right=False,
)

salary_summary = (
    df.groupby("Salary_Band", observed=False)
    .agg(
        Employees=("EmployeeNumber", "count"),
        Employees_Left=("Attrition", lambda x: (x == "Yes").sum()),
        Average_Tenure=("YearsAtCompany", "mean"),
    )
    .reset_index()
)

salary_summary["Attrition_Rate"] = (
    salary_summary["Employees_Left"]
    / salary_summary["Employees"]
    * 100
)

print("\n" + "=" * 60)
print("SALARY BAND ATTRITION")
print("=" * 60)

print(salary_summary.round(2))

# ---------------------------------------------------------
# 13. Tenure Band Analysis
# ---------------------------------------------------------

df["Tenure_Band"] = pd.cut(
    df["YearsAtCompany"],
    bins=[-1, 1, 3, 5, 10, np.inf],
    labels=[
        "0-1 Years",
        "2-3 Years",
        "4-5 Years",
        "6-10 Years",
        "10+ Years",
    ],
)

tenure_summary = (
    df.groupby("Tenure_Band", observed=False)
    .agg(
        Employees=("EmployeeNumber", "count"),
        Employees_Left=("Attrition", lambda x: (x == "Yes").sum()),
        Average_Income=("MonthlyIncome", "mean"),
    )
    .reset_index()
)

tenure_summary["Attrition_Rate"] = (
    tenure_summary["Employees_Left"]
    / tenure_summary["Employees"]
    * 100
)

print("\n" + "=" * 60)
print("TENURE BAND ATTRITION")
print("=" * 60)

print(tenure_summary.round(2))

# ---------------------------------------------------------
# 14. Job Satisfaction Analysis
# ---------------------------------------------------------

satisfaction_summary = (
    df.groupby("JobSatisfaction")
    .agg(
        Employees=("EmployeeNumber", "count"),
        Employees_Left=("Attrition", lambda x: (x == "Yes").sum()),
    )
    .reset_index()
)

satisfaction_summary["Attrition_Rate"] = (
    satisfaction_summary["Employees_Left"]
    / satisfaction_summary["Employees"]
    * 100
)

print("\n" + "=" * 60)
print("JOB SATISFACTION ATTRITION")
print("=" * 60)

print(satisfaction_summary.round(2))

# ---------------------------------------------------------
# 15. Work-Life Balance Analysis
# ---------------------------------------------------------

wlb_summary = (
    df.groupby("WorkLifeBalance")
    .agg(
        Employees=("EmployeeNumber", "count"),
        Employees_Left=("Attrition", lambda x: (x == "Yes").sum()),
    )
    .reset_index()
)

wlb_summary["Attrition_Rate"] = (
    wlb_summary["Employees_Left"]
    / wlb_summary["Employees"]
    * 100
)

print("\n" + "=" * 60)
print("WORK-LIFE BALANCE ATTRITION")
print("=" * 60)

print(wlb_summary.round(2))

# ---------------------------------------------------------
# 16. Visualization Settings
# ---------------------------------------------------------

sns.set_theme(style="whitegrid")

# ---------------------------------------------------------
# 17. Attrition Distribution Chart
# ---------------------------------------------------------

plt.figure(figsize=(7, 5))

sns.countplot(
    data=df,
    x="Attrition"
)

plt.title("Employee Attrition Distribution")
plt.xlabel("Attrition")
plt.ylabel("Employee Count")

plt.tight_layout()
plt.show()

# ---------------------------------------------------------
# 18. Department Attrition Chart
# ---------------------------------------------------------

plt.figure(figsize=(8, 5))

sns.barplot(
    data=department_summary,
    x="Department",
    y="Attrition_Rate"
)

plt.title("Attrition Rate by Department")
plt.xlabel("Department")
plt.ylabel("Attrition Rate (%)")

plt.tight_layout()
plt.show()

# ---------------------------------------------------------
# 19. Job Role Attrition Chart
# ---------------------------------------------------------

plt.figure(figsize=(10, 6))

sns.barplot(
    data=job_role_summary,
    x="Attrition_Rate",
    y="JobRole"
)

plt.title("Attrition Rate by Job Role")
plt.xlabel("Attrition Rate (%)")
plt.ylabel("Job Role")

plt.tight_layout()
plt.show()

# ---------------------------------------------------------
# 20. Overtime Attrition Chart
# ---------------------------------------------------------

plt.figure(figsize=(7, 5))

sns.barplot(
    data=overtime_summary,
    x="OverTime",
    y="Attrition_Rate"
)

plt.title("Attrition Rate by Overtime")
plt.xlabel("Overtime")
plt.ylabel("Attrition Rate (%)")

plt.tight_layout()
plt.show()

# ---------------------------------------------------------
# 21. Salary Band Attrition Chart
# ---------------------------------------------------------

plt.figure(figsize=(9, 5))

sns.barplot(
    data=salary_summary,
    x="Salary_Band",
    y="Attrition_Rate"
)

plt.title("Attrition Rate by Salary Band")
plt.xlabel("Monthly Income Band")
plt.ylabel("Attrition Rate (%)")
plt.xticks(rotation=20)

plt.tight_layout()
plt.show()

# ---------------------------------------------------------
# 22. Tenure Attrition Chart
# ---------------------------------------------------------

plt.figure(figsize=(9, 5))

sns.barplot(
    data=tenure_summary,
    x="Tenure_Band",
    y="Attrition_Rate"
)

plt.title("Attrition Rate by Tenure")
plt.xlabel("Years at Company")
plt.ylabel("Attrition Rate (%)")

plt.tight_layout()
plt.show()

# ---------------------------------------------------------
# 23. Income vs Attrition
# ---------------------------------------------------------

plt.figure(figsize=(8, 5))

sns.boxplot(
    data=df,
    x="Attrition",
    y="MonthlyIncome"
)

plt.title("Monthly Income Distribution by Attrition")
plt.xlabel("Attrition")
plt.ylabel("Monthly Income")

plt.tight_layout()
plt.show()

# ---------------------------------------------------------
# 24. Age vs Attrition
# ---------------------------------------------------------

plt.figure(figsize=(8, 5))

sns.boxplot(
    data=df,
    x="Attrition",
    y="Age"
)

plt.title("Age Distribution by Attrition")
plt.xlabel("Attrition")
plt.ylabel("Age")

plt.tight_layout()
plt.show()

# ---------------------------------------------------------
# 25. Correlation Analysis
# ---------------------------------------------------------

numeric_columns = [
    "Age",
    "DailyRate",
    "DistanceFromHome",
    "HourlyRate",
    "JobInvolvement",
    "JobLevel",
    "JobSatisfaction",
    "MonthlyIncome",
    "MonthlyRate",
    "NumCompaniesWorked",
    "PercentSalaryHike",
    "PerformanceRating",
    "RelationshipSatisfaction",
    "StockOptionLevel",
    "TotalWorkingYears",
    "TrainingTimesLastYear",
    "WorkLifeBalance",
    "YearsAtCompany",
    "YearsInCurrentRole",
    "YearsSinceLastPromotion",
    "YearsWithCurrManager",
]

correlation_matrix = df[numeric_columns].corr()

plt.figure(figsize=(14, 10))

sns.heatmap(
    correlation_matrix,
    annot=False,
    cmap="coolwarm",
    center=0
)

plt.title("Employee Workforce Correlation Matrix")

plt.tight_layout()
plt.show()

print("\n" + "=" * 60)
print("EDA COMPLETE")
print("=" * 60)