
-- Ecommerce Sales Analytics Database on MySQL 8.0
-- Professional 3NF Schema


DROP DATABASE IF EXISTS ecommerce_sales;
CREATE DATABASE ecommerce_sales;
USE ecommerce_sales;

CREATE TABLE Customer(
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  phone VARCHAR(20),
  join_date DATE NOT NULL,
  city VARCHAR(100)
);

CREATE TABLE Category(
  category_id INT AUTO_INCREMENT PRIMARY KEY,
  category_name VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE Product(
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  category_id INT NOT NULL,
  product_name VARCHAR(120) NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL CHECK(unit_price>0),
  stock_quantity INT NOT NULL DEFAULT 0 CHECK(stock_quantity>=0),
  FOREIGN KEY(category_id) REFERENCES Category(category_id)
);

CREATE TABLE Orders(
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date DATE NOT NULL,
  order_status ENUM('Pending','Paid','Shipped','Delivered','Cancelled')
    DEFAULT 'Pending',
  FOREIGN KEY(customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE OrderItems(
  order_item_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL CHECK(quantity>0),
  unit_price DECIMAL(10,2) NOT NULL CHECK(unit_price>0),
  discount DECIMAL(5,2) DEFAULT 0 CHECK(discount>=0),
  FOREIGN KEY(order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
  FOREIGN KEY(product_id) REFERENCES Product(product_id)
);

CREATE TABLE Payment(
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL UNIQUE,
  payment_date DATE NOT NULL,
  amount DECIMAL(10,2) NOT NULL CHECK(amount>=0),
  payment_method ENUM('Cash','Card','eWallet','Bank Transfer') NOT NULL,
  payment_status ENUM('Pending','Completed','Refunded')
    DEFAULT 'Completed',
  FOREIGN KEY(order_id) REFERENCES Orders(order_id)
);

CREATE INDEX idx_orders_customer ON Orders(customer_id);
CREATE INDEX idx_orders_date ON Orders(order_date);
CREATE INDEX idx_orderitems_product ON OrderItems(product_id);
CREATE INDEX idx_payment_date ON Payment(payment_date);

INSERT INTO Category(category_name) VALUES
('Electronics'),('Fitness'),('Accessories'),('Home'),('Books');

INSERT INTO Customer(full_name,email,phone,join_date,city) VALUES
('Ashim Paudel','ashim@example.com','9800000001','2024-01-10','Kathmandu'),
('Sita Sharma','sita@example.com','9800000002','2024-02-15','Pokhara'),
('Ravi Thapa','ravi@example.com','9800000003','2024-03-12','Lalitpur'),
('Maya Gurung','maya@example.com','9800000004','2024-03-25','Bhaktapur'),
('Ram KC','ram@example.com','9800000005','2024-04-11','Butwal'),
('Nisha Rai','nisha@example.com','9800000006','2024-05-09','Dharan'),
('Bikash Lama','bikash@example.com','9800000007','2024-06-01','Hetauda'),
('Anita Karki','anita@example.com','9800000008','2024-06-18','Biratnagar'),
('Prakash Oli','prakash@example.com','9800000009','2024-07-01','Nepalgunj'),
('Suman Shrestha','suman@example.com','9800000010','2024-07-22','Chitwan');

INSERT INTO Product(category_id,product_name,unit_price,stock_quantity) VALUES
(1,'Laptop',900,20),
(1,'Smartphone',650,30),
(1,'Tablet',400,25),
(2,'Gym Membership',250,999),
(2,'Protein Powder',45,120),
(3,'Headphones',70,80),
(3,'Keyboard',55,70),
(4,'Office Chair',180,15),
(4,'Desk Lamp',40,40),
(5,'SQL Handbook',35,60);

INSERT INTO Orders(customer_id,order_date,order_status) VALUES
(1,'2025-01-05','Delivered'),
(2,'2025-01-08','Delivered'),
(1,'2025-02-14','Delivered'),
(3,'2025-02-20','Shipped'),
(4,'2025-03-10','Delivered');

INSERT INTO OrderItems(order_id,product_id,quantity,unit_price,discount) VALUES
(1,1,1,900,0),
(2,2,1,650,0),
(3,6,2,70,10),
(3,5,1,45,0),
(4,4,1,250,0),
(5,10,2,35,0);

INSERT INTO Payment(order_id,payment_date,amount,payment_method,payment_status) VALUES
(1,'2025-01-05',900,'Card','Completed'),
(2,'2025-01-08',650,'eWallet','Completed'),
(3,'2025-02-14',175,'Cash','Completed'),
(4,'2025-02-20',250,'Bank Transfer','Completed'),
(5,'2025-03-10',70,'Card','Completed');
