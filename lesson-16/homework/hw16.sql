

--easy





-- 1. Numbers table 1 dan 1000 gacha
WITH NumbersCTE AS (
    SELECT 1 AS Number
    UNION ALL
    SELECT Number + 1 FROM NumbersCTE WHERE Number < 1000
)
SELECT Number FROM NumbersCTE
OPTION (MAXRECURSION 1000);

-- 2. Total sales per employee (derived table)
SELECT e.EmployeeID, e.FirstName, e.LastName, dt.TotalSales
FROM Employees e
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) dt ON e.EmployeeID = dt.EmployeeID;

-- 3. Average salary using CTE
WITH AvgSalaryCTE AS (
    SELECT AVG(Salary) AS AvgSalary FROM Employees
)
SELECT * FROM AvgSalaryCTE;

-- 4. Highest sales per product (derived table)
SELECT p.ProductID, p.ProductName, dt.MaxSale
FROM Products p
JOIN (
    SELECT ProductID, MAX(SalesAmount) AS MaxSale
    FROM Sales
    GROUP BY ProductID
) dt ON p.ProductID = dt.ProductID;

-- 5. Double number starting at 1, max less than 1,000,000
WITH DoubleNumbers AS (
    SELECT 1 AS Num
    UNION ALL
    SELECT Num * 2 FROM DoubleNumbers WHERE Num * 2 < 1000000
)
SELECT Num FROM DoubleNumbers;

-- 6. Employees with more than 5 sales (CTE)
WITH SalesCountCTE AS (
    SELECT EmployeeID, COUNT(*) AS SalesCount
    FROM Sales
    GROUP BY EmployeeID
    HAVING COUNT(*) > 5
)
SELECT e.FirstName, e.LastName
FROM Employees e
JOIN SalesCountCTE s ON e.EmployeeID = s.EmployeeID;

-- 7. Products with sales > 500 (CTE)
WITH ProductSalesCTE AS (
    SELECT ProductID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
    HAVING SUM(SalesAmount) > 500
)
SELECT p.ProductName, ps.TotalSales
FROM Products p
JOIN ProductSalesCTE ps ON p.ProductID = ps.ProductID;

-- 8. Employees with salary above average (CTE)
WITH AvgSalaryCTE AS (
    SELECT AVG(Salary) AS AvgSalary FROM Employees
)
SELECT e.*
FROM Employees e
CROSS JOIN AvgSalaryCTE a
WHERE e.Salary > a.AvgSalary;



--middle


-- 1. Top 5 employees by number of orders (derived table)
SELECT e.EmployeeID, e.FirstName, e.LastName, dt.OrderCount
FROM Employees e
JOIN (
    SELECT EmployeeID, COUNT(*) AS OrderCount
    FROM Sales
    GROUP BY EmployeeID
) dt ON e.EmployeeID = dt.EmployeeID
ORDER BY dt.OrderCount DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- 2. Sales per product category (derived table)
SELECT p.CategoryID, SUM(dt.SalesAmount) AS TotalSales
FROM Products p
JOIN (
    SELECT ProductID, SalesAmount
    FROM Sales
) dt ON p.ProductID = dt.ProductID
GROUP BY p.CategoryID;

-- 3. Factorial of each value (Numbers1)
WITH FactorialCTE AS (
    SELECT Number, 1 AS Factorial, 1 AS Counter
    FROM Numbers1
    WHERE Number = 1
    UNION ALL
    SELECT n.Number, f.Factorial * (f.Counter + 1), f.Counter + 1
    FROM FactorialCTE f
    JOIN Numbers1 n ON n.Number = f.Number
    WHERE f.Counter < n.Number
)
SELECT Number, MAX(Factorial) AS Factorial
FROM FactorialCTE
GROUP BY Number
ORDER BY Number
OPTION (MAXRECURSION 0);

-- 4. Split string into rows of substrings for each character (Example)
WITH CharCTE AS (
    SELECT Id, CAST(SUBSTRING(String, 1, 1) AS VARCHAR(1)) AS Char, 1 AS Pos
    FROM Example
    WHERE LEN(String) > 0
    UNION ALL
    SELECT Id, CAST(SUBSTRING(String, Pos + 1, 1) AS VARCHAR(1)), Pos + 1
    FROM CharCTE
    WHERE Pos + 1 <= LEN((SELECT String FROM Example WHERE Id = CharCTE.Id))
)
SELECT Id, Char, Pos FROM CharCTE
ORDER BY Id, Pos
OPTION (MAXRECURSION 1000);

