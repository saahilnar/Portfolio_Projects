# Dataset

## Credit Card Default Dataset

This project uses the **Default of Credit Card Clients** dataset from the UCI Machine Learning Repository.

### Dataset Overview

- **Customers:** 30,000
- **Columns:** 25
- **Missing values:** None identified
- **Duplicate customer IDs:** None identified
- **Target variable:** `default_payment_next_month`

The dataset contains customer demographic information, credit limits, six months of billing history, six months of payment history, repayment status, and the following-month default indicator.

### Main Fields

| Field | Description |
|---|---|
| `ID` | Customer identifier |
| `LIMIT_BAL` | Credit limit |
| `SEX` | Customer gender code |
| `EDUCATION` | Education category |
| `MARRIAGE` | Marital status category |
| `AGE` | Customer age |
| `PAY_0` – `PAY_6` | Repayment status across six months |
| `BILL_AMT1` – `BILL_AMT6` | Monthly billing amounts |
| `PAY_AMT1` – `PAY_AMT6` | Monthly payment amounts |
| `default_payment_next_month` | Default indicator |

### Data Usage

The dataset was used for:

- Credit portfolio analysis
- Customer segmentation
- Credit utilization analysis
- Payment behavior analysis
- Delinquency analysis
- Default analysis
- Customer value and risk segmentation

### Raw Dataset

The original dataset is **not included in this GitHub repository**.

Users should obtain the dataset from the original UCI Machine Learning Repository source and place the CSV locally before running the SQL script.

### Data Processing

The raw dataset was imported into MySQL and transformed into analytical tables for Power BI.

The SQL workflow includes:

1. Raw data import
2. Data quality validation
3. Customer-level analytics
4. Six-month behavioral analysis
5. Risk segmentation
6. Credit utilization analysis
7. Delinquency analysis
8. Default analysis
9. Portfolio KPI creation
10. Customer value and behavioral risk analysis
