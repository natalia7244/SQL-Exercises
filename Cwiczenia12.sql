--Zadanie 1
-- ZnajdŸ produkty, które by³y zamawiane w zamówieniach z³o¿onych przez klientów z Niemiec.

SELECT DISTINCT OD.ProductID, P.ProductName, O.ShipCountry
FROM [Order Details] OD
JOIN Orders O ON O.OrderID = OD.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN Products P ON P.ProductID = OD.ProductID
WHERE O.ShipCountry = 'Germany'



SELECT DISTINCT OD.ProductID, P.ProductName
FROM [Order Details] OD
JOIN Products P ON P.ProductID = OD.ProductID
WHERE OrderID IN (
	SELECT OrderID
	FROM Orders
	WHERE ShipCountry = 'Germany'
	)

--Zadanie 2
-- ZnajdŸ produkty, które by³y zamawiane w zamówieniach dostarczonych do Francji.

SELECT DISTINCT P.ProductID, P.ProductName
FROM [Order Details] OD
JOIN Products P ON OD.ProductID = P.ProductID
WHERE OD.OrderID IN (
	SELECT OrderID
	FROM Orders
	WHERE ShipCountry = 'France'
	)
ORDER BY P.ProductID ASC


--Zadanie 3
-- ZnajdŸ dostawców, którzy dostarczaj¹ produkty z cen¹ jednostkow¹ (UnitPrice) wy¿sz¹ ni¿ œrednia cena wszystkich produktów.

SELECT SupplierID, CompanyName
FROM Suppliers
WHERE SupplierID IN (
	SELECT SupplierID
	FROM Products
	WHERE UnitPrice < (SELECT AVG(UnitPrice) FROM Products)
	)

--Zadanie 4
-- ZnajdŸ klientów, którzy z³o¿yli zamówienia z wag¹ wiêksz¹ ni¿ 100.

SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID IN (
	SELECT CustomerID
	FROM Orders
	WHERE Freight > 100
	)

--Zadanie 5
-- ZnajdŸ zamówienia, które zawieraj¹ co najmniej jeden produkt, który jest obecnie niedostêpny w magazynie.

	



