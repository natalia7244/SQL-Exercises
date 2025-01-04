--Zad. 1
--Nale�y wybra� produkty sprzedawane w pude�kach (ang. box), gdzie zapas magazynowy jest w zakresie od 20 do 35, a identyfikator kategorii produktu to 2 lub 3, u�o�one w kolejno�ci od najdro�szych.
--Wy�wietl nazwy produkt�w oraz wszystkie szczeg�y zwi�zane z podanymi warunkami.


SELECT ProductName, UnitPrice, QuantityPerUnit, UnitsInStock, CategoryID
FROM Products
WHERE (UnitsInStock BETWEEN 20 AND 35)
AND (CategoryID IN(2,3))
AND (QuantityPerUnit LIKE '%box%')
ORDER BY UnitPrice DESC


--Zad. 2
--Nale�y wybra� zam�wienia, gdzie kraj dostawy to Francja lub Niemcy, nazwa miasta zaczyna si� na liter� B, K lub P, zam�wienie zosta�o dostarczone, w kolejno�ci sk�adania zam�wie�.
--Wy�wietl numery zam�wie� oraz wszystkie szczeg�y zwi�zane z podanymi warunkami.


SELECT OrderID, OrderDate, ShipCountry, ShippedDate, ShipCity
FROM Orders 
WHERE (ShipCountry IN ('France','Germany'))
AND ((ShipCity LIKE 'B%')
OR (ShipCity LIKE 'K%')
OR (ShipCity LIKE 'P%'))
AND (ShippedDate IS NOT NULL)
ORDER BY OrderDate ASC

--Zad. 3
--Podaj klient�w, kt�rzy z�o�yli zam�wienia w pierwszych 5 dniach ka�dego miesi�ca.

SELECT DISTINCT Customers.CompanyName
FROM Orders 
JOIN Customers
ON Customers.CustomerID = Orders.CustomerID
WHERE DAY(OrderDate) BETWEEN 1 AND 5
ORDER BY Customers.CompanyName


--Zad. 4
--Jaki jest �redni czas (w dniach) realizacji zam�wienia (od z�o�enia do wys�ania) przez poszczeg�lnych pracownik�w.
--Wy�wietl dwie kolumny: identyfikator pracownika, �redni czas dostawy.
--�rednia powinna by� przedstawiona jako u�amek (liczba z przecinkiem).


SELECT EmployeeID, (CAST(SUM(DATEDIFF(day, OrderDate, ShippedDate)) AS FLOAT) / COUNT(*)) AS 'Sredni czas dostawy'
FROM Orders
WHERE ShippedDate IS NOT NULL
GROUP BY EmployeeID
ORDER BY EmployeeID ASC


--Zad. 5
--Jaka jest liczba pracownik�w urodzonych w poszczeg�lnych latach.
--Wy�wietl dwie kolumny: rok urodzenia, liczba pracownik�w.


SELECT YEAR(BirthDate) AS 'Rok urodzenia', COUNT(EmployeeID) AS 'Liczba pracownikow'
FROM Employees
GROUP BY YEAR(BirthDate)
ORDER BY YEAR(BirthDate) ASC


--Zad. 6
--Poka� pracownik�w, kt�rzy w III kwartale 1996 roku przyj�li
--wi�cej ni� 5 zam�wie�.
--Wy�wietl identyfikator pracownika, liczb� zam�wie�.

SELECT EmployeeID, COUNT(EmployeeID) AS 'Liczba zamowien'
FROM Orders
WHERE YEAR(OrderDate) = 1996 AND DATEPART(qq, OrderDate) = 3
GROUP BY EmployeeID
HAVING COUNT(EmployeeID) > 5 

--Zad. 7
--Ile zam�wie� zrealizowali poszczeg�lni przewo�nicy i ile ��cznie za nie dostali w roku 1997.
--Wy�wietl trzy kolumny: identyfikator przewo�nika (ShipVia), liczba zam�wie�, koszt przewozu (Freight)

SELECT ShipVia AS 'ID przewoznika', COUNT(ShipVia) AS 'Liczba zamowien', SUM(Freight) AS '�aczna kwota'
FROM Orders
WHERE YEAR(ShippedDate) = 1997
GROUP BY ShipVia
ORDER BY ShipVIA ASC





