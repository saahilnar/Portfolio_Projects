# FinTech Credit Card Customer & Transaction Analytics

## Project Overview

This project analyzes credit card customer behavior, credit exposure, payment patterns, delinquency, and default risk using a portfolio of 30,000 customers.

The objective is to transform raw credit card data into actionable business insights for credit risk monitoring, customer segmentation, and portfolio management.

The project follows an end-to-end Data Analytics workflow:

**Raw Data → MySQL → SQL Analytics → Power BI → Business Insights**

---

## Business Objectives

The analysis focuses on:

- Understanding the overall credit portfolio
- Measuring credit exposure and utilization
- Analyzing customer payment behavior
- Identifying delinquency patterns
- Understanding default risk
- Segmenting customers based on behavioral risk
- Comparing default rates across customer demographics
- Identifying high-value customer segments
- Understanding the relationship between customer value and behavioral risk

---

## Dataset

### Default of Credit Card Clients

Source: **UCI Machine Learning Repository**

The dataset contains information for 30,000 credit card customers.

### Dataset Characteristics

| Metric | Value |
|---|---:|
| Customers | 30,000 |
| Columns | 25 |
| Missing Values | None identified |
| Duplicate Customer IDs | None identified |
| Historical Billing Months | 6 |
| Historical Payment Months | 6 |
| Target Variable | `default_payment_next_month` |

The dataset contains:

- Customer demographics
- Credit limits
- Repayment status
- Monthly billing amounts
- Monthly payment amounts
- Next-month default status

The raw dataset is not included in this repository.

Refer to [`data/README.md`](data/README.md) for dataset details and usage instructions.

---

## Technology Stack

| Technology | Purpose |
|---|---|
| MySQL 8 | Data storage and SQL analytics |
| SQL | Data transformation and analytical modeling |
| Power BI | Interactive dashboard and visualization |
| DAX | KPI and dashboard measures |
| GitHub | Version control and portfolio hosting |

---

## Project Structure

```text
FinTech Credit Card Customer & Transaction Analytics/
│
├── data/
│   └── README.md
│
├── sql/
│   └── 01_full_fintech_analysis.sql
│
├── dashboard/
│   └── FinTech Credit Card Customer & Transaction Analytics.pbix
│
├── Business_Insights.md
│
└── README.md