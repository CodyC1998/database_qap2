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
INSERT INTO products(product_name, price, stock_quantity) VALUES
('Apple iPhone 16', '1129.99', '3'),
('Samsung Galaxy S25', '1198.99', '2'),
('OnePlus 13', '1399.99', '5'),
('Google Pixel 8a', '679.99', '8'),
('Samsung Galaxy Z Fold6', '2474.99', '2');

INSERT INTO customers(first_name, last_name, email) VALUES
('Alice', 'Johnson', 'alice.johnson@example.com'),
('Bob', 'Smith', 'bob.smith@example.com'),
('Charlie', 'Brown', 'charlie.brown@example.com'),
('Diana', 'Williams', 'diana.williams@example.com');

INSERT INTO orders (cust_id, order_date) VALUES
(1, '2025-02-01'),
(2, '2025-02-05'),
(3, '2025-02-07'),
(4, '2025-02-09'),
(2, '2025-02-09');

INSERT INTO order_items(order_id, product_id, quantity) VALUES
(1, 1, 2),
(2, 2, 2),
(3, 5, 2),
(4, 3, 2),
(5, 4, 3);

-- SQL queries

-- retrieve name and stock quntity of all products
SELECT product_name, stock_quantity
FROM products;

-- retrieve product names and quantity for one of the placed orders
SELECT products.product_name, order_items.quantity
FROM order_items
JOIN products ON order_items.product_id = products.product_id
WHERE order_items.order_id = 1;

-- retrieve all orders placed by a specific customer
SELECT orders.order_id, products.product_name, order_items.quantity
FROM orders
JOIN order_items ON orders.order_id = order_items.order_id
JOIN products ON order_items.product_id = products.product_id
WHERE orders.cust_id = 2;

-- update data (I update the products table to remove items based on the quantity ordered from order 1)
UPDATE products
SET stock_quantity = stock_quantity - (
    SELECT quantity
    FROM order_items
    WHERE order_id = 1 AND product_id = products.product_id
)
WHERE product_id IN (
    SELECT product_id
    FROM order_items
    WHERE order_id = 1
);

-- delete data
DELETE FROM order_items
WHERE order_id = 2;

DELETE FROM orders
WHERE order_id = 2;