"""
===========================================================
Project: Employee Attrition & Workforce Analytics
File: 02_attrition_statistical_analysis.py
Purpose: Statistical Analysis of Attrition Drivers
===========================================================
"""

import pandas as pd
import numpy as np
from scipy.stats import chi2_contingency, mannwhitneyu

# ---------------------------------------------------------
# 1. Configuration
# ---------------------------------------------------------

CSV_PATH = (
    r"D:\Saahil\Project Work\Employee Attrition & Workforce Analytics"
    r"\data\WA_Fn-UseC_-HR-Employee-Attrition.csv"
)

OUTPUT_PATH = (
    r"D:\Saahil\Project Work\Employee Attrition & Workforce Analytics"
    r"\python\statistical_test_results.csv"
)

# ---------------------------------------------------------
# 2. Load Dataset
# ---------------------------------------------------------

df = pd.read_csv(CSV_PATH)

print("\n" + "=" * 70)
print("EMPLOYEE ATTRITION — STATISTICAL ANALYSIS")
print("=" * 70)

print(f"Dataset rows: {len(df)}")

# ---------------------------------------------------------
# 3. Helper Function — Chi-Square Test
# ---------------------------------------------------------

def chi_square_test(data, variable):
    """
    Tests whether a categorical workforce variable
    is associated with employee attrition.
    """

    contingency_table = pd.crosstab(
        data[variable],
        data["Attrition"]
    )

    chi2, p_value, dof, expected = chi2_contingency(
        contingency_table
    )

    n = contingency_table.to_numpy().sum()

    min_dimension = min(
        contingency_table.shape[0] - 1,
        contingency_table.shape[1] - 1
    )

    cramers_v = np.sqrt(
        chi2 / (n * min_dimension)
    )

    return {
        "Variable": variable,
        "Test": "Chi-Square",
        "Statistic": chi2,
        "P_Value": p_value,
        "Effect_Size": cramers_v,
        "Effect_Size_Type": "Cramer's V"
    }


# ---------------------------------------------------------
# 4. Helper Function — Mann-Whitney U Test
# ---------------------------------------------------------

def mann_whitney_test(data, variable):
    """
    Compares the distribution of a numerical variable
    between employees who left and employees who stayed.
    """

    stayed = data.loc[
        data["Attrition"] == "No",
        variable
    ].dropna()

    left = data.loc[
        data["Attrition"] == "Yes",
        variable
    ].dropna()

    statistic, p_value = mannwhitneyu(
        left,
        stayed,
        alternative="two-sided"
    )

    n_left = len(left)
    n_stayed = len(stayed)

    # Rank-biserial correlation.
    # Positive value indicates higher values in the
    # Attrition = Yes group.
    rank_biserial = (
        (2 * statistic) /
        (n_left * n_stayed)
    ) - 1

    return {
        "Variable": variable,
        "Test": "Mann-Whitney U",
        "Statistic": statistic,
        "P_Value": p_value,
        "Effect_Size": rank_biserial,
        "Effect_Size_Type": "Rank-Biserial Correlation"
    }


# ---------------------------------------------------------
# 5. Chi-Square Tests
# ---------------------------------------------------------

categorical_variables = [
    "OverTime",
    "JobSatisfaction",
    "WorkLifeBalance",
    "Department",
    "BusinessTravel",
    "MaritalStatus",
    "JobLevel",
]

chi_square_results = []

for variable in categorical_variables:

    result = chi_square_test(
        df,
        variable
    )

    chi_square_results.append(result)

# ---------------------------------------------------------
# 6. Mann-Whitney U Tests
# ---------------------------------------------------------

numeric_variables = [
    "MonthlyIncome",
    "YearsAtCompany",
    "Age",
    "TotalWorkingYears",
    "YearsSinceLastPromotion",
]

mann_whitney_results = []

for variable in numeric_variables:

    result = mann_whitney_test(
        df,
        variable
    )

    mann_whitney_results.append(result)

# ---------------------------------------------------------
# 7. Combine Results
# ---------------------------------------------------------

results = pd.DataFrame(
    chi_square_results + mann_whitney_results
)

results["Significant"] = np.where(
    results["P_Value"] < 0.05,
    "Yes",
    "No"
)

results["P_Value"] = results["P_Value"].round(6)

results["Statistic"] = results["Statistic"].round(4)

results["Effect_Size"] = results["Effect_Size"].round(4)

# ---------------------------------------------------------
# 8. Display Results
# ---------------------------------------------------------

print("\n" + "=" * 70)
print("STATISTICAL TEST RESULTS")
print("=" * 70)

print(
    results[
        [
            "Variable",
            "Test",
            "Statistic",
            "P_Value",
            "Effect_Size",
            "Effect_Size_Type",
            "Significant",
        ]
    ].to_string(index=False)
)

# ---------------------------------------------------------
# 9. Interpretation
# ---------------------------------------------------------

print("\n" + "=" * 70)
print("INTERPRETATION")
print("=" * 70)

for _, row in results.iterrows():

    if row["P_Value"] < 0.05:

        print(
            f"✓ {row['Variable']}: "
            f"statistically significant "
            f"(p = {row['P_Value']:.6f})"
        )

    else:

        print(
            f"○ {row['Variable']}: "
            f"not statistically significant "
            f"(p = {row['P_Value']:.6f})"
        )

# ---------------------------------------------------------
# 10. Save Results
# ---------------------------------------------------------

results.to_csv(
    OUTPUT_PATH,
    index=False
)

print("\n" + "=" * 70)
print("RESULTS SAVED")
print("=" * 70)

print(f"File: {OUTPUT_PATH}")

print("\n" + "=" * 70)
print("STATISTICAL ANALYSIS COMPLETE")
print("=" * 70)


