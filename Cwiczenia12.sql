--Zadanie 1
-- Znajd� produkty, kt�re by�y zamawiane w zam�wieniach z�o�onych przez klient�w z Niemiec.

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
-- Znajd� produkty, kt�re by�y zamawiane w zam�wieniach dostarczonych do Francji.

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
-- Znajd� dostawc�w, kt�rzy dostarczaj� produkty z cen� jednostkow� (UnitPrice) wy�sz� ni� �rednia cena wszystkich produkt�w.

SELECT SupplierID, CompanyName
FROM Suppliers
WHERE SupplierID IN (
	SELECT SupplierID
	FROM Products
	WHERE UnitPrice < (SELECT AVG(UnitPrice) FROM Products)
	)

--Zadanie 4
-- Znajd� klient�w, kt�rzy z�o�yli zam�wienia z wag� wi�ksz� ni� 100.

SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID IN (
	SELECT CustomerID
	FROM Orders
	WHERE Freight > 100
	)

--Zadanie 5
-- Znajd� zam�wienia, kt�re zawieraj� co najmniej jeden produkt, kt�ry jest obecnie niedost�pny w magazynie.

	



