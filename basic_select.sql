--challenge: A 
-- 1 List all customers ordered alphabetically by last name.
select * FROM customers ORDER BY last_name DESC

 -- 2 Retrieve all products with a price greater than 10,000.
 SELECT * FROM products WHERE price > 10000

-- 3 Display all orders with status "delivered".
SELECT * FROM orders WHERE status = "delivered";

-- 4 Show all categories ordered by category name.
SELECT * FROM categories ORDER BY category_name;

-- 5 List all suppliers located in alphabetical order.
SELECT * FROM suppliers ORDER BY company_name;
