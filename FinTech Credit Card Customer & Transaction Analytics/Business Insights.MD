# Business Insights

## FinTech Credit Card Customer & Transaction Analytics

### Executive Summary

This analysis examines credit card customer behavior across credit exposure, utilization, payment activity, delinquency, customer value, and default outcomes.

The dataset contains **30,000 customers** with six months of billing and payment history.

The analysis is designed to help understand:

- Credit portfolio exposure
- Customer payment behavior
- Credit utilization
- Delinquency patterns
- Default risk
- Customer value
- Behavioral risk concentration

---

# 1. Portfolio Overview

The portfolio contains **30,000 customers** with a wide range of credit limits and payment behaviors.

The analysis evaluates both the amount of credit made available to customers and how customers use and repay that credit.

Key portfolio indicators are available in the Power BI dashboard, including:

- Total customers
- Total credit limit
- Average credit limit
- Default rate
- Average credit utilization
- Average monthly bill

These metrics provide a high-level view of portfolio scale and customer credit behavior.

---

# 2. Credit Utilization & Default Risk

Credit utilization is an important behavioral indicator because it reflects how much of a customer's available credit is being used.

Customers are categorized into:

- Low Utilization
- Moderate Utilization
- High Utilization
- Over Limit

The analysis compares customer concentration and default rates across these segments.

### Business Insight

Higher utilization segments should be monitored separately because customers using a large proportion of their available credit represent a different behavioral profile from customers with relatively low utilization.

The dashboard allows users to compare utilization levels directly with observed default rates.

---

# 3. Delinquency & Default

Repayment behavior is analyzed across six months using repayment-status fields.

Customers are grouped according to the number and severity of delinquent months.

The analysis evaluates default rates across delinquency levels.

### Business Insight

Delinquency provides a behavioral signal that can be monitored independently of the final default outcome.

Customers showing repeated delinquency can therefore be considered a distinct population for portfolio monitoring and further analysis.

> Important: Behavioral risk segmentation in this project does not use the default target variable directly. This avoids target leakage when constructing customer risk segments.

---

# 4. Payment Behavior

The project analyzes six months of:

- Billing amounts
- Payment amounts

Two important behavioral measures are:

### Payment-to-Bill Ratio

This compares the amount paid against the amount billed.

A lower ratio can indicate that a customer is paying a smaller proportion of their billed amount.

### Monthly Bill vs Payment Trend

The Power BI dashboard compares aggregate monthly billing and payment activity to provide a view of portfolio-level payment behavior.

These measures help distinguish customers based on repayment patterns rather than relying only on demographic characteristics.

---

# 5. Behavioral Risk Segmentation

Customers are classified into behavioral risk segments using credit utilization and delinquency-related indicators.

The major behavioral segments include:

- Low Risk
- High Utilization Risk
- High Delinquency Risk
- High Utilization & Delinquency Risk

### Business Insight

The segmentation provides a framework for separating customers based on observed credit behavior.

This can support:

- Portfolio monitoring
- Customer review
- Risk-focused reporting
- Further investigation of high-risk behavioral groups

The segmentation should be interpreted as an analytical classification rather than a production credit-scoring model.

---

# 6. Customer Value & Risk

Customers are segmented into three customer-value groups:

- High Value
- Medium Value
- Lower Value

Customer value is determined using credit-limit and average monthly bill characteristics.

These value segments are analyzed alongside behavioral risk.

### Business Insight

Combining customer value with behavioral risk provides a more detailed view of the portfolio than analyzing either dimension independently.

For example, the dashboard can distinguish between:

- Higher-value customers with lower behavioral risk
- Higher-value customers showing elevated behavioral risk
- Lower-value customers with higher behavioral risk
- Lower-risk customers across different value levels

This framework can support differentiated portfolio analysis and customer-management strategies.

---

# 7. Credit Limit Analysis

Customers are grouped into credit-limit segments to evaluate differences in portfolio behavior.

The analysis compares:

- Customer population
- Default rate
- Credit exposure
- Customer behavior

### Business Insight

Credit-limit segmentation helps identify whether observed default patterns vary across different levels of credit exposure.

It also provides context when interpreting utilization and customer-value metrics.

---

# 8. Demographic Analysis

The project evaluates default rates across:

- Age groups
- Gender
- Education level
- Marital status

These dimensions are used for descriptive portfolio analysis.

### Business Insight

Differences between demographic groups can highlight areas for further investigation.

However, demographic differences should not automatically be interpreted as causal drivers of default. Additional analysis and appropriate risk-modeling techniques would be required before using such variables in operational decision-making.

---

# 9. Portfolio Risk Monitoring Framework

The analysis suggests a practical monitoring framework based on three dimensions:

```text
Customer Value
      +
Behavioral Risk
      +
Credit Utilization / Delinquency