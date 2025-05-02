
--Basic Level 1-10


create table Employees (
EmpID int , name varchar(50),Salary Decimal (10,2))

Insert into Employees(EmpID,name,Salary)
values (1,'Shox',7000000)

Insert into Employees(EmpID,name,Salary)
values (2,'Leyla',500000),(3,'Zita',750000)


update Employees set Salary = 500000
where EmpID = 2

delete from Employees
where EmpID = 1



create table Department (DepID int Primary key,DepartmentName varchar (50))



select * from Employses

truncate table Employses


-- Intermadiate Level

create table AnalystsMambers (
EmpID int , name varchar(50),Salary Decimal (10,2))

Insert into AnalystsMambers (EmpID,name,Salary)
values (1,'IT',7000000),(2,'Math',12000),(3,'Data',5600000),(3,'HR',3400000),(4,'SMM',5100000)

update AnalystsMambers
set name = 'manejmant'
where Salary > 50000

truncate table AnalaystsMambers

exec sp_rename 'AnalystsMambers ','StafMambers'

select * from 

drop table AnalystsMambers


--hard 

Create Table Productss (
    ProductID Int Primary Key,
    MahsulotNomi Varchar(100),
    Kategoriya Varchar(50),
    Narx Decimal(10, 2) Check (Narx > 0),
    StockQuantity Int)

	alter table Productss
	add constraint DF_stock Default 50 for StockQuantity;





exec sp_columns Products

select column_name
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'Mahsulotlar'

insert into Productss(ProductID, MahsulotNomi,Kategoriya,Narx)
Values (1,'Phone','Electronic',1200),
       (2,'Notebook','Electronic',4500),
	   (3,'Table','Furniture',5000),
	   (4,'EirPods','Electronic',1000)

	   delete from Productss

	   select * into Products_backup
	   from Productss

	  

	   Alter Table Inventar
       Alter Column Narx Float;

	   ALTER TABLE Productss
	   DROP CONSTRAINT CK__Products__Narx__33008CF0;

	   --boshqattan table yaratish ohirida

	   Create table Inventar_Yangi(
	   ProductCode int identity(1000,5) primary key,
	    ProductID Int,
		MahsulotNomi Varchar(100),
		ProductCategory Varchar(50),
		Narx Float,
		StockQuantity Int)
		--Eski Inventardan ma'lumotlarni ko'chirish

		INSERT INTO Inventar_Yangi(MahsulotNomi, ProductCategory, Narx)
		SELECT MahsulotNomi, Kategoriya, Narx FROM Productss;

		select * from Inventar_Yangi