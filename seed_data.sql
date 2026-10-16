-- ============================================================
-- Seed Data for Retail Star Schema
-- ============================================================

-- ------------------------------------------------------------
-- dim_date (a small sample of dates)
-- ------------------------------------------------------------
INSERT INTO dim_date (date_key, full_date, day_of_week, day_of_month, month_number, month_name, quarter, year, is_weekend) VALUES
(20230101, '2023-01-01', 'Sunday',    1,  1, 'January',   1, 2023, TRUE),
(20230115, '2023-01-15', 'Sunday',   15,  1, 'January',   1, 2023, TRUE),
(20230210, '2023-02-10', 'Friday',   10,  2, 'February',  1, 2023, FALSE),
(20230314, '2023-03-14', 'Tuesday',  14,  3, 'March',     1, 2023, FALSE),
(20230405, '2023-04-05', 'Wednesday', 5,  4, 'April',     2, 2023, FALSE),
(20230520, '2023-05-20', 'Saturday', 20,  5, 'May',       2, 2023, TRUE),
(20230618, '2023-06-18', 'Sunday',   18,  6, 'June',      2, 2023, TRUE),
(20230722, '2023-07-22', 'Saturday', 22,  7, 'July',      3, 2023, TRUE),
(20230810, '2023-08-10', 'Thursday', 10,  8, 'August',    3, 2023, FALSE),
(20230915, '2023-09-15', 'Friday',   15,  9, 'September', 3, 2023, FALSE),
(20231005, '2023-10-05', 'Thursday',  5, 10, 'October',   4, 2023, FALSE),
(20231120, '2023-11-20', 'Monday',   20, 11, 'November',  4, 2023, FALSE),
(20231215, '2023-12-15', 'Friday',   15, 12, 'December',  4, 2023, FALSE);

-- ------------------------------------------------------------
-- dim_customer
-- ------------------------------------------------------------
INSERT INTO dim_customer (customer_id, first_name, last_name, email, city, state, country, segment) VALUES
('CUST-001', 'Alice',   'Johnson', 'alice.johnson@email.com',  'New York',    'NY', 'USA', 'Consumer'),
('CUST-002', 'Bob',     'Smith',   'bob.smith@email.com',      'Los Angeles', 'CA', 'USA', 'Corporate'),
('CUST-003', 'Carol',   'White',   'carol.white@email.com',    'Chicago',     'IL', 'USA', 'Consumer'),
('CUST-004', 'David',   'Brown',   'david.brown@email.com',    'Houston',     'TX', 'USA', 'Home Office'),
('CUST-005', 'Eva',     'Davis',   'eva.davis@email.com',      'Phoenix',     'AZ', 'USA', 'Consumer'),
('CUST-006', 'Frank',   'Miller',  'frank.miller@email.com',   'Philadelphia','PA', 'USA', 'Corporate'),
('CUST-007', 'Grace',   'Wilson',  'grace.wilson@email.com',   'San Antonio', 'TX', 'USA', 'Consumer'),
('CUST-008', 'Henry',   'Moore',   'henry.moore@email.com',    'San Diego',   'CA', 'USA', 'Home Office');

-- ------------------------------------------------------------
-- dim_product
-- ------------------------------------------------------------
INSERT INTO dim_product (product_id, product_name, category, sub_category, brand, unit_cost) VALUES
('PROD-001', 'Wireless Mouse',          'Electronics',   'Peripherals',    'Logitech',  15.00),
('PROD-002', 'USB-C Hub 7-Port',        'Electronics',   'Peripherals',    'Anker',     22.00),
('PROD-003', 'Desk Lamp LED',           'Office Supplies','Lighting',       'BenQ',      35.00),
('PROD-004', 'Ergonomic Chair',         'Furniture',     'Seating',        'Herman Miller', 280.00),
('PROD-005', 'Standing Desk',           'Furniture',     'Desks',          'Uplift',   320.00),
('PROD-006', 'Notebook Pack (3x)',      'Office Supplies','Paper',          'Moleskine',  6.00),
('PROD-007', 'Mechanical Keyboard',     'Electronics',   'Peripherals',    'Keychron',  55.00),
('PROD-008', 'Monitor 27-inch 4K',      'Electronics',   'Displays',       'LG',       220.00);

-- ------------------------------------------------------------
-- dim_store
-- ------------------------------------------------------------
INSERT INTO dim_store (store_id, store_name, city, state, region) VALUES
('STR-001', 'Downtown NYC Store',    'New York',     'NY', 'East'),
('STR-002', 'LA Westside Store',     'Los Angeles',  'CA', 'West'),
('STR-003', 'Chicago Central Store', 'Chicago',      'IL', 'Central'),
('STR-004', 'Houston South Store',   'Houston',      'TX', 'Central'),
('STR-005', 'Online Store',          'N/A',          'N/A','Online');

-- ------------------------------------------------------------
-- fact_sales
-- (sales_amount = quantity * unit_price * (1 - discount))
-- (profit = sales_amount - quantity * unit_cost)
-- ------------------------------------------------------------
INSERT INTO fact_sales (order_id, date_key, customer_key, product_key, store_key, quantity, unit_price, discount, sales_amount, profit) VALUES
('ORD-1001', 20230101, 1, 1, 1, 2,  29.99, 0.00,  59.98,  29.98),
('ORD-1002', 20230115, 2, 8, 2, 1, 499.00, 0.10, 449.10,   9.10),
('ORD-1003', 20230210, 3, 4, 3, 1, 599.00, 0.05, 569.05, 289.05),
('ORD-1004', 20230314, 4, 5, 4, 1, 749.00, 0.00, 749.00, 429.00),
('ORD-1005', 20230405, 5, 7, 5, 3,  99.00, 0.00, 297.00, 132.00),
('ORD-1006', 20230405, 1, 2, 5, 2,  45.00, 0.10,  81.00,  37.00),
('ORD-1007', 20230520, 6, 3, 1, 1,  79.99, 0.15,  67.99,  32.99),
('ORD-1008', 20230618, 7, 6, 3, 4,  12.99, 0.00,  51.96,  27.96),
('ORD-1009', 20230722, 8, 8, 2, 1, 499.00, 0.00, 499.00, 279.00),
('ORD-1010', 20230810, 2, 1, 5, 4,  29.99, 0.00, 119.96,  59.96),
('ORD-1011', 20230915, 3, 5, 3, 2, 749.00, 0.20, 599.20, 279.20),
('ORD-1012', 20231005, 4, 4, 4, 1, 599.00, 0.05, 569.05, 289.05),
('ORD-1013', 20231120, 5, 7, 1, 3,  99.00, 0.00, 198.00,  88.00),
('ORD-1014', 20231215, 6, 2, 5, 2,  45.00, 0.00,  90.00,  46.00),
('ORD-1015', 20231215, 7, 8, 2, 1, 499.00, 0.10, 449.10, 229.10);