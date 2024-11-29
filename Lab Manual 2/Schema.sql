-- Create the 'salesman' table
CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(255),
    city VARCHAR(255),
    commission DECIMAL(5, 2)
);

-- Create the 'orders' table
CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);

-- Create the 'customers' table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(255),
    city VARCHAR(255),
    grade INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);


-- Populate the 'salesman' table
INSERT INTO salesman (salesman_id, name, city, commission)
VALUES
    (5001, 'James Hoog', 'New York', 0.15),
    (5002, 'Nail Knite', 'Paris', 0.13),
    (5005, 'Pit Alex', 'London', 0.11),
    (5006, 'Mc Lyon', 'Paris', 0.14),
    (5003, 'Paul Adam', 'San Jose', 0.13),
    (5007, 'Lauson Hen', 'San Jose', 0.12);

-- Populate the 'customers' table
INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id)
VALUES
    (3002, 'Nick Rimando', 'New York', 100, 5001),
    (3007, 'John Brad Davis', 'New York', 200, 5001),
    (3005, 'Graham Zusi', 'California', 200, 5002),
    (3008, 'Julian Green', 'London', 300, 5002),
    (3004, 'Fabian Johnson', 'Paris', 300, 5006),
    (3009, 'Geoff Cameron', 'Berlin', 100, 5003),
    (3003, 'Jozy Altidore', 'Moscow', NULL, 5007),
    (3001, 'John Brad Guzan', 'London', NULL, 5005);

-- Populate the 'orders' table
INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES
    (70001, 150.50, '2012-10-05', 3005, 5002),
    (70009, 270.65, '2011-09-10', 3001, 5005),
    (70002, 65.26, '2014-10-05', 3002, 5001),
    (70004, 110.50, '2011-08-17', 3009, 5003),
    (70005, 948.50, '2012-09-10', 3005, 5002),
    (70003, 2400.60, '2010-07-27', 3007, 5001),
    (70007, 5760.00, '2013-09-10', 3002, 5001),
    (70012, 1983.43, '2010-10-10', 3004, 5006),
    (70011, 2480.40, '2013-10-10', 3009, 5003),
    (70013, 250.45, '2010-06-27', 3008, 5002),
    (70010, 75.29, '2014-08-17', 3003, 5007),
    (70014, 3045.60, '2010-04-25', 3002, 5001);
