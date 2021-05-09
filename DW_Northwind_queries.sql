-- Q0 ¿Para cuantos y cuales años hay registros de rdenes en NorthwindDB
select year(OrderDate) as year, count(*) as count 
from DW_Northwind.dbo.FactSales 
group by year(OrderDate)

-- Q1 ¿cual es el producto del que mas unidades se vendieron en 1996?
select p.ProductName, q.totalQuantity from (
    select top 1 sum(Quantity) as totalQuantity, ProductID 
    from DW_Northwind.dbo.FactSales where year(OrderDate) = 1996 
    group by ProductID 
    order by totalQuantity desc
) as q, DW_Northwind.dbo.DimProduct as p
where p.ProductID = q.ProductID

-- Q2 ¿Cual es el total de ventas (dinero) en 1996?
select sum(total) as total_ventas_1996 
from DW_Northwind.dbo.FactSales 
where year(OrderDate) = 1996

-- Q3 ¿Cual es el total de ventas (dinero) en 1997?
select sum(total) as total_ventas_1997
from DW_Northwind.dbo.FactSales 
where year(OrderDate) = 1997

-- Q4 ¿Cual es el total de ventas (dinero) considerando todos los años incluidos en la BD?
select sum(total) as total_all_time
from DW_Northwind.dbo.FactSales 

-- Q5 ¿Cual es el producto que generó mas ganancias en 1997?
select p.ProductName, q.ganancias_1997 from (
    select top 1 sum(total) as ganancias_1997, ProductID 
    from DW_Northwind.dbo.FactSales where year(OrderDate) = 1997
    group by ProductID 
    order by ganancias_1997 desc
) as q, DW_Northwind.dbo.DimProduct as p
where p.ProductID = q.ProductID

-- Q6 ¿Cuál es la Región de Estados Unidos que vendió más productos en 1997?
select top 1 e.Region, count(*) as numero_ventas_1997
from DW_Northwind.dbo.FactSales f, DW_Northwind.dbo.DimEmployee e
where f.EmployeeID = e.EmployeeID and e.Country = 'USA' and year(f.OrderDate) = 1997
group by e.Region;

-- Q7 ¿Para la region de Q6 cuál es el estado o que mas ventas tuvo (dinero) en 1997?

select top 1 e.City, sum(f.total)
from DW_Northwind.dbo.FactSales f, DW_Northwind.dbo.DimEmployee e
where e.Region = 'WA' and year(f.OrderDate) = 1997 and f.EmployeeID = e.EmployeeID
group by e.City


-- Q8 ¿Cual es el total de ventas en total (todos los años) organizado por Región, País, Estado y Ciudad?

-- Por pais
select e.Country, sum(f.total) as total
from DW_Northwind.dbo.FactSales f, DW_Northwind.dbo.DimEmployee e
where f.EmployeeID = e.EmployeeID
group by e.Country

-- Por region
select e.Region, sum(f.total) as total
from DW_Northwind.dbo.FactSales f, DW_Northwind.dbo.DimEmployee e
where f.EmployeeID = e.EmployeeID
group by e.Region

-- Por ciudad
select e.City, sum(f.total) as total
from DW_Northwind.dbo.FactSales f, DW_Northwind.dbo.DimEmployee e
where f.EmployeeID = e.EmployeeID
group by e.City



