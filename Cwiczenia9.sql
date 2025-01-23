-- Zadanie 1
-- Wyœwietl nazwy klientów oraz ³¹czn¹ wartoœæ zamówieñ, ale tylko dla tych, którzy dokonali zamówieñ na kwotê wiêksz¹ ni¿ 10000.

SELECT C.CompanyName, SUM(OD.UnitPrice * OD.Quantity) AS "£¹czna wartoœæ"
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN "Order Details" OD ON O.OrderID = OD.OrderID
GROUP BY C.CompanyName
HAVING SUM(OD.UnitPrice * OD.Quantity) > 10000
ORDER BY SUM(OD.UnitPrice * OD.Quantity) ASC

-- Zadanie 2
-- Wyœwietl listê zamówieñ z kategori¹ przypisan¹ na podstawie wartoœci zamówienia: "Ma³e" (do 5000), "Œrednie" (5000-15000), lub "Du¿e" (powy¿ej 15000).

SELECT OrderID, SUM(UnitPrice * Quantity) "Wartosc" ,
	CASE 
		WHEN SUM(UnitPrice * Quantity) < 500 THEN 'Ma³e'
		WHEN SUM(UnitPrice * Quantity) > 500 AND SUM(UnitPrice * Quantity) < 1500 THEN 'Srednie'
		WHEN SUM(UnitPrice * Quantity) > 1500 THEN 'Du¿e'
	END "Rozmiar"
FROM "Order Details"
GROUP BY OrderID

--Zadanie 3
-- Wyœwietl nazwiska pracowników, którzy obs³ugiwali zamówienia na kwotê wiêksz¹ ni¿ 5000.

SELECT E.LastName, SUM(UnitPrice *Quantity) AS "Kwota zamowienia"
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
JOIN "Order Details" OD ON O.OrderID = OD.OrderID
GROUP BY E.LastName
HAVING SUM(UnitPrice *Quantity) > 5000

--Zadanie 4
-- Wyœwietl listê produktów wraz z ich cen¹ i informacj¹, czy s¹ "Tanie" (cena poni¿ej 100), czy "Drogie" (cena 100 lub wiêcej).

SELECT ProductName, UnitPrice, IIF(UnitPrice < 100, 'Tanie', 'Drogie') AS "Informacja"
FROM Products

--Zadanie 5
-- Wyœwietl dostawców oraz liczbê produktów, które dostarczaj¹, ale tylko tych, którzy dostarczyli wiêcej ni¿ 4 produktów.

SELECT S.CompanyName, COUNT(P.ProductID) AS "Liczba dostarczonych produktow"
FROM Suppliers S
JOIN Products P ON S.SupplierID = P.SupplierID
GROUP BY S.CompanyName
HAVING COUNT(P.ProductID) > 4
