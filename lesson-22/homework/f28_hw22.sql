create database f28_hw22

use f28_hw22


CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(50)
);

INSERT INTO sales_data VALUES
    (1, 101, 'Alice', 'Electronics', 'Laptop', 1, 1200.00, 1200.00, '2024-01-01', 'North'),
    (2, 102, 'Bob', 'Electronics', 'Phone', 2, 600.00, 1200.00, '2024-01-02', 'South'),
    (3, 103, 'Charlie', 'Clothing', 'T-Shirt', 5, 20.00, 100.00, '2024-01-03', 'East'),
    (4, 104, 'David', 'Furniture', 'Table', 1, 250.00, 250.00, '2024-01-04', 'West'),
    (5, 105, 'Eve', 'Electronics', 'Tablet', 1, 300.00, 300.00, '2024-01-05', 'North'),
    (6, 106, 'Frank', 'Clothing', 'Jacket', 2, 80.00, 160.00, '2024-01-06', 'South'),
    (7, 107, 'Grace', 'Electronics', 'Headphones', 3, 50.00, 150.00, '2024-01-07', 'East'),
    (8, 108, 'Hank', 'Furniture', 'Chair', 4, 75.00, 300.00, '2024-01-08', 'West'),
    (9, 109, 'Ivy', 'Clothing', 'Jeans', 1, 40.00, 40.00, '2024-01-09', 'North'),
    (10, 110, 'Jack', 'Electronics', 'Laptop', 2, 1200.00, 2400.00, '2024-01-10', 'South'),
    (11, 101, 'Alice', 'Electronics', 'Phone', 1, 600.00, 600.00, '2024-01-11', 'North'),
    (12, 102, 'Bob', 'Furniture', 'Sofa', 1, 500.00, 500.00, '2024-01-12', 'South'),
    (13, 103, 'Charlie', 'Electronics', 'Camera', 1, 400.00, 400.00, '2024-01-13', 'East'),
    (14, 104, 'David', 'Clothing', 'Sweater', 2, 60.00, 120.00, '2024-01-14', 'West'),
    (15, 105, 'Eve', 'Furniture', 'Bed', 1, 800.00, 800.00, '2024-01-15', 'North'),
    (16, 106, 'Frank', 'Electronics', 'Monitor', 1, 200.00, 200.00, '2024-01-16', 'South'),
    (17, 107, 'Grace', 'Clothing', 'Scarf', 3, 25.00, 75.00, '2024-01-17', 'East'),
    (18, 108, 'Hank', 'Furniture', 'Desk', 1, 350.00, 350.00, '2024-01-18', 'West'),
    (19, 109, 'Ivy', 'Electronics', 'Speaker', 2, 100.00, 200.00, '2024-01-19', 'North'),
    (20, 110, 'Jack', 'Clothing', 'Shoes', 1, 90.00, 90.00, '2024-01-20', 'South'),
    (21, 111, 'Kevin', 'Electronics', 'Mouse', 3, 25.00, 75.00, '2024-01-21', 'East'),
    (22, 112, 'Laura', 'Furniture', 'Couch', 1, 700.00, 700.00, '2024-01-22', 'West'),
    (23, 113, 'Mike', 'Clothing', 'Hat', 4, 15.00, 60.00, '2024-01-23', 'North'),
    (24, 114, 'Nancy', 'Electronics', 'Smartwatch', 1, 250.00, 250.00, '2024-01-24', 'South'),
    (25, 115, 'Oscar', 'Furniture', 'Wardrobe', 1, 1000.00, 1000.00, '2024-01-25', 'East')








	CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);






CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);




CREATE TABLE MyData (
    Id INT, Grp INT, Val1 INT, Val2 INT
);
INSERT INTO MyData VALUES
(1,1,30,29), (2,1,19,0), (3,1,11,45), (4,2,0,0), (5,2,100,17);





CREATE TABLE TheSumPuzzle (
    ID INT, Cost INT, Quantity INT
);
INSERT INTO TheSumPuzzle VALUES
(1234,12,164), (1234,13,164), (1235,100,130), (1235,100,135), (1236,12,136);





CREATE TABLE Seats 
( 
SeatNumber INTEGER 
); 

INSERT INTO Seats VALUES 
(7),(13),(14),(15),(27),(28),(29),(30), 
(31),(32),(33),(34),(35),(52),(53),(54); 




--easy 
--1

SELECT SUM(total_amount) AS total_revenue
FROM   sales_data;

--2

SELECT AVG(unit_price) AS avg_unit_price
FROM   sales_data;

--3

SELECT COUNT(*) AS total_transactions
FROM   sales_data;

--4

SELECT MAX(quantity_sold) AS max_units_sold
FROM   sales_data;

--5

