/* ============================================================
   PROJECT: Credit Card Portfolio & Risk Analytics
   Dataset: UCI Default of Credit Card Clients
   Database: fintech_credit_analytics
   Platform: MySQL 8.x
   ============================================================ */


/* ============================================================
   1. DATABASE SETUP
   ============================================================ */

CREATE DATABASE IF NOT EXISTS fintech_credit_analytics;

USE fintech_credit_analytics;


/* ============================================================
   2. RAW TABLE
   ============================================================ */

DROP TABLE IF EXISTS credit_card_raw;

CREATE TABLE credit_card_raw (
    ID INT,
    LIMIT_BAL DECIMAL(15,2),
    SEX TINYINT,
    EDUCATION TINYINT,
    MARRIAGE TINYINT,
    AGE INT,

    PAY_0 INT,
    PAY_2 INT,
    PAY_3 INT,
    PAY_4 INT,
    PAY_5 INT,
    PAY_6 INT,

    BILL_AMT1 DECIMAL(15,2),
    BILL_AMT2 DECIMAL(15,2),
    BILL_AMT3 DECIMAL(15,2),
    BILL_AMT4 DECIMAL(15,2),
    BILL_AMT5 DECIMAL(15,2),
    BILL_AMT6 DECIMAL(15,2),

    PAY_AMT1 DECIMAL(15,2),
    PAY_AMT2 DECIMAL(15,2),
    PAY_AMT3 DECIMAL(15,2),
    PAY_AMT4 DECIMAL(15,2),
    PAY_AMT5 DECIMAL(15,2),
    PAY_AMT6 DECIMAL(15,2),

    default_payment_next_month TINYINT
);


/* ============================================================
   3. CSV IMPORT
   ============================================================ */

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE
'D:/Saahil/Project Work/FinTech Credit Card Customer & Transaction Analytics/data/credit_card_clients.csv'
INTO TABLE credit_card_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


/* ============================================================
   4. RAW DATA VALIDATION
   ============================================================ */

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT ID) AS unique_customers
FROM credit_card_raw;


SELECT
    ID,
    COUNT(*) AS duplicate_count
FROM credit_card_raw
GROUP BY ID
HAVING COUNT(*) > 1;


SELECT
    COUNT(*) AS rows_with_nulls
FROM credit_card_raw
WHERE ID IS NULL
   OR LIMIT_BAL IS NULL
   OR SEX IS NULL
   OR EDUCATION IS NULL
   OR MARRIAGE IS NULL
   OR AGE IS NULL
   OR PAY_0 IS NULL
   OR PAY_2 IS NULL
   OR PAY_3 IS NULL
   OR PAY_4 IS NULL
   OR PAY_5 IS NULL
   OR PAY_6 IS NULL
   OR BILL_AMT1 IS NULL
   OR BILL_AMT2 IS NULL
   OR BILL_AMT3 IS NULL
   OR BILL_AMT4 IS NULL
   OR BILL_AMT5 IS NULL
   OR BILL_AMT6 IS NULL
   OR PAY_AMT1 IS NULL
   OR PAY_AMT2 IS NULL
   OR PAY_AMT3 IS NULL
   OR PAY_AMT4 IS NULL
   OR PAY_AMT5 IS NULL
   OR PAY_AMT6 IS NULL
   OR default_payment_next_month IS NULL;


SELECT
    MIN(LIMIT_BAL) AS min_credit_limit,
    MAX(LIMIT_BAL) AS max_credit_limit,
    ROUND(AVG(LIMIT_BAL),2) AS avg_credit_limit,
    MIN(AGE) AS min_age,
    MAX(AGE) AS max_age,
    ROUND(AVG(AGE),2) AS avg_age
FROM credit_card_raw;


/* ============================================================
   5. CUSTOMER ANALYTICS
   ============================================================ */

DROP TABLE IF EXISTS customer_analytics;

CREATE TABLE customer_analytics AS

