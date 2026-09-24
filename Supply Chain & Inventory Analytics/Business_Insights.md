# Supply Chain & Inventory Analytics — Business Insights

## Executive Summary

The analysis covers 91,250 supply-chain records across 50 SKUs, 5 warehouses, 10 suppliers, and 4 regions for 2024. Total revenue was ₹33.43M with gross profit of ₹11.09M and a gross margin of 33.17%.

Demand shows a clear seasonal pattern while inventory levels remain relatively stable. This creates significant differences in inventory coverage throughout the year. Forecast accuracy is broadly consistent across regions, while promotion periods are associated with higher average demand.

## 1. Overall Business Performance

- Total revenue: **₹33.43M**
- Gross profit: **₹11.09M**
- Gross margin: **33.17%**
- Total units sold: **1.83M**
- Average inventory: **471.52 units**
- Reorder-alert records: **5,041**
- Average supplier lead time: **7.98 days**
- Forecast MAPE: **16.32%**

## 2. Demand & Revenue Trends

Demand peaked in **March 2024**, with 231,596 units sold and revenue of approximately ₹4.23M. Demand reached its lowest point in **September**, with 76,304 units sold and revenue of approximately ₹1.39M, before recovering during Q4.

Gross margin remained close to 33% throughout the year.

**Business implication:** Inventory planning should account for the observed demand cycle rather than relying on a constant inventory level throughout the year.

## 3. Inventory Coverage

Average inventory remained relatively stable while demand varied considerably. Monthly inventory coverage increased sharply during the lower-demand period, reaching more than 100 days during September and October.

SKU segmentation identified:
- High Demand - Low Coverage: **15 SKUs**
- Low Demand - High Coverage: **15 SKUs**
- High Demand - High Coverage: **10 SKUs**
- Low Demand - Low Coverage: **10 SKUs**

**Business implication:** High-demand SKUs with lower coverage require closer replenishment monitoring, while low-demand SKUs with high coverage should be reviewed for inventory efficiency. Coverage alone does not establish economic excess inventory.

## 4. SKU Performance

**SKU_38** generated approximately ₹1.06M in revenue, among the highest in the dataset. SKU profitability also varies materially across products.

**Business implication:** SKU-level revenue, gross profit, inventory coverage, and reorder alerts should be considered together when prioritizing inventory and replenishment decisions.

## 5. Supplier Performance

The analysis covers 10 suppliers. Average supplier lead time is approximately **7.98 days**, with supplier-level averages ranging from roughly 7 to 9 days.

There is no simple monotonic relationship between supplier lead time and inventory coverage in this dataset.

**Business implication:** Supplier evaluation should consider lead time, revenue contribution, profitability, inventory coverage, and reorder activity together.

## 6. Forecast Accuracy

Overall forecast performance:
- **MAE:** 2.38 units
- **RMSE:** 2.99 units
- **MAPE:** 16.32%
- **Forecast bias:** approximately +0.03

Regional MAPE:
- South: **16.16%**
- East: **16.33%**
- North: **16.35%**
- West: **16.44%**

**Business implication:** Forecast performance is broadly consistent across regions.

## 7. Promotion Analysis

Promotion records show higher average demand:
- Promotion: **24.91 average units sold**
- No Promotion: **19.50 average units sold**

Average demand forecast was also higher during promotion periods:
- Promotion: **24.93**
- No Promotion: **19.53**

Gross margin remained almost unchanged at approximately 33%.

**Business implication:** Promotion periods are associated with higher demand, making promotion-aware inventory and replenishment planning important. These results describe an association and do not prove that promotions caused the increase.

## 8. Replenishment

There were **5,041 reorder-alert records**, based on inventory being at or below the defined reorder point.

**Business implication:** Reorder alerts can be combined with demand forecasts, supplier lead times, and SKU-level revenue to prioritize replenishment monitoring.

## 9. Key Recommendations

1. Monitor high-demand SKUs with lower inventory coverage closely.
2. Review low-demand SKUs with high theoretical coverage for inventory efficiency.
3. Incorporate promotion periods into demand and replenishment planning.
4. Use forecast accuracy metrics regularly to monitor demand-planning performance.
5. Evaluate suppliers using lead time, profitability, revenue contribution, coverage, and reorder activity together.
6. Align inventory levels with seasonal demand patterns rather than maintaining a uniform inventory strategy throughout the year.

## Dataset Disclaimer

This project uses a publicly available synthetic/high-dimensional supply-chain inventory dataset for portfolio and analytical demonstration purposes. Findings represent patterns within the dataset and should not be interpreted as actual company performance.
