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
  orders 
LIMIT 
  10;
SELECT 
  * 
FROM 
  books 
LIMIT 
  10;
-- EXAMINE THE INDEXES THAT ALREADY EXIST ON THE THREE TABLES
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
-- CREATE INDEX
CREATE INDEX customer_id_inx ON orders (customer_id);
-- CHECK RUNTIME OF A QUERY
EXPLAIN ANALYZE 
SELECT 
  original_language, 
  title, 
  sales_in_millions 
FROM 
  books 
WHERE 
  original_language = 'French';
-- LETS GET THE SIZE OF THE BOOKS TABLE
SELECT 
  pg_size_pretty (
    pg_total_relation_size('books')
  );
-- CREATE INDEX 
CREATE INDEX language_title_copies_idx ON books (
  original_language, title, sales_in_millions
);
-- COMPARE RUNTIME AND SIZE WITH OUR NEW INDEX 
SELECT 
  * 
FROM 
  pg_Indexes 
WHERE 
  tablename = 'books';
SELECT 
  pg_size_pretty (
    pg_total_relation_size('books')
  );
-- DELETE MULTICOLUMN INDEX TO MAKE IT SO INSERTS INTO THE BOOKS WILL RUN QUICKLY
DROP 
  INDEX IF EXISTS language_title_copies_idx;
SELECT 
  * 
FROM 
  pg_Indexes 
WHERE 
  tablename = 'books';
