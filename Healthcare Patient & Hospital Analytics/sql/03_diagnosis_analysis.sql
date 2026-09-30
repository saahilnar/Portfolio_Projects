USE healthcare_analytics;


-- =====================================================
-- MAP DIAGNOSIS CODES TO DESCRIPTIONS
-- =====================================================

DROP TABLE IF EXISTS admission_diagnoses;

CREATE TABLE admission_diagnoses AS

SELECT
    d.subject_id,
    d.hadm_id,
    d.seq_num,
    d.icd_code,
    d.icd_version,

    m.long_title AS diagnosis_name

FROM diagnoses_icd_raw d

LEFT JOIN d_icd_diagnoses_raw m
    ON d.icd_code = m.icd_code
    AND d.icd_version = m.icd_version;


-- =====================================================
-- UNMATCHED DIAGNOSIS CODES
-- =====================================================

SELECT
    COUNT(*) AS unmatched_diagnosis_codes
FROM admission_diagnoses
WHERE diagnosis_name IS NULL;


-- =====================================================
-- DIAGNOSIS ANALYSIS
-- =====================================================

DROP TABLE IF EXISTS diagnosis_analysis;

CREATE TABLE diagnosis_analysis AS

SELECT
    diagnosis_name,
    icd_version,

    COUNT(*) AS diagnosis_occurrences,

    COUNT(
        DISTINCT hadm_id
    ) AS affected_admissions,

    COUNT(
        DISTINCT subject_id
    ) AS affected_patients

FROM admission_diagnoses

WHERE diagnosis_name IS NOT NULL

GROUP BY
    diagnosis_name,
    icd_version;


-- =====================================================
-- TOP 20 DIAGNOSES
-- =====================================================

SELECT
    diagnosis_name,
    icd_version,
    diagnosis_occurrences,
    affected_admissions,
    affected_patients

FROM diagnosis_analysis

ORDER BY affected_admissions DESC

LIMIT 20;


-- =====================================================
-- TOTAL UNIQUE DIAGNOSIS ENTRIES
-- =====================================================

SELECT
    COUNT(*) AS unique_diagnosis_entries

FROM diagnosis_analysis;