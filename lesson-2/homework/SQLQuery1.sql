--Easy Questions :



--1. Data:
Data is facts or information that have not yet been processed or analyzed. It can be numbers, text, or other forms of data.

--2. Database:
A database is a structured collection of data. It is stored and managed electronically.

--3. Relational Database:
In this type of database, data is stored in the form of tables and there are relationships between them (via keys).
	
--4. Table:
A table is a structure in which data is stored in the form of rows and columns.


--Questions Medium – 6:
--1:

SQL Server is a Database Management System (DBMS) by Microsoft that is used to  manage, and process data.

SSMS is a graphical user interface (GUI) tool by Microsoft for managing SQL Server.


--2:
SSMS is used to interact with SQL Server, create queries, execute them.

--3:

SQL is a standard language used for interacting with databases. It is used to query, modify, delete, and manage data in relational databases.




-- 4-5
create database studentID

create table students ( studentID int primary key, name varchar(50), Age int)

--question hard -7

 --DQL (Data Query Language):

select * from students

--INSERT (MA'LUMOT QO'SHISH):
insert into students (studentID, name, age)
values (1 , 'Victor Roque', 20)
--UPDATE (MA'LUMOT YANGILASH ):
Update Students
Set Age = 23
Where StudentID = 1;
--DELETE (MA'LUMOTNI O'CHIRISH BUTUNLAY)
delete from Students
where studentID = 1

--DDL (Data Definition Language)

select @@SERVERNAME 

GRANT SELECT, INSERT ON Students TO SFE3296;
REVOKE SELECT, INSERT ON Students FROM SFE3296;

--TCL (Transaction Control Language)

INSERT INTO Students (StudentID, Name, Age)
VALUES 
(1, 'John Doe', 22),
(2, 'Jane Smith', 21),
(3, 'Sam Brown', 23);









