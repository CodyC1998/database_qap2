-- create tables
CREATE TABLE products(
	product_id SERIAL PRIMARY KEY,
	product_name TEXT,
	price DECIMAL(10, 2),
	stock_quantity INT
);

CREATE TABLE customers(
	cust_id SERIAL PRIMARY KEY,
	first_name TEXT,
	last_name TEXT,
	email TEXT
);

CREATE TABLE orders(
	order_id SERIAL PRIMARY KEY,
	cust_id INT REFERENCES customers(cust_id),
	order_date DATE
);

CREATE TABLE order_items(
	order_id INT REFERENCES orders(order_id),
	product_id INT REFERENCES products(product_id),
	quantity INT,
	PRIMARY KEY (order_id, product_id)
);

-- insert data
