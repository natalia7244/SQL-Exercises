-- Zadanie 1
-- Wyœwietl nazwy krajów dostawców (Suppliers.Country) oraz informacjê, 
-- czy œrednia cena ich produktów (Products.UnitPrice) jest wiêksza czy mniejsza od 20.

SELECT Suppliers.Country, AVG(Products.UnitPrice) AS "Srednia cena",
	CASE 
		WHEN AVG(Products.UnitPrice) > 20 THEN 'Wieksza od 20'
		WHEN AVG(Products.UnitPrice) < 20 THEN 'Mniejsza od 20'
		WHEN AVG(Products.UnitPrice) = 20  THEN 'Rowna 20'
	END AS "Wieksza/Mniejsza"
FROM Suppliers
JOIN Products ON Suppliers.SupplierID = Products.SupplierID
GROUP BY Suppliers.Country;

-- Zadanie 2
-- Wyœwietl listê klientów (Customers.CompanyName), którzy z³o¿yli zamówienia (Orders.OrderID) o ³¹cznej wartoœci powy¿ej 10 000 
-- (wartoœæ zamówienia oblicz na podstawie OrderDetails.UnitPrice * OrderDetails.Quantity).

SELECT Customers.CompanyName, SUM("Order Details".UnitPrice * "Order Details".Quantity) AS "Wartoœæ zamowienia"
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN "Order Details" ON Orders.OrderID = "Order Details".OrderID
GROUP BY Customers.CompanyName
HAVING  SUM("Order Details".UnitPrice * "Order Details".Quantity) > 10000;

-- Zadanie 3
-- Wyœwietl wszystkie zamówienia (Orders.OrderID) razem z nazw¹ pracownika (Employees.FirstName, Employees.LastName) oraz kolumn¹,
-- która poka¿e Dostarczone (jeœli Orders.ShippedDate nie jest NULL) lub Oczekuj¹ce (jeœli jest NULL).

SELECT 
    O.OrderID AS Zamówienie,
    E.FirstName + ' ' + E.LastName AS Pracownik,
    CASE 
        WHEN O.ShippedDate IS NOT NULL THEN 'Dostarczone'
        ELSE 'Oczekuj¹ce'
    END AS "Status"
FROM Orders O
JOIN Employees E ON O.EmployeeID = E.EmployeeID;


-- Zadanie 4
-- Wyœwietl listê produktów z kategorii, które sprzedaj¹ siê w iloœciach powy¿ej 500 sztuk.

SELECT 
    P.ProductName AS Produkt,
    C.CategoryName AS Kategoria,
    SUM(od.Quantity) AS £¹cznaIloœæ
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductName, C.CategoryName
HAVING SUM(OD.Quantity) > 500;


-- Zadanie 5
-- Wyœwietl listê kategorii produktów wraz z ³¹czn¹ wartoœci¹ sprzeda¿y 
-- i informacj¹, czy przekroczy³a ona 50 000 ('Przekroczono' lub 'Nie przekroczono').

SELECT C.CategoryName, SUM(O.UnitPrice * O.Quantity) AS "Laczna wartosc",
	CASE
		WHEN SUM(O.UnitPrice * O.Quantity) > 50000 THEN 'Przekroczono'
		WHEN SUM(O.UnitPrice * O.Quantity) < 50000 THEN 'Nie przekroczono'
	END AS "Informacja"
FROM Categories AS C
JOIN Products AS P ON C.CategoryID = P.CategoryID
JOIN "Order Details" AS O ON P.ProductID = O.ProductID
GROUP BY C.CategoryName