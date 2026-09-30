USE healthcare_analytics;


-- =====================================================
-- FINAL ADMISSION-LEVEL ANALYTICS TABLE
-- =====================================================

DROP TABLE IF EXISTS healthcare_admission_analytics;

CREATE TABLE healthcare_admission_analytics AS

SELECT
    hadm_id,
    subject_id,

    gender,
    anchor_age,
    age_group,

    admittime,
    dischtime,

    admission_type,
    admission_location,
    discharge_location,

    insurance,
    language,
    marital_status,
    race,

    length_of_stay_days,

    admission_year,
    admission_month,

    mortality_flag,

    admission_number,
    readmission_flag,

    diagnosis_count,
    unique_diagnosis_count,

    procedure_count,
    unique_procedure_count,

    service_count

FROM healthcare_admission_summary;


-- =====================================================
-- 30-DAY READMISSION ANALYSIS
-- =====================================================

DROP TABLE IF EXISTS readmission_30day;

CREATE TABLE readmission_30day AS

SELECT
    subject_id,
    hadm_id,
    dischtime,

    LEAD(admittime) OVER (
        PARTITION BY subject_id
        ORDER BY admittime
    ) AS next_admittime

FROM fact_admissions;


ALTER TABLE healthcare_admission_analytics

ADD COLUMN days_to_next_admission DECIMAL(10,2),

ADD COLUMN readmission_30day_flag TINYINT;


UPDATE healthcare_admission_analytics h

JOIN readmission_30day r
    ON h.hadm_id = r.hadm_id

SET

    h.days_to_next_admission =
        CASE
            WHEN r.next_admittime IS NOT NULL
            THEN TIMESTAMPDIFF(
                HOUR,
                h.dischtime,
                r.next_admittime
            ) / 24
            ELSE NULL
        END,

    h.readmission_30day_flag =
        CASE
            WHEN r.next_admittime IS NOT NULL
            AND TIMESTAMPDIFF(
                HOUR,
                h.dischtime,
                r.next_admittime
            ) BETWEEN 0 AND 720
            THEN 1
            ELSE 0
        END;


-- =====================================================
-- FINAL KPI SUMMARY
-- =====================================================

DROP TABLE IF EXISTS healthcare_kpi_summary;

CREATE TABLE healthcare_kpi_summary AS

SELECT

    COUNT(
        DISTINCT subject_id
    ) AS total_patients,

    COUNT(
        DISTINCT hadm_id
    ) AS total_admissions,

    ROUND(
        AVG(length_of_stay_days),
        2
    ) AS avg_length_of_stay_days,

    ROUND(
        100 * SUM(mortality_flag) / COUNT(*),
        2
    ) AS mortality_rate_pct,

    ROUND(
        100 * SUM(readmission_30day_flag)
        /
        NULLIF(
            SUM(
                CASE
                    WHEN days_to_next_admission IS NOT NULL
                    THEN 1
                    ELSE 0
                END
            ),
            0
        ),
        2
    ) AS readmission_30day_rate_pct,

    ROUND(
        AVG(diagnosis_count),
        2
    ) AS avg_diagnoses_per_admission,

    ROUND(
        AVG(procedure_count),
        2
    ) AS avg_procedures_per_admission,

    ROUND(
        AVG(service_count),
        2
    ) AS avg_services_per_admission

FROM healthcare_admission_analytics;


-- =====================================================
-- PATIENT-LEVEL ANALYTICS
-- =====================================================

DROP TABLE IF EXISTS patient_analytics;

CREATE TABLE patient_analytics AS

SELECT
    p.subject_id,
    p.gender,
    p.anchor_age,
    p.anchor_year_group,
    p.dod,

    COUNT(a.hadm_id) AS total_admissions,

    MIN(a.admittime) AS first_admission,

    MAX(a.admittime) AS last_admission,

    ROUND(
        AVG(a.length_of_stay_days),
        2
    ) AS avg_length_of_stay_days,

    SUM(a.mortality_flag) AS mortality_events,

    SUM(a.readmission_30day_flag)
        AS readmission_30day_events

FROM patients_raw p

LEFT JOIN healthcare_admission_analytics a
    ON p.subject_id = a.subject_id

GROUP BY
    p.subject_id,
    p.gender,
    p.anchor_age,
    p.anchor_year_group,
    p.dod;


-- =====================================================
-- AGE GROUP ANALYSIS
-- =====================================================

DROP TABLE IF EXISTS age_group_analysis;

CREATE TABLE age_group_analysis AS