SELECT
    ID AS customer_id,

    CASE
        WHEN SEX = 1 THEN 'Male'
        WHEN SEX = 2 THEN 'Female'
        ELSE 'Unknown'
    END AS gender,

    CASE
        WHEN EDUCATION = 1 THEN 'Graduate School'
        WHEN EDUCATION = 2 THEN 'University'
        WHEN EDUCATION = 3 THEN 'High School'
        WHEN EDUCATION = 4 THEN 'Other'
        ELSE 'Unknown'
    END AS education_level,

    CASE
        WHEN MARRIAGE = 1 THEN 'Married'
        WHEN MARRIAGE = 2 THEN 'Single'
        WHEN MARRIAGE = 3 THEN 'Other'
        ELSE 'Unknown'
    END AS marital_status,

    AGE AS age,

    CASE
        WHEN AGE < 30 THEN '18-29'
        WHEN AGE BETWEEN 30 AND 39 THEN '30-39'
        WHEN AGE BETWEEN 40 AND 49 THEN '40-49'
        WHEN AGE BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END AS age_group,

    LIMIT_BAL AS credit_limit,

    CASE
        WHEN LIMIT_BAL < 50000 THEN 'Under 50K'
        WHEN LIMIT_BAL < 100000 THEN '50K-99K'
        WHEN LIMIT_BAL < 200000 THEN '100K-199K'
        WHEN LIMIT_BAL < 500000 THEN '200K-499K'
        ELSE '500K+'
    END AS credit_limit_segment,

    BILL_AMT1,
    BILL_AMT2,
    BILL_AMT3,
    BILL_AMT4,
    BILL_AMT5,
    BILL_AMT6,

    PAY_AMT1,
    PAY_AMT2,
    PAY_AMT3,
    PAY_AMT4,
    PAY_AMT5,
    PAY_AMT6,

    ROUND(
        BILL_AMT1 +
        BILL_AMT2 +
        BILL_AMT3 +
        BILL_AMT4 +
        BILL_AMT5 +
        BILL_AMT6,
        2
    ) AS total_bill_amount,

    ROUND(
        (
            BILL_AMT1 +
            BILL_AMT2 +
            BILL_AMT3 +
            BILL_AMT4 +
            BILL_AMT5 +
            BILL_AMT6
        ) / 6,
        2
    ) AS avg_monthly_bill,

    GREATEST(
        BILL_AMT1,
        BILL_AMT2,
        BILL_AMT3,
        BILL_AMT4,
        BILL_AMT5,
        BILL_AMT6
    ) AS max_monthly_bill,

    ROUND(
        PAY_AMT1 +
        PAY_AMT2 +
        PAY_AMT3 +
        PAY_AMT4 +
        PAY_AMT5 +
        PAY_AMT6,
        2
    ) AS total_payment_amount,

    ROUND(
        (
            PAY_AMT1 +
            PAY_AMT2 +
            PAY_AMT3 +
            PAY_AMT4 +
            PAY_AMT5 +
            PAY_AMT6
        ) / 6,
        2
    ) AS avg_monthly_payment,

    ROUND(
        (
            (
                BILL_AMT1 +
                BILL_AMT2 +
                BILL_AMT3 +
                BILL_AMT4 +
                BILL_AMT5 +
                BILL_AMT6
            ) / 6
        ) / NULLIF(LIMIT_BAL,0),
        4
    ) AS avg_credit_utilization,

    ROUND(
        (
            PAY_AMT1 +
            PAY_AMT2 +
            PAY_AMT3 +
            PAY_AMT4 +
            PAY_AMT5 +
            PAY_AMT6
        )
        /
        NULLIF(
            BILL_AMT1 +
            BILL_AMT2 +
            BILL_AMT3 +
            BILL_AMT4 +
            BILL_AMT5 +
            BILL_AMT6,
            0
        ),
        4
    ) AS payment_to_bill_ratio,

    PAY_0,
    PAY_2,
    PAY_3,
    PAY_4,
    PAY_5,
    PAY_6,

    GREATEST(
        PAY_0,
        PAY_2,
        PAY_3,
        PAY_4,
        PAY_5,
        PAY_6
    ) AS max_delinquency_status,

    (
        CASE WHEN PAY_0 > 0 THEN 1 ELSE 0 END +
        CASE WHEN PAY_2 > 0 THEN 1 ELSE 0 END +
        CASE WHEN PAY_3 > 0 THEN 1 ELSE 0 END +
        CASE WHEN PAY_4 > 0 THEN 1 ELSE 0 END +
        CASE WHEN PAY_5 > 0 THEN 1 ELSE 0 END +
        CASE WHEN PAY_6 > 0 THEN 1 ELSE 0 END
    ) AS delinquent_months,

    (
        CASE WHEN PAY_0 >= 2 THEN 1 ELSE 0 END +
        CASE WHEN PAY_2 >= 2 THEN 1 ELSE 0 END +
        CASE WHEN PAY_3 >= 2 THEN 1 ELSE 0 END +
        CASE WHEN PAY_4 >= 2 THEN 1 ELSE 0 END +
        CASE WHEN PAY_5 >= 2 THEN 1 ELSE 0 END +
        CASE WHEN PAY_6 >= 2 THEN 1 ELSE 0 END
    ) AS severe_delinquency_months,

    CASE
        WHEN (
            (
                (
                    BILL_AMT1 +
                    BILL_AMT2 +
                    BILL_AMT3 +
                    BILL_AMT4 +
                    BILL_AMT5 +
                    BILL_AMT6
                ) / 6
            ) / NULLIF(LIMIT_BAL,0)
        ) < 0.30 THEN 'Low'

        WHEN (
            (
                (
                    BILL_AMT1 +
                    BILL_AMT2 +
                    BILL_AMT3 +
                    BILL_AMT4 +
                    BILL_AMT5 +
                    BILL_AMT6
                ) / 6
            ) / NULLIF(LIMIT_BAL,0)
        ) < 0.70 THEN 'Moderate'

        WHEN (
            (
                (
                    BILL_AMT1 +
                    BILL_AMT2 +
                    BILL_AMT3 +
                    BILL_AMT4 +
                    BILL_AMT5 +
                    BILL_AMT6
                ) / 6
            ) / NULLIF(LIMIT_BAL,0)
        ) <= 1.00 THEN 'High'

        ELSE 'Over Limit'
    END AS utilization_segment,

    CASE
        WHEN GREATEST(
            PAY_0,
            PAY_2,
            PAY_3,
            PAY_4,
            PAY_5,
            PAY_6
        ) >= 2
            THEN 'High Delinquency Risk'

        WHEN
            (
                (
                    (
                        BILL_AMT1 +
                        BILL_AMT2 +
                        BILL_AMT3 +
                        BILL_AMT4 +
                        BILL_AMT5 +
                        BILL_AMT6
                    ) / 6
                ) / NULLIF(LIMIT_BAL,0)
            ) > 0.70
            AND
            (
                PAY_0 > 0
                OR PAY_2 > 0
                OR PAY_3 > 0
                OR PAY_4 > 0
                OR PAY_5 > 0
                OR PAY_6 > 0
            )
            THEN 'High Utilization Risk'

        WHEN
            (
                (
                    (
                        BILL_AMT1 +
                        BILL_AMT2 +
                        BILL_AMT3 +
                        BILL_AMT4 +
                        BILL_AMT5 +
                        BILL_AMT6
                    ) / 6
                ) / NULLIF(LIMIT_BAL,0)
            ) > 0.70
            THEN 'High Utilization'

        WHEN
            PAY_0 > 0
            OR PAY_2 > 0
            OR PAY_3 > 0
            OR PAY_4 > 0
            OR PAY_5 > 0
            OR PAY_6 > 0
            THEN 'Delinquency Watch'

        ELSE 'Lower Risk Behavior'
    END AS behavioral_risk_segment,

    default_payment_next_month AS default_flag

