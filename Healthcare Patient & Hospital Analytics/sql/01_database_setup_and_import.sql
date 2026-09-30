/*
=========================================================
Healthcare Patient & Hospital Analytics
MIMIC-IV Clinical Database Demo 2.2
Database Setup + Raw Data Import
=========================================================
*/

CREATE DATABASE IF NOT EXISTS healthcare_analytics;

USE healthcare_analytics;

SET GLOBAL local_infile = 1;


-- =====================================================
-- PATIENTS
-- =====================================================

DROP TABLE IF EXISTS patients_raw;

CREATE TABLE patients_raw (
    subject_id INT,
    gender VARCHAR(10),
    anchor_age INT,
    anchor_year INT,
    anchor_year_group VARCHAR(20),
    dod DATE
);


-- =====================================================
-- ADMISSIONS
-- =====================================================

DROP TABLE IF EXISTS admissions_raw;

CREATE TABLE admissions_raw (
    subject_id INT,
    hadm_id INT,
    admittime DATETIME,
    dischtime DATETIME,
    deathtime DATETIME,
    admission_type VARCHAR(50),
    admit_provider_id VARCHAR(20),
    admission_location VARCHAR(100),
    discharge_location VARCHAR(100),
    insurance VARCHAR(50),
    language VARCHAR(20),
    marital_status VARCHAR(50),
    race VARCHAR(100),
    edregtime DATETIME,
    edouttime DATETIME,
    hospital_expire_flag TINYINT
);


-- =====================================================
-- DIAGNOSES
-- =====================================================

DROP TABLE IF EXISTS diagnoses_icd_raw;

CREATE TABLE diagnoses_icd_raw (
    subject_id INT,
    hadm_id INT,
    seq_num INT,
    icd_code VARCHAR(20),
    icd_version TINYINT
);


-- =====================================================
-- PROCEDURES
-- =====================================================

DROP TABLE IF EXISTS procedures_icd_raw;

CREATE TABLE procedures_icd_raw (
    subject_id INT,
    hadm_id INT,
    seq_num INT,
    chartdate DATE,
    icd_code VARCHAR(20),
    icd_version TINYINT
);


-- =====================================================
-- SERVICES
-- =====================================================

DROP TABLE IF EXISTS services_raw;

CREATE TABLE services_raw (
    subject_id INT,
    hadm_id INT,
    transfertime DATETIME,
    prev_service VARCHAR(50),
    curr_service VARCHAR(50)
);


-- =====================================================
-- DIAGNOSIS LOOKUP
-- =====================================================

DROP TABLE IF EXISTS d_icd_diagnoses_raw;

CREATE TABLE d_icd_diagnoses_raw (
    icd_code VARCHAR(20),
    icd_version TINYINT,
    long_title VARCHAR(255)
);


-- =====================================================
-- PROCEDURE LOOKUP
-- =====================================================

DROP TABLE IF EXISTS d_icd_procedures_raw;

CREATE TABLE d_icd_procedures_raw (
    icd_code VARCHAR(20),
    icd_version TINYINT,
    long_title VARCHAR(255)
);


-- =====================================================
-- CSV IMPORT
-- =====================================================
-- Update the path if your dataset is stored elsewhere.
-- =====================================================


LOAD DATA LOCAL INFILE
'D:/Saahil/Project Work/Healthcare Patient & Hospital Analytics/data/mimic-iv-clinical-database-demo-2.2/hosp/patients.csv'
INTO TABLE patients_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE
'D:/Saahil/Project Work/Healthcare Patient & Hospital Analytics/data/mimic-iv-clinical-database-demo-2.2/hosp/admissions.csv'
INTO TABLE admissions_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE
'D:/Saahil/Project Work/Healthcare Patient & Hospital Analytics/data/mimic-iv-clinical-database-demo-2.2/hosp/diagnoses_icd.csv'
INTO TABLE diagnoses_icd_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE
'D:/Saahil/Project Work/Healthcare Patient & Hospital Analytics/data/mimic-iv-clinical-database-demo-2.2/hosp/procedures_icd.csv'
INTO TABLE procedures_icd_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE
'D:/Saahil/Project Work/Healthcare Patient & Hospital Analytics/data/mimic-iv-clinical-database-demo-2.2/hosp/services.csv'
INTO TABLE services_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE
'D:/Saahil/Project Work/Healthcare Patient & Hospital Analytics/data/mimic-iv-clinical-database-demo-2.2/hosp/d_icd_diagnoses.csv'
INTO TABLE d_icd_diagnoses_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE
'D:/Saahil/Project Work/Healthcare Patient & Hospital Analytics/data/mimic-iv-clinical-database-demo-2.2/hosp/d_icd_procedures.csv'
INTO TABLE d_icd_procedures_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- =====================================================
-- ROW COUNT VALIDATION
-- =====================================================

SELECT COUNT(*) AS patients_count
FROM patients_raw;

SELECT COUNT(*) AS admissions_count
FROM admissions_raw;

SELECT COUNT(*) AS diagnoses_count
FROM diagnoses_icd_raw;

SELECT COUNT(*) AS procedures_count
FROM procedures_icd_raw;

SELECT COUNT(*) AS services_count
FROM services_raw;

SELECT COUNT(*) AS diagnosis_lookup_count
FROM d_icd_diagnoses_raw;

SELECT COUNT(*) AS procedure_lookup_count
FROM d_icd_procedures_raw;