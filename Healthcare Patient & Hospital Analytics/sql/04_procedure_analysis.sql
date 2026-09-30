USE healthcare_analytics;


-- =====================================================
-- MAP PROCEDURE CODES TO DESCRIPTIONS
-- =====================================================

DROP TABLE IF EXISTS admission_procedures;

CREATE TABLE admission_procedures AS

SELECT
    p.subject_id,
    p.hadm_id,
    p.seq_num,
    p.chartdate,
    p.icd_code,
    p.icd_version,

    m.long_title AS procedure_name

FROM procedures_icd_raw p

LEFT JOIN d_icd_procedures_raw m
    ON p.icd_code = m.icd_code
    AND p.icd_version = m.icd_version;


-- =====================================================
-- UNMATCHED PROCEDURE CODES
-- =====================================================

SELECT
    COUNT(*) AS unmatched_procedure_codes

FROM admission_procedures

WHERE procedure_name IS NULL;


-- =====================================================
-- PROCEDURE ANALYSIS
-- =====================================================

DROP TABLE IF EXISTS procedure_analysis;

CREATE TABLE procedure_analysis AS

SELECT
    procedure_name,
    icd_version,

    COUNT(*) AS procedure_occurrences,

    COUNT(
        DISTINCT hadm_id
    ) AS affected_admissions,

    COUNT(
        DISTINCT subject_id
    ) AS affected_patients

FROM admission_procedures

WHERE procedure_name IS NOT NULL

GROUP BY
    procedure_name,
    icd_version;


-- =====================================================
-- TOP 20 PROCEDURES
-- =====================================================

SELECT
    procedure_name,
    icd_version,
    procedure_occurrences,
    affected_admissions,
    affected_patients

FROM procedure_analysis

ORDER BY affected_admissions DESC

LIMIT 20;


-- =====================================================
-- UNIQUE PROCEDURE ENTRIES
-- =====================================================

SELECT
    COUNT(*) AS unique_procedure_entries

FROM procedure_analysis;