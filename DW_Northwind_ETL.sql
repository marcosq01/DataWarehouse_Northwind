-- 5

-- Poblar tablas de modelo multidimensional (DW_Northwind) a partir de base de datos operacional (NorthwindBD)*/

-- Cambia los nulos en Region de Employees

update NorthwindDB.dbo.Employees set Region = 'Europe' where Country = 'UK'

-- Cambia los nulos en Region de Customers

update NorthwindDB.dbo.Customers set Region = 'North America' where Region is NULL and Country in ('Mexico');

update NorthwindDB.dbo.Customers set Region = 'South America' where Region is NULL and Country in ('Argentina', 'Brazil');

update NorthwindDB.dbo.Customers set Region = 'Europe' where Region is NULL and Country in ('Austria', 'Belgium', 'Denmark', 'Finland', 'France', 'Germany', 'Italy', 'Netherlands', 'Norway', 'Poland', 'Portugal', 'Spain', 'Sweden', 'Switzerland', 'UK');

-- Cambia los nulos en Region de Suppliers

update NorthwindDB.dbo.Suppliers set Region = 'South America' where Region is NULL and Country in ('Argentina', 'Brazil');

update NorthwindDB.dbo.Suppliers set Region = 'Europe' where Region is NULL and Country in ('Austria', 'Belgium', 'Denmark', 'Finland', 'France', 'Germany', 'Italy', 'Netherlands', 'Norway', 'Poland', 'Portugal', 'Spain', 'Sweden', 'Switzerland', 'UK');

update NorthwindDB.dbo.Suppliers set Region = 'Asia' where Region is NULL and Country in ('Japan', 'Singapore');


-- Dimension Producto
Insert into DW_Northwind.dbo.DimProduct
   select p.ProductID, p.ProductName, c.CategoryName, s.CompanyName, s.Address, s.City, s.Region, s.PostalCode, s.Country   
   from NorthwindDB.dbo.Products p, NorthwindDB.dbo.Categories c, NorthwindDB.dbo.Suppliers s
   where p.categoryID=c.categoryID and p.SupplierID = s.SupplierID;

-- Dimension Employee
Insert into DW_Northwind.dbo.DimEmployee
   select e.EmployeeID, e.FirstName + ' ' + e.LastName as Name, e.City, e.Country, e.Region, e.HireDate
   from NorthwindDB.dbo.Employees e;
   
-- Dimension Customer
Insert into DW_Northwind.dbo.DimCustomer
    select c.CustomerID, c.CompanyName, c.City, c.Country, c.Region
    from NorthwindDB.dbo.Customers c;


-- Dimension Time
Insert into DW_Northwind.dbo.DimTime
    select distinct o.OrderDate
    from NorthwindDB.dbo.Orders o;


Insert into DW_Northwind.dbo.FactSales
    select od.ProductID, o.EmployeeID, o.CustomerID, o.OrderDate , 
    o.OrderID, od.Quantity, od.UnitPrice, 
    od.Discount, 
    (od.UnitPrice * od.Quantity * od.Discount) as discountPercent , 
    (od.unitPrice * od.Quantity - od.UnitPrice * od.Quantity * od.Discount) as total
    from NorthwindDB.dbo.Orders o, NorthwindDB.dbo.[Order Details] od 
    where o.OrderID = od.OrderID;

