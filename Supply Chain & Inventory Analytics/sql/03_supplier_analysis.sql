-- Project 3: Supply Chain & Inventory Analytics
-- 03_supplier_analysis.sql

USE supply_chain_analytics;

DROP TABLE IF EXISTS supplier_analysis;
CREATE TABLE supplier_analysis AS
SELECT
    supplier_id,
    COUNT(*) AS records,
    COUNT(DISTINCT sku_id) AS sku_count,
    COUNT(DISTINCT warehouse_id) AS warehouse_count,
    ROUND(AVG(supplier_lead_time_days),2) AS avg_lead_time_days,
    ROUND(AVG(order_quantity),2) AS avg_order_quantity,
    ROUND(AVG(inventory_level),2) AS avg_inventory,
    ROUND(AVG(forecast_inventory_coverage_days),2) AS avg_coverage_days,
    SUM(reorder_alert) AS reorder_alerts,
    ROUND(SUM(sales_revenue),2) AS revenue,
    ROUND(SUM(gross_profit),2) AS gross_profit,
    ROUND(SUM(gross_profit) / NULLIF(SUM(sales_revenue),0) * 100,2) AS gross_margin_pct
FROM supply_chain
GROUP BY supplier_id
ORDER BY revenue DESC;

SELECT * FROM supplier_analysis ORDER BY revenue DESC;

-- Lead-time analysis
SELECT
    supplier_lead_time_days,
    COUNT(*) AS records,
    ROUND(AVG(inventory_level),2) AS avg_inventory,
    ROUND(AVG(forecast_inventory_coverage_days),2) AS avg_coverage_days,
    SUM(reorder_alert) AS reorder_alerts,
    ROUND(SUM(sales_revenue),2) AS revenue
FROM supply_chain
GROUP BY supplier_lead_time_days
ORDER BY supplier_lead_time_days;
