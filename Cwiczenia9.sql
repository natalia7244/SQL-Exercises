-- Zadanie 1
-- Wy�wietl nazwy klient�w oraz ��czn� warto�� zam�wie�, ale tylko dla tych, kt�rzy dokonali zam�wie� na kwot� wi�ksz� ni� 10000.

SELECT C.CompanyName, SUM(OD.UnitPrice * OD.Quantity) AS "��czna warto��"
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN "Order Details" OD ON O.OrderID = OD.OrderID
GROUP BY C.CompanyName
HAVING SUM(OD.UnitPrice * OD.Quantity) > 10000
ORDER BY SUM(OD.UnitPrice * OD.Quantity) ASC

-- Zadanie 2
-- Wy�wietl list� zam�wie� z kategori� przypisan� na podstawie warto�ci zam�wienia: "Ma�e" (do 5000), "�rednie" (5000-15000), lub "Du�e" (powy�ej 15000).

SELECT OrderID, SUM(UnitPrice * Quantity) "Wartosc" ,
	CASE 
		WHEN SUM(UnitPrice * Quantity) < 500 THEN 'Ma�e'
		WHEN SUM(UnitPrice * Quantity) > 500 AND SUM(UnitPrice * Quantity) < 1500 THEN 'Srednie'
		WHEN SUM(UnitPrice * Quantity) > 1500 THEN 'Du�e'
	END "Rozmiar"
FROM "Order Details"
GROUP BY OrderID

--Zadanie 3
-- Wy�wietl nazwiska pracownik�w, kt�rzy obs�ugiwali zam�wienia na kwot� wi�ksz� ni� 5000.

SELECT E.LastName, SUM(UnitPrice *Quantity) AS "Kwota zamowienia"
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
JOIN "Order Details" OD ON O.OrderID = OD.OrderID
GROUP BY E.LastName
HAVING SUM(UnitPrice *Quantity) > 5000

--Zadanie 4
-- Wy�wietl list� produkt�w wraz z ich cen� i informacj�, czy s� "Tanie" (cena poni�ej 100), czy "Drogie" (cena 100 lub wi�cej).

SELECT ProductName, UnitPrice, IIF(UnitPrice < 100, 'Tanie', 'Drogie') AS "Informacja"
FROM Products

--Zadanie 5
-- Wy�wietl dostawc�w oraz liczb� produkt�w, kt�re dostarczaj�, ale tylko tych, kt�rzy dostarczyli wi�cej ni� 4 produkt�w.

SELECT S.CompanyName, COUNT(P.ProductID) AS "Liczba dostarczonych produktow"
FROM Suppliers S
JOIN Products P ON S.SupplierID = P.SupplierID
GROUP BY S.CompanyName
HAVING COUNT(P.ProductID) > 4
