-- 4

-- Crea las tablas de la base de datos DW_Northwind

use DW_Northwind
go

create table DW_Northwind.dbo.DimProduct (
    ProductID    int,
    ProductName  varchar (40),
    categoryName varchar (15),
    SupplierName varchar (40), 
    "Address"      varchar (60),
    City         varchar (15),
    Region       varchar (15),
    PostalCode   varchar (10), 
    Country      varchar (15), 
    primary key (ProductID)
)

create table DW_Northwind.dbo.DimTime (
    OrderDate datetime
    primary key (OrderDate) 
)

create table DW_Northwind.dbo.DimEmployee (
    EmployeeID int,
    "Name"     varchar (30),
    City       varchar (15),
    Country    varchar (15),
    Region     varchar (15),
    hireDate   datetime
    primary key (EmployeeID)
)

create table DW_Northwind.dbo.DimCustomer (
    CustomerID   varchar (5),
    CustomerName varchar (40),
    City         varchar (15),
    Country      varchar (15),
    Region       varchar (15),
    primary key (CustomerID)
)

create table DW_Northwind.dbo.FactSales (
    ProductID       int,
    EmployeeID      int,
    CustomerID      varchar(5),
    OrderDate       datetime,
    OrderID         int,                               
    Quantity        smallint,
    unitPrice       money,
    discountPercent real,
    discountAmount  money,
    total           money, 
    primary key (ProductID, EmployeeID, CustomerID, OrderDate),
    foreign key (ProductID)  references DW_Northwind.dbo.DimProduct(productID),
    foreign key (EmployeeID) references DW_Northwind.dbo.DimEmployee(EmployeeID),
    foreign key (CustomerID) references DW_Northwind.dbo.DimCustomer(CustomerID),
    foreign key (OrderDate)  references DW_Northwind.dbo.DimTime(OrderDate)
)
