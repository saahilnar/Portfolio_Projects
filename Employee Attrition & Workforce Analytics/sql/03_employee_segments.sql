/*
===========================================================
Project: Employee Attrition & Workforce Analytics
File: 03_employee_segments.sql
Purpose: Create employee-level analytical segments
Database: employee_attrition_analytics
===========================================================
*/

USE employee_attrition_analytics;


/* =========================================================
1. Employee Attrition Risk Segmentation
   Descriptive segmentation only — NOT a predictive model.
========================================================= */

SELECT
    employee_id,
    age,
    department,
    job_role,
    job_level,
    monthly_income,
    years_at_company,
    overtime,
    job_satisfaction,
    work_life_balance,
    years_since_last_promotion,
    years_with_current_manager,
    attrition,

    CASE
        WHEN years_at_company <= 1
             AND overtime = 'Yes'
             AND monthly_income < 5000
            THEN 'Early Career - High Exposure'

        WHEN years_at_company <= 3
             AND overtime = 'Yes'
            THEN 'Early Career - Overtime'

        WHEN monthly_income < 3000
             AND overtime = 'Yes'
            THEN 'Lower Income - Overtime'

        WHEN years_since_last_promotion >= 5
             AND years_at_company >= 5
            THEN 'Long Promotion Gap'

        WHEN job_satisfaction = 1
             AND work_life_balance = 1
            THEN 'Low Satisfaction & Balance'

        ELSE 'Other'
    END AS employee_segment

FROM employee_attrition;


/* =========================================================
2. Segment-Level Attrition Summary
========================================================= */

SELECT
    employee_segment,
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate,
    ROUND(AVG(monthly_income), 2) AS avg_monthly_income,
    ROUND(AVG(years_at_company), 2) AS avg_years_at_company
FROM
(
    SELECT
        employee_id,
        monthly_income,
        years_at_company,
        attrition,

        CASE
            WHEN years_at_company <= 1
                 AND overtime = 'Yes'
                 AND monthly_income < 5000
                THEN 'Early Career - High Exposure'

            WHEN years_at_company <= 3
                 AND overtime = 'Yes'
                THEN 'Early Career - Overtime'

            WHEN monthly_income < 3000
                 AND overtime = 'Yes'
                THEN 'Lower Income - Overtime'

            WHEN years_since_last_promotion >= 5
                 AND years_at_company >= 5
                THEN 'Long Promotion Gap'

            WHEN job_satisfaction = 1
                 AND work_life_balance = 1
                THEN 'Low Satisfaction & Balance'

            ELSE 'Other'
        END AS employee_segment

    FROM employee_attrition
) AS segmented_employees
GROUP BY employee_segment
ORDER BY attrition_rate DESC;


/* =========================================================
3. High-Exposure Population
========================================================= */

SELECT
    COUNT(*) AS high_exposure_employees,
    SUM(attrition = 'Yes') AS high_exposure_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS high_exposure_attrition_rate
FROM employee_attrition
WHERE years_at_company <= 1
  AND overtime = 'Yes'
  AND monthly_income < 5000;


/* =========================================================
4. Employees With Long Promotion Gaps
========================================================= */

SELECT
    COUNT(*) AS long_promotion_gap_employees,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_attrition
WHERE years_at_company >= 5
  AND years_since_last_promotion >= 5;


/* =========================================================
5. Low Satisfaction + Poor Work-Life Balance
========================================================= */

SELECT
    COUNT(*) AS employees_in_segment,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_attrition
WHERE job_satisfaction = 1
  AND work_life_balance = 1;


/* =========================================================
6. Attrition by Job Role + Overtime
========================================================= */

SELECT
    job_role,
    overtime,
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_attrition
GROUP BY
    job_role,
    overtime
ORDER BY
    attrition_rate DESC;


/* =========================================================
7. Attrition by Job Role + Salary Band
========================================================= */

SELECT
    job_role,
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
    job_role,
    CASE
        WHEN monthly_income < 3000 THEN 'Below 3000'
        WHEN monthly_income < 5000 THEN '3000 - 4999'
        WHEN monthly_income < 8000 THEN '5000 - 7999'
        WHEN monthly_income < 12000 THEN '8000 - 11999'
        ELSE '12000+'
    END
HAVING COUNT(*) >= 10
ORDER BY attrition_rate DESC;


/* =========================================================
8. Attrition by Department + Overtime
========================================================= */

SELECT
    department,
    overtime,
    COUNT(*) AS total_employees,
    SUM(attrition = 'Yes') AS employees_left,
    ROUND(
        SUM(attrition = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_attrition
GROUP BY
    department,
    overtime
ORDER BY
    department,
    attrition_rate DESC;