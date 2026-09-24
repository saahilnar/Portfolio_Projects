-- Project 3: Supply Chain & Inventory Analytics
-- 02_inventory_analysis.sql

USE supply_chain_analytics;

-- SKU-level analysis
SELECT
    sku_id,
    SUM(units_sold) AS units_sold,
    ROUND(SUM(sales_revenue), 2) AS revenue,
    ROUND(SUM(gross_profit), 2) AS gross_profit,
    ROUND(SUM(gross_profit) / NULLIF(SUM(sales_revenue),0) * 100, 2) AS gross_margin_pct,
    ROUND(AVG(inventory_level), 2) AS avg_inventory,
    ROUND(AVG(demand_forecast), 2) AS avg_daily_forecast,
    ROUND(AVG(forecast_inventory_coverage_days), 2) AS avg_coverage_days,
    SUM(reorder_alert) AS reorder_alerts
FROM supply_chain
GROUP BY sku_id
ORDER BY revenue DESC;

-- High coverage SKUs
SELECT
    sku_id,
    SUM(units_sold) AS units_sold,
    ROUND(SUM(sales_revenue), 2) AS revenue,
    ROUND(AVG(inventory_level), 2) AS avg_inventory,
    ROUND(AVG(demand_forecast), 2) AS avg_daily_forecast,
    ROUND(AVG(forecast_inventory_coverage_days), 2) AS avg_coverage_days,
    SUM(reorder_alert) AS reorder_alerts
FROM supply_chain
GROUP BY sku_id
HAVING AVG(forecast_inventory_coverage_days) > 60
ORDER BY avg_coverage_days DESC;

-- Coverage bands
SELECT
    CASE
        WHEN forecast_inventory_coverage_days < 30 THEN 'Below 30 Days'
        WHEN forecast_inventory_coverage_days < 45 THEN '30–44 Days'
        WHEN forecast_inventory_coverage_days < 60 THEN '45–59 Days'
        WHEN forecast_inventory_coverage_days < 90 THEN '60–89 Days'
        ELSE '90+ Days'
    END AS coverage_band,
    COUNT(*) AS records,
    COUNT(DISTINCT sku_id) AS sku_count,
    ROUND(AVG(inventory_level), 2) AS avg_inventory,
    ROUND(AVG(demand_forecast), 2) AS avg_daily_forecast,
    ROUND(AVG(forecast_inventory_coverage_days), 2) AS avg_coverage_days,
    SUM(units_sold) AS units_sold,
    ROUND(SUM(sales_revenue), 2) AS revenue,
    SUM(reorder_alert) AS reorder_alerts
FROM supply_chain
GROUP BY coverage_band
ORDER BY FIELD(coverage_band,'Below 30 Days','30–44 Days','45–59 Days','60–89 Days','90+ Days');

-- SKU inventory segmentation
DROP TABLE IF EXISTS sku_inventory_analysis;
CREATE TABLE sku_inventory_analysis AS
WITH sku_metrics AS (
    SELECT
        sku_id,
        SUM(units_sold) AS units_sold,
        ROUND(SUM(sales_revenue), 2) AS revenue,
        ROUND(SUM(gross_profit), 2) AS gross_profit,
        ROUND(AVG(inventory_level), 2) AS avg_inventory,
        ROUND(AVG(demand_forecast), 2) AS avg_daily_forecast,
        ROUND(AVG(forecast_inventory_coverage_days), 2) AS avg_coverage_days,
        SUM(reorder_alert) AS reorder_alerts
    FROM supply_chain
    GROUP BY sku_id
),
ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (ORDER BY avg_daily_forecast) AS demand_rn,
        ROW_NUMBER() OVER (ORDER BY avg_coverage_days) AS coverage_rn,
        COUNT(*) OVER () AS total_skus
    FROM sku_metrics
),
thresholds AS (
    SELECT
        AVG(CASE WHEN demand_rn IN (FLOOR((total_skus+1)/2),CEIL((total_skus+1)/2)) THEN avg_daily_forecast END) AS median_demand,
        AVG(CASE WHEN coverage_rn IN (FLOOR((total_skus+1)/2),CEIL((total_skus+1)/2)) THEN avg_coverage_days END) AS median_coverage
    FROM ranked
)
SELECT
    r.*,
    ROUND(t.median_demand,2) AS median_demand,
    ROUND(t.median_coverage,2) AS median_coverage,
    CASE
        WHEN r.avg_daily_forecast >= t.median_demand AND r.avg_coverage_days < t.median_coverage THEN 'High Demand - Low Coverage'
        WHEN r.avg_daily_forecast < t.median_demand AND r.avg_coverage_days >= t.median_coverage THEN 'Low Demand - High Coverage'
        WHEN r.avg_daily_forecast >= t.median_demand AND r.avg_coverage_days >= t.median_coverage THEN 'High Demand - High Coverage'
        ELSE 'Low Demand - Low Coverage'
    END AS inventory_segment
FROM ranked r
CROSS JOIN thresholds t;

SELECT * FROM sku_inventory_analysis ORDER BY inventory_segment, revenue DESC;

-- Segment summary
SELECT
    inventory_segment,
    COUNT(*) AS sku_count,
    ROUND(SUM(units_sold),0) AS units_sold,
    ROUND(SUM(revenue),2) AS revenue,
    ROUND(AVG(avg_inventory),2) AS avg_inventory,
    ROUND(AVG(avg_daily_forecast),2) AS avg_daily_forecast,
    ROUND(AVG(avg_coverage_days),2) AS avg_coverage_days,
    SUM(reorder_alerts) AS reorder_alerts
FROM sku_inventory_analysis
GROUP BY inventory_segment
ORDER BY sku_count DESC;
