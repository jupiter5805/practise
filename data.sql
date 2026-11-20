CREATE TABLE IF NOT EXISTS pharmacies (
    pharmacy_id INT PRIMARY KEY,
    pharmacy_name VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS sales (
    sale_id INT PRIMARY KEY,
    pharmacy_id INT REFERENCES pharmacies(pharmacy_id),
    product VARCHAR(100),
    amount DECIMAL(10,2)
);
INSERT INTO pharmacies VALUES
(1, 'Well Pharmacy A', 'Manchester'),
(2, 'Well Pharmacy B', 'Stockport'),
(3, 'Well Pharmacy C', 'Liverpool'),
(4, 'Well Pharmacy D', 'Leeds')
ON CONFLICT (pharmacy_id) DO NOTHING;

INSERT INTO sales VALUES
(101, 1, 'Paracetamol', 100),
(102, 1, 'Ibuprofen', 200),
(103, 2, 'Paracetamol', 150),
(104, 2, 'Vitamin D', 300),
(105, 3, 'Aspirin', 250)
ON CONFLICT (sale_id) DO NOTHING;

CREATE TABLE IF NOT EXISTS daily_sales (
sale_id INT PRIMARY KEY,
pharmacy_id INT REFERENCES pharmacies(pharmacy_id),
sale_date DATE NOT NULL,
amount NUMERIC(10,2)
);
INSERT INTO daily_sales VALUES
(201, 1, '2026-11-01', 100),
(202, 1, '2026-11-02', 180),
(203, 1, '2026-11-03', 180),
(204, 2, '2026-11-01', 150),
(205, 2, '2026-11-02', 300),
(206, 2, '2026-11-03', 120),
(207, 3, '2026-11-01', 250),
(208, 3, '2026-11-03', 90)
ON CONFLICT (sale_id) DO NOTHING;

CREATE TABLE IF NOT EXISTS sales_staging (
raw_id INT PRIMARY KEY,
source_sale_id INT,
pharmacy_id INT,
product TEXT,
amount_text TEXT
);
INSERT INTO sales_staging VALUES
(1, 901, 1, ' Paracetamol ', '100.00'),
(2, 901, 1, ' Paracetamol ', '100.00'),
(3, 902, 2, 'VITAMIN D', ' 300 '),
(4, 903, 3, 'Aspirin', NULL),
(5, 904, 99, 'Ibuprofen', '200'),
(6, 905, 2, '', 'invalid'),
(7, 906, 1, 'Ibuprofen', '-20'),
(8, NULL, 3, NULL, '75')
ON CONFLICT (raw_id) DO NOTHING;