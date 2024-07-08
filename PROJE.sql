--Hangi müþteriler en çok sipariþ vermiþtir?**
SELECT * FROM Orders
SELECT * FROM [Order Details]
SELECT * FROM Customers

SELECT C.CustomerID,O.OrderID,sum(OD.Quantity) AS ORDERR
FROM Customers C 
JOIN Orders O 
ON C.CustomerID = O.CustomerID 
JOIN [Order Details] OD 
ON OD.OrderID=O.OrderID
GROUP BY C.CustomerID,O.OrderID
ORDER BY ORDERR DESC;


--Sipariþ sayýsýna göre müþteri sýralamasý nedir?
SELECT * FROM Orders
SELECT * FROM [Order Details]
SELECT * FROM Customers

SELECT 
 C.CompanyName,O.OrderID,sum(OD.Quantity) as TotalOrder
FROM Customers C 
JOIN Orders O 
ON C.CustomerID = O.CustomerID 
JOIN [Order Details] OD 
ON OD.OrderID=O.OrderID
group by C.CompanyName, O.OrderID
ORDER BY TotalOrder DESC;


--En çok satýlan ürünler nelerdir?
SELECT  p.ProductID  , p.ProductName,SUM(o.Quantity)AS ToplamSatýlanUrun
FROM
Products p 
join 
[Order Details] o
on
o.ProductID=p.ProductID 
GROUP BY p.ProductID, p.ProductName
ORDER BY ToplamSatýlanUrun DESC; 

--Hangi çalýþanlarýn sipariþleri en yüksek toplam deðere sahiptir?

SELECT * FROM Employees
SELECT * FROM Orders
SELECT * FROM [Order Details]

SELECT 
E.EmployeeID,  E.FirstName,  E.LastName, 
SUM(D.UnitPrice * D.Quantity) AS TotalSales
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] D ON O.OrderID = D.OrderID
GROUP BY 
E.EmployeeID, E.FirstName, E.LastName
ORDER BY 
TotalSales DESC;


--Hangi kategorideki ürünler en çok satýlmaktadýr?
SELECT * FROM Products
SELECT * FROM [Order Details]

SELECT  p.ProductID  , p.ProductName, p.CategoryID,SUM(o.Quantity)AS Toplam
FROM
Products p 
join 
[Order Details] o
on
o.ProductID=p.ProductID 
GROUP BY p.ProductID, p.ProductName, p.CategoryID
ORDER BY TOPLAM DESC;

--Kategori bazýnda satýþ miktarlarý nelerdir?
SELECT * FROM Products
SELECT * FROM [Order Details]

SELECT p.ProductID, p.ProductName, p.CategoryID,SUM(o.Quantity)AS Toplam
FROM
Products p 
join 
[Order Details] o
on
o.ProductID=p.ProductID 
GROUP BY p.ProductID, p.ProductName, p.CategoryID
ORDER BY TOPLAM DESC;


--En çok sipariþ veren ülkeler hangileridir?
SELECT * FROM Orders
SELECT * FROM [Order Details]

SELECT O.ShipCountry, SUM(D.Quantity) AS TotalQuantity
FROM Orders O
 JOIN [Order Details] D ON O.OrderID = D.OrderID
GROUP BY O.ShipCountry
ORDER BY TotalQuantity DESC;

/*SELECT  O.ShipCountry, O.OrderID,D.Quantity FROM Orders O right JOIN [Order Details] D ON O.OrderID=D.OrderID
ORDER BY O.ShipCountry  DESC;*/

/*SELECT O.ShipCountry,COUNT(*)  AS TotalOrders
FROM Orders O 
GROUP BY O.ShipCountry
ORDER BY TotalOrders DESC;*/

--Hangi þehirlerden daha fazla sipariþ gelmektedir?
SELECT * FROM Orders
SELECT * FROM [Order Details]

Select O.ShipCity,
SUM(OD.Quantity)
as
SUMM FROM Orders O 
join 
[Order Details] OD on O.OrderID = OD.OrderID
group by O.ShipCity
order  by SUMM DESC;

----Hangi sipariþler en yüksek toplam deðere sahiptir  	
SELECT * FROM [Order Details]
SELECT * FROM Products	
	
SELECT UnitPrice, ProductName FROM Products
ORDER BY UnitPrice DESC;
	
--Hangi ürünlerin teslimat süresi daha uzundur?
SELECT 
OD.ProductID,
P.ProductName,
AVG(DATEDIFF(day, O.OrderDate, O.ShippedDate)) AS Dayss
FROM 
[Order Details] OD
JOIN 
Orders O ON OD.OrderID = O.OrderID
JOIN 
Products P ON OD.ProductID = P.ProductID
GROUP BY  OD.ProductID, P.ProductName
ORDER BY  Dayss DESC;

--En uzun süreli müþteri iliþkisine sahip müþteriler kimlerdir?
SELECT * FROM Orders	
SELECT * FROM Customers	

SELECT
C.CustomerID,
C.CompanyName,
DATEDIFF(DAY, max(O.OrderDate), GETDATE()) AS Dayy
FROM
Customers C
JOIN
Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CompanyName
ORDER BY Dayy DESC;

--Aylýk bazda satýþ gelirleri nedir?

SELECT 
MONTH(O.OrderDate) AS Ay,
SUM(OD.Quantity * OD.UnitPrice) AS Salee
FROM 
Orders O
JOIN 
[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY MONTH(O.OrderDate)
ORDER BY Ay;

--Hangi çalýþanlarýn sipariþleri en yüksek toplam deðere sahiptir?
SELECT *  FROM Employees
SELECT *  FROM Orders
SELECT *  FROM [Order Details]

SELECT p.EmployeeID, p.FirstName, p.LastName, sd.OrderID, SUM(sd.Quantity * sd.UnitPrice) AS toplam 
FROM Employees p
JOIN Orders o ON p.EmployeeID = o.EmployeeID
JOIN [Order Details] sd ON o.OrderID = sd.OrderID
GROUP BY p.EmployeeID, p.FirstName, p.LastName, sd.OrderID
ORDER BY toplam DESC;

---------------------------------------------------------------------------------------------------------------------

--En çok satýlan ürünler nelerdir?
SELECT satis.UrunID ,satis.YeniSatis, satis.UrunAdi  FROM Urunler satis 
Order BY satis.YeniSatis desc

--Hangi ürünlerin stoðu azalmýþ ve yeniden sipariþ verilmesi gerekmektedir? SATIÞ DETAYLARI
SELECT * FROM [Satis Detaylari]
SELECT * FROM Urunler

SELECT * FROM Urunler stok
order by stok.HedefStokDuzeyi

 /* SELECT * FROM "Satis Detaylari" stok
  ORDER BY stok.Miktar ASC*/

--En çok satýþ yapan çalýþanlar kimlerdir?
SELECT * FROM [Satislar]
SELECT * FROM Personeller
SELECT * FROM [Satis Detaylari]

SELECT  p.PersonelID, p.Adi, p.SoyAdi, sd.SatisID FROM Personeller p 
join Satislar s on p.PersonelID =s.PersonelID 
join [Satis Detaylari] sd on sd.SatisID = sd.SatisID

--Hangi çalýþanlarýn sipariþleri en yüksek toplam deðere sahiptir?
SELECT * FROM Personeller
SELECT * FROM [Satislar]
SELECT * FROM [Satis Detaylari]

SELECT  p.PersonelID, p.Adi, p.SoyAdi, sd.SatisID FROM Personeller p 
join Satislar s on p.PersonelID =s.PersonelID 
join [Satis Detaylari] sd on sd.SatisID = sd.SatisID





