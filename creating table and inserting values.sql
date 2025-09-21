-- Customers table
CREATE TABLE Customer (
    cid INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    joindate DATE
);

-- Products table
CREATE TABLE Product (
    pid INT PRIMARY KEY,
    productname VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

-- Orders table
CREATE TABLE Orders (
    oid INT PRIMARY KEY,
    cid INT,
    orderdate DATE,
    FOREIGN KEY (cid) REFERENCES Customers(cid)
);

-- Payments table
CREATE TABLE Payment (
    pid INT PRIMARY KEY,
    oid INT,
    amount DECIMAL(10,2),
    paymentdate DATE,
    FOREIGN KEY (oid) REFERENCES Orders(oid)
);


#inserting values
INSERT INTO Customer (cid, name, email, joindate) VALUES
(1, 'Ashim Paudel', 'ashim@example.com', '2023-01-10'),
(2, 'Sita Sharma', 'sita@example.com', '2023-02-15'),
(3, 'Ravi Thapa', 'ravi@example.com', '2023-03-20'),
(4, 'Maya Gurung', 'maya@example.com', '2023-05-01');

-- Insert Products
INSERT INTO Product (pid, Productname, category, price) VALUES
(1, 'Laptop', 'Electronics', 750.00),
(2, 'Smartphone', 'Electronics', 500.00),
(3, 'Headphones', 'Accessories', 50.00),
(4, 'Gym Membership', 'Fitness', 200.00),
(5, 'Protein Powder', 'Fitness', 30.00);

-- Insert Orders
INSERT INTO Orders (oid, cid, orderdate) VALUES
(101, 1, '2023-06-12'),
(102, 2, '2023-06-15'),
(103, 1, '2023-07-05'),
(104, 3, '2023-07-20'),
(105, 4, '2023-08-01');

-- Insert Payments
INSERT INTO Payment (pid, oid, amount,paymentdate ) VALUES
(1001, 101, 750.00, '2023-06-12'),
(1002, 102, 500.00, '2023-06-15'),
(1003, 103, 80.00, '2023-07-05'),
(1004, 104, 200.00, '2023-07-20'),
(1005, 105, 30.00, '2023-08-01');
