USE healthcare_analytics;


-- =====================================================
-- SERVICE / DEPARTMENT ANALYSIS
-- =====================================================

DROP TABLE IF EXISTS service_analysis;

CREATE TABLE service_analysis AS

SELECT
    curr_service AS service,

    COUNT(*) AS service_transfers,

    COUNT(
        DISTINCT hadm_id
    ) AS affected_admissions,

    COUNT(
        DISTINCT subject_id
    ) AS affected_patients

FROM services_raw

WHERE curr_service IS NOT NULL

GROUP BY curr_service;


-- =====================================================
-- SERVICE SUMMARY
-- =====================================================

SELECT
    service,
    service_transfers,
    affected_admissions,
    affected_patients

FROM service_analysis

ORDER BY affected_admissions DESC;


-- =====================================================
-- SERVICE TRANSITIONS
-- =====================================================

SELECT
    COALESCE(
        prev_service,
        'Initial Service'
    ) AS previous_service,

    curr_service AS current_service,

    COUNT(*) AS transition_count,

    COUNT(
        DISTINCT hadm_id
    ) AS affected_admissions

FROM services_raw

WHERE curr_service IS NOT NULL

GROUP BY
    COALESCE(
        prev_service,
        'Initial Service'
    ),
    curr_service

ORDER BY transition_count DESC

LIMIT 30;


-- =====================================================
-- UNIQUE SERVICES
-- =====================================================

SELECT
    COUNT(*) AS unique_services

FROM service_analysis;