-- 02_SQL_Analytics.sql
USE ecommerce_sales;

-- 1 Total Revenue
SELECT SUM(amount) AS total_revenue FROM Payment;

-- 2 Total Customers
SELECT COUNT(*) AS total_customers FROM Customer;

-- 3 Total Orders
SELECT COUNT(*) total_orders FROM Orders;

-- 4 Average Order Value
SELECT ROUND(AVG(amount),2) avg_order_value FROM Payment;

-- 5 Monthly Revenue
SELECT DATE_FORMAT(payment_date,'%Y-%m') month,SUM(amount) revenue
FROM Payment GROUP BY month ORDER BY month;

-- 6 Yearly Revenue
SELECT YEAR(payment_date) year,SUM(amount) revenue
FROM Payment GROUP BY year;

-- 7 Revenue by Customer
SELECT c.full_name,SUM(p.amount) total_spent
FROM Customer c
JOIN Orders o ON c.customer_id=o.customer_id
JOIN Payment p ON o.order_id=p.order_id
GROUP BY c.customer_id,c.full_name
ORDER BY total_spent DESC;

-- 8 Top 5 Customers
SELECT c.full_name,SUM(p.amount) total_spent
FROM Customer c
JOIN Orders o ON c.customer_id=o.customer_id
JOIN Payment p ON o.order_id=p.order_id
GROUP BY c.customer_id,c.full_name
ORDER BY total_spent DESC
LIMIT 5;

-- 9 Customers Without Orders
SELECT c.full_name
FROM Customer c
LEFT JOIN Orders o ON c.customer_id=o.customer_id
WHERE o.order_id IS NULL;

--10 Best Selling Products
SELECT pr.product_name,SUM(oi.quantity) qty_sold
FROM OrderItems oi
JOIN Product pr ON oi.product_id=pr.product_id
GROUP BY pr.product_id,pr.product_name
ORDER BY qty_sold DESC;

--11 Revenue by Product
SELECT pr.product_name,
SUM((oi.unit_price-oi.discount)*oi.quantity) revenue
FROM OrderItems oi
JOIN Product pr ON oi.product_id=pr.product_id
GROUP BY pr.product_id;

--12 Revenue by Category
SELECT ca.category_name,
SUM((oi.unit_price-oi.discount)*oi.quantity) revenue
FROM Category ca
JOIN Product pr ON ca.category_id=pr.category_id
JOIN OrderItems oi ON pr.product_id=oi.product_id
GROUP BY ca.category_id;

--13 Most Expensive Product
SELECT product_name,unit_price
FROM Product
WHERE unit_price=(SELECT MAX(unit_price) FROM Product);

--14 Cheapest Product
SELECT product_name,unit_price
FROM Product
WHERE unit_price=(SELECT MIN(unit_price) FROM Product);

--15 Repeat Customers
SELECT c.full_name,COUNT(*) orders_count
FROM Customer c JOIN Orders o USING(customer_id)
GROUP BY c.customer_id
HAVING COUNT(*)>1;

--16 Running Revenue
SELECT payment_date,amount,
SUM(amount) OVER(ORDER BY payment_date) running_revenue
FROM Payment;

--17 Customer Order Sequence
SELECT c.full_name,o.order_date,
ROW_NUMBER() OVER(PARTITION BY c.customer_id ORDER BY o.order_date) order_sequence
FROM Orders o JOIN Customer c USING(customer_id);

--18 Rank Customers
SELECT full_name,total_spent,
RANK() OVER(ORDER BY total_spent DESC) spending_rank
FROM(
SELECT c.full_name,SUM(p.amount) total_spent
FROM Customer c
JOIN Orders o USING(customer_id)
JOIN Payment p USING(order_id)
GROUP BY c.customer_id,c.full_name
)x;

--19 Monthly Growth
WITH m AS(
SELECT DATE_FORMAT(payment_date,'%Y-%m') mth,SUM(amount) rev
FROM Payment GROUP BY mth)
SELECT mth,rev,
LAG(rev) OVER(ORDER BY mth) previous_month,
rev-LAG(rev) OVER(ORDER BY mth) growth
FROM m;

--20 Average Items Per Order
SELECT AVG(item_count) avg_items
FROM(
SELECT order_id,SUM(quantity) item_count
FROM OrderItems GROUP BY order_id)t;
