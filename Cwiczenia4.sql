--Zad. 1
--Nale¿y wybraæ produkty sprzedawane w pude³kach (ang. box), gdzie zapas magazynowy jest w zakresie od 20 do 35, a identyfikator kategorii produktu to 2 lub 3, u³o¿one w kolejnoœci od najdro¿szych.
--Wyœwietl nazwy produktów oraz wszystkie szczegó³y zwi¹zane z podanymi warunkami.


SELECT ProductName, UnitPrice, QuantityPerUnit, UnitsInStock, CategoryID
FROM Products
WHERE (UnitsInStock BETWEEN 20 AND 35)
AND (CategoryID IN(2,3))
AND (QuantityPerUnit LIKE '%box%')
ORDER BY UnitPrice DESC


--Zad. 2
--Nale¿y wybraæ zamówienia, gdzie kraj dostawy to Francja lub Niemcy, nazwa miasta zaczyna siê na literê B, K lub P, zamówienie zosta³o dostarczone, w kolejnoœci sk³adania zamówieñ.
--Wyœwietl numery zamówieñ oraz wszystkie szczegó³y zwi¹zane z podanymi warunkami.


SELECT OrderID, OrderDate, ShipCountry, ShippedDate, ShipCity
FROM Orders 
WHERE (ShipCountry IN ('France','Germany'))
AND ((ShipCity LIKE 'B%')
OR (ShipCity LIKE 'K%')
OR (ShipCity LIKE 'P%'))
AND (ShippedDate IS NOT NULL)
ORDER BY OrderDate ASC

--Zad. 3
--Podaj klientów, którzy z³o¿yli zamówienia w pierwszych 5 dniach ka¿dego miesi¹ca.

SELECT DISTINCT Customers.CompanyName
FROM Orders 
JOIN Customers
ON Customers.CustomerID = Orders.CustomerID
WHERE DAY(OrderDate) BETWEEN 1 AND 5
ORDER BY Customers.CompanyName


--Zad. 4
--Jaki jest œredni czas (w dniach) realizacji zamówienia (od z³o¿enia do wys³ania) przez poszczególnych pracowników.
--Wyœwietl dwie kolumny: identyfikator pracownika, œredni czas dostawy.
--Œrednia powinna byæ przedstawiona jako u³amek (liczba z przecinkiem).


SELECT EmployeeID, (CAST(SUM(DATEDIFF(day, OrderDate, ShippedDate)) AS FLOAT) / COUNT(*)) AS 'Sredni czas dostawy'
FROM Orders
WHERE ShippedDate IS NOT NULL
GROUP BY EmployeeID
ORDER BY EmployeeID ASC


--Zad. 5
--Jaka jest liczba pracowników urodzonych w poszczególnych latach.
--Wyœwietl dwie kolumny: rok urodzenia, liczba pracowników.


SELECT YEAR(BirthDate) AS 'Rok urodzenia', COUNT(EmployeeID) AS 'Liczba pracownikow'
FROM Employees
GROUP BY YEAR(BirthDate)
ORDER BY YEAR(BirthDate) ASC


--Zad. 6
--Poka¿ pracowników, którzy w III kwartale 1996 roku przyjêli
--wiêcej ni¿ 5 zamówieñ.
--Wyœwietl identyfikator pracownika, liczbê zamówieñ.

SELECT EmployeeID, COUNT(EmployeeID) AS 'Liczba zamowien'
FROM Orders
WHERE YEAR(OrderDate) = 1996 AND DATEPART(qq, OrderDate) = 3
GROUP BY EmployeeID
HAVING COUNT(EmployeeID) > 5 

--Zad. 7
--Ile zamówieñ zrealizowali poszczególni przewoŸnicy i ile ³¹cznie za nie dostali w roku 1997.
--Wyœwietl trzy kolumny: identyfikator przewoŸnika (ShipVia), liczba zamówieñ, koszt przewozu (Freight)

SELECT ShipVia AS 'ID przewoznika', COUNT(ShipVia) AS 'Liczba zamowien', SUM(Freight) AS '£aczna kwota'
FROM Orders
WHERE YEAR(ShippedDate) = 1997
GROUP BY ShipVia
ORDER BY ShipVIA ASC





