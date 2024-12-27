create database Tech_Fix;

use Tech_Fix;

CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) NOT NULL,
    password NVARCHAR(255) NOT NULL,
    role VARCHAR(50) CHECK (role IN ('techfix', 'supplier')) NOT NULL,
    email NVARCHAR(100),
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    supplier_id INT NOT NULL,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX),
    category NVARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (supplier_id) REFERENCES users(user_id)
);

CREATE TABLE quotes (
    quote_id INT IDENTITY(1,1) PRIMARY KEY,
    techfix_id INT NOT NULL,
    supplier_id INT NOT NULL,
    product_id INT NOT NULL,
    requested_quantity INT,
    quoted_price DECIMAL(10, 2),
    status VARCHAR(50) CHECK (status IN ('requested', 'responded', 'approved', 'rejected')) DEFAULT 'requested',
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (techfix_id) REFERENCES users(user_id),
    FOREIGN KEY (supplier_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    techfix_id INT NOT NULL,
    supplier_id INT NOT NULL,
    product_id INT NOT NULL,
    order_quantity INT,
    total_price DECIMAL(10, 2),
    order_status VARCHAR(50) CHECK (order_status IN ('pending', 'processed', 'shipped', 'delivered', 'cancelled')) DEFAULT 'pending',
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (techfix_id) REFERENCES users(user_id),
    FOREIGN KEY (supplier_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE inventory (
    inventory_id INT IDENTITY(1,1) PRIMARY KEY,
    supplier_id INT NOT NULL,
    product_id INT NOT NULL,
    stock_quantity INT,
    last_updated DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (supplier_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO users (username, password, role, email, created_at)
VALUES 
    ('John', 'john123', 'techfix', 'john@techfix.com', GETDATE()),
    ('supplier_one', 'hashed_password456', 'supplier', 'supplier1@hardware.com', GETDATE()),
    ('supplier_two', 'hashed_password789', 'supplier', 'supplier2@components.com', GETDATE());

INSERT INTO products (supplier_id, name, description, category, price, stock_quantity, created_at, updated_at)
VALUES 
    (2, '16GB DDR4 RAM', 'High-performance memory for gaming and workstations', 'Memory', 79.99, 150, GETDATE(), GETDATE()),
    (3, '500GB NVMe SSD', 'Fast storage solution for laptops and desktops', 'Storage', 99.99, 100, GETDATE(), GETDATE()),
    (2, 'Intel Core i7 Processor', 'Latest 11th Gen Intel Processor', 'CPU', 299.99, 50, GETDATE(), GETDATE());

INSERT INTO quotes (techfix_id, supplier_id, product_id, requested_quantity, quoted_price, status, created_at, updated_at)
VALUES 
    (1, 2, 1, 20, 75.99, 'requested', GETDATE(), GETDATE()),
    (1, 3, 2, 10, 95.99, 'responded', GETDATE(), GETDATE()),
    (1, 2, 3, 5, 285.99, 'approved', GETDATE(), GETDATE());

INSERT INTO orders (techfix_id, supplier_id, product_id, order_quantity, total_price, order_status, created_at, updated_at)
VALUES 
    (1, 2, 1, 20, 1519.80, 'pending', GETDATE(), GETDATE()),
    (1, 3, 2, 10, 959.90, 'shipped', GETDATE(), GETDATE()),
    (1, 2, 3, 5, 1429.95, 'delivered', GETDATE(), GETDATE());

INSERT INTO inventory (supplier_id, product_id, stock_quantity, last_updated)
VALUES 
    (2, 1, 150, GETDATE()),
    (3, 2, 100, GETDATE()),
    (2, 3, 50, GETDATE());


ALTER TABLE Products
ALTER COLUMN Price DECIMAL;

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Products';

ALTER TABLE quotes
ALTER COLUMN quoted_price DECIMAL;

ALTER TABLE orders
ALTER COLUMN total_price DECIMAL;