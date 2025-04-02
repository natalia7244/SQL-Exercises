-- Zadanie 1
-- Znajd� klient�w, kt�rzy z�o�yli wi�cej ni� 5 zam�wie�.

WITH KlienciZamowienia AS (
    SELECT CustomerID, COUNT(OrderID) AS LiczbaZamowien
    FROM Orders
    GROUP BY CustomerID
)
SELECT C.CustomerID, C.CompanyName, KZ.LiczbaZamowien
FROM Customers C
JOIN KlienciZamowienia KZ ON C.CustomerID = KZ.CustomerID
WHERE KZ.LiczbaZamowien > 5;

-- Zadanie 2
-- Chcemy dla ka�dego klienta znale�� 3 najdro�sze zam�wienia.

WITH ZamowieniaRanking AS (
SELECT O.CustomerID, O.OrderID, 
		ROUND(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)),2) AS WARTOSC_ZAMOWIENIA, 
		RANK() OVER (PARTITION BY O.CustomerID ORDER BY SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) DESC) AS RANGA
FROM [Order Details] OD
JOIN Orders O ON OD.OrderID = O.OrderID
GROUP BY O.CustomerID, O.OrderID 
)
SELECT *
FROM ZamowieniaRanking
WHERE RANGA <= 3

-- Zadanie 3
--  Znajd� klient�w, kt�rzy wydali ��cznie ponad 10 000$ na zam�wienia.

WITH SumaZamowien AS (
SELECT C.CompanyName, ROUND(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)),2) AS Lacznie_Zamowienia
FROM Customers C
JOIN Orders O ON O.CustomerID = C.CustomerID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY C.CompanyName
)

SELECT *
FROM SumaZamowien
WHERE Lacznie_Zamowienia > 10000
ORDER BY Lacznie_Zamowienia DESC

-- Zadanie 4
-- Znajd� produkty, kt�re przynios�y najwi�kszy przych�d w danym roku.

WITH PrzychodRok AS (
SELECT P.ProductName, YEAR(O.OrderDate) AS ROK, ROUND(SUM(OD.UnitPrice * OD.Quantity * (1-OD.Discount)), 2) AS SUMA,
		RANK () OVER (PARTITION BY YEAR(O.OrderDate) ORDER BY ROUND(SUM(OD.UnitPrice * OD.Quantity * (1-OD.Discount)), 2) DESC) AS RANGA
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
JOIN Products P ON P.ProductID = OD.ProductID
GROUP BY P.ProductName, YEAR(O.OrderDate)
)

SELECT *
FROM PrzychodRok
WHERE RANGA <= 3
ORDER BY ROK, RANGA

-- Zadanie 5
-- Znajd� TOP 5 najlepszych sprzedawc�w.

WITH Ranking_Pracownikow AS (
SELECT E.EmployeeID, E.LastName, E.FirstName, ROUND(SUM(OD.UnitPrice * OD.Quantity * (1-OD.Discount)), 2) AS WARTOSC_SPRZEDAZY,
		RANK () OVER ( ORDER BY ROUND(SUM(OD.UnitPrice * OD.Quantity * (1-OD.Discount)), 2) DESC) AS RANKING_PRACOWNIKOW
FROM Employees E
JOIN Orders O ON O.EmployeeID = E.EmployeeID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
GROUP BY E.EmployeeID, E.LastName, E.FirstName
)
SELECT *
FROM Ranking_Pracownikow
WHERE RANKING_PRACOWNIKOW <= 5