-- 5. Sales difference between current and previous month (CTE)
WITH MonthlySales AS (
    SELECT
        YEAR(SaleDate) AS SaleYear,
        MONTH(SaleDate) AS SaleMonth,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY YEAR(SaleDate), MONTH(SaleDate)
),
SalesDiff AS (
    SELECT
        ms1.SaleYear,
        ms1.SaleMonth,
        ms1.TotalSales,
        ms1.TotalSales - ISNULL(ms2.TotalSales, 0) AS SalesDifference
    FROM MonthlySales ms1
    LEFT JOIN MonthlySales ms2
        ON ms1.SaleYear = ms2.SaleYear AND ms1.SaleMonth = ms2.SaleMonth + 1
)
SELECT * FROM SalesDiff
ORDER BY SaleYear, SaleMonth;

-- 6. Employees with sales over $45,000 in each quarter (derived table)
WITH QuarterlySales AS (
    SELECT 
        e.EmployeeID,
        DATEPART(QUARTER, s.SaleDate) AS SaleQuarter,
        SUM(s.SalesAmount) AS TotalSales
    FROM Sales s
    JOIN Employees e ON s.EmployeeID = e.EmployeeID
    GROUP BY e.EmployeeID, DATEPART(QUARTER, s.SaleDate)
)
SELECT e.EmployeeID, e.FirstName, e.LastName, qs.SaleQuarter, qs.TotalSales
FROM QuarterlySales qs
JOIN Employees e ON qs.EmployeeID = e.EmployeeID
WHERE qs.TotalSales > 45000
ORDER BY e.EmployeeID, qs.SaleQuarter;





--difficult

-- 1. Fibonacci numbers using recursion
WITH FibonacciCTE AS (
    SELECT 1 AS FibNumber, 0 AS Prev, 1 AS Current
    UNION ALL
    SELECT FibNumber + 1, Current, Prev + Current
    FROM FibonacciCTE
    WHERE FibNumber < 20  -- istalgan limit
)
SELECT FibNumber, Current AS FibonacciValue
FROM FibonacciCTE;

-- 2. Find strings with all same characters and length > 1 (FindSameCharacters)
SELECT Id, Vals
FROM FindSameCharacters
WHERE Vals IS NOT NULL
AND LEN(Vals) > 1
AND Vals NOT LIKE '%[^' + SUBSTRING(Vals,1,1) + ']%';

-- 3. Numbers table 1 through n with growing sequence (Example: n=5 -> 1,12,123,1234,12345)
DECLARE @n INT = 5;

WITH SequenceCTE AS (
    SELECT 1 AS Num, CAST('1' AS VARCHAR(MAX)) AS Seq
    UNION ALL
    SELECT Num + 1, Seq + CAST(Num + 1 AS VARCHAR)
    FROM SequenceCTE
    WHERE Num < @n
)
SELECT Seq FROM SequenceCTE
OPTION (MAXRECURSION 0);

-- 4. Employees with most sales in last 6 months (derived table)
DECLARE @SixMonthsAgo DATE = DATEADD(MONTH, -6, GETDATE());

WITH SalesLast6Months AS (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= @SixMonthsAgo
    GROUP BY EmployeeID
),
MaxSales AS (
    SELECT MAX(TotalSales) AS MaxTotalSales FROM SalesLast6Months
)
SELECT e.EmployeeID, e.FirstName, e.LastName, s.TotalSales
FROM SalesLast6Months s
JOIN Employees e ON s.EmployeeID = e.EmployeeID
JOIN MaxSales m ON s.TotalSales = m.MaxTotalSales;

-- 5. Remove duplicate integers and single digits from strings (RemoveDuplicateIntsFromNames)
WITH SplitInts AS (
    SELECT
        PawanName,
        value AS IntChar
    FROM RemoveDuplicateIntsFromNames
    CROSS APPLY STRING_SPLIT(Pawan_slug_name, '-') -- split by dash
),
FilteredInts AS (
    SELECT
        PawanName,
        IntChar
    FROM SplitInts
    WHERE LEN(IntChar) > 1 -- remove single digits
),
Reconstructed AS (
    SELECT
        PawanName,
        STRING_AGG(IntChar, '-') WITHIN GROUP (ORDER BY IntChar) AS CleanedInts
    FROM (
        SELECT DISTINCT PawanName, IntChar FROM FilteredInts
    ) t
    GROUP BY PawanName
)
SELECT
    r.PawanName,
    CONCAT('Pawan', CHAR(65 + r.PawanName - 1), '-', ISNULL(c.CleanedInts, '')) AS CleanName
FROM RemoveDuplicateIntsFromNames r
LEFT JOIN Reconstructed c ON r.PawanName = c.PawanName;


