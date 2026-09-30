USE healthcare_analytics;


-- =====================================================
-- DATA QUALITY CHECKS
-- =====================================================

SELECT COUNT(*) AS admissions_without_patient
FROM admissions_raw a
LEFT JOIN patients_raw p
    ON a.subject_id = p.subject_id
WHERE p.subject_id IS NULL;


SELECT COUNT(*) AS diagnoses_without_admission
FROM diagnoses_icd_raw d
LEFT JOIN admissions_raw a
    ON d.hadm_id = a.hadm_id
WHERE a.hadm_id IS NULL;


SELECT COUNT(*) AS procedures_without_admission
FROM procedures_icd_raw p
LEFT JOIN admissions_raw a
    ON p.hadm_id = a.hadm_id
WHERE a.hadm_id IS NULL;


SELECT COUNT(*) AS services_without_admission
FROM services_raw s
LEFT JOIN admissions_raw a
    ON s.hadm_id = a.hadm_id
WHERE a.hadm_id IS NULL;


-- =====================================================
-- DATE VALIDATION
-- =====================================================

SELECT
    MIN(admittime) AS first_admission,
    MAX(admittime) AS last_admission,
    MIN(dischtime) AS first_discharge,
    MAX(dischtime) AS last_discharge,
    SUM(dischtime < admittime) AS invalid_discharge_dates
FROM admissions_raw;


-- =====================================================
-- DUPLICATE ADMISSIONS
-- =====================================================

SELECT
    hadm_id,
    COUNT(*) AS duplicate_count
FROM admissions_raw
GROUP BY hadm_id
HAVING COUNT(*) > 1;


-- =====================================================
-- FACT ADMISSIONS
-- =====================================================

DROP TABLE IF EXISTS fact_admissions;

CREATE TABLE fact_admissions AS

SELECT
    a.hadm_id,
    a.subject_id,

    a.admittime,
    a.dischtime,

    a.admission_type,
    a.admission_location,
    a.discharge_location,

    a.insurance,
    a.language,
    a.marital_status,
    a.race,

    p.gender,
    p.anchor_age,

    ROUND(
        TIMESTAMPDIFF(
            MINUTE,
            a.admittime,
            a.dischtime
        ) / 1440,
        2
    ) AS length_of_stay_days,

    YEAR(a.admittime) AS admission_year,

    MONTH(a.admittime) AS admission_month,

    CASE
        WHEN p.anchor_age < 30 THEN 'Under 30'
        WHEN p.anchor_age BETWEEN 30 AND 44 THEN '30-44'
        WHEN p.anchor_age BETWEEN 45 AND 59 THEN '45-59'
        WHEN p.anchor_age BETWEEN 60 AND 74 THEN '60-74'
        ELSE '75+'
    END AS age_group,

    a.hospital_expire_flag AS mortality_flag,

    CASE
        WHEN a.admission_type = 'EMERGENCY'
        THEN 1
        ELSE 0
    END AS emergency_admission_flag

FROM admissions_raw a

INNER JOIN patients_raw p
    ON a.subject_id = p.subject_id;


-- =====================================================
-- ADMISSION SEQUENCE
-- =====================================================

DROP TABLE IF EXISTS admission_sequence;

CREATE TABLE admission_sequence AS

SELECT
    hadm_id,
    subject_id,
    admittime,

    ROW_NUMBER() OVER (
        PARTITION BY subject_id
        ORDER BY admittime
    ) AS admission_number

FROM fact_admissions;


ALTER TABLE fact_admissions
ADD COLUMN admission_number INT,
ADD COLUMN readmission_flag TINYINT;


UPDATE fact_admissions f

JOIN admission_sequence s
    ON f.hadm_id = s.hadm_id

SET
    f.admission_number = s.admission_number,

    f.readmission_flag =
        CASE
            WHEN s.admission_number > 1
            THEN 1
            ELSE 0
        END;


-- =====================================================
-- READMISSION SUMMARY
-- =====================================================

DROP TABLE IF EXISTS admission_readmission;

CREATE TABLE admission_readmission AS

SELECT
    subject_id,

    COUNT(*) AS total_admissions,

    SUM(
        CASE
            WHEN admission_number > 1
            THEN 1
            ELSE 0
        END
    ) AS subsequent_admissions

FROM admission_sequence

GROUP BY subject_id;


-- =====================================================
-- DIAGNOSIS COUNT PER ADMISSION
-- =====================================================

DROP TABLE IF EXISTS admission_diagnosis_summary;

CREATE TABLE admission_diagnosis_summary AS

SELECT
    hadm_id,

    COUNT(*) AS diagnosis_count,

    COUNT(
        DISTINCT CONCAT(
            icd_version,
            '-',
            icd_code
        )
    ) AS unique_diagnosis_count

FROM diagnoses_icd_raw

GROUP BY hadm_id;


-- =====================================================
-- PROCEDURE COUNT PER ADMISSION
-- =====================================================

DROP TABLE IF EXISTS admission_procedure_summary;

CREATE TABLE admission_procedure_summary AS

SELECT
    hadm_id,

    COUNT(*) AS procedure_count,

    COUNT(
        DISTINCT CONCAT(
            icd_version,
            '-',
            icd_code
        )
    ) AS unique_procedure_count

FROM procedures_icd_raw

GROUP BY hadm_id;


-- =====================================================
-- SERVICE COUNT PER ADMISSION
-- =====================================================

DROP TABLE IF EXISTS admission_service_summary;

CREATE TABLE admission_service_summary AS

SELECT
    hadm_id,
    COUNT(*) AS service_count

FROM services_raw

GROUP BY hadm_id;


-- =====================================================
-- COMBINED ADMISSION SUMMARY
-- =====================================================

DROP TABLE IF EXISTS healthcare_admission_summary;

CREATE TABLE healthcare_admission_summary AS

SELECT
    f.*,

    COALESCE(
        d.diagnosis_count,
        0
    ) AS diagnosis_count,

    COALESCE(
        d.unique_diagnosis_count,
        0
    ) AS unique_diagnosis_count,

    COALESCE(
        p.procedure_count,
        0
    ) AS procedure_count,

    COALESCE(
        p.unique_procedure_count,
        0
    ) AS unique_procedure_count,

    COALESCE(
        s.service_count,
        0
    ) AS service_count

FROM fact_admissions f

LEFT JOIN admission_diagnosis_summary d
    ON f.hadm_id = d.hadm_id

LEFT JOIN admission_procedure_summary p
    ON f.hadm_id = p.hadm_id

LEFT JOIN admission_service_summary s
    ON f.hadm_id = s.hadm_id;