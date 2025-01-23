-- Zadanie 1
-- Wy�wietl miesi�ce, w kt�rych dokonano zam�wie�, ��czn� warto�� zam�wie� w danym miesi�cu oraz liczb� zam�wie�. 
--Wyniki posortuj malej�co wed�ug ��cznej warto�ci zam�wie�.

SELECT  YEAR(O.OrderDate) AS ROK, 
		MONTH(O.OrderDate) AS MIESIAC, 
		COUNT(O.OrderID) AS "Liczba zam�wien", 
		SUM(OD.UnitPrice * OD.Quantity) AS "��czna warto��"
FROM Orders O
JOIN "Order Details" OD ON O.OrderID = OD.OrderID
GROUP BY YEAR(O.OrderDate), MONTH(O.OrderDate)
ORDER BY SUM(OD.UnitPrice * OD.Quantity) DESC


--Zadanie 2
--Wy�wietl 10 najlepszych klient�w (wed�ug warto�ci zam�wie�) w ca�ej historii bazy danych. 
-- W wynikach uwzgl�dnij nazw� klienta, liczb� zam�wie� oraz ��czn� warto�� zam�wie�.

SELECT TOP 10 C.CompanyName, 
	COUNT(O.OrderID) AS "Liczba zamowien", 
	SUM(OD.UnitPrice * OD.Quantity) AS "Suma zam�wienia"
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN "Order Details" OD ON O.OrderID = OD.OrderID
GROUP BY C.CompanyName
ORDER BY SUM(OD.UnitPrice * OD.Quantity) DESC


--Zadanie 3
-- Znajd� klient�w, kt�rzy z�o�yli co najmniej jedno zam�wienie w ka�dym kwartale w danym roku (np. w ka�dym z czterech kwartali 2023 roku). Wyniki maj� zawiera�:
   -- Rok.
   -- Identyfikator klienta.
   -- Nazwisko klienta.
   -- Liczb� kwartali, w kt�rych klient z�o�y� zam�wienie w danym roku (powinno wynosi� 4, je�li klient spe�nia wymaganie).

SELECT C.CustomerID, C.CompanyName, 
		YEAR(O.OrderDate) AS "ROK", 
		COUNT(DISTINCT DATEPART(QUARTER, O.OrderDate)) AS "Liczba kwartali"
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CompanyName, YEAR(O.OrderDate)
HAVING COUNT(DISTINCT DATEPART(QUARTER, O.OrderDate)) = 4


--Zadanie 4
-- Chcemy znale�� klient�w, kt�rzy z�o�yli co najmniej jedno zam�wienie w ka�dym miesi�cu w danym roku (np. w ka�dym z 12 miesi�cy 2023 roku). Wyniki maj� zawiera�:
    -- Rok.
    -- Identyfikator klienta.
    -- Nazwisko klienta.
    -- Liczb� miesi�cy, w kt�rych klient z�o�y� zam�wienie w danym roku (powinna wynosi� 12, je�li klient spe�nia wymaganie).


SELECT C.CustomerID, C.CompanyName, 
		YEAR(O.OrderDate) AS "Rok", 
		COUNT(DISTINCT MONTH(O.OrderDate)) AS "Liczba miesi�cy"
FROM Customers C
JOIN Orders O ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.CompanyName, YEAR(O.OrderDate)
HAVING COUNT(DISTINCT MONTH(O.OrderDate)) = 12


--Zadanie 5
-- Znajd� 10 najlepszych klient�w pod wzgl�dem liczby zam�wie� W danym roku. Wyniki maj� zawiera�:
    --Rok.
    --Identyfikator klienta.
    --Nazwisko klienta.
    --Liczb� zam�wie� danego klienta w danym roku.
    --Posortowane wed�ug liczby zam�wie� w kolejno�ci malej�cej.

SELECT TOP 10 YEAR(O.OrderDate) AS "Rok",
		C.CustomerID, 
		C.CompanyName,
		COUNT(OrderID) AS "Liczba zamowien"
FROM Customers C
JOIN Orders O ON O.CustomerID = C.CustomerID
GROUP BY YEAR(O.OrderDate), C.CustomerID, C.CompanyName 
ORDER BY COUNT(OrderID) DESC
