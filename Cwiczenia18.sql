-- Zadanie 1
-- Dla ka¿dego klienta podaj:
-- - identyfikator klienta 
-- - liczbê z³o¿onych zamówieñ
-- - ³¹czn¹ wartoœæ wszystkich zamówieñ 
-- Posortuj wynik malej¹co wg wartoœci zamówieñ.
-- Uwzglêdnij tylko klientów, którzy maj¹ co najmniej jedno zamówienie.

-- Bonus: Dodaj warunek, aby pokazaæ tylko tych klientów,
-- których ³¹czna wartoœæ zamówieñ przekracza 10000 jednostek.

SELECT C.CustomerID, COUNT(O.OrderID) AS Ilosc_zamowien, SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS Laczna_wartosc
FROM Customers C
JOIN Orders O ON O.CustomerID = C.CustomerID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY C.CustomerID
HAVING COUNT(O.OrderID) > 0 AND SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount))  > 10000
ORDER BY Laczna_wartosc DESC

-- Zadanie 2
-- Dla ka¿dego produktu podaj:
-- - identyfikator produktu 
-- - ³¹czn¹ liczbê sprzedanych sztuk
-- - ³¹czn¹ wartoœæ sprzeda¿y 
-- Uwzglêdnij tylko te produkty, których ³¹czna wartoœæ sprzeda¿y przekracza 5000 jednostek
-- Posortuj wynik malej¹co wed³ug wartoœci sprzeda¿y

SELECT P.ProductID, SUM(OD.Quantity) AS Liczba_Sprzedanych, SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS Wartosc_Sprzedazy
FROM Products P
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductID
HAVING SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) > 5000
ORDER BY Wartosc_Sprzedazy DESC

--Zadanie 3
-- Dla ka¿dego klienta oblicz:
-- - ³¹czn¹ wartoœæ wszystkich jego zamówieñ 
-- - liczbê zamówieñ
-- - pozycjê klienta w rankingu wg wartoœci zamówieñ (od najwiêkszej do najmniejszej)
-- U¿yj funkcji okna RANK()
-- Posortuj wynik wed³ug pozycji w rankingu

SELECT C.CompanyName, COUNT(O.OrderID) AS Ilosc, SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS Lacznie, 
		RANK () OVER (ORDER BY SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount))  DESC) AS RANKING
FROM Customers C
JOIN Orders O ON O.CustomerID = C.CustomerID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY C.CompanyName

-- Zadanie 4
-- Dla ka¿dego produktu podaj:
-- - identyfikator produktu 
-- - nazwê produktu 
-- - nazwê kategorii 
-- - ³¹czn¹ wartoœæ sprzeda¿y 
-- - pozycjê produktu w rankingu w obrêbie swojej kategorii 
-- U¿yj funkcji RANK() OVER (PARTITION BY CategoryName ORDER BY ...)
-- Posortuj wynik wed³ug kategorii i pozycji w rankingu

SELECT P.ProductID, C.CategoryName, SUM(OD.UnitPrice * OD.Quantity *(1 - OD.Discount)) AS WARTOSC_SPRZEDAZY,
		RANK () OVER ( PARTITION BY C.CategoryName ORDER BY SUM(OD.UnitPrice * OD.Quantity *(1 - OD.Discount)) DESC ) AS Ranking
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
JOIN [Order Details] OD ON OD.ProductID = P.ProductID
GROUP BY P.ProductID, C.CategoryName

-- Zadanie 5
-- Dla ka¿dego produktu podaj:
-- - identyfikator produktu 
-- - nazwê produktu 
-- - nazwê kategorii 
-- - ³¹czn¹ wartoœæ sprzeda¿y
-- - pozycjê w rankingu w swojej kategorii
-- Poka¿ tylko te produkty, które zajmuj¹ miejsce 1, 2 lub 3 w swojej kategorii

;WITH Ranking2 AS (
SELECT P.ProductID, C.CategoryName, SUM(OD.UnitPrice * OD.Quantity *(1 - OD.Discount)) AS WARTOSC_SPRZEDAZY,
		RANK () OVER ( PARTITION BY C.CategoryName ORDER BY SUM(OD.UnitPrice * OD.Quantity *(1 - OD.Discount)) DESC ) AS Pozycja_w_rankingu
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
JOIN [Order Details] OD ON OD.ProductID = P.ProductID
GROUP BY P.ProductID, C.CategoryName
)

SELECT *
FROM Ranking2
WHERE Pozycja_w_rankingu <=3
ORDER BY CategoryName, Pozycja_w_rankingu