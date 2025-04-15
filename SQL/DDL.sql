use ProductManagerDemoDb;
go

DROP TABLE IF EXISTS dbo.OrderItems;
DROP TABLE IF EXISTS dbo.Orders;
DROP TABLE IF EXISTS dbo.Users;
DROP TABLE IF EXISTS dbo.Products;
go

CREATE TABLE dbo.Products (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Price DECIMAL(10, 2),
    Description NVARCHAR(MAX) ,
    CreatedAt DATETIME DEFAULT GETDATE()
);

go

CREATE TABLE dbo.Users (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Email NVARCHAR(100) UNIQUE,
    PasswordHash NVARCHAR(255) ,
    CreatedAt DATETIME DEFAULT GETDATE()
);

go

CREATE TABLE dbo.Orders (
    Id INT PRIMARY KEY IDENTITY(1,1),
    UserId INT,
    OrderDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(50) ,
    FOREIGN KEY (UserId) REFERENCES dbo.Users(Id)
);

CREATE TABLE dbo.OrderItems (
    Id INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT,
    ProductId INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderId) REFERENCES dbo.Orders(Id),
    FOREIGN KEY (ProductId) REFERENCES dbo.Products(Id)
)

-- Insert Users
INSERT INTO dbo.Users (Name, Email, PasswordHash)
VALUES
('Alice Johnson', 'alice@example.com', 'hashedpassword1'),
('Bob Smith', 'bob@example.com', 'hashedpassword2'),
('Charlie Lee', 'charlie@example.com', 'hashedpassword3');

-- Insert Products
INSERT INTO dbo.Products (Name, Price, Description)
VALUES
('Wireless Mouse', 25.99, 'Ergonomic wireless mouse with USB receiver'),
('Mechanical Keyboard', 89.50, 'Backlit mechanical keyboard with blue switches'),
('HD Monitor', 199.99, '24-inch full HD monitor'),
('USB-C Hub', 45.00, 'Multiport USB-C hub with HDMI and USB 3.0');

-- Insert Orders
INSERT INTO dbo.Orders (UserId, Status)
VALUES
(1, 'Pending'),
(2, 'Shipped');

-- Insert OrderItems
-- Order 1 (Alice) bought 2 items
INSERT INTO dbo.OrderItems (OrderId, ProductId, Quantity, Price)
VALUES
(1, 1, 2, 25.99),  -- 2x Wireless Mouse
(1, 4, 1, 45.00);  -- 1x USB-C Hub

-- Order 2 (Bob) bought 1 item
INSERT INTO dbo.OrderItems (OrderId, ProductId, Quantity, Price)
VALUES
(2, 2, 1, 89.50);  -- 1x Mechanical Keyboard
