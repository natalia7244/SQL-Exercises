
-- ZADANIE 1
-- (EWyœwietl identyfikatory produktów (ProductID), które zosta³y zamówione wiêcej ni¿ 10 razy, 
-- oraz ³¹czn¹ liczbê zamówionych jednostek (SUM(Quantity)) dla ka¿dego z tych produktów. 
-- Wyniki posortuj wed³ug ³¹cznej liczby zamówionych jednostek w kolejnoœci malej¹cej.

SELECT ProductID, SUM(Quantity) AS "Suma"
FROM "Order Details"
GROUP BY ProductID
HAVING SUM(Quantity) > 10
ORDER BY Suma DESC

-- ZADANIE 2
-- ZnajdŸ klientów, którzy w 1997 roku z³o¿yli wiêcej ni¿ 5 zamówieñ.
-- Wyœwietl nazwê klienta (CompanyName) oraz liczbê zamówieñ, które z³o¿yli w tym roku. 
-- Posortuj wyniki wed³ug liczby zamówieñ w kolejnoœci malej¹cej.

SELECT Customers.CompanyName, COUNT(*) AS "Laczna liczba zamowien w 1997"
FROM Orders
JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
WHERE YEAR(OrderDate) = 1997
GROUP BY Customers.CompanyName
HAVING COUNT(*) > 5
ORDER BY COUNT(*) DESC

-- ZADANIE 3
-- ZnajdŸ produkty, które by³y sprzedawane w iloœci wiêkszej 
-- ni¿ 100 jednostek w sumie przez wszystkie zamówienia w 1998 roku.

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
--ZnajdŸ kraje, do których wysy³ano zamówienia o ³¹cznej wartoœci (kolumna Freight) wiêkszej ni¿ 500 w ca³ym roku 1996.
-- Wyœwietl nazwê kraju (ShipCountry), ³¹czn¹ wartoœæ transportu (SUM(Freight)), 
-- oraz liczbê zamówieñ z³o¿onych do danego kraju (COUNT(*)). Wyniki posortuj malej¹co wed³ug ³¹cznej wartoœci transportu.

SELECT ShipCountry AS "Nazwa kraju", SUM(Freight) AS "Laczna wartosc", COUNT(*) AS "Laczna liczba zamowien"
FROM Orders
WHERE YEAR(OrderDate) = 1996
GROUP BY ShipCountry
HAVING SUM(Freight) > 500
ORDER BY SUM(Freight) DESC

--ZADANIE 5
-- ZnajdŸ dostawców (suppliers), którzy dostarczyli wiêcej ni¿ 3 ró¿ne produkty, 
-- i wyœwietl ich nazwê firmy (CompanyName) oraz liczbê ró¿nych produktów, które dostarczyli.
-- Wyniki posortuj malej¹co wed³ug liczby produktów.

SELECT Suppliers.CompanyName AS "Dostawcy", COUNT(DISTINCT Products.ProductID) AS "Liczba roznych produktow"
FROM Products
JOIN Suppliers
ON Products.SupplierID = Suppliers.SupplierID
GROUP BY Suppliers.CompanyName
HAVING COUNT(DISTINCT Products.ProductID) > 3
ORDER BY COUNT(DISTINCT Products.ProductID) DESC