"""
===========================================================
Project: Employee Attrition & Workforce Analytics
File: 02_attrition_statistical_analysis.py
Purpose: Statistical Analysis of Attrition Drivers
===========================================================
"""

import pandas as pd
import numpy as np
from scipy.stats import chi2_contingency, mannwhitneyu

# ---------------------------------------------------------
# 1. Configuration
# ---------------------------------------------------------

CSV_PATH = (
    r"D:\Saahil\Project Work\Employee Attrition & Workforce Analytics"
    r"\data\WA_Fn-UseC_-HR-Employee-Attrition.csv"
)

OUTPUT_PATH = (
    r"D:\Saahil\Project Work\Employee Attrition & Workforce Analytics"
    r"\python\statistical_test_results.csv"
)

# ---------------------------------------------------------
# 2. Load Dataset
# ---------------------------------------------------------

df = pd.read_csv(CSV_PATH)

print("\n" + "=" * 70)
print("EMPLOYEE ATTRITION — STATISTICAL ANALYSIS")
print("=" * 70)

print(f"Dataset rows: {len(df)}")

# ---------------------------------------------------------
# 3. Helper Function — Chi-Square Test
# ---------------------------------------------------------

def chi_square_test(data, variable):
    """
    Tests whether a categorical workforce variable
    is associated with employee attrition.
    """

    contingency_table = pd.crosstab(
        data[variable],
        data["Attrition"]
    )

    chi2, p_value, dof, expected = chi2_contingency(
        contingency_table
    )

    n = contingency_table.to_numpy().sum()

    min_dimension = min(
        contingency_table.shape[0] - 1,
        contingency_table.shape[1] - 1
    )

    cramers_v = np.sqrt(
        chi2 / (n * min_dimension)
    )

    return {
        "Variable": variable,
        "Test": "Chi-Square",
        "Statistic": chi2,
        "P_Value": p_value,
        "Effect_Size": cramers_v,
        "Effect_Size_Type": "Cramer's V"
    }


# ---------------------------------------------------------
# 4. Helper Function — Mann-Whitney U Test
# ---------------------------------------------------------

def mann_whitney_test(data, variable):
    """
    Compares the distribution of a numerical variable
    between employees who left and employees who stayed.
    """

    stayed = data.loc[
        data["Attrition"] == "No",
        variable
    ].dropna()

    left = data.loc[
        data["Attrition"] == "Yes",
        variable
    ].dropna()

    statistic, p_value = mannwhitneyu(
        left,
        stayed,
        alternative="two-sided"
    )

    n_left = len(left)
    n_stayed = len(stayed)

    # Rank-biserial correlation.
    # Positive value indicates higher values in the
    # Attrition = Yes group.
    rank_biserial = (
        (2 * statistic) /
        (n_left * n_stayed)
    ) - 1

    return {
        "Variable": variable,
        "Test": "Mann-Whitney U",
        "Statistic": statistic,
        "P_Value": p_value,
        "Effect_Size": rank_biserial,
        "Effect_Size_Type": "Rank-Biserial Correlation"
    }


# ---------------------------------------------------------
# 5. Chi-Square Tests
# ---------------------------------------------------------

categorical_variables = [
    "OverTime",
    "JobSatisfaction",
    "WorkLifeBalance",
    "Department",
    "BusinessTravel",
    "MaritalStatus",
    "JobLevel",
]

chi_square_results = []

for variable in categorical_variables:

    result = chi_square_test(
        df,
        variable
    )

    chi_square_results.append(result)

# ---------------------------------------------------------
# 6. Mann-Whitney U Tests
# ---------------------------------------------------------

numeric_variables = [
    "MonthlyIncome",
    "YearsAtCompany",
    "Age",
    "TotalWorkingYears",
    "YearsSinceLastPromotion",
]

mann_whitney_results = []

for variable in numeric_variables:

    result = mann_whitney_test(
        df,
        variable
    )

    mann_whitney_results.append(result)

# ---------------------------------------------------------
# 7. Combine Results
# ---------------------------------------------------------

results = pd.DataFrame(
    chi_square_results + mann_whitney_results
)

results["Significant"] = np.where(
    results["P_Value"] < 0.05,
    "Yes",
    "No"
)

results["P_Value"] = results["P_Value"].round(6)

results["Statistic"] = results["Statistic"].round(4)

results["Effect_Size"] = results["Effect_Size"].round(4)

# ---------------------------------------------------------
# 8. Display Results
# ---------------------------------------------------------

print("\n" + "=" * 70)
print("STATISTICAL TEST RESULTS")
print("=" * 70)

print(
    results[
        [
            "Variable",
            "Test",
            "Statistic",
            "P_Value",
            "Effect_Size",
            "Effect_Size_Type",
            "Significant",
        ]
    ].to_string(index=False)
)

# ---------------------------------------------------------
# 9. Interpretation
# ---------------------------------------------------------

print("\n" + "=" * 70)
print("INTERPRETATION")
print("=" * 70)

for _, row in results.iterrows():

    if row["P_Value"] < 0.05:

        print(
            f"✓ {row['Variable']}: "
            f"statistically significant "
            f"(p = {row['P_Value']:.6f})"
        )

    else:

        print(
            f"○ {row['Variable']}: "
            f"not statistically significant "
            f"(p = {row['P_Value']:.6f})"
        )

# ---------------------------------------------------------
# 10. Save Results
# ---------------------------------------------------------

results.to_csv(
    OUTPUT_PATH,
    index=False
)

print("\n" + "=" * 70)
print("RESULTS SAVED")
print("=" * 70)

print(f"File: {OUTPUT_PATH}")

print("\n" + "=" * 70)
print("STATISTICAL ANALYSIS COMPLETE")
print("=" * 70)