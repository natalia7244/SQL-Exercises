
-- ZADANIE 1
-- (EWy�wietl identyfikatory produkt�w (ProductID), kt�re zosta�y zam�wione wi�cej ni� 10 razy, 
-- oraz ��czn� liczb� zam�wionych jednostek (SUM(Quantity)) dla ka�dego z tych produkt�w. 
-- Wyniki posortuj wed�ug ��cznej liczby zam�wionych jednostek w kolejno�ci malej�cej.

SELECT ProductID, SUM(Quantity) AS "Suma"
FROM "Order Details"
GROUP BY ProductID
HAVING SUM(Quantity) > 10
ORDER BY Suma DESC

-- ZADANIE 2
-- Znajd� klient�w, kt�rzy w 1997 roku z�o�yli wi�cej ni� 5 zam�wie�.
-- Wy�wietl nazw� klienta (CompanyName) oraz liczb� zam�wie�, kt�re z�o�yli w tym roku. 
-- Posortuj wyniki wed�ug liczby zam�wie� w kolejno�ci malej�cej.

SELECT Customers.CompanyName, COUNT(*) AS "Laczna liczba zamowien w 1997"
FROM Orders
JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
WHERE YEAR(OrderDate) = 1997
GROUP BY Customers.CompanyName
HAVING COUNT(*) > 5
ORDER BY COUNT(*) DESC

-- ZADANIE 3
-- Znajd� produkty, kt�re by�y sprzedawane w ilo�ci wi�kszej 
-- ni� 100 jednostek w sumie przez wszystkie zam�wienia w 1998 roku.

SELECT Products.ProductName, SUM("Order Details".Quantity) AS "Suma sprzednanych produktow"
FROM "Order Details"
JOIN Orders
ON "Order Details".OrderID = Orders.OrderID
JOIN Products
ON "Order Details".ProductID = Products.ProductID
WHERE YEAR(Orders.OrderDate) = 1998
GROUP BY Products.ProductName
HAVING SUM("Order Details".Quantity) > 100
ORDER BY SUM("Order Details".Quantity) DESC

--ZADANIE 4
--Znajd� kraje, do kt�rych wysy�ano zam�wienia o ��cznej warto�ci (kolumna Freight) wi�kszej ni� 500 w ca�ym roku 1996.
-- Wy�wietl nazw� kraju (ShipCountry), ��czn� warto�� transportu (SUM(Freight)), 
-- oraz liczb� zam�wie� z�o�onych do danego kraju (COUNT(*)). Wyniki posortuj malej�co wed�ug ��cznej warto�ci transportu.

SELECT ShipCountry AS "Nazwa kraju", SUM(Freight) AS "Laczna wartosc", COUNT(*) AS "Laczna liczba zamowien"
FROM Orders
WHERE YEAR(OrderDate) = 1996
GROUP BY ShipCountry
HAVING SUM(Freight) > 500
ORDER BY SUM(Freight) DESC

--ZADANIE 5
-- Znajd� dostawc�w (suppliers), kt�rzy dostarczyli wi�cej ni� 3 r�ne produkty, 
-- i wy�wietl ich nazw� firmy (CompanyName) oraz liczb� r�nych produkt�w, kt�re dostarczyli.
-- Wyniki posortuj malej�co wed�ug liczby produkt�w.

SELECT Suppliers.CompanyName AS "Dostawcy", COUNT(DISTINCT Products.ProductID) AS "Liczba roznych produktow"
FROM Products
JOIN Suppliers
ON Products.SupplierID = Suppliers.SupplierID
GROUP BY Suppliers.CompanyName
HAVING COUNT(DISTINCT Products.ProductID) > 3
ORDER BY COUNT(DISTINCT Products.ProductID) DESC




