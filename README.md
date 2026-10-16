# Data Warehouse Star Schema Design

A complete star schema implementation for a sample retail dataset. This project demonstrates data warehouse design principles including fact and dimension tables, surrogate keys, and analytical SQL queries — all runnable on **PostgreSQL** or **Google BigQuery**.

---

## Schema Overview

The schema models a retail business with the following structure:

**Fact Table:**
- `fact_sales` — One row per line item on a sales order

**Dimension Tables:**
- `dim_date` — Calendar attributes (year, quarter, month, day)
- `dim_customer` — Customer demographics and location
- `dim_product` — Product details and category hierarchy
- `dim_store` — Store location and region

```
        dim_date
           |
dim_customer — fact_sales — dim_product
           |
        dim_store
```

---

## Files

| File | Description |
|------|-------------|
| `schema.sql` | DDL to create all dimension and fact tables |
| `seed_data.sql` | INSERT statements to populate tables with sample data |
| `queries.sql` | Analytical queries demonstrating star schema usage |
| `README.md` | This file |

---

## Getting Started

### PostgreSQL (Local)

1. Make sure PostgreSQL is installed and running.
2. Create a database:
   ```bash
   createdb retail_dw
   ```
3. Run the schema and seed scripts:
   ```bash
   psql -d retail_dw -f schema.sql
   psql -d retail_dw -f seed_data.sql
   ```
4. Run analytical queries:
   ```bash
   psql -d retail_dw -f queries.sql
   ```

### Google BigQuery (Cloud)

1. Create a BigQuery dataset named `retail_dw` in your GCP project.
2. In the BigQuery console or via `bq` CLI, run `schema.sql` first, then `seed_data.sql`.
   - Note: BigQuery uses standard SQL. The scripts use ANSI SQL and are compatible with minor adjustments (e.g., replace `SERIAL` with `INT64`, use `INSERT INTO` without column-type casts).
3. Paste queries from `queries.sql` into the BigQuery query editor to explore results.

---

## Star Schema Design Decisions

- **Surrogate keys** are used for all dimension tables (e.g., `customer_key`) instead of natural business keys to insulate the fact table from source system changes.
- **Slowly Changing Dimensions (SCD Type 1)** — dimension records are overwritten on update (simple approach suitable for a portfolio demo).
- **Degenerate dimension** — `order_id` is stored directly on the fact table since it carries no additional attributes.
- **Date dimension** — pre-populated with computed calendar attributes to enable fast time-series aggregations without runtime date functions.

---

## Sample Analytical Questions Answered

- What are total sales by product category per quarter?
- Which stores generate the most revenue?
- Who are the top 5 customers by lifetime spend?
- What is the month-over-month sales trend?

---

## Skills Demonstrated

- Relational database design (star schema / dimensional modeling)
- SQL DDL (CREATE TABLE, primary keys, foreign keys)
- SQL DML (INSERT, bulk seed data)
- Analytical SQL (GROUP BY, JOIN across fact and dimensions, window functions)
- Cloud data warehousing concepts (BigQuery-compatible design)