use sales;

#1. find the most expensive product  from products list
select productname,price from product
where price=(select max(price) from product);

#2. find all the product expensice than 100
 select productname,price from product 
 where price > 100;

#3. Get all order  place by ashime paudel 
 select * from orders 
 INNER JOIN customer
 ON orders.cid=customer.cid
 WHERE customer.name='Ashim Paudel';
 
 #4. toal revenue earned
  select sum(amount) AS totalrevenue
  from payment;
  
  #5.REVENUE BY customer
 SELECT c.name, SUM(p.amount) AS TotalSpent
FROM Customer c
JOIN Orders o ON c.cid = o.cid
JOIN Payment p ON o.oid = p.oid
GROUP BY c.name
ORDER BY TotalSpent DESC;

#6. monthly revenue
SELECT DATE_FORMAT(paymentdate, '%Y-%m') AS Month,
       SUM(amount) AS MonthlyRevenue
FROM Payment
GROUP BY Month
ORDER BY Month;

#7.YEARLY REVENUE
select DATE(paymentdate) AS year,
max(amount) AS REVENUE
from payment
GROUP BY DATE(paymentdate)
ORDER BY year;

#8. customer who havent place any order
select customer.name from customer
left join orders 
ON orders.cid = customer.cid
where orders.oid is NULL;

#9. top 2 customer by spendings

select customer.name as names,
sum(payment.amount) as totalspend 
from customer
join orders ON customer.cid= orders.cid
join payment ON orders.oid=payment.oid
GROUP BY customer.name
ORDER BY totalspend DESC
LIMIT 2;

#10. order and payment in july 2023

SELECT 
    orders.oid,
    payment.amount,
    payment.paymentdate
FROM payment
JOIN orders ON orders.oid = payment.oid
WHERE YEAR(payment.paymentdate) = 2023
  AND MONTH(payment.paymentdate) = 7
ORDER BY payment.paymentdate;

#11. customer with highest single payment

select customer.name,payment.amount from customer
join orders on customer.cid= orders.cid
join  payment on orders.oid= payment.oid
ORDER BY payment.amount DESC
LIMIT 1;





  
  