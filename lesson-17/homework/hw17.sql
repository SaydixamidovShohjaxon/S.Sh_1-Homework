

create database f28_hw17

use f28_hw17


DROP TABLE IF EXISTS #RegionSales;
GO
CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);




CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);





CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);



DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');



--1



WITH Regions       AS (SELECT DISTINCT Region      FROM #RegionSales),
     Distributors  AS (SELECT DISTINCT Distributor FROM #RegionSales),
     AllCombos AS (
        SELECT r.Region, d.Distributor
        FROM Regions r CROSS JOIN Distributors d
)
SELECT c.Region,
       c.Distributor,
       COALESCE(rs.Sales, 0) AS Sales
FROM AllCombos c
LEFT JOIN #RegionSales rs
       ON rs.Region = c.Region
      AND rs.Distributor = c.Distributor
ORDER BY c.Region, c.Distributor;





--2


SELECT name
FROM Employee
WHERE id IN (
     SELECT managerId
     FROM Employee
     WHERE managerId IS NOT NULL
     GROUP BY managerId
     HAVING COUNT(*) >= 5
);



--3

WITH Feb AS (
    SELECT product_id,
           SUM(unit) AS tot_unit
    FROM Orders
    WHERE order_date >= '2020-02-01'
      AND order_date <  '2020-03-01'
    GROUP BY product_id
    HAVING SUM(unit) >= 100
)
SELECT p.product_name,
       f.tot_unit AS unit
FROM Feb f
JOIN Products p ON p.product_id = f.product_id
ORDER BY p.product_name;




--4

WITH cnt AS (
    SELECT CustomerID, Vendor, COUNT(*) AS orders_cnt
    FROM Orders
    GROUP BY CustomerID, Vendor
), rnk AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY CustomerID
                              ORDER BY orders_cnt DESC, Vendor) AS rn
    FROM cnt
)
SELECT CustomerID, Vendor
FROM rnk
WHERE rn = 1
ORDER BY CustomerID;


--5

DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2, @isPrime BIT = 1;

IF @Check_Prime < 2        -- 0 va 1 — tub emas
    SET @isPrime = 0;

WHILE @i * @i <= @Check_Prime AND @isPrime = 1
BEGIN
    IF @Check_Prime % @i = 0
        SET @isPrime = 0;
    SET @i += 1;
END

SELECT CASE WHEN @isPrime = 1
            THEN 'This number is prime'
            ELSE 'This number is not prime'
       END AS Result;



--6

WITH loc_cnt AS (
    SELECT Device_id,
           Locations,
           COUNT(*) AS signals_loc
    FROM Device
    GROUP BY Device_id, Locations
), agg AS (
    SELECT Device_id,
           COUNT(DISTINCT Locations) AS no_of_location,
           SUM(signals_loc)          AS no_of_signals
    FROM loc_cnt
    GROUP BY Device_id
), mx AS (
    SELECT Device_id,
           Locations,
           ROW_NUMBER() OVER (PARTITION BY Device_id ORDER BY signals_loc DESC) AS rn
    FROM loc_cnt
)
SELECT a.Device_id,
       a.no_of_location,
       m.Locations AS max_signal_location,
       a.no_of_signals
FROM agg a
JOIN mx  m ON m.Device_id = a.Device_id AND m.rn = 1
ORDER BY a.Device_id;





--7

SELECT EmpID, EmpName, Salary
FROM Employee e
WHERE Salary > (
      SELECT AVG(Salary) FROM Employee
      WHERE DeptID = e.DeptID
);




--8


WITH Winning(Number) AS (
    SELECT 25 UNION ALL SELECT 45 UNION ALL SELECT 78
), match_cnt AS (           
    SELECT t.TicketID,
           COUNT(w.Number) AS hits
    FROM   Tickets t
    LEFT  JOIN Winning w ON w.Number = t.Number
    GROUP BY t.TicketID
), prizes AS (
    SELECT TicketID,
           CASE WHEN hits = 3 THEN 100
                WHEN hits BETWEEN 1 AND 2 THEN 10
                ELSE 0
           END AS prize
    FROM match_cnt
)
SELECT SUM(prize) AS Total_Winnings
FROM prizes;  



--9


WITH user_day AS (
    SELECT user_id,
           spend_date,
           MAX(CASE WHEN platform='Mobile'  THEN 1 ELSE 0 END) AS has_mobile,
           MAX(CASE WHEN platform='Desktop' THEN 1 ELSE 0 END) AS has_desktop,
           SUM(amount) AS total_amt
    FROM Spending
    GROUP BY user_id, spend_date
), class AS (
    SELECT spend_date,
           CASE
               WHEN has_mobile = 1 AND has_desktop = 1 THEN 'Both'
               WHEN has_mobile = 1                      THEN 'Mobile'
               ELSE 'Desktop'
           END AS Platform,
           total_amt
    FROM user_day
)
SELECT ROW_NUMBER() OVER(ORDER BY spend_date,
         CASE Platform WHEN 'Mobile' THEN 1 WHEN 'Desktop' THEN 2 ELSE 3 END) AS Row,
       spend_date,
       Platform,
       SUM(total_amt)       AS Total_Amount,
       COUNT(*)             AS Total_users
FROM class
GROUP BY spend_date, Platform
ORDER BY spend_date,
         CASE Platform WHEN 'Mobile' THEN 1 WHEN 'Desktop' THEN 2 ELSE 3 END;


--10



WITH cte AS (
    SELECT Product, Quantity
    FROM   Grouped
    UNION ALL
    SELECT Product, Quantity - 1
    FROM   cte
    WHERE  Quantity > 1
)
SELECT Product, 1 AS Quantity
FROM   cte
ORDER BY Product
OPTION (MAXRECURSION 0); 


