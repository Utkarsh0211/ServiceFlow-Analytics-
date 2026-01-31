-- =====================================================
-- GreenScape Analytics – MASTER SQL SCRIPT
-- =====================================================

BEGIN;

-- =========================
-- DROP EXISTING OBJECTS
-- =========================
DROP VIEW IF EXISTS vw_kpi_invoice_handoff_delay;
DROP VIEW IF EXISTS vw_kpi_dso;
DROP VIEW IF EXISTS vw_kpi_job_cost_variance;
DROP VIEW IF EXISTS vw_kpi_unbilled_revenue;
DROP VIEW IF EXISTS vw_kpi_job_cycle_time;

DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS invoice_line_items CASCADE;
DROP TABLE IF EXISTS invoices CASCADE;
DROP TABLE IF EXISTS job_costs CASCADE;
DROP TABLE IF EXISTS jobs CASCADE;
DROP TABLE IF EXISTS customers CASCADE;

DROP TABLE IF EXISTS dim_cost_type CASCADE;
DROP TABLE IF EXISTS dim_invoice_status CASCADE;
DROP TABLE IF EXISTS dim_job_status CASCADE;
DROP TABLE IF EXISTS dim_service_type CASCADE;
DROP TABLE IF EXISTS dim_region CASCADE;

-- =========================
-- DIMENSIONS
-- =========================
CREATE TABLE dim_region (
    region_id SERIAL PRIMARY KEY,
    region_code VARCHAR(10) UNIQUE NOT NULL,
    region_name VARCHAR(50) NOT NULL
);

CREATE TABLE dim_service_type (
    service_type_id SERIAL PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL
);

