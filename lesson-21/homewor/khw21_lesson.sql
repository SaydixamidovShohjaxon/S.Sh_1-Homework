

create database f28_hw21


use f28_hw21


CREATE TABLE ProductSales (
    SaleID INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    SaleDate DATE NOT NULL,
    SaleAmount DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    CustomerID INT NOT NULL
);
INSERT INTO ProductSales (SaleID, ProductName, SaleDate, SaleAmount, Quantity, CustomerID)
VALUES 
(1, 'Product A', '2023-01-01', 148.00, 2, 101),
(2, 'Product B', '2023-01-02', 202.00, 3, 102),
(3, 'Product C', '2023-01-03', 248.00, 1, 103),
(4, 'Product A', '2023-01-04', 149.50, 4, 101),
(5, 'Product B', '2023-01-05', 203.00, 5, 104),
(6, 'Product C', '2023-01-06', 252.00, 2, 105),
(7, 'Product A', '2023-01-07', 151.00, 1, 101),
(8, 'Product B', '2023-01-08', 205.00, 8, 102),
(9, 'Product C', '2023-01-09', 253.00, 7, 106),
(10, 'Product A', '2023-01-10', 152.00, 2, 107),
(11, 'Product B', '2023-01-11', 207.00, 3, 108),
(12, 'Product C', '2023-01-12', 249.00, 1, 109),
(13, 'Product A', '2023-01-13', 153.00, 4, 110),
(14, 'Product B', '2023-01-14', 208.50, 5, 111),
(15, 'Product C', '2023-01-15', 251.00, 2, 112),
(16, 'Product A', '2023-01-16', 154.00, 1, 113),
(17, 'Product B', '2023-01-17', 210.00, 8, 114),
(18, 'Product C', '2023-01-18', 254.00, 7, 115),
(19, 'Product A', '2023-01-19', 155.00, 3, 116),
(20, 'Product B', '2023-01-20', 211.00, 4, 117),
(21, 'Product C', '2023-01-21', 256.00, 2, 118),
(22, 'Product A', '2023-01-22', 157.00, 5, 119),
(23, 'Product B', '2023-01-23', 213.00, 3, 120),
(24, 'Product C', '2023-01-24', 255.00, 1, 121),
(25, 'Product A', '2023-01-25', 158.00, 6, 122),
(26, 'Product B', '2023-01-26', 215.00, 7, 123),
(27, 'Product C', '2023-01-27', 257.00, 3, 124),
(28, 'Product A', '2023-01-28', 159.50, 4, 125),
(29, 'Product B', '2023-01-29', 218.00, 5, 126),
(30, 'Product C', '2023-01-30', 258.00, 2, 127);





CREATE TABLE Employees1 (
    EmployeeID   INT PRIMARY KEY,
    Name         VARCHAR(50),
    Department   VARCHAR(50),
    Salary       DECIMAL(10,2),
    HireDate     DATE
);

INSERT INTO Employees1 (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'John Smith', 'IT', 60000.00, '2020-03-15'),
(2, 'Emma Johnson', 'HR', 50000.00, '2019-07-22'),
(3, 'Michael Brown', 'Finance', 75000.00, '2018-11-10'),
(4, 'Olivia Davis', 'Marketing', 55000.00, '2021-01-05'),
(5, 'William Wilson', 'IT', 62000.00, '2022-06-12'),
(6, 'Sophia Martinez', 'Finance', 77000.00, '2017-09-30'),
(7, 'James Anderson', 'HR', 52000.00, '2020-04-18'),
(8, 'Isabella Thomas', 'Marketing', 58000.00, '2019-08-25'),
(9, 'Benjamin Taylor', 'IT', 64000.00, '2021-11-17'),
(10, 'Charlotte Lee', 'Finance', 80000.00, '2016-05-09'),
(11, 'Ethan Harris', 'IT', 63000.00, '2023-02-14'),
(12, 'Mia Clark', 'HR', 53000.00, '2022-09-05'),
(13, 'Alexander Lewis', 'Finance', 78000.00, '2015-12-20'),
(14, 'Amelia Walker', 'Marketing', 57000.00, '2020-07-28'),
(15, 'Daniel Hall', 'IT', 61000.00, '2018-10-13'),
(16, 'Harper Allen', 'Finance', 79000.00, '2017-03-22'),
(17, 'Matthew Young', 'HR', 54000.00, '2021-06-30'),
(18, 'Ava King', 'Marketing', 56000.00, '2019-04-16'),
(19, 'Lucas Wright', 'IT', 65000.00, '2022-12-01'),
(20, 'Evelyn Scott', 'Finance', 81000.00, '2016-08-07');




