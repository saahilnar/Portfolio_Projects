# Healthcare Patient & Hospital Analytics — Business Insights

## 1. Executive Summary

This project analyzes the MIMIC-IV Clinical Database Demo 2.2, a de-identified clinical dataset containing 100 patients and 275 hospital admissions.

The analysis focuses on patient utilization, clinical activity, hospital services, readmissions, and mortality outcomes.

### Key findings

- The dataset contains **100 unique patients** and **275 hospital admissions**.
- Average hospital length of stay was **6.86 days**.
- The overall mortality rate was **5.45%** across admissions.
- The calculated 30-day readmission rate was **30.29%**, using admissions with an observable subsequent admission opportunity as the denominator.
- Admissions contained an average of **16.39 diagnosis records**.
- Admissions averaged **2.63 procedure records** and **1.14 hospital service records**.
- **48 patients** had more than one admission.
- There were **53 identified 30-day readmissions** under the project's methodology.

---

## 2. Patient & Admission Utilization

### Multiple admissions were common within the demo population

The dataset contains 275 admissions across 100 patients, with 48 patients having more than one admission.

This indicates that a meaningful portion of the demo population interacted with the hospital system multiple times.

However, the number of subsequent admissions should not be interpreted as a standard readmission metric because not every subsequent admission necessarily occurred within 30 days.

### Admission source

Emergency Room admissions represented the largest admission source in the dataset, followed by physician referrals and transfers from other hospitals.

This provides an operational view of how patients entered the hospital and can help contextualize downstream utilization patterns.

---

## 3. Length of Stay

The overall average length of stay was:

**6.86 days**

Length of stay varied across age groups and admission types.

The dashboard allows users to compare average LOS across these segments and identify groups associated with longer hospital utilization.

Because this dataset is a 100-patient demonstration dataset, observed differences should be treated as descriptive rather than representative of a broader hospital population.

---

## 4. Clinical Activity

### Diagnosis activity

There were:

- **4,506 diagnosis records**
- **1,472 unique diagnosis codes**
- **16.39 average diagnosis records per admission**

The most frequently recorded diagnosis descriptions by affected admissions included:

- Unspecified essential hypertension
- Hyperlipidemia, unspecified
- Acute kidney failure, unspecified
- Other and unspecified hyperlipidemia
- Hypothyroidism, unspecified
- Obesity, unspecified
- Anemia, unspecified
- Long-term current insulin use
- Urinary tract infection
- Personal history of nicotine dependence

These figures represent coded diagnosis activity within admissions and should not be interpreted directly as disease prevalence.

The same clinical condition may also appear under different ICD coding systems or coding descriptions.

---

## 5. Procedure Activity

There were:

- **722 procedure records**
- **187 admissions with at least one procedure**
- **3.86 average procedures among admissions with procedures**

Frequently recorded procedures included activities such as:

- Infusion device insertion
- Central venous catheter placement
- Enteral nutrition
- Mechanical ventilation
- Venous catheterization
- Abdominal drainage
- Endotracheal airway procedures
- Arterial catheterization
- Urinary filtration
- Coronary artery bypass procedures

Procedure frequency should be interpreted as clinical activity rather than as a direct measure of disease severity.

---

## 6. Hospital Service Utilization

All 275 admissions had associated service records.

There were **13 unique hospital services** and **319 service records**.

The most frequently represented services included:

- MED
- CMED
- SURG
- OMED
- CSURG
- NSURG
- VSURG
- NMED

Some admissions involved multiple services, with a maximum of three service records observed for an admission.

This provides a view of cross-service utilization and the types of hospital departments represented in the dataset.

---

## 7. Readmission Analysis

### 30-day readmissions

The analysis identified:

**53 30-day readmissions**

The calculated 30-day readmission rate was:

**30.29%**

### Methodology

The readmission calculation uses the next admission date for each patient and compares it with the discharge date of the current admission.

An admission is classified as a 30-day readmission when the patient's next admission occurs within 30 days after discharge.

The denominator includes only admissions with an observable subsequent admission opportunity.

Therefore, this metric should not be compared directly with externally reported hospital readmission rates that use a different population, eligibility criteria, exclusions, or methodology.

---

## 8. Mortality

There were:

**15 deaths**

The overall admission-level mortality rate was:

**5.45%**

The dashboard provides mortality breakdowns by age group and admission type.

These comparisons are descriptive and should not be interpreted as evidence that age group or admission type causes differences in mortality.

The small size of the demo dataset also means that a small number of events can materially affect percentages.

---

## 9. Operational Interpretation

From a hospital analytics perspective, the dashboard provides visibility into four important areas:

### Patient utilization
Understanding repeat admissions and admission sources can help describe how patients interact with hospital services.

### Clinical workload
Diagnosis, procedure, and service activity provide a view of the clinical workload represented in the dataset.

### Resource utilization
Length of stay and procedure/service activity provide indicators of hospital resource utilization.

### Patient outcomes
Mortality and 30-day readmissions provide outcome-oriented measures that can be monitored alongside utilization metrics.

---

## 10. Important Data Limitations

### Dataset size

This project uses the **MIMIC-IV Clinical Database Demo 2.2**, which contains only 100 patients.

The findings are therefore **demonstrative and exploratory** and should not be generalized to an entire hospital, healthcare system, or population.

### De-identified dates

MIMIC-IV uses de-identified and shifted dates.

Therefore, the years shown in the raw data should not be interpreted as actual calendar years or used for real-world temporal conclusions.

### Readmission methodology

The 30-day readmission metric uses the next observed admission after discharge and excludes admissions without an observable subsequent admission opportunity from the denominator.

### Diagnosis interpretation

Diagnosis frequency represents coded clinical activity at the admission level. It is not equivalent to disease prevalence.

### Causality

The analysis is descriptive.

Observed relationships between demographic groups, admission characteristics, clinical activity, and outcomes should not be interpreted as causal relationships.

---

## 11. Dashboard Purpose

The Power BI dashboard is designed to demonstrate an end-to-end healthcare analytics workflow:

**Raw clinical data → Data validation → Analytical modeling → KPI development → Clinical utilization analysis → Outcome analysis → Business interpretation**

The project demonstrates practical skills in:

- SQL data preparation
- Relational data modeling
- Data quality validation
- Healthcare KPI development
- Power BI dashboard development
- DAX
- Clinical activity analysis
- Readmission analysis
- Outcome analysis
- Business-oriented storytelling