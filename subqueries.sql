-- Challenge C : SUBQUERIES

-- 01 List products that cost above the average product price.
select * from products WHERE price > (SELECT  AVG(price) from products) ;

-- 02 Find customers who placed more orders than the average customer.

-- get orders per customer
SELECT customer_id, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id;

-- avg numbers of orders per customer
SELECT AVG(order_count) FROM (SELECT customer_id, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id) t;


SELECT c.customer_id, c.first_name, c.last_name
FROM customers c
JOIN (
    SELECT customer_id, COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
) opc ON c.customer_id = opc.customer_id
WHERE opc.order_count >
(
    SELECT AVG(order_count)
    FROM (
        SELECT COUNT(*) AS order_count
        FROM orders
        GROUP BY customer_id
    ) avg_orders
);