--1 puzzle 

SELECT *, 
       ROW_NUMBER() OVER (ORDER BY SaleDate) AS row_num
FROM ProductSales;


--2

SELECT ProductName,
       SUM(Quantity) AS total_qty,
       DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) AS rank
FROM ProductSales
GROUP BY ProductName;

--3

SELECT *
FROM (
SELECT *, 
ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rn
FROM ProductSales
) AS ranked
WHERE rn = 1;

--4


SELECT SaleID, SaleDate, SaleAmount,
       LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS next_sale_amount
FROM ProductSales;

--5

SELECT SaleID, SaleDate, SaleAmount,
LAG(SaleAmount) OVER (ORDER BY SaleDate) AS prev_sale_amount
FROM ProductSales;

--6

SELECT *
FROM (SELECT *, 
LAG(SaleAmount) OVER (ORDER BY SaleDate) AS prev_amt
 FROM ProductSales
) AS t
WHERE SaleAmount > prev_amt;


--7

SELECT *
FROM (
    SELECT *, 
           LAG(SaleAmount) OVER (ORDER BY SaleDate) AS prev_amt
    FROM ProductSales
) AS t
WHERE SaleAmount > prev_amt;

--8


SELECT *, 
ROUND(((LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount) /
SaleAmount) * 100, 2) AS percent_change
FROM ProductSales;


--9

SELECT *, 
 ROUND(SaleAmount / LAG(SaleAmount) OVER 
 (PARTITION BY ProductName ORDER BY SaleDate), 2) AS ratio
FROM ProductSales;


--10

SELECT *, 
SaleAmount - FIRST_VALUE(SaleAmount) OVER 
(PARTITION BY ProductName ORDER BY SaleDate) AS diff_from_first
FROM ProductSales;


--11

SELECT *
FROM (SELECT *, 
LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS prev_amt
FROM ProductSales
) AS t
WHERE SaleAmount > prev_amt;


--12

SELECT *, 
 SUM(SaleAmount) OVER (ORDER BY SaleDate) AS running_total
FROM ProductSales;

--13

SELECT *, 
ROUND(AVG(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS moving_avg
FROM ProductSales;


--14

SELECT *, 
SaleAmount - AVG(SaleAmount) OVER () AS diff_from_avg
FROM ProductSales;


--15

SELECT *, 
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS salary_rank
FROM Employees1;

--16

SELECT *
FROM (
SELECT *, 
 DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS dept_rank
 FROM Employees1
) AS ranked
WHERE dept_rank <= 2;

--17

SELECT *
FROM (
SELECT *, 
 ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary ASC) AS rn
FROM Employees1
) AS ranked
WHERE rn = 1;

--18

SELECT *, 
 SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate) AS dept_running_total
FROM Employees1;


--19

SELECT DISTINCT Department,
 SUM(Salary) OVER (PARTITION BY Department) AS total_salary
FROM Employees1;

--20

SELECT DISTINCT Department,
 AVG(Salary) OVER (PARTITION BY Department) AS avg_salary
FROM Employees1;

--21

SELECT *, 
 Salary - AVG(Salary) OVER (PARTITION BY Department) AS diff_from_avg
FROM Employees1;


--22

SELECT *, 
  ROUND(AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING), 2) AS moving_avg
FROM Employees1;


--23
