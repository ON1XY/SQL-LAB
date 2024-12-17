

CREATE DATABASE IF NOT EXISTS company;
USE company;

-- Таблиця department
CREATE TABLE department (
    department_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(255) NOT NULL,
    city VARCHAR(255) DEFAULT 'Lviv',
    street VARCHAR(255) NOT NULL,
    building_no INTEGER
);

-- Таблиця employee
CREATE TABLE employee (
    employee_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(255) NOT NULL UNIQUE,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    position VARCHAR(30) NOT NULL,
    employment_date DATE,
    department_id INTEGER,
    manager_id INTEGER,
    rate FLOAT,
    bonus FLOAT,
    FOREIGN KEY (department_id) REFERENCES department(department_id),
    FOREIGN KEY (manager_id) REFERENCES employee(employee_id)
);

-- Таблиця customer
CREATE TABLE customer (
    customer_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    gender VARCHAR(10),
    birth_date DATE,
    phone_number BIGINT(15),
    email VARCHAR(255),
    discount INTEGER
);

-- Таблиця product
CREATE TABLE product (
    product_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    product_description VARCHAR(255),
    category VARCHAR(255),
    manufacture VARCHAR(255),
    product_type VARCHAR(255),
    amount INTEGER,
    price FLOAT
);

-- Таблиця invoice
CREATE TABLE invoice (
    invoice_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    employee_id INTEGER,
    customer_id INTEGER,
    payment_method VARCHAR(50),
    transaction_moment DATETIME,
    status VARCHAR(50),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Таблиця orders
CREATE TABLE orders (
    orders_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    employee_id INTEGER,
    product_id INTEGER,
    customer_id INTEGER,
    invoice_id INTEGER,
    order_datetime DATETIME,
    quantity INTEGER,
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id)
);

-- Додавання даних у таблицю department
INSERT INTO department (department_name, city, street, building_no)
VALUES ('Sales', 'Kyiv', 'Shevchenko Street', 10),
       ('IT', 'Lviv', 'Hrushevskogo Street', 15);

-- Додавання даних у таблицю employee
INSERT INTO employee (user_name, first_name, last_name, position, employment_date, department_id, rate, bonus)
VALUES ('jdoe', 'John', 'Doe', 'Manager', '2015-03-01', 1, 5000, 1000),
       ('asmith', 'Anna', 'Smith', 'Seller', '2018-07-12', 1, 3000, 500),
       ('bwhite', 'Bob', 'White', 'Consultant', '2012-05-23', 2, 6000, NULL);

-- Додавання даних у таблицю customer
INSERT INTO customer (first_name, last_name, gender, birth_date, phone_number, email, discount)
VALUES ('Alice', 'Brown', 'F', '1990-05-15', 380971234567, 'alice.brown@example.com', 10),
       ('Charlie', 'Johnson', 'M', '1988-10-22', 380972345678, 'charlie.j@example.com', 5);

-- Додавання даних у таблицю product
INSERT INTO product (product_name, product_description, category, manufacture, product_type, amount, price)
VALUES ('Laptop', 'Gaming Laptop', 'Electronics', 'Dell', 'Hardware', 10, 1500.00),
       ('Mouse', 'Wireless Mouse', 'Electronics', 'Logitech', 'Accessory', 50, 20.00);

-- Додавання даних у таблицю invoice
INSERT INTO invoice (employee_id, customer_id, payment_method, transaction_moment, status)
VALUES (1, 1, 'Card', '2023-12-01 10:00:00', 'Completed'),
       (2, 2, 'Cash', '2023-12-02 14:30:00', 'Pending');

-- Додавання даних у таблицю orders
INSERT INTO orders (employee_id, product_id, customer_id, invoice_id, order_datetime, quantity)
VALUES (1, 1, 1, 1, '2023-12-01 10:00:00', 2),
       (2, 2, 2, 2, '2023-12-02 14:30:00', 5);


-- Завдання 5.1: Показати список всіх керівників
SELECT 
    employee_id AS "Manager ID", 
    last_name AS "Manager Last Name",
    first_name AS "Manager First Name",
    position AS "Manager Title",
    employment_date AS "Manager Hire Date"
FROM 
    employee AS Managers
WHERE 
    position IN ('CEO', 'Manager');

