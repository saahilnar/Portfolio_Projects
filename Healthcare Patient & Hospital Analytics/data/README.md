# Dataset

This project uses the MIMIC-IV Clinical Database Demo 2.2 dataset from PhysioNet.

The dataset is not included in this GitHub repository because the source data has specific access and usage requirements.

## Dataset Used

MIMIC-IV Clinical Database Demo 2.2

The project uses the 100-patient demonstration dataset.

## Source

PhysioNet:
https://physionet.org/content/mimic-iv-demo/2.2/

## Data Used

The following MIMIC-IV tables were used:

- patients
- admissions
- diagnoses_icd
- d_icd_diagnoses
- procedures_icd
- d_icd_procedures
- services

## Local Setup

Download the MIMIC-IV Clinical Database Demo 2.2 dataset from PhysioNet and extract the required CSV files into this folder before running the SQL import scripts.

The SQL scripts contain the table creation and CSV import workflow.

## Important

The raw MIMIC-IV data is intentionally excluded from this repository.

This repository contains the analytical SQL, Power BI dashboard, documentation, and business insights.
