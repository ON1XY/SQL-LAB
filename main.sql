CREATE TABLE department (
    department_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(255) NOT NULL,
    city VARCHAR(255) DEFAULT 'Lviv',
    street VARCHAR(255) NOT NULL,
    building_no INTEGER
);

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

CREATE TABLE customer (
    customer_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    gender VARCHAR(10),
    birth_date DATE,
    phone_number BIGINT(15) NOT NULL,
    email VARCHAR(255),
    discount INTEGER
);

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

CREATE TABLE orders (
    orders_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    employee_id INTEGER,
    product_id INTEGER,
    customer_id INTEGER,
    order_datetime DATETIME,
    quantity INTEGER,
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);


-- Завдання 4.1: Показати список всіх співробітників

SELECT * 
FROM employee;

-- Завдання 4.2: Показати конкретні поля співробітників
SELECT employee_id, user_name, first_name, last_name, position
FROM employee;

-- Завдання 4.3: Показати перші 7 співробітників
SELECT employee_id, user_name, first_name, last_name, position
FROM employee
LIMIT 7;

-- Завдання 4.4: Показати унікальні посади
SELECT DISTINCT position
FROM employee;

-- Завдання 4.5: Відсортувати унікальні посади за зростанням
SELECT DISTINCT position
FROM employee
ORDER BY position ASC;

-- Завдання 4.6: Показати продавців, відсортованих за датою
SELECT employee_id, user_name, first_name, last_name, position, employment_date
FROM employee
WHERE position = 'Seller'
ORDER BY employment_date ASC;

-- Завдання 4.7: Показати працівників на посадах "Seller" або "Consultant" після 1 січня 2013
SELECT employee_id, user_name, first_name, last_name, position, employment_date
FROM employee
WHERE (position = 'Seller' OR position = 'Consultant')
AND employment_date > '2013-01-01'
ORDER BY employment_date DESC;

-- Завдання 4.8: Показати продавців, консультантів після 2013 року
SELECT first_name, last_name, position, employment_date
FROM employee
WHERE (position IN ('Seller', 'Consultant', 'Senior Consultant'))
AND employment_date > '2013-01-01'
ORDER BY employment_date DESC;

-- Завдання 4.9: Показати працівників без менеджера або з департаментом
SELECT first_name, last_name, manager_id, department_id
FROM employee
WHERE manager_id IS NULL OR department_id IS NOT NULL
ORDER BY manager_id ASC;

-- Завдання 4.10: Показати працівників, які отримали премію у 2016 році
SELECT first_name, last_name, position, employment_date, bonus
FROM employee
WHERE bonus IS NOT NULL
AND employment_date BETWEEN '2016-01-01' AND '2016-12-31'
ORDER BY last_name ASC;

-- Завдання 4.11: Використати CASE для звіту
SELECT last_name, first_name, position,
CASE
    WHEN position = 'Senior Consultant' THEN 'Can Sales, Consulting and Lead'
    WHEN position IN ('Senior Consultant', 'Consultant') THEN 'Can Sales and Consulting'
    WHEN position LIKE 'Assistant Consultant' THEN 'Can only Consulting'
    WHEN position LIKE 'Seller' THEN 'Can only Sale'
    ELSE 'Service Roles'
END AS 'Relation to Customer'
FROM employee
ORDER BY last_name;

-- Завдання 4.12: Перейменувати колонки у звіті
SELECT last_name AS "Last Name",
       first_name AS "First Name",
       position AS "Title",
       employment_date AS "Hire Date"
FROM employee;
