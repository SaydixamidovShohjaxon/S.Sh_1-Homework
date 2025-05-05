create database [F28_class3]

use [F28_class3]

Create Table Mahsulotlar (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Narx DECIMAL(10, 2))


	Insert into Mahsulotlar (ProductID, ProductName, Narx) Values
(1, 'Qahva', 19000.00),
(2, 'Choy', 7000.00),
(3, 'Shakar', 45000.50)

truncate table Mahsulotlar
delete Mahsulotlar

Alter TAble Mahsulotlar
Add Constraint UQ_ProdName Unique (ProductName);

--Unique mahsulotlarri nomini takrorlamaslik uchunn

Create Table Kategoriya (
    KategoriyaID Int PRimary Key,
    CategoryName Varchar(50) Unique

)

	select * from Mahsulotlar

	Bulk Insert Mahsulotlar
From 'C:\Temp\mmahsulotlar.txt'
With (
    Fieldterminator = ',', 
    Rowterminator = '\n',
    Firstrow = 2 
)
CREATE TABLE Turkumlar (
    TurkumID INT PRIMARY KEY,
    TurkumNomi VARCHAR(50)
)
	select * from Turkumlar




	ALTER TABLE Mahsulotlar
ADD TurkumID INT;

ALTER TABLE Mahsulotlar
ADD CONSTRAINT FK_Mahsulotlar_Turkumlar FOREIGN KEY (TurkumID)
REFERENCES Turkumlar (TurkumID)


ALTER TABLE Mahsulotlar
ADD CONSTRAINT CHK_Narx_Pozitiv CHECK (Narx > 0);



	ALTER TABLE Mahsulotlar
ADD Birja INT NOT NULL DEFAULT 0;


	


	SELECT ProductID, ProductName, ISNULL(Narx, 0) AS Narx
FROM Mahsulotlar

select * from Mahsulotlar


--level hard

CREATE TABLE Mijozlar (
    MijozID INT PRIMARY KEY,
    FIO VARCHAR(100),
    Yosh INT CHECK (Yosh >= 18)
)

CREATE TABLE Hisoblar (
    HisobID INT IDENTITY(100,10) PRIMARY KEY,
    HisobNomi VARCHAR(100)
)

select * from Mijozlar
select * from Hisoblar

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
)

SELECT ISNULL(Narx, 0) AS YangiNarx FROM Mahsulotlar;

SELECT COALESCE(Email, Telefon, 'Maʼlumot yo‘q')
AS Kontakt FROM Xodimlar

CREATE TABLE Xodimlar (
    EmpID INT PRIMARY KEY,
    FIO VARCHAR(100),
    Email VARCHAR(100) UNIQUE
)

CREATE TABLE Buyurtmalar (
    BuyurtmaID INT PRIMARY KEY,
    MijozID INT,
    FOREIGN KEY (MijozID) REFERENCES Mijozlar(MijozID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)

select * from Buyurtmalar