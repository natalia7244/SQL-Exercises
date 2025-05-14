-- Zadanie 1: Pierwsze zamówienie ka¿dego klienta
-- Dla ka¿dego klienta wyœwietl:
-- - nazwê klienta
-- - identyfikator zamówienia
-- - datê zamówienia
-- - pozycjê zamówienia w historii klienta (1 = najstarsze)

;WITH Ranking_Zamowien AS (
SELECT C.CustomerID, C.CompanyName, O.OrderDate, 
		RANK () OVER ( PARTITION BY C.CustomerID ORDER BY O.OrderDate ASC ) AS KOLEJNOSC_ZAMOWIEN
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
)

SELECT *
FROM Ranking_Zamowien
WHERE KOLEJNOSC_ZAMOWIEN = 1
ORDER BY CompanyName


-- Zadanie2: Najwiêksze i najmniejsze zamówienie w ka¿dym kraju
-- Dla ka¿dego kraju podaj:
-- - nazwê klienta 
-- - numer zamówienia 
-- - wartoœæ zamówienia 
-- - informacjê, czy jest to najwiêksze czy najmniejsze zamówienie w danym kraju

; WITH Zamowienia AS (
SELECT C.Country, C.CompanyName, O.OrderID, SUM(OD.Quantity * OD.UnitPrice * (1-OD.Discount)) AS Wartosc_Zamowienia
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
GROUP BY C.Country, C.CompanyName, O.OrderID
),

Ranking AS (
SELECT Country, CompanyName, OrderID, Wartosc_Zamowienia, 
	RANK () OVER (PARTITION BY Country ORDER BY Wartosc_Zamowienia DESC) AS MaxRank,
	RANK () OVER (PARTITION BY Country ORDER BY Wartosc_Zamowienia ASC) AS MinRank
FROM Zamowienia
)

SELECT *, CASE
	WHEN MaxRank = 1 THEN 'Najwieksza wartosc'
	WHEN MinRank = 1 THEN 'Najmniejsza wartosc'
	END AS TypZamowienia
FROM Ranking
WHERE MaxRank = 1 OR MinRank = 1
ORDER BY Country, Wartosc_Zamowienia


-- Zadanie3: Najlepszy miesi¹c sprzeda¿y w ka¿dym roku
-- Dla ka¿dego roku:
-- - oblicz liczbê zamówieñ w ka¿dym miesi¹cu
-- - nadaj im ranking (RANK) wg liczby zamówieñ
-- - poka¿ tylko miesi¹ce z miejscem 1 (czyli najlepszy miesi¹c roku)
-- Posortuj wynik wg roku rosn¹co

; WITH Miesiace AS (
SELECT  YEAR(O.OrderDate) AS Rok, MONTH(O.OrderDate) AS Miesiac,COUNT(MONTH(O.OrderDate)) AS Ilosc_zamowien
FROM Orders O
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
GROUP BY YEAR(O.OrderDate), MONTH(O.OrderDate)
),

Ranking AS (
SELECT * , RANK () OVER (PARTITION BY Rok ORDER BY Ilosc_zamowien DESC) AS Ranking_Zamowien
FROM Miesiace
)

SELECT *
FROM Ranking
WHERE Ranking_Zamowien = 1
ORDER BY Rok;