-- Zadanie 1
-- Wyœwietl miesi¹ce, w których dokonano zamówieñ, ³¹czn¹ wartoœæ zamówieñ w danym miesi¹cu oraz liczbê zamówieñ. 
--Wyniki posortuj malej¹co wed³ug ³¹cznej wartoœci zamówieñ.

SELECT  YEAR(O.OrderDate) AS ROK, 
		MONTH(O.OrderDate) AS MIESIAC, 
		COUNT(O.OrderID) AS "Liczba zamówien", 
		SUM(OD.UnitPrice * OD.Quantity) AS "£¹czna wartoœæ"
FROM Orders O
JOIN "Order Details" OD ON O.OrderID = OD.OrderID
GROUP BY YEAR(O.OrderDate), MONTH(O.OrderDate)
ORDER BY SUM(OD.UnitPrice * OD.Quantity) DESC


--Zadanie 2
--Wyœwietl 10 najlepszych klientów (wed³ug wartoœci zamówieñ) w ca³ej historii bazy danych. 
-- W wynikach uwzglêdnij nazwê klienta, liczbê zamówieñ oraz ³¹czn¹ wartoœæ zamówieñ.

SELECT TOP 10 C.CompanyName, 
	COUNT(O.OrderID) AS "Liczba zamowien", 
	SUM(OD.UnitPrice * OD.Quantity) AS "Suma zamówienia"
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN "Order Details" OD ON O.OrderID = OD.OrderID
GROUP BY C.CompanyName
ORDER BY SUM(OD.UnitPrice * OD.Quantity) DESC


--Zadanie 3
-- ZnajdŸ klientów, którzy z³o¿yli co najmniej jedno zamówienie w ka¿dym kwartale w danym roku (np. w ka¿dym z czterech kwartali 2023 roku). Wyniki maj¹ zawieraæ:
   -- Rok.
   -- Identyfikator klienta.
   -- Nazwisko klienta.
   -- Liczbê kwartali, w których klient z³o¿y³ zamówienie w danym roku (powinno wynosiæ 4, jeœli klient spe³nia wymaganie).

SELECT C.CustomerID, C.CompanyName, 
		YEAR(O.OrderDate) AS "ROK", 
		COUNT(DISTINCT DATEPART(QUARTER, O.OrderDate)) AS "Liczba kwartali"
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CompanyName, YEAR(O.OrderDate)
HAVING COUNT(DISTINCT DATEPART(QUARTER, O.OrderDate)) = 4


--Zadanie 4
-- Chcemy znaleŸæ klientów, którzy z³o¿yli co najmniej jedno zamówienie w ka¿dym miesi¹cu w danym roku (np. w ka¿dym z 12 miesiêcy 2023 roku). Wyniki maj¹ zawieraæ:
    -- Rok.
    -- Identyfikator klienta.
    -- Nazwisko klienta.
    -- Liczbê miesiêcy, w których klient z³o¿y³ zamówienie w danym roku (powinna wynosiæ 12, jeœli klient spe³nia wymaganie).


SELECT C.CustomerID, C.CompanyName, 
		YEAR(O.OrderDate) AS "Rok", 
		COUNT(DISTINCT MONTH(O.OrderDate)) AS "Liczba miesiêcy"
FROM Customers C
JOIN Orders O ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.CompanyName, YEAR(O.OrderDate)
HAVING COUNT(DISTINCT MONTH(O.OrderDate)) = 12


--Zadanie 5
-- ZnajdŸ 10 najlepszych klientów pod wzglêdem liczby zamówieñ W danym roku. Wyniki maj¹ zawieraæ:
    --Rok.
    --Identyfikator klienta.
    --Nazwisko klienta.
    --Liczbê zamówieñ danego klienta w danym roku.
    --Posortowane wed³ug liczby zamówieñ w kolejnoœci malej¹cej.

SELECT TOP 10 YEAR(O.OrderDate) AS "Rok",
		C.CustomerID, 
		C.CompanyName,
		COUNT(OrderID) AS "Liczba zamowien"
FROM Customers C
JOIN Orders O ON O.CustomerID = C.CustomerID
GROUP BY YEAR(O.OrderDate), C.CustomerID, C.CompanyName 
ORDER BY COUNT(OrderID) DESC
