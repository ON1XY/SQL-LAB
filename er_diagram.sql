CREATE TABLE [department] (
	[department_id] int NOT NULL,
	[department_name] nvarchar(255) NOT NULL,
	[city] nvarchar(255) NOT NULL,
	[street] nvarchar(255) NOT NULL,
	[building_no] int NOT NULL,
	PRIMARY KEY ([department_id])
);

CREATE TABLE [employee] (
	[employee_id] int NOT NULL,
	[user_name] nvarchar(255) NOT NULL,
	[first_name] nvarchar(255) NOT NULL,
	[last_name] nvarchar(255) NOT NULL,
	[position] nvarchar(255) NOT NULL,
	[employment_date] date NOT NULL,
	[department_id] int NOT NULL,
	[manager_id] int NOT NULL,
	[rate] float(53) NOT NULL,
	[bonus] float(53) NOT NULL,
	PRIMARY KEY ([employee_id])
);

CREATE TABLE [product] (
	[product_id] int NOT NULL,
	[product_name] nvarchar(255) NOT NULL,
	[product_description] nvarchar(255) NOT NULL,
	[category] nvarchar(255) NOT NULL,
	[manufacture] nvarchar(255) NOT NULL,
	[product_type] nvarchar(255) NOT NULL,
	[amount] int NOT NULL,
	[price] float(53) NOT NULL,
	PRIMARY KEY ([product_id])
);

CREATE TABLE [customer] (
	[customer_id] int IDENTITY(1,1) NOT NULL,
	[first_name] nvarchar(255) NOT NULL,
	[last_name] nvarchar(255) NOT NULL,
	[gender] nvarchar(10) NOT NULL,
	[birth_date] date NOT NULL,
	[phone_number] bigint NOT NULL,
	[email] nvarchar(255) NOT NULL,
	[discount] int NOT NULL,
	PRIMARY KEY ([customer_id])
);

CREATE TABLE [orders] (
	[orders_id] int IDENTITY(1,1) NOT NULL,
	[employee_id] int NOT NULL,
	[product_id] int NOT NULL,
	[customer_id] int NOT NULL,
	[transaction_type] int NOT NULL,
	[transaction_moment] datetime NOT NULL,
	[amount] int NOT NULL,
	PRIMARY KEY ([orders_id])
);


ALTER TABLE [employee] ADD CONSTRAINT [employee_fk6] FOREIGN KEY ([department_id]) REFERENCES [department]([department_id]);

ALTER TABLE [employee] ADD CONSTRAINT [employee_fk7] FOREIGN KEY ([manager_id]) REFERENCES [employee]([employee_id]);


ALTER TABLE [orders] ADD CONSTRAINT [orders_fk1] FOREIGN KEY ([employee_id]) REFERENCES [employee]([employee_id]);

ALTER TABLE [orders] ADD CONSTRAINT [orders_fk2] FOREIGN KEY ([product_id]) REFERENCES [product]([product_id]);

ALTER TABLE [orders] ADD CONSTRAINT [orders_fk3] FOREIGN KEY ([customer_id]) REFERENCES [customer]([customer_id]);