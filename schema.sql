-- ============================================================
-- Star Schema DDL
-- Retail Data Warehouse
-- Compatible with PostgreSQL (use SERIAL for auto-increment)
-- For BigQuery: replace SERIAL -> INT64, VARCHAR -> STRING
-- ============================================================

-- Drop tables if they exist (for clean re-runs)
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_customer;
DROP TABLE IF EXISTS dim_product;
DROP TABLE IF EXISTS dim_store;

-- ------------------------------------------------------------
-- Dimension: Date
-- ------------------------------------------------------------
CREATE TABLE dim_date (
    date_key        INTEGER PRIMARY KEY,  -- YYYYMMDD format
    full_date       DATE        NOT NULL,
    day_of_week     VARCHAR(10) NOT NULL,
    day_of_month    INTEGER     NOT NULL,
    month_number    INTEGER     NOT NULL,
    month_name      VARCHAR(10) NOT NULL,
    quarter         INTEGER     NOT NULL,
    year            INTEGER     NOT NULL,
    is_weekend      BOOLEAN     NOT NULL
);

-- ------------------------------------------------------------
-- Dimension: Customer
-- ------------------------------------------------------------
CREATE TABLE dim_customer (
    customer_key    SERIAL PRIMARY KEY,
    customer_id     VARCHAR(20)  NOT NULL UNIQUE,  -- natural key
    first_name      VARCHAR(50)  NOT NULL,
    last_name       VARCHAR(50)  NOT NULL,
    email           VARCHAR(100),
    city            VARCHAR(50),
    state           VARCHAR(50),
    country         VARCHAR(50)  NOT NULL DEFAULT 'USA',
    segment         VARCHAR(30)  -- e.g. 'Consumer', 'Corporate', 'Home Office'
);

-- ------------------------------------------------------------
-- Dimension: Product
-- ------------------------------------------------------------
CREATE TABLE dim_product (
    product_key     SERIAL PRIMARY KEY,
    product_id      VARCHAR(20)  NOT NULL UNIQUE,  -- natural key
    product_name    VARCHAR(150) NOT NULL,
    category        VARCHAR(50)  NOT NULL,
    sub_category    VARCHAR(50),
    brand           VARCHAR(50),
    unit_cost       NUMERIC(10,2) NOT NULL
);

-- ------------------------------------------------------------
-- Dimension: Store
-- ------------------------------------------------------------
CREATE TABLE dim_store (
    store_key       SERIAL PRIMARY KEY,
    store_id        VARCHAR(20)  NOT NULL UNIQUE,  -- natural key
    store_name      VARCHAR(100) NOT NULL,
    city            VARCHAR(50),
    state           VARCHAR(50),
    region          VARCHAR(30)  -- e.g. 'East', 'West', 'Central'
);

-- ------------------------------------------------------------
-- Fact: Sales
-- ------------------------------------------------------------
CREATE TABLE fact_sales (
    sales_key       SERIAL PRIMARY KEY,
    order_id        VARCHAR(30)   NOT NULL,  -- degenerate dimension
    date_key        INTEGER       NOT NULL REFERENCES dim_date(date_key),
    customer_key    INTEGER       NOT NULL REFERENCES dim_customer(customer_key),
    product_key     INTEGER       NOT NULL REFERENCES dim_product(product_key),
    store_key       INTEGER       NOT NULL REFERENCES dim_store(store_key),
    quantity        INTEGER       NOT NULL,
    unit_price      NUMERIC(10,2) NOT NULL,
    discount        NUMERIC(5,2)  NOT NULL DEFAULT 0.00,
    sales_amount    NUMERIC(12,2) NOT NULL,  -- quantity * unit_price * (1 - discount)
    profit          NUMERIC(12,2) NOT NULL   -- sales_amount - (quantity * unit_cost)
);