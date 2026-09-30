# Healthcare Patient & Hospital Analytics

An end-to-end healthcare analytics project analyzing patient admissions, clinical activity, hospital service utilization, readmissions, and mortality outcomes using the MIMIC-IV Clinical Database Demo 2.2.

The project demonstrates the complete analytics workflow from raw clinical data ingestion and SQL transformation to Power BI dashboard development and business interpretation.

---

## Project Overview

Healthcare organizations generate large volumes of clinical and operational data across admissions, diagnoses, procedures, services, and patient records.

This project analyzes these datasets to answer questions such as:

- How many patients and admissions are represented?
- What are the major admission patterns?
- How long do patients stay in the hospital?
- What diagnoses are most frequently recorded?
- Which procedures are most frequently performed?
- Which hospital services are most utilized?
- How frequently do patients return within 30 days?
- What mortality patterns are visible across patient and admission segments?

---

## Dataset

### MIMIC-IV Clinical Database Demo 2.2

Source:

PhysioNet — MIMIC-IV Clinical Database Demo 2.2

Dataset type:

De-identified clinical healthcare data.

This project uses the **100-patient demonstration dataset**, not the full MIMIC-IV dataset.

### Core datasets used

- Patients
- Admissions
- Diagnoses
- Diagnosis reference data
- Procedures
- Procedure reference data
- Hospital services

---

## Dataset Scale

| Metric | Value |
|---|---:|
| Unique Patients | 100 |
| Hospital Admissions | 275 |
| Diagnosis Records | 4,506 |
| Procedure Records | 722 |
| Hospital Service Records | 319 |
| Unique Diagnosis Codes | 1,472 |
| Admissions with Procedures | 187 |
| Patients with Multiple Admissions | 48 |

---

## Technology Stack

### Database & SQL
- MySQL 8
- SQL
- Window Functions
- CTEs
- Data Validation
- Analytical Data Modeling

### Business Intelligence
- Microsoft Power BI
- DAX
- Interactive Slicers
- KPI Cards
- Clinical & Operational Dashboards

### Documentation
- Markdown
- GitHub

---

## Project Architecture

```text
MIMIC-IV Demo CSV Files
        |
        v
MySQL Raw Tables
        |
        v
Data Quality Validation
        |
        v
Analytical Tables
        |
        v
Healthcare KPI & Clinical Analysis
        |
        v
Power BI Data Model
        |
        v
Interactive Healthcare Dashboard
        |
        v
Business Insights
