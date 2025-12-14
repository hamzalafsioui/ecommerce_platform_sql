-- Challenge C : SUBQUERIES

-- 01 List products that cost above the average product price. -------------
select * from products WHERE price > (SELECT  AVG(price) from products) ;

-- 02 Find customers who placed more orders than the average customer. -------------

-- get orders per customer
SELECT customer_id, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id;

-- avg numbers of orders per customer
SELECT AVG(order_count) FROM (SELECT customer_id, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id) t;

-- result: 
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

-- 03 List orders whose total amount is above average order value. -------------
SELECT * FROM order_items ;
-- calculate order_total
SELECT order_id,SUM(price*quantity) as order_total FROM order_items GROUP BY order_id;
-- calculate avg of order_total
SELECT AVG(order_total) as avg_orders FROM (
        SELECT SUM(price * quantity) AS order_total
        FROM order_items
        GROUP BY order_id
    ) avg_orders;

-- result:
SELECT sp.order_id, sp.order_total
FROM (
    SELECT order_id, SUM(price * quantity) AS order_total
    FROM order_items
    GROUP BY order_id
) sp
WHERE sp.total_price >
(
    SELECT AVG(order_total)
    FROM (
        SELECT SUM(price * quantity) AS order_total
        FROM order_items
        GROUP BY order_id
    ) avg_orders
);
-- result: with CTE (Common Table Expression)
WITH order_totals AS (
    SELECT order_id, SUM(price * quantity) AS order_total
    FROM order_items
    GROUP BY order_id
)
SELECT order_id,order_total FROM order_totals
WHERE order_total > (SELECT AVG(order_total) FROM order_totals);