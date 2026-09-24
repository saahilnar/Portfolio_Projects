# Supply Chain & Inventory Analytics

An end-to-end Supply Chain and Inventory Analytics project built using **MySQL and Power BI** to analyze sales performance, inventory efficiency, SKU-level performance, supplier operations, demand forecasting, and replenishment activity.

## Project Overview

This project analyzes 91,250 supply-chain records covering:
- 50 SKUs
- 5 warehouses
- 10 suppliers
- 4 regions
- 2024 operational data

## Business Objectives

- Monitor revenue, gross profit, and gross margin
- Analyze monthly demand and revenue trends
- Evaluate inventory coverage and replenishment requirements
- Identify high-performing and high-risk SKUs
- Analyze supplier lead times and operational performance
- Measure demand forecast accuracy
- Compare promotion and non-promotion demand
- Support inventory and replenishment planning

## Tools & Technologies

- **MySQL 8** — Data loading, transformation, KPI calculations, and analytical tables
- **Power BI** — Interactive dashboard and business visualization
- **SQL** — Aggregation, segmentation, inventory analysis, supplier analysis, and forecast evaluation

## Key Metrics

| Metric | Result |
|---|---:|
| Total Revenue | ₹33.43M |
| Gross Profit | ₹11.09M |
| Gross Margin | 33.17% |
| Total Units Sold | 1.83M |
| Average Inventory | 471.52 |
| Reorder Alerts | 5,041 |
| Average Supplier Lead Time | 7.98 days |
| Forecast MAE | 2.38 units |
| Forecast RMSE | 2.99 units |
| Forecast MAPE | 16.32% |

## Key Findings

- Demand peaked in **March 2024** and reached its lowest level in **September**, followed by a Q4 recovery.
- Inventory levels remained relatively stable while demand varied considerably, creating large changes in inventory coverage.
- SKU-level revenue, profitability, coverage, and reorder activity vary across products.
- Supplier lead times remain within a relatively narrow range, while supplier revenue, profit, coverage, and reorder activity differ.
- Forecast accuracy is broadly consistent across regions, with MAPE around 16%.
- Promotion periods are associated with higher average units sold and higher demand forecasts than non-promotion periods.

## Power BI Dashboard

### 1. Supply Chain & Inventory Performance Overview
Executive KPIs, monthly trends, regional performance, top SKUs, supplier lead time, reorder alerts, and promotion analysis.

### 2. Inventory & SKU Insights
Inventory segmentation, SKU revenue vs coverage, reorder alerts, SKU profitability, inventory segments, supplier coverage, and SKU performance summary.

### 3. Forecast & Supplier Analytics
Forecast MAE/MAPE/RMSE, regional forecast accuracy, forecast bias, promotion demand, supplier revenue/profit, lead time, and supplier performance summary.

## Project Structure

```text
Supply Chain & Inventory Analytics/
├── data/
│   └── supply_chain_dataset1.csv
├── sql/
│   ├── 01_supply_chain_kpis.sql
│   ├── 02_inventory_analysis.sql
│   ├── 03_supplier_analysis.sql
│   └── 04_forecast_accuracy.sql
├── dashboard/
│   └── Supply_Chain_Inventory_Analytics.pbix
├── README.md
└── Business_Insights.md
```

## Dataset Note

This project uses a publicly available synthetic/high-dimensional supply-chain inventory dataset for portfolio and analytical demonstration purposes. Findings represent patterns within the dataset and should not be interpreted as actual company performance.
