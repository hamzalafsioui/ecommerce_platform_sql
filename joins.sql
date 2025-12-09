-- Challenge B : JOINS
-- 1 Show each customer and the number of addresses they have.
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    COUNT(a.address_id) AS number_of_addresses
FROM customers c
LEFT JOIN addresses a ON a.customer_id = c.customer_id
GROUP BY c.customer_id, full_name
ORDER BY full_name;
 -- 2 List each order with customer full name and order status.
SELECT 
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    o.status,
    o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC;
-- 3 Display all products with their supplier company names.
SELECT 
    p.product_id,
    p.product_name,
    p.price,
    s.company_name AS supplier
FROM products p
JOIN suppliers s ON s.supplier_id = p.supplier_id
ORDER BY p.price DESC;
-- 4 Retrieve all products and their categories (many-to-many).
SELECT 
    p.product_id,
    p.product_name,
    c.category_name
FROM products p
JOIN product_category pc ON p.product_id = pc.product_id
JOIN categories c ON c.category_id = pc.category_id
ORDER BY p.product_id;
-- 5 Show all order items with product name and order date.
SELECT 
    oi.order_item_id,
    o.order_id,
    o.order_date,
    p.product_name,
    oi.quantity,
    oi.price
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN products p ON p.product_id = oi.product_id
ORDER BY o.order_date DESC;
-- 6 Display each customer and their latest order.
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    o.order_id,
    o.order_date
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_date = (
    SELECT MAX(o2.order_date)
    FROM orders o2
    WHERE o2.customer_id = c.customer_id
)
ORDER BY o.order_date DESC;
-- 7 Find all products that are low in stock (stock <= 10).
SELECT 
    p.product_id,
    p.product_name,
    i.stock
FROM products p
JOIN inventory i ON p.product_id = i.product_id
WHERE i.stock <= 10
ORDER BY i.stock ASC;
-- 8 List each category and the number of products in it.
SELECT 
    c.category_id,
    c.category_name,
    COUNT(pc.product_id) AS number_of_products
FROM categories c
JOIN product_category pc ON pc.category_id = c.category_id
GROUP BY c.category_id, c.category_name
ORDER BY number_of_products DESC;

-- 9 Show each customer and how much they spent on all orders.
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    SUM(oi.quantity * oi.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;

-- 10 Find the top 3 most expensive products with supplier name.
SELECT p.product_id,p.product_name,p.price,s.company_name 
FROM products p 
INNER JOIN suppliers s ON S.supplier_id = p.supplier_id
ORDER BY p.price 
DESC LIMIT 3;