SELECT product_category,
       SUM(quantity_sold) AS units_sold
FROM   sales_data
GROUP  BY product_category;


--6

SELECT region,
       SUM(total_amount) AS region_revenue
FROM   sales_data
GROUP  BY region;


--7

SELECT TOP (1) product_name,
       SUM(total_amount) AS product_revenue
FROM   sales_data
GROUP  BY product_name
ORDER  BY product_revenue DESC;


--8

SELECT order_date,
       SUM(total_amount) OVER (ORDER BY order_date)
         AS running_total_revenue
FROM   sales_data
ORDER  BY order_date;


--9

SELECT product_category,
       SUM(total_amount) AS category_revenue,
       100.0 * SUM(total_amount)/ SUM(SUM(total_amount)) OVER () AS revenue_pct
FROM   sales_data
GROUP  BY product_category;

--10

SELECT sale_id,
       customer_id,
       order_date,
       total_amount,
       SUM(total_amount) OVER (PARTITION BY customer_id  ORDER BY order_date) AS running_total_customer
FROM   sales_data
ORDER  BY customer_id, order_date;


--11


SELECT product_category, order_date,
  SUM(total_amount) OVER (PARTITION BY product_category
  ORDER BY order_date) AS cumulative_rev
FROM   sales_data
ORDER  BY product_category, order_date;


--12

--13

SELECT Value,
       SUM(Value) OVER (ORDER BY Value) AS [Sum of Previous]
FROM   OneColumn
ORDER  BY Value;


--14

SELECT customer_id, customer_name,
       COUNT(DISTINCT product_category) AS cat_cnt
FROM   sales_data
GROUP  BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1;


--15

WITH reg_avg AS (
    SELECT region, AVG(total_amount) AS avg_amt
    FROM   sales_data GROUP BY region
), cust_tot AS (
    SELECT customer_id, customer_name, region,
           SUM(total_amount) AS tot_amt
    FROM   sales_data
    GROUP  BY customer_id, customer_name, region
)
SELECT c.*
FROM   cust_tot c
JOIN   reg_avg r ON r.region = c.region
WHERE  c.tot_amt > r.avg_amt;

--16

WITH ct AS (
  SELECT customer_id, customer_name, region,
         SUM(total_amount) AS tot_spend
  FROM   sales_data
  GROUP  BY customer_id, customer_name, region
)
SELECT customer_id, customer_name, region, tot_spend,
       DENSE_RANK() OVER (PARTITION BY region ORDER BY tot_spend DESC) AS rnk
FROM   ct
ORDER  BY region, rnk;

--17


SELECT sale_id, customer_id, order_date, total_amount,
       SUM(total_amount) OVER (PARTITION BY customer_id
                               ORDER BY order_date) AS cumulative_sales
FROM   sales_data
ORDER  BY customer_id, order_date;

--18


WITH m AS (
  SELECT FORMAT(order_date,'yyyy-MM') AS ym,
         SUM(total_amount)            AS month_sales
  FROM   sales_data
  GROUP  BY FORMAT(order_date,'yyyy-MM')
)
SELECT ym,
       month_sales,
       100.0 * (month_sales - LAG(month_sales) OVER (ORDER BY ym))
              / LAG(month_sales) OVER (ORDER BY ym) AS growth_pct
FROM   m
ORDER  BY ym;


--19

SELECT *
FROM  (
  SELECT *, LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_amt
  FROM   sales_data
) x
WHERE prev_amt IS NOT NULL
  AND total_amount > prev_amt;


  --20

  WITH avg_p AS (SELECT AVG(unit_price) AS avg_price FROM sales_data)
SELECT DISTINCT product_name, unit_price
FROM   sales_data, avg_p
WHERE  unit_price > avg_price;

--21

SELECT Id, Grp, Val1, Val2,
       CASE WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id)=1
            THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
       END AS Tot
FROM   MyData
ORDER  BY Id;

--22

SELECT Id,
       SUM(Cost)                AS Cost,
       SUM(DISTINCT Quantity)   AS Quantity
FROM   TheSumPuzzle
GROUP  BY Id;


--23

WITH s AS (
  SELECT SeatNumber,
         LEAD(SeatNumber) OVER (ORDER BY SeatNumber) AS nxt
  FROM   Seats
)
SELECT SeatNumber+1  AS [Gap Start],
       nxt-1         AS [Gap End]
FROM   s
WHERE  nxt IS NOT NULL
  AND  nxt - SeatNumber > 1

UNION ALL                         -- boshidagi bo‘shliq
SELECT 1,
       (SELECT MIN(SeatNumber)-1 FROM Seats)
WHERE  (SELECT MIN(SeatNumber) FROM Seats) > 1

ORDER BY [Gap Start];



