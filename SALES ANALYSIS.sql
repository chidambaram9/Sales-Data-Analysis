CREATE DATABASE Saleschidambaram;
USE Saleschidambaram;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE NOT NULL,
    City VARCHAR(50),
    Country VARCHAR(50)
);



CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10,2) NOT NULL
);


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);



CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);
DROP TABLE IF EXISTS OrderDetails;

INSERT INTO Customers (Name, Email, City, Country) VALUES
('John Doe', 'john@example.com', 'New York', 'USA'),
('Alice Brown', 'alice@example.com', 'London', 'UK');

INSERT INTO Products (ProductName, Category, Price) VALUES
('Laptop', 'Electronics', 800),
('Phone', 'Electronics', 500);

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2024-01-10', 1300),
(2, '2024-01-15', 500);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Subtotal) VALUES
(1, 1, 1, 800),
(1, 2, 1, 500),
(2, 2, 1, 500);

SELECT o.OrderID, c.Name AS Customer, p.ProductName, od.Quantity, od.Subtotal, o.OrderDate
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Customers c ON o.CustomerID = c.CustomerID;
SELECT SUM(TotalAmount) AS Total_Revenue FROM Orders;
SELECT p.ProductName, SUM(od.Quantity) AS Total_Sold
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY Total_Sold DESC
LIMIT 1;
SELECT c.Name, SUM(o.TotalAmount) AS Total_Spent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.Name
ORDER BY Total_Spent DESC;
SELECT YEAR(OrderDate) AS Year, MONTH(OrderDate) AS Month, SUM(TotalAmount) AS Monthly_Sales
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY Year, Month;