FROM credit_card_raw;


/* ============================================================
   6. CUSTOMER ANALYTICS VALIDATION
   ============================================================ */

SELECT COUNT(*) AS analytical_customers
FROM customer_analytics;

SELECT
    behavioral_risk_segment,
    COUNT(*) AS customers
FROM customer_analytics
GROUP BY behavioral_risk_segment
ORDER BY customers DESC;

SELECT
    utilization_segment,
    COUNT(*) AS customers
FROM customer_analytics
GROUP BY utilization_segment;


/* ============================================================
   7. MONTHLY CUSTOMER BEHAVIOR
   ============================================================ */

DROP TABLE IF EXISTS monthly_customer_behavior;

CREATE TABLE monthly_customer_behavior AS

SELECT
    customer_id,
    1 AS month_number,
    'Month 1' AS month_label,
    PAY_0 AS repayment_status,
    BILL_AMT1 AS bill_amount,
    PAY_AMT1 AS payment_amount,
    ROUND(
        BILL_AMT1 / NULLIF(credit_limit,0),
        4
    ) AS credit_utilization
FROM customer_analytics

UNION ALL

SELECT
    customer_id,
    2,
    'Month 2',
    PAY_2,
    BILL_AMT2,
    PAY_AMT2,
    ROUND(
        BILL_AMT2 / NULLIF(credit_limit,0),
        4
    )
