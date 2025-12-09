-- Challenge C : SUBQUERIES

-- 01 List products that cost above the average product price.
select * from products WHERE price > (SELECT  AVG(price) from products) ;

