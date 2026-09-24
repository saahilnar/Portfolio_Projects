-- Project 3: Supply Chain & Inventory Analytics
-- 01_supply_chain_kpis.sql

USE supply_chain_analytics;

-- Overall KPI summary
DROP TABLE IF EXISTS supply_chain_kpi_summary;
CREATE TABLE supply_chain_kpi_summary AS
SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT sku_id) AS total_skus,
    COUNT(DISTINCT warehouse_id) AS total_warehouses,
    COUNT(DISTINCT supplier_id) AS total_suppliers,
    ROUND(SUM(units_sold), 0) AS total_units_sold,
    ROUND(SUM(sales_revenue), 2) AS total_revenue,
    ROUND(SUM(gross_profit), 2) AS total_gross_profit,
    ROUND(SUM(gross_profit) / NULLIF(SUM(sales_revenue),0) * 100, 2) AS gross_margin_pct,
    ROUND(AVG(inventory_level), 2) AS avg_inventory,
    ROUND(AVG(demand_forecast), 2) AS avg_daily_forecast,
    ROUND(AVG(supplier_lead_time_days), 2) AS avg_supplier_lead_time_days,
    ROUND(AVG(order_quantity), 2) AS avg_order_quantity,
    SUM(reorder_alert) AS total_reorder_alerts,
    ROUND(AVG(forecast_inventory_coverage_days), 2) AS avg_inventory_coverage_days,
    SUM(promotion_flag) AS promotion_records,
    SUM(stockout_flag) AS stockout_records
FROM supply_chain;

SELECT * FROM supply_chain_kpi_summary;

-- Monthly performance
DROP TABLE IF EXISTS monthly_supply_chain_analysis;
CREATE TABLE monthly_supply_chain_analysis AS
SELECT
    DATE_FORMAT(date, '%Y-%m') AS month,
    SUM(units_sold) AS units_sold,
    ROUND(SUM(sales_revenue), 2) AS revenue,
    ROUND(SUM(gross_profit), 2) AS gross_profit,
    ROUND(SUM(gross_profit) / NULLIF(SUM(sales_revenue),0) * 100, 2) AS gross_margin_pct,
    ROUND(AVG(inventory_level), 2) AS avg_inventory,
    ROUND(AVG(demand_forecast), 2) AS avg_daily_forecast,
    ROUND(AVG(forecast_inventory_coverage_days), 2) AS avg_coverage_days,
    SUM(reorder_alert) AS reorder_alerts,
    SUM(promotion_flag) AS promotion_records
FROM supply_chain
GROUP BY DATE_FORMAT(date, '%Y-%m')
ORDER BY month;

SELECT * FROM monthly_supply_chain_analysis;

-- Regional performance
SELECT
    region,
    COUNT(*) AS records,
    SUM(units_sold) AS units_sold,
    ROUND(SUM(sales_revenue), 2) AS revenue,
    ROUND(SUM(gross_profit), 2) AS gross_profit,
    ROUND(SUM(gross_profit) / NULLIF(SUM(sales_revenue),0) * 100, 2) AS gross_margin_pct
FROM supply_chain
GROUP BY region
ORDER BY revenue DESC;