CREATE TABLE dim_job_status (
    job_status_id SERIAL PRIMARY KEY,
    status_code VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE dim_invoice_status (
    invoice_status_id SERIAL PRIMARY KEY,
    status_code VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE dim_cost_type (
    cost_type_id SERIAL PRIMARY KEY,
    cost_type_name VARCHAR(50) NOT NULL
);

-- =========================
-- FACT TABLES
-- =========================
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_code VARCHAR(20) UNIQUE NOT NULL,
    customer_name VARCHAR(150) NOT NULL,
    region_id INT REFERENCES dim_region(region_id),
    created_date DATE NOT NULL
);

CREATE TABLE jobs (
    job_id SERIAL PRIMARY KEY,
    job_number VARCHAR(20) UNIQUE NOT NULL,
    customer_id INT REFERENCES customers(customer_id),
    service_type_id INT REFERENCES dim_service_type(service_type_id),
    region_id INT REFERENCES dim_region(region_id),
    job_status_id INT REFERENCES dim_job_status(job_status_id),
    scheduled_date DATE,
    completed_date DATE,
    estimated_revenue NUMERIC(12,2),
    estimated_cost NUMERIC(12,2),
    created_date DATE NOT NULL
);

CREATE TABLE job_costs (
    job_cost_id SERIAL PRIMARY KEY,
    job_id INT REFERENCES jobs(job_id),
    cost_type_id INT REFERENCES dim_cost_type(cost_type_id),
    actual_amount NUMERIC(12,2)
);

CREATE TABLE invoices (
    invoice_id SERIAL PRIMARY KEY,
    invoice_number VARCHAR(20) UNIQUE NOT NULL,
    customer_id INT REFERENCES customers(customer_id),
    invoice_status_id INT REFERENCES dim_invoice_status(invoice_status_id),
    invoice_date DATE,
    invoice_amount NUMERIC(12,2)
);

CREATE TABLE invoice_line_items (
    invoice_id INT REFERENCES invoices(invoice_id),
    job_id INT REFERENCES jobs(job_id),
    PRIMARY KEY (invoice_id, job_id)
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    invoice_id INT REFERENCES invoices(invoice_id),
    payment_date DATE,
    payment_amount NUMERIC(12,2)
);

-- =========================
-- REFERENCE DATA
-- =========================
INSERT INTO dim_region (region_code, region_name)
VALUES ('NORTH','North'),('CENTRAL','Central'),('SOUTH','South')
ON CONFLICT DO NOTHING;

INSERT INTO dim_job_status (status_code)
VALUES ('SCHEDULED'),('IN_PROGRESS'),('COMPLETED'),('CANCELLED')
ON CONFLICT DO NOTHING;

INSERT INTO dim_invoice_status (status_code)
VALUES ('DRAFT'),('SENT'),('PAID')
ON CONFLICT DO NOTHING;

INSERT INTO dim_service_type (service_name)
VALUES ('Lawn Maintenance'),('Installation'),('Emergency Repair')
ON CONFLICT DO NOTHING;

INSERT INTO dim_cost_type (cost_type_name)
VALUES ('Labor'),('Materials')
ON CONFLICT DO NOTHING;

-- =========================
-- TRANSACTION DATA
-- =========================
INSERT INTO customers (customer_code, customer_name, region_id, created_date)
VALUES
('CUST-001','Oakwood Corporate Park',1,'2024-01-05'),
('CUST-002','Riverside HOA',2,'2024-02-10'),
('CUST-003','City of Greenfield',3,'2024-03-01')
ON CONFLICT DO NOTHING;

INSERT INTO jobs (
    job_number, customer_id, service_type_id, region_id,
    job_status_id, scheduled_date, completed_date,
    estimated_revenue, estimated_cost, created_date
)
VALUES
('JOB-1001',1,1,1,3,'2024-01-10','2024-01-10',2500,1800,'2024-01-05'),
('JOB-1002',2,2,2,3,'2024-02-15','2024-02-20',12000,9000,'2024-02-10'),
('JOB-1003',3,3,3,2,'2024-03-05',NULL,3500,2800,'2024-03-01')
ON CONFLICT DO NOTHING;

INSERT INTO job_costs (job_id, cost_type_id, actual_amount)
VALUES
(1,1,1300),(1,2,500),(2,1,6200),(2,2,4500)
ON CONFLICT DO NOTHING;

INSERT INTO invoices (invoice_number, customer_id, invoice_status_id, invoice_date, invoice_amount)
VALUES ('INV-5001',1,2,'2024-01-15',2500)
ON CONFLICT DO NOTHING;

INSERT INTO invoice_line_items (invoice_id, job_id)
VALUES (1,1)
ON CONFLICT DO NOTHING;

INSERT INTO payments (invoice_id, payment_date, payment_amount)
VALUES (1,'2024-03-01',1500)
ON CONFLICT DO NOTHING;

-- =========================
-- KPI VIEWS (POWER BI READY)
-- =========================

CREATE VIEW vw_kpi_invoice_handoff_delay AS
SELECT
    j.job_number,
    j.completed_date,
    CURRENT_DATE - j.completed_date AS days_pending
FROM jobs j
JOIN dim_job_status js ON j.job_status_id = js.job_status_id
LEFT JOIN invoice_line_items ili ON j.job_id = ili.job_id
WHERE js.status_code = 'COMPLETED'
  AND ili.job_id IS NULL;

CREATE VIEW vw_kpi_dso AS
SELECT
    AVG(p.payment_date - i.invoice_date) AS dso_days
FROM invoices i
JOIN payments p ON i.invoice_id = p.invoice_id;

CREATE VIEW vw_kpi_job_cost_variance AS
SELECT
    j.job_number,
    j.estimated_cost,
    SUM(jc.actual_amount) AS actual_cost,
    SUM(jc.actual_amount) - j.estimated_cost AS variance
FROM jobs j
JOIN job_costs jc ON j.job_id = jc.job_id
GROUP BY j.job_number, j.estimated_cost;

CREATE VIEW vw_kpi_unbilled_revenue AS
SELECT
    SUM(j.estimated_revenue) AS unbilled_amount
FROM jobs j
JOIN dim_job_status js ON j.job_status_id = js.job_status_id
LEFT JOIN invoice_line_items ili ON j.job_id = ili.job_id
WHERE js.status_code = 'COMPLETED'
  AND ili.job_id IS NULL;

CREATE VIEW vw_kpi_job_cycle_time AS
SELECT
    job_number,
    completed_date - scheduled_date AS cycle_days
FROM jobs
WHERE completed_date IS NOT NULL;

COMMIT;