-- Завдання 5.2: Показати список всіх працівників та їх керівників
SELECT 
    e.employee_id AS "Employee ID", 
    e.last_name AS "Employee Last Name",
    e.first_name AS "Employee First Name",
    e.position AS "Employee Title",
    e.employment_date AS "Hire Date",
    m.employee_id AS "Manager ID",
    m.last_name AS "Manager Last Name",
    m.first_name AS "Manager First Name",
    m.position AS "Manager Title",
    m.employment_date AS "Manager Hire Date"
FROM 
    employee AS e
JOIN 
    employee AS m ON e.manager_id = m.employee_id;

-- Завдання 5.3: Показати список всіх працівників та назви департаментів
SELECT 
    e.employee_id AS "Employee ID", 
    e.last_name AS "Employee Last Name",
    e.first_name AS "Employee First Name",
    e.position AS "Employee Title",
    d.department_name AS "Department Name"
FROM 
    employee AS e
JOIN 
    department AS d ON e.department_id = d.department_id;

-- Завдання 5.4: Показати список працівників які здійснювали продажі
SELECT 
    e.employee_id AS "Employee ID",
    e.last_name AS "Employee Last Name",
    e.first_name AS "Employee First Name",
    e.position AS "Employee Title",
    i.invoice_id AS "Invoice",
    i.transaction_moment AS "Transaction moment"
FROM 
    employee AS e
JOIN 
    invoice AS i ON e.employee_id = i.employee_id
ORDER BY 
    i.transaction_moment;

-- Завдання 5.5: Показати список працівників які здійснювали продажі (NATURAL JOIN)
SELECT 
    e.employee_id AS "Employee ID",
    e.last_name AS "Employee Last Name",
    e.first_name AS "Employee First Name",
    e.position AS "Employee Title",
    i.invoice_id AS "Invoice",
    i.transaction_moment AS "Transaction moment"
FROM 
    employee AS e
NATURAL JOIN 
    invoice AS i
ORDER BY 
    i.transaction_moment;

-- Завдання 5.6: Показати список працівників які здійснювали продажі та клієнтів
SELECT 
    e.employee_id AS "Employee ID",
    e.last_name AS "Employee Last Name",
    e.first_name AS "Employee First Name",
    i.invoice_id AS "Invoice",
    i.transaction_moment AS "Transaction moment",
    c.customer_id AS "Customer ID",
    c.last_name AS "Customer Last Name",
    c.first_name AS "Customer First Name"
FROM 
    employee AS e
NATURAL JOIN 
    invoice AS i
JOIN 
    customer AS c USING (customer_id)
ORDER BY 
    i.transaction_moment;

-- Завдання 5.7: Показати список працівників які здійснювали продажі для неавторизованих клієнтів
SELECT 
    e.employee_id AS "Employee ID",
    e.last_name AS "Employee Last Name",
    e.first_name AS "Employee First Name",
    i.invoice_id AS "Invoice",
    i.transaction_moment AS "Transaction moment",
    c.customer_id AS "Customer ID",
    c.last_name AS "Customer Last Name",
    c.first_name AS "Customer First Name"
FROM 
    employee AS e
NATURAL JOIN 
    invoice AS i
LEFT JOIN 
    customer AS c USING (customer_id)
WHERE 
    c.customer_id IS NULL
ORDER BY 
    i.transaction_moment;

-- Завдання 5.8: Показати організаційну структуру компанії
SELECT 
    e.employee_id AS "Employee ID",
    e.last_name AS "Employee Last Name",
    e.first_name AS "Employee First Name",
    e.position AS "Employee Position",
    m.employee_id AS "Manager ID",
    m.last_name AS "Manager Last Name",
    m.first_name AS "Manager First Name",
    d.department_id AS "Department ID",
    d.department_name AS "Department Name",
    d.city AS "Department City"
FROM 
    department AS d
RIGHT JOIN 
    employee AS e ON e.department_id = d.department_id
LEFT JOIN 
    employee AS m ON e.manager_id = m.employee_id;

-- Завдання 5.9: Показати список працівників консультантів
SELECT 
    employee_id,
    first_name,
    last_name,
    position,
    'Consulting' AS Responsibility
FROM 
    employee
WHERE 
    position LIKE '%Consultant%'
UNION
SELECT 
    employee_id,
    first_name,
    last_name,
    position,
    'Not Consulting' AS Responsibility
FROM 
    employee
WHERE 
    position NOT LIKE '%Consultant%'
ORDER BY 
    last_name;