SELECT
    age_group,

    COUNT(*) AS admissions,

    COUNT(
        DISTINCT subject_id
    ) AS patients,

    ROUND(
        AVG(length_of_stay_days),
        2
    ) AS avg_length_of_stay_days,

    SUM(mortality_flag) AS deaths,

    SUM(readmission_30day_flag)
        AS readmissions_30day

FROM healthcare_admission_analytics

GROUP BY age_group

ORDER BY FIELD(
    age_group,
    'Under 30',
    '30-44',
    '45-59',
    '60-74',
    '75+'
);


-- =====================================================
-- ADMISSION TYPE ANALYSIS
-- =====================================================

DROP TABLE IF EXISTS admission_type_analysis;

CREATE TABLE admission_type_analysis AS

SELECT
    admission_type,

    COUNT(*) AS admissions,

    COUNT(
        DISTINCT subject_id
    ) AS patients,

    ROUND(
        AVG(length_of_stay_days),
        2
    ) AS avg_length_of_stay_days,

    SUM(mortality_flag) AS deaths,

    SUM(readmission_30day_flag)
        AS readmissions_30day

FROM healthcare_admission_analytics

GROUP BY admission_type

ORDER BY admissions DESC;


-- =====================================================
-- INSURANCE ANALYSIS
-- =====================================================

DROP TABLE IF EXISTS insurance_analysis;

CREATE TABLE insurance_analysis AS

SELECT
    insurance,

    COUNT(*) AS admissions,

    COUNT(
        DISTINCT subject_id
    ) AS patients,

    ROUND(
        AVG(length_of_stay_days),
        2
    ) AS avg_length_of_stay_days,

    SUM(mortality_flag) AS deaths,

    SUM(readmission_30day_flag)
        AS readmissions_30day

FROM healthcare_admission_analytics

GROUP BY insurance

ORDER BY admissions DESC;


-- =====================================================
-- MONTHLY HEALTHCARE ANALYSIS
-- =====================================================

DROP TABLE IF EXISTS monthly_healthcare_analysis;

CREATE TABLE monthly_healthcare_analysis AS

SELECT

    admission_year,

    admission_month,

    COUNT(*) AS total_admissions,

    COUNT(
        DISTINCT subject_id
    ) AS unique_patients,

    ROUND(
        AVG(length_of_stay_days),
        2
    ) AS avg_length_of_stay_days,

    SUM(mortality_flag) AS deaths,

    ROUND(
        100 * AVG(mortality_flag),
        2
    ) AS mortality_rate_pct,

    SUM(readmission_30day_flag)
        AS readmissions_30day,

    SUM(
        CASE
            WHEN days_to_next_admission IS NOT NULL
            THEN 1
            ELSE 0
        END
    ) AS readmission_opportunities,

    ROUND(
        100 * SUM(readmission_30day_flag)
        /
        NULLIF(
            SUM(
                CASE
                    WHEN days_to_next_admission IS NOT NULL
                    THEN 1
                    ELSE 0
                END
            ),
            0
        ),
        2
    ) AS readmission_30day_rate_pct

FROM healthcare_admission_analytics

GROUP BY
    admission_year,
    admission_month

ORDER BY
    admission_year,
    admission_month;


-- =====================================================
-- CLINICAL ACTIVITY ANALYSIS
-- =====================================================

DROP TABLE IF EXISTS clinical_activity_analysis;

CREATE TABLE clinical_activity_analysis AS

SELECT

    age_group,

    COUNT(*) AS admissions,

    ROUND(
        AVG(diagnosis_count),
        2
    ) AS avg_diagnoses,

    ROUND(
        AVG(unique_diagnosis_count),
        2
    ) AS avg_unique_diagnoses,

    ROUND(
        AVG(procedure_count),
        2
    ) AS avg_procedures,

    ROUND(
        AVG(unique_procedure_count),
        2
    ) AS avg_unique_procedures,

    ROUND(
        AVG(service_count),
        2
    ) AS avg_services,

    ROUND(
        AVG(length_of_stay_days),
        2
    ) AS avg_length_of_stay_days

FROM healthcare_admission_analytics

GROUP BY age_group

ORDER BY FIELD(
    age_group,
    'Under 30',
    '30-44',
    '45-59',
    '60-74',
    '75+'
);


-- =====================================================
-- FINAL VALIDATION
-- =====================================================

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT hadm_id) AS unique_admissions,
    COUNT(DISTINCT subject_id) AS unique_patients
FROM healthcare_admission_analytics;


SELECT
    COUNT(*) AS unique_diagnosis_entries
FROM diagnosis_analysis;


SELECT
    COUNT(*) AS unique_procedure_entries
FROM procedure_analysis;


SELECT
    COUNT(*) AS unique_services
FROM service_analysis;