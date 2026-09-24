-- Project 3: Supply Chain & Inventory Analytics
-- 04_forecast_accuracy.sql

USE supply_chain_analytics;

-- Overall forecast accuracy. MAPE excludes zero-actual-sales records.
DROP TABLE IF EXISTS forecast_accuracy_overall;
CREATE TABLE forecast_accuracy_overall AS
SELECT
    'Overall' AS region,
    COUNT(*) AS total_records,
    SUM(CASE WHEN units_sold = 0 THEN 1 ELSE 0 END) AS zero_sales_records,
    ROUND(AVG(ABS(units_sold - demand_forecast)),2) AS mae,
    ROUND(SQRT(AVG(POW(units_sold - demand_forecast,2))),2) AS rmse,
    ROUND(
        AVG(
            CASE
                WHEN units_sold > 0
                THEN ABS(units_sold - demand_forecast) / units_sold
                ELSE NULL
            END
        ) * 100,2
    ) AS mape_pct,
    ROUND(AVG(demand_forecast - units_sold),2) AS forecast_bias
FROM supply_chain;

SELECT * FROM forecast_accuracy_overall;

-- Regional forecast accuracy
DROP TABLE IF EXISTS forecast_accuracy_analysis;
CREATE TABLE forecast_accuracy_analysis AS
SELECT
    region,
    COUNT(*) AS total_records,
    SUM(CASE WHEN units_sold = 0 THEN 1 ELSE 0 END) AS zero_sales_records,
    ROUND(AVG(ABS(units_sold - demand_forecast)),2) AS mae,
    ROUND(SQRT(AVG(POW(units_sold - demand_forecast,2))),2) AS rmse,
    ROUND(
        AVG(
            CASE
                WHEN units_sold > 0
                THEN ABS(units_sold - demand_forecast) / units_sold
                ELSE NULL
            END
        ) * 100,2
    ) AS mape_pct,
    ROUND(AVG(demand_forecast - units_sold),2) AS forecast_bias
FROM supply_chain
GROUP BY region
ORDER BY region;

SELECT * FROM forecast_accuracy_analysis;

-- Promotion vs non-promotion
SELECT
    CASE WHEN promotion_flag = 1 THEN 'Promotion' ELSE 'No Promotion' END AS promotion_status,
    COUNT(*) AS records,
    ROUND(AVG(units_sold),2) AS avg_units_sold,
    ROUND(AVG(demand_forecast),2) AS avg_forecast,
    ROUND(AVG(ABS(units_sold - demand_forecast)),2) AS mae,
    ROUND(
        AVG(
            CASE
                WHEN units_sold > 0
                THEN ABS(units_sold - demand_forecast) / units_sold
                ELSE NULL
            END
        ) * 100,2
    ) AS mape_pct,
    ROUND(AVG(demand_forecast - units_sold),2) AS forecast_bias
FROM supply_chain
GROUP BY promotion_flag
ORDER BY promotion_flag DESC;
