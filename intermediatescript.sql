-- FAMILIARIZE YOURSELF WITH WHAT WE ARE STARTING WITH
SELECT 
  * 
FROM 
  customers 
LIMIT 
  10;
SELECT 
  * 
FROM 
  books 
LIMIT 
  10;
SELECT 
  * 
FROM 
  orders 
LIMIT 
  10;
-- EXAMINE THE INDEXES THAT ALREADY EXIST
SELECT 
  * 
FROM 
  pg_Indexes 
WHERE 
  tablename = 'customers';
SELECT 
  * 
FROM 
  pg_Indexes 
WHERE 
  tablename = 'orders';
SELECT 
  * 
FROM 
  pg_Indexes 
WHERE 
  tablename = 'books';
-- SALES GREATER THAN 18UNITS SOLD IN AN ORDER (HOW LONG WILL THIS SELECT STATEMENT TAKE WITHOUT AN INDEX?)
EXPLAIN ANALYZE 
SELECT 
  customer_id, 
  quantity 
FROM 
  orders 
WHERE 
  quantity > 18;
-- CREATE INDEX TO IMPROVE THE SERACH TIME FOR THE ABOVE QUERY
CREATE INDEX customer_id_quantity_idx ON orders (customer_id, quantity) 
WHERE 
  quantity > 18;
-- VERIFY AND COMPARE IMPACT OF NEW INDEX 
EXPLAIN ANALYZE 
SELECT 
  customer_id, 
  quantity 
FROM 
  orders 
WHERE 
  quantity > 18;
-- AS MORE ORDERS ARE PLACED, WOULD THIS DIFFERENCE BECOME GREATER OR LESS NOTICEABLE?
EXPLAIN ANALYZE 
SELECT 
  * 
FROM 
  customers 
WHERE 
  customer_id < 100;
-- ADD PRIMARY KEY TO CUSTOMERS TABLE
ALTER TABLE 
  customers 
ADD 
  CONSTRAINT customers_pkey PRIMARY KEY (customer_id);
-- CHECK EFFECTIVENESS OF THIS INDEX
EXPLAIN ANALYZE 
SELECT 
  * 
FROM 
  customers 
WHERE 
  customer_id < 100;
-- VIEW TABLE ORGANISED BY PRIMARY KEY
SELECT 
  * 
FROM 
  customers 
LIMIT 
  10;
-- BUILD MULTICOLUMN INDEX
CREATE INDEX customer_id_book_id_orders_idx ON orders(customer_id, book_id);
-- DROP PREVIOUS INDEX AND RECREATE TO IMPROVE FOR THIS NEW INFORMATION
DROP 
  INDEX IF EXISTS customer_id_book_id_orders_idx;
-- CREATE INDEX TO IMPROVE RUNTIME
CREATE INDEX books_author_title_idx ON books (author, title);
EXPLAIN ANALYZE 
SELECT 
  quantity, 
  price_base 
FROM 
  orders 
WHERE 
  (
    (quantity * price_base) > 100
  );
-- CREATE INDEX TO SPEED UP QUERY
CREATE INDEX orders_quantity_price_base_idx ON orders(quantity, price_base) 
WHERE 
  (
    (quantity * price_base)
  ) > 100;
EXPLAIN ANALYZE 
SELECT 
  quantity, 
  price_base 
FROM 
  orders 
WHERE 
  (
    (quantity * price_base) > 100
  );
SELECT 
  * 
FROM 
  pg_indexes 
WHERE 
  tablename IN ('customers', 'books', 'orders') 
ORDER BY 
  tablename, 
  indexname;
DROP 
  INDEX IF EXISTS books_author_idx;
DROP 
  INDEX IF EXISTS orders_customer_id_quantity;
-- CREATE INDEX TO SPEED UP QUERY
CREATE INDEX customers_last_name_first_name_email_address ON customers (
  last_name, first_name, email_address
);
SELECT 
  * 
FROM 
  pg_indexes 
WHERE 
  tablename IN ('customers', 'books', 'orders') 
ORDER BY 
  tablename, 
  indexname;
