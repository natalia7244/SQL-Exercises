-- Zadanie 1
-- Wy�wietl nazwy kraj�w dostawc�w (Suppliers.Country) oraz informacj�, 
-- czy �rednia cena ich produkt�w (Products.UnitPrice) jest wi�ksza czy mniejsza od 20.

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
-- Wy�wietl list� klient�w (Customers.CompanyName), kt�rzy z�o�yli zam�wienia (Orders.OrderID) o ��cznej warto�ci powy�ej 10 000 
-- (warto�� zam�wienia oblicz na podstawie OrderDetails.UnitPrice * OrderDetails.Quantity).

SELECT Customers.CompanyName, SUM("Order Details".UnitPrice * "Order Details".Quantity) AS "Warto�� zamowienia"
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN "Order Details" ON Orders.OrderID = "Order Details".OrderID
GROUP BY Customers.CompanyName
HAVING  SUM("Order Details".UnitPrice * "Order Details".Quantity) > 10000;

-- Zadanie 3
-- Wy�wietl wszystkie zam�wienia (Orders.OrderID) razem z nazw� pracownika (Employees.FirstName, Employees.LastName) oraz kolumn�,
-- kt�ra poka�e Dostarczone (je�li Orders.ShippedDate nie jest NULL) lub Oczekuj�ce (je�li jest NULL).

SELECT 
    O.OrderID AS Zam�wienie,
    E.FirstName + ' ' + E.LastName AS Pracownik,
    CASE 
        WHEN O.ShippedDate IS NOT NULL THEN 'Dostarczone'
        ELSE 'Oczekuj�ce'
    END AS "Status"
FROM Orders O
JOIN Employees E ON O.EmployeeID = E.EmployeeID;


-- Zadanie 4
-- Wy�wietl list� produkt�w z kategorii, kt�re sprzedaj� si� w ilo�ciach powy�ej 500 sztuk.

SELECT 
    P.ProductName AS Produkt,
    C.CategoryName AS Kategoria,
    SUM(od.Quantity) AS ��cznaIlo��
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductName, C.CategoryName
HAVING SUM(OD.Quantity) > 500;


-- Zadanie 5
-- Wy�wietl list� kategorii produkt�w wraz z ��czn� warto�ci� sprzeda�y 
-- i informacj�, czy przekroczy�a ona 50 000 ('Przekroczono' lub 'Nie przekroczono').

SELECT C.CategoryName, SUM(O.UnitPrice * O.Quantity) AS "Laczna wartosc",
	CASE
		WHEN SUM(O.UnitPrice * O.Quantity) > 50000 THEN 'Przekroczono'
		WHEN SUM(O.UnitPrice * O.Quantity) < 50000 THEN 'Nie przekroczono'
	END AS "Informacja"
FROM Categories AS C
JOIN Products AS P ON C.CategoryID = P.CategoryID
JOIN "Order Details" AS O ON P.ProductID = O.ProductID
GROUP BY C.CategoryName