-- Zadanie 1
-- Stwórz widok, który zawiera informacje o zamówieniach z³o¿onych przez klientów z Niemiec (Germany). 

CREATE VIEW ZamowieniaNiemcy AS
SELECT *
FROM Orders
WHERE ShipCountry = 'Germany'

SELECT *
FROM ZamowieniaNiemcy

DROP VIEW ZamowieniaNiemcy

--Zadanie 2
-- Stwórz widok, który wyœwietla produkty, których cena jednostkowa (UnitPrice) przekracza 50. 

CREATE VIEW CenaWieksza AS
SELECT ProductID, ProductName, UnitsInStock, UnitPrice
FROM Products
WHERE UnitPrice > 50

SELECT *
FROM CenaWieksza

DROP VIEW CenaWieksza

--Zadanie 3
-- Stwórz widok zawieraj¹cy informacje o najlepszych klientach, czyli tych, którzy z³o¿yli co najmniej 10 zamówieñ. 

CREATE VIEW NajlepsiKlienci AS
SELECT 
	O.CustomerID, 
	C.CompanyName, 
	COUNT(O.OrderID) AS "Liczba zamowien"
FROM Customers C
JOIN Orders O ON O.CustomerID = C.CustomerID
GROUP BY O.CustomerID, C.CompanyName
HAVING COUNT(O.OrderID) > 10

SELECT *
FROM NajlepsiKlienci

DROP VIEW NajlepsiKlienci


-- Zadanie 4
-- Stwórz widok, który wyœwietla szczegó³y zamówieñ z rabatem.

CREATE VIEW Rabat AS
SELECT 
	OrderID, 
	UnitPrice, 
	Discount,  
	Quantity, 
	(UnitPrice * Quantity) AS "Wartosc", 
	(UnitPrice * Quantity * (1 - Discount)) AS "Wartoœæ po rabacie"
FROM "Order Details"
WHERE Discount > 0

SELECT *
FROM Rabat

DROP VIEW Rabat

--Zadanie 5
-- Stwórz widok, który wyœwietla pracowników oraz przypisane im regiony.

CREATE VIEW Regiony AS
SELECT DISTINCT 
	E.EmployeeID, 
	E.LastName, 
	E.FirstName, 
	T.TerritoryID, 
	T.TerritoryDescription
FROM Employees E
JOIN EmployeeTerritories ET ON E.EmployeeID = ET.EmployeeID
JOIN Territories T ON T.TerritoryID = ET.TerritoryID

SELECT *
FROM Regiony

DROP VIEW Regiony

