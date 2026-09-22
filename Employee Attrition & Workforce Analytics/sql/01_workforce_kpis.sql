/*
===========================================================
Project: Employee Attrition & Workforce Analytics
File: 01_workforce_kpis.sql
Purpose: Executive workforce and attrition KPIs
Database: employee_attrition_analytics
===========================================================
*/

USE employee_attrition_analytics;


/* =========================================================
1. Overall Workforce KPIs
========================================================= */

SELECT
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    SUM(attrition = 'No') AS employees_stayed,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate,
    ROUND(AVG(monthly_income), 2) AS avg_monthly_income,
    ROUND(AVG(years_at_company), 2) AS avg_years_at_company,
    ROUND(AVG(age), 2) AS avg_age
FROM employee_attrition;


/* =========================================================
2. Attrition Population Comparison
========================================================= */

SELECT
    attrition,
    COUNT(*) AS employee_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS workforce_percentage,
    ROUND(AVG(monthly_income), 2) AS avg_monthly_income,
    ROUND(AVG(years_at_company), 2) AS avg_years_at_company,
    ROUND(AVG(age), 2) AS avg_age,
    ROUND(AVG(total_working_years), 2) AS avg_total_working_years
FROM employee_attrition
GROUP BY attrition
ORDER BY attrition;


/* =========================================================
3. Attrition by Department
========================================================= */

SELECT
    department,
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    SUM(attrition = 'No') AS employees_stayed,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate,
    ROUND(AVG(monthly_income), 2) AS avg_monthly_income,
    ROUND(AVG(years_at_company), 2) AS avg_years_at_company
FROM employee_attrition
GROUP BY department
ORDER BY attrition_rate DESC;


/* =========================================================
4. Attrition by Job Role
========================================================= */

SELECT
    job_role,
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate,
    ROUND(AVG(monthly_income), 2) AS avg_monthly_income,
    ROUND(AVG(years_at_company), 2) AS avg_years_at_company
FROM employee_attrition
GROUP BY job_role
ORDER BY attrition_rate DESC;


/* =========================================================
5. Attrition by Job Level
========================================================= */

SELECT
    job_level,
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate,
    ROUND(AVG(monthly_income), 2) AS avg_monthly_income,
    ROUND(AVG(years_at_company), 2) AS avg_years_at_company
FROM employee_attrition
GROUP BY job_level
ORDER BY job_level;


/* =========================================================
6. Attrition by Overtime
========================================================= */

SELECT
    overtime,
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate,
    ROUND(AVG(monthly_income), 2) AS avg_monthly_income,
    ROUND(AVG(years_at_company), 2) AS avg_years_at_company
FROM employee_attrition
GROUP BY overtime
ORDER BY attrition_rate DESC;


/* =========================================================
7. Attrition by Business Travel
========================================================= */

SELECT
    business_travel,
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_attrition
GROUP BY business_travel
ORDER BY attrition_rate DESC;


/* =========================================================
8. Attrition by Gender
========================================================= */

SELECT
    gender,
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_attrition
GROUP BY gender
ORDER BY attrition_rate DESC;


/* =========================================================
9. Attrition by Marital Status
========================================================= */

SELECT
    marital_status,
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_attrition
GROUP BY marital_status
ORDER BY attrition_rate DESC;


/* =========================================================
10. Attrition by Education Field
========================================================= */

SELECT
    education_field,
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_attrition
GROUP BY education_field
ORDER BY attrition_rate DESC;