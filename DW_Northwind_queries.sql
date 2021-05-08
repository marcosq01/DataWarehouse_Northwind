-- Q0
select year(OrderDate) as year, count(*) as count from DW_Northwind.dbo.FactSales group by year(OrderDate)

-- Q1
select p.ProductName, q.totalQuantity from (
    select top 1 sum(Quantity) as totalQuantity, ProductID 
    from DW_Northwind.dbo.FactSales where year(OrderDate) = 1996 
    group by ProductID 
    order by totalQuantity desc
) as q, DW_Northwind.dbo.DimProduct as p
where p.ProductID = q.ProductID

-- Q2
select sum(total) as total_ventas_1996 
from DW_Northwind.dbo.FactSales 
where year(OrderDate) = 1996

-- Q3
select sum(total) as total_ventas_1997
from DW_Northwind.dbo.FactSales 
where year(OrderDate) = 1997

-- Q4
select sum(total) as total_all_time
from DW_Northwind.dbo.FactSales 

-- Q5
select p.ProductName, q.ganancias_1997 from (
    select top 1 sum(total) as ganancias_1997, ProductID 
    from DW_Northwind.dbo.FactSales where year(OrderDate) = 1997
    group by ProductID 
    order by ganancias_1997 desc
) as q, DW_Northwind.dbo.DimProduct as p
where p.ProductID = q.ProductID

-- Q6
select top 1 e.Region, count(*) as numero_ventas_1997
from DW_Northwind.dbo.FactSales f, DW_Northwind.dbo.DimEmployee e
where f.EmployeeID = e.EmployeeID and e.Country = 'USA' and year(f.OrderDate) = 1997
group by e.Region;

-- Q7

select e.Region, e.Country, sum(f.total) as total
from DW_Northwind.dbo.FactSales f, DW_Northwind.dbo.DimEmployee e
where f.EmployeeID = e.EmployeeID
group by e.Region, e.Country