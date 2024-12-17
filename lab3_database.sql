CREATE TABLE IF NOT EXISTS employee (
  employee_id int NOT NULL,
  user_name varchar(255) NOT NULL,
  last_name varchar(255) NOT NULL,
  first_name varchar(255) NOT NULL,
  position varchar(255) NOT NULL,
  employee_date date NOT NULL,
  department_id int,
  manager_id int,
  rate float NOT NULL,
  bonus float,
  PRIMARY KEY (employee_id)
);

CREATE TABLE IF NOT EXISTS department (
  department_id int NOT NULL,
  department_name varchar(255) NOT NULL,
  city varchar(255) NOT NULL,
  street varchar(255) NOT NULL,
  building_no int NOT NULL,
  PRIMARY KEY (department_id)
);

CREATE TABLE IF NOT EXISTS customer (
  customer_id int AUTO_INCREMENT NOT NULL,
  first_name varchar(255) NOT NULL,
  last_name varchar(255) NOT NULL,
  gender varchar(255) NOT NULL,
  birth_date date NOT NULL,
  phone_number bigint NOT NULL,
  email varchar(255) NOT NULL,
  discount int NOT NULL,
  PRIMARY KEY (customer_id)
);

CREATE TABLE IF NOT EXISTS product (
  product_id int NOT NULL,
  product_name varchar(255) NOT NULL,
  product_description varchar(255) NOT NULL,
  category varchar(255) NOT NULL,
  manufacture varchar(255) NOT NULL,
  product_type varchar(255) NOT NULL,
  amount int NOT NULL,
  price float NOT NULL,
  PRIMARY KEY (product_id)
);

CREATE TABLE IF NOT EXISTS orders (
  orders_id int AUTO_INCREMENT NOT NULL,
  employee_id int NOT NULL,
  customer_id int NOT NULL,
  transaction_type int NOT NULL,
  transaction_moment datetime NOT NULL,
  amount int NOT NULL,
  product_id int NOT NULL,
  PRIMARY KEY (orders_id)
);

-- Зовнішні ключі
ALTER TABLE employee ADD CONSTRAINT employee_fk6 FOREIGN KEY (department_id) REFERENCES department(department_id);
ALTER TABLE employee ADD CONSTRAINT employee_fk7 FOREIGN KEY (manager_id) REFERENCES employee(employee_id);

ALTER TABLE orders ADD CONSTRAINT orders_fk1 FOREIGN KEY (employee_id) REFERENCES employee(employee_id);
ALTER TABLE orders ADD CONSTRAINT orders_fk2 FOREIGN KEY (customer_id) REFERENCES customer(customer_id);
ALTER TABLE orders ADD CONSTRAINT orders_fk6 FOREIGN KEY (product_id) REFERENCES product(product_id);
