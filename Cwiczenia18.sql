-- Zadanie 1
-- Dla ka�dego klienta podaj:
-- - identyfikator klienta 
-- - liczb� z�o�onych zam�wie�
-- - ��czn� warto�� wszystkich zam�wie� 
-- Posortuj wynik malej�co wg warto�ci zam�wie�.
-- Uwzgl�dnij tylko klient�w, kt�rzy maj� co najmniej jedno zam�wienie.

-- Bonus: Dodaj warunek, aby pokaza� tylko tych klient�w,
-- kt�rych ��czna warto�� zam�wie� przekracza 10000 jednostek.

SELECT C.CustomerID, COUNT(O.OrderID) AS Ilosc_zamowien, SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS Laczna_wartosc
FROM Customers C
JOIN Orders O ON O.CustomerID = C.CustomerID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY C.CustomerID
HAVING COUNT(O.OrderID) > 0 AND SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount))  > 10000
ORDER BY Laczna_wartosc DESC

-- Zadanie 2
-- Dla ka�dego produktu podaj:
-- - identyfikator produktu 
-- - ��czn� liczb� sprzedanych sztuk
-- - ��czn� warto�� sprzeda�y 
-- Uwzgl�dnij tylko te produkty, kt�rych ��czna warto�� sprzeda�y przekracza 5000 jednostek
-- Posortuj wynik malej�co wed�ug warto�ci sprzeda�y

SELECT P.ProductID, SUM(OD.Quantity) AS Liczba_Sprzedanych, SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS Wartosc_Sprzedazy
FROM Products P
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductID
HAVING SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) > 5000
ORDER BY Wartosc_Sprzedazy DESC

--Zadanie 3
-- Dla ka�dego klienta oblicz:
-- - ��czn� warto�� wszystkich jego zam�wie� 
-- - liczb� zam�wie�
-- - pozycj� klienta w rankingu wg warto�ci zam�wie� (od najwi�kszej do najmniejszej)
-- U�yj funkcji okna RANK()
-- Posortuj wynik wed�ug pozycji w rankingu

SELECT C.CompanyName, COUNT(O.OrderID) AS Ilosc, SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS Lacznie, 
		RANK () OVER (ORDER BY SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount))  DESC) AS RANKING
FROM Customers C
JOIN Orders O ON O.CustomerID = C.CustomerID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY C.CompanyName

-- Zadanie 4
-- Dla ka�dego produktu podaj:
-- - identyfikator produktu 
-- - nazw� produktu 
-- - nazw� kategorii 
-- - ��czn� warto�� sprzeda�y 
-- - pozycj� produktu w rankingu w obr�bie swojej kategorii 
-- U�yj funkcji RANK() OVER (PARTITION BY CategoryName ORDER BY ...)
-- Posortuj wynik wed�ug kategorii i pozycji w rankingu

SELECT P.ProductID, C.CategoryName, SUM(OD.UnitPrice * OD.Quantity *(1 - OD.Discount)) AS WARTOSC_SPRZEDAZY,
		RANK () OVER ( PARTITION BY C.CategoryName ORDER BY SUM(OD.UnitPrice * OD.Quantity *(1 - OD.Discount)) DESC ) AS Ranking
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
JOIN [Order Details] OD ON OD.ProductID = P.ProductID
GROUP BY P.ProductID, C.CategoryName

-- Zadanie 5
-- Dla ka�dego produktu podaj:
-- - identyfikator produktu 
-- - nazw� produktu 
-- - nazw� kategorii 
-- - ��czn� warto�� sprzeda�y
-- - pozycj� w rankingu w swojej kategorii
-- Poka� tylko te produkty, kt�re zajmuj� miejsce 1, 2 lub 3 w swojej kategorii

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