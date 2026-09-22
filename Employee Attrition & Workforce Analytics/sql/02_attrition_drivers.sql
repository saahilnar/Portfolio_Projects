/*
===========================================================
Project: Employee Attrition & Workforce Analytics
File: 02_attrition_drivers.sql
Purpose: Analyze key factors associated with employee attrition
Database: employee_attrition_analytics
===========================================================
*/

USE employee_attrition_analytics;


/* =========================================================
1. Attrition by Salary Band
========================================================= */

SELECT
    CASE
        WHEN monthly_income < 3000 THEN 'Below 3000'
        WHEN monthly_income < 5000 THEN '3000 - 4999'
        WHEN monthly_income < 8000 THEN '5000 - 7999'
        WHEN monthly_income < 12000 THEN '8000 - 11999'
        ELSE '12000+'
    END AS salary_band,
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate,
    ROUND(AVG(years_at_company), 2) AS avg_years_at_company
FROM employee_attrition
GROUP BY
    CASE
        WHEN monthly_income < 3000 THEN 'Below 3000'
        WHEN monthly_income < 5000 THEN '3000 - 4999'
        WHEN monthly_income < 8000 THEN '5000 - 7999'
        WHEN monthly_income < 12000 THEN '8000 - 11999'
        ELSE '12000+'
    END
ORDER BY MIN(monthly_income);


/* =========================================================
2. Attrition by Tenure Band
========================================================= */

SELECT
    CASE
        WHEN years_at_company <= 1 THEN '0-1 years'
        WHEN years_at_company <= 3 THEN '2-3 years'
        WHEN years_at_company <= 5 THEN '4-5 years'
        WHEN years_at_company <= 10 THEN '6-10 years'
        ELSE '10+ years'
    END AS tenure_band,
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate,
    ROUND(AVG(monthly_income), 2) AS avg_monthly_income
FROM employee_attrition
GROUP BY
    CASE
        WHEN years_at_company <= 1 THEN '0-1 years'
        WHEN years_at_company <= 3 THEN '2-3 years'
        WHEN years_at_company <= 5 THEN '4-5 years'
        WHEN years_at_company <= 10 THEN '6-10 years'
        ELSE '10+ years'
    END
ORDER BY MIN(years_at_company);


/* =========================================================
3. Attrition by Job Satisfaction
========================================================= */

SELECT
    job_satisfaction,
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_attrition
GROUP BY job_satisfaction
ORDER BY job_satisfaction;


/* =========================================================
4. Attrition by Work-Life Balance
========================================================= */

SELECT
    work_life_balance,
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_attrition
GROUP BY work_life_balance
ORDER BY work_life_balance;


/* =========================================================
5. Attrition by Years Since Last Promotion
========================================================= */

SELECT
    CASE
        WHEN years_since_last_promotion <= 1 THEN '0-1 years'
        WHEN years_since_last_promotion <= 3 THEN '2-3 years'
        WHEN years_since_last_promotion <= 5 THEN '4-5 years'
        ELSE '6+ years'
    END AS promotion_gap_band,
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate,
    ROUND(AVG(monthly_income), 2) AS avg_monthly_income
FROM employee_attrition
GROUP BY
    CASE
        WHEN years_since_last_promotion <= 1 THEN '0-1 years'
        WHEN years_since_last_promotion <= 3 THEN '2-3 years'
        WHEN years_since_last_promotion <= 5 THEN '4-5 years'
        ELSE '6+ years'
    END
ORDER BY MIN(years_since_last_promotion);


/* =========================================================
6. Attrition by Years With Current Manager
========================================================= */

SELECT
    CASE
        WHEN years_with_current_manager <= 1 THEN '0-1 years'
        WHEN years_with_current_manager <= 3 THEN '2-3 years'
        WHEN years_with_current_manager <= 5 THEN '4-5 years'
        ELSE '6+ years'
    END AS manager_tenure_band,
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_attrition
GROUP BY
    CASE
        WHEN years_with_current_manager <= 1 THEN '0-1 years'
        WHEN years_with_current_manager <= 3 THEN '2-3 years'
        WHEN years_with_current_manager <= 5 THEN '4-5 years'
        ELSE '6+ years'
    END
ORDER BY MIN(years_with_current_manager);


/* =========================================================
7. Attrition by Age Band
========================================================= */

SELECT
    CASE
        WHEN age < 25 THEN 'Under 25'
        WHEN age < 35 THEN '25-34'
        WHEN age < 45 THEN '35-44'
        WHEN age < 55 THEN '45-54'
        ELSE '55+'
    END AS age_band,
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_attrition
GROUP BY
    CASE
        WHEN age < 25 THEN 'Under 25'
        WHEN age < 35 THEN '25-34'
        WHEN age < 45 THEN '35-44'
        WHEN age < 55 THEN '45-54'
        ELSE '55+'
    END
ORDER BY MIN(age);


/* =========================================================
8. Overtime + Salary Band
========================================================= */

SELECT
    overtime,
    CASE
        WHEN monthly_income < 3000 THEN 'Below 3000'
        WHEN monthly_income < 5000 THEN '3000 - 4999'
        WHEN monthly_income < 8000 THEN '5000 - 7999'
        WHEN monthly_income < 12000 THEN '8000 - 11999'
        ELSE '12000+'
    END AS salary_band,
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_attrition
GROUP BY
    overtime,
    CASE
        WHEN monthly_income < 3000 THEN 'Below 3000'
        WHEN monthly_income < 5000 THEN '3000 - 4999'
        WHEN monthly_income < 8000 THEN '5000 - 7999'
        WHEN monthly_income < 12000 THEN '8000 - 11999'
        ELSE '12000+'
    END
ORDER BY overtime, MIN(monthly_income);


/* =========================================================
9. Overtime + Tenure Band
========================================================= */

SELECT
    overtime,
    CASE
        WHEN years_at_company <= 1 THEN '0-1 years'
        WHEN years_at_company <= 3 THEN '2-3 years'
        WHEN years_at_company <= 5 THEN '4-5 years'
        WHEN years_at_company <= 10 THEN '6-10 years'
        ELSE '10+ years'
    END AS tenure_band,
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_attrition
GROUP BY
    overtime,
    CASE
        WHEN years_at_company <= 1 THEN '0-1 years'
        WHEN years_at_company <= 3 THEN '2-3 years'
        WHEN years_at_company <= 5 THEN '4-5 years'
        WHEN years_at_company <= 10 THEN '6-10 years'
        ELSE '10+ years'
    END
ORDER BY overtime, MIN(years_at_company);


/* =========================================================
10. Attrition by Training Frequency
========================================================= */

SELECT
    training_times_last_year,
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_attrition
GROUP BY training_times_last_year
ORDER BY training_times_last_year;