FROM customer_analytics

UNION ALL

SELECT
    customer_id,
    3,
    'Month 3',
    PAY_3,
    BILL_AMT3,
    PAY_AMT3,
    ROUND(
        BILL_AMT3 / NULLIF(credit_limit,0),
        4
    )
FROM customer_analytics

UNION ALL

SELECT
    customer_id,
    4,
    'Month 4',
    PAY_4,
    BILL_AMT4,
    PAY_AMT4,
    ROUND(
        BILL_AMT4 / NULLIF(credit_limit,0),
        4
    )
FROM customer_analytics

UNION ALL

SELECT
    customer_id,
    5,
    'Month 5',
    PAY_5,
    BILL_AMT5,
    PAY_AMT5,
    ROUND(
        BILL_AMT5 / NULLIF(credit_limit,0),
        4
    )
FROM customer_analytics

UNION ALL

SELECT
    customer_id,
    6,
    'Month 6',
    PAY_6,
    BILL_AMT6,
    PAY_AMT6,
    ROUND(
        BILL_AMT6 / NULLIF(credit_limit,0),
        4
    )
FROM customer_analytics;


/* ============================================================
   8. RISK SEGMENT ANALYSIS
   ============================================================ */

DROP TABLE IF EXISTS risk_segment_analysis;

CREATE TABLE risk_segment_analysis AS

SELECT
    behavioral_risk_segment,
    COUNT(*) AS customers,
    SUM(default_flag) AS default_customers,
    ROUND(
        SUM(default_flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,
    ROUND(
        AVG(avg_credit_utilization) * 100,
        2
    ) AS avg_utilization_pct,
    ROUND(
        AVG(avg_monthly_bill),
        2
    ) AS avg_monthly_bill,
    ROUND(
        AVG(avg_monthly_payment),
        2
    ) AS avg_monthly_payment
FROM customer_analytics
GROUP BY behavioral_risk_segment;


/* ============================================================
   9. AGE GROUP ANALYSIS
   ============================================================ */

DROP TABLE IF EXISTS age_group_analysis;

CREATE TABLE age_group_analysis AS

SELECT
    age_group,
    COUNT(*) AS customers,
    SUM(default_flag) AS default_customers,
    ROUND(
        SUM(default_flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,
    ROUND(
        AVG(credit_limit),
        2
    ) AS avg_credit_limit,
    ROUND(
        AVG(avg_monthly_bill),
        2
    ) AS avg_monthly_bill,
    ROUND(
        AVG(avg_credit_utilization) * 100,
        2
    ) AS avg_utilization_pct
FROM customer_analytics
GROUP BY age_group;


/* ============================================================
   10. GENDER ANALYSIS
   ============================================================ */

DROP TABLE IF EXISTS gender_analysis;

CREATE TABLE gender_analysis AS

SELECT
    gender,
    COUNT(*) AS customers,
    SUM(default_flag) AS default_customers,
    ROUND(
        SUM(default_flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,
    ROUND(
        AVG(credit_limit),
        2
    ) AS avg_credit_limit,
    ROUND(
        AVG(avg_monthly_bill),
        2
    ) AS avg_monthly_bill
FROM customer_analytics
GROUP BY gender;


/* ============================================================
   11. EDUCATION ANALYSIS
   ============================================================ */

DROP TABLE IF EXISTS education_analysis;

CREATE TABLE education_analysis AS

SELECT
    education_level,
    COUNT(*) AS customers,
    SUM(default_flag) AS default_customers,
    ROUND(
        SUM(default_flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,
    ROUND(
        AVG(credit_limit),
        2
    ) AS avg_credit_limit,
    ROUND(
        AVG(avg_monthly_bill),
        2
    ) AS avg_monthly_bill
FROM customer_analytics
GROUP BY education_level;


/* ============================================================
   12. MARITAL STATUS ANALYSIS
   ============================================================ */

DROP TABLE IF EXISTS marital_analysis;

CREATE TABLE marital_analysis AS

SELECT
    marital_status,
    COUNT(*) AS customers,
    SUM(default_flag) AS default_customers,
    ROUND(
        SUM(default_flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,
    ROUND(
        AVG(credit_limit),
        2
    ) AS avg_credit_limit,
    ROUND(
        AVG(avg_monthly_bill),
        2
    ) AS avg_monthly_bill
FROM customer_analytics
GROUP BY marital_status;


/* ============================================================
   13. CREDIT LIMIT ANALYSIS
   ============================================================ */

DROP TABLE IF EXISTS credit_limit_analysis;

CREATE TABLE credit_limit_analysis AS

SELECT
    credit_limit_segment,
    COUNT(*) AS customers,
    SUM(default_flag) AS default_customers,
    ROUND(
        SUM(default_flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,
    ROUND(
        AVG(credit_limit),
        2
    ) AS avg_credit_limit,
    ROUND(
        AVG(avg_monthly_bill),
        2
    ) AS avg_monthly_bill,
    ROUND(
        AVG(avg_credit_utilization) * 100,
        2
    ) AS avg_utilization_pct
FROM customer_analytics
GROUP BY credit_limit_segment;


/* ============================================================
   14. UTILIZATION ANALYSIS
   ============================================================ */

DROP TABLE IF EXISTS utilization_analysis;

CREATE TABLE utilization_analysis AS

SELECT
    utilization_segment,
    COUNT(*) AS customers,
    SUM(default_flag) AS default_customers,
    ROUND(
        SUM(default_flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,
    ROUND(
        AVG(avg_credit_utilization) * 100,
        2
    ) AS avg_utilization_pct,
    ROUND(
        AVG(credit_limit),
        2
    ) AS avg_credit_limit
FROM customer_analytics
GROUP BY utilization_segment;


/* Logical sort order for Power BI */

ALTER TABLE utilization_analysis
ADD COLUMN utilization_sort INT;

UPDATE utilization_analysis
SET utilization_sort =
    CASE utilization_segment
        WHEN 'Low' THEN 1
        WHEN 'Moderate' THEN 2
        WHEN 'High' THEN 3
        WHEN 'Over Limit' THEN 4
        ELSE 99
    END;


/* ============================================================
   15. DELINQUENCY ANALYSIS
   ============================================================ */

DROP TABLE IF EXISTS delinquency_analysis;

CREATE TABLE delinquency_analysis AS

SELECT
    CASE
        WHEN max_delinquency_status <= 0
            THEN 'No Delinquency'

        WHEN max_delinquency_status = 1
            THEN '1 Month Delinquency'

        WHEN max_delinquency_status = 2
            THEN '2 Months Delinquency'

        WHEN max_delinquency_status = 3
            THEN '3 Months Delinquency'

        ELSE '4+ Months Delinquency'
    END AS delinquency_level,

    COUNT(*) AS customers,

    SUM(default_flag) AS default_customers,

    ROUND(
        SUM(default_flag) * 100.0 / COUNT(*),
        2
    ) AS default_rate_pct,

    ROUND(
        AVG(credit_limit),
        2
    ) AS avg_credit_limit,

    ROUND(
        AVG(avg_monthly_bill),
        2
    ) AS avg_monthly_bill

FROM customer_analytics

GROUP BY
    CASE
        WHEN max_delinquency_status <= 0
            THEN 'No Delinquency'

        WHEN max_delinquency_status = 1
            THEN '1 Month Delinquency'

        WHEN max_delinquency_status = 2
            THEN '2 Months Delinquency'

        WHEN max_delinquency_status = 3
            THEN '3 Months Delinquency'

        ELSE '4+ Months Delinquency'
    END;


/* Add logical sort */

ALTER TABLE delinquency_analysis
ADD COLUMN delinquency_sort INT;

UPDATE delinquency_analysis
SET delinquency_sort =
    CASE delinquency_level
        WHEN 'No Delinquency' THEN 1
        WHEN '1 Month Delinquency' THEN 2
        WHEN '2 Months Delinquency' THEN 3
        WHEN '3 Months Delinquency' THEN 4
        WHEN '4+ Months Delinquency' THEN 5
        ELSE 99
    END;


/* ============================================================
   16. MONTHLY PORTFOLIO ANALYSIS
   ============================================================ */

DROP TABLE IF EXISTS monthly_portfolio_analysis;

CREATE TABLE monthly_portfolio_analysis AS

SELECT
    1 AS month_number,
    'Month 1' AS month_label,

    COUNT(*) AS customers,

    ROUND(
        AVG(BILL_AMT1),
        2
    ) AS avg_bill_amount,

    ROUND(
        SUM(BILL_AMT1),
        2
    ) AS total_bill_amount,

    ROUND(
        AVG(PAY_AMT1),
        2
    ) AS avg_payment_amount,

    ROUND(
        SUM(PAY_AMT1),
        2
    ) AS total_payment_amount,

    ROUND(
        AVG(
            BILL_AMT1 / NULLIF(LIMIT_BAL,0)
        ) * 100,
        2
    ) AS avg_utilization_pct

FROM credit_card_raw

UNION ALL

SELECT
    2,
    'Month 2',
    COUNT(*),
    ROUND(AVG(BILL_AMT2),2),
    ROUND(SUM(BILL_AMT2),2),
    ROUND(AVG(PAY_AMT2),2),
    ROUND(SUM(PAY_AMT2),2),
    ROUND(
        AVG(
            BILL_AMT2 / NULLIF(LIMIT_BAL,0)
        ) * 100,
        2
    )
FROM credit_card_raw

UNION ALL

SELECT
    3,
    'Month 3',
    COUNT(*),
    ROUND(AVG(BILL_AMT3),2),
    ROUND(SUM(BILL_AMT3),2),
    ROUND(AVG(PAY_AMT3),2),
    ROUND(SUM(PAY_AMT3),2),
    ROUND(
        AVG(
            BILL_AMT3 / NULLIF(LIMIT_BAL,0)
        ) * 100,
        2
    )
FROM credit_card_raw

UNION ALL

SELECT
    4,
    'Month 4',
    COUNT(*),
    ROUND(AVG(BILL_AMT4),2),
    ROUND(SUM(BILL_AMT4),2),
    ROUND(AVG(PAY_AMT4),2),
    ROUND(SUM(PAY_AMT4),2),
    ROUND(
        AVG(
            BILL_AMT4 / NULLIF(LIMIT_BAL,0)
        ) * 100,
        2
    )
FROM credit_card_raw

UNION ALL

SELECT
    5,
    'Month 5',
    COUNT(*),
    ROUND(AVG(BILL_AMT5),2),
    ROUND(SUM(BILL_AMT5),2),
    ROUND(AVG(PAY_AMT5),2),
    ROUND(SUM(PAY_AMT5),2),
    ROUND(
        AVG(
            BILL_AMT5 / NULLIF(LIMIT_BAL,0)
        ) * 100,
        2
    )
FROM credit_card_raw

UNION ALL

SELECT
    6,
    'Month 6',
    COUNT(*),
    ROUND(AVG(BILL_AMT6),2),
    ROUND(SUM(BILL_AMT6),2),
    ROUND(AVG(PAY_AMT6),2),
    ROUND(SUM(PAY_AMT6),2),
    ROUND(
        AVG(
            BILL_AMT6 / NULLIF(LIMIT_BAL,0)
        ) * 100,
        2
    )
FROM credit_card_raw;


/* ============================================================
   17. DEFAULT ANALYSIS
   ============================================================ */

DROP TABLE IF EXISTS default_analysis;

CREATE TABLE default_analysis AS

SELECT
    CASE
        WHEN default_flag = 0 THEN 'Non-Default'
        WHEN default_flag = 1 THEN 'Default'
        ELSE 'Unknown'
    END AS default_status,

    COUNT(*) AS customers,

    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM customer_analytics),
        2
    ) AS customer_share_pct,

    ROUND(
        AVG(credit_limit),
        2
    ) AS avg_credit_limit,

    ROUND(
        AVG(avg_monthly_bill),
        2
    ) AS avg_monthly_bill,

    ROUND(
        AVG(avg_monthly_payment),
        2
    ) AS avg_monthly_payment,

    ROUND(
        AVG(avg_credit_utilization) * 100,
        2
    ) AS avg_utilization_pct,

    ROUND(
        AVG(delinquent_months),
        2
    ) AS avg_delinquent_months

FROM customer_analytics

GROUP BY default_flag;


/* ============================================================
   18. PORTFOLIO KPI SUMMARY
   ============================================================ */

DROP TABLE IF EXISTS portfolio_kpi_summary;

CREATE TABLE portfolio_kpi_summary AS

SELECT

    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN default_flag = 0 THEN 1
            ELSE 0
        END
    ) AS non_default_customers,

    SUM(
        CASE
            WHEN default_flag = 1 THEN 1
            ELSE 0
        END
    ) AS default_customers,

    ROUND(
        AVG(default_flag) * 100,
        2
    ) AS default_rate_pct,

    ROUND(
        SUM(credit_limit),
        2
    ) AS total_credit_limit,

    ROUND(
        AVG(credit_limit),
        2
    ) AS avg_credit_limit,

    ROUND(
        AVG(avg_monthly_bill),
        2
    ) AS avg_monthly_bill,

    ROUND(
        AVG(avg_monthly_payment),
        2
    ) AS avg_monthly_payment,

    ROUND(
        AVG(avg_credit_utilization) * 100,
        2
    ) AS avg_credit_utilization_pct,

    ROUND(
        AVG(payment_to_bill_ratio) * 100,
        2
    ) AS avg_payment_to_bill_pct,

    ROUND(
        AVG(delinquent_months),
        2
    ) AS avg_delinquent_months

FROM customer_analytics;


/* ============================================================
   19. CUSTOMER VALUE / OPPORTUNITY ANALYSIS
   ============================================================ */

DROP TABLE IF EXISTS customer_opportunity_analysis;

CREATE TABLE customer_opportunity_analysis AS

SELECT

    CASE
        WHEN credit_limit >= 200000
             AND avg_monthly_bill >= 50000
            THEN 'High Value'

        WHEN credit_limit >= 100000
             OR avg_monthly_bill >= 25000
            THEN 'Medium Value'

        ELSE 'Lower Value'
    END AS customer_value_segment,

    behavioral_risk_segment,

    COUNT(*) AS customers,

    ROUND(
        AVG(credit_limit),
        2
    ) AS avg_credit_limit,

    ROUND(
        AVG(avg_monthly_bill),
        2
    ) AS avg_monthly_bill,

    ROUND(
        AVG(avg_monthly_payment),
        2
    ) AS avg_monthly_payment,

    ROUND(
        AVG(avg_credit_utilization) * 100,
        2
    ) AS avg_utilization_pct,

    ROUND(
        AVG(default_flag) * 100,
        2
    ) AS default_rate_pct

FROM customer_analytics

GROUP BY
    CASE
        WHEN credit_limit >= 200000
             AND avg_monthly_bill >= 50000
            THEN 'High Value'

        WHEN credit_limit >= 100000
             OR avg_monthly_bill >= 25000
            THEN 'Medium Value'

        ELSE 'Lower Value'
    END,

    behavioral_risk_segment;


/* ============================================================
   20. FINAL VALIDATION
   ============================================================ */

SELECT
    'Raw Customers' AS metric,
    COUNT(*) AS value
FROM credit_card_raw

UNION ALL

SELECT
    'Analytical Customers',
    COUNT(*)
FROM customer_analytics

UNION ALL

SELECT
    'Monthly Behavior Records',
    COUNT(*)
FROM monthly_customer_behavior;


/* ============================================================
   21. FINAL KPI CHECK
   ============================================================ */

SELECT *
FROM portfolio_kpi_summary;


/* ============================================================
   22. FINAL ANALYSIS CHECKS
   ============================================================ */

SELECT *
FROM risk_segment_analysis
ORDER BY customers DESC;

SELECT *
FROM credit_limit_analysis
ORDER BY default_rate_pct DESC;

SELECT *
FROM utilization_analysis
ORDER BY utilization_sort;

SELECT *
FROM delinquency_analysis
ORDER BY delinquency_sort;

SELECT *
FROM age_group_analysis;

SELECT *
FROM education_analysis
ORDER BY default_rate_pct DESC;

SELECT *
FROM marital_analysis
ORDER BY default_rate_pct DESC;

SELECT *
FROM customer_opportunity_analysis
ORDER BY
    customer_value_segment,
    default_rate_pct DESC;

SELECT *
FROM monthly_portfolio_analysis
ORDER BY month_number;

SELECT *
FROM default_analysis;


/* ============================================================
   END OF SCRIPT
   ============================================================ */