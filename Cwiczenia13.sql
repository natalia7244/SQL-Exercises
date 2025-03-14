--Zad. 1
--Podaj klientów (z nazwy), którzy w 1997 roku z³o¿yli przynajmniej 3 zamówienia na produkty w s³oikach.
--Nazwy kolumn w kolejnoœci NAZWA_KLIENTA, LICZBA_ZAM

SELECT C.CompanyName As NAZWA_KLIENTA, COUNT(O.OrderID) AS "LICZBA_ZAMOWIEN"
FROM Products P
JOIN "Order Details" OD ON P.ProductID = OD.ProductID
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE Year(O.OrderDate) = 1997 AND P.QuantityPerUnit LIKE '%jar%'
GROUP BY C.CompanyName
HAVING COUNT(O.OrderID) >= 3

--Zad. 2.
--ZnajdŸ wszystkich klientów pochodz¹cych z Niemiec, których ³¹czna wartoœæ zakupionego towaru jest wiêksza ni¿ 5000.
--Posortuj listê alfabetycznie wed³ug klientów.
--Wyœwietl nazwy kolumn w kolejnoœci: NAZWA_KLIENTA, WARTOŒÆ_ZAM

SELECT C.CompanyName AS NAZWA_KLIENTA, SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS WARTOSC_ZAM
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN "Order Details" OD ON OD.OrderID = O.OrderID
WHERE C.Country = 'Germany'
GROUP BY C.CompanyName
HAVING SUM(OD.UnitPrice * OD.Quantity) > 5000
ORDER BY C.CompanyName ASC


--Zad. 3. 
--Podaæ pracowników oraz liczbê zamówieñ zrealizowanych w terminie, w latach 1997-1998
--Dane wyœwietl w kolejnoœci od najwiêkszej liczby zamówieñ.
--Nazwy kolumn w kolejnoœci IMIE, NAZWISKO, LICZBA_ZAM

SELECT E.FirstName AS IMIE, E.LastName AS NAZWISKO,  COUNT(O.OrderID) AS LICZBA_ZAM
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
WHERE (YEAR(O.ShippedDate) BETWEEN 1997 AND 1998) AND (O.RequiredDate >= O.ShippedDate)
GROUP BY E.EmployeeID, E.FirstName, E.LastName
ORDER BY LICZBA_ZAM DESC

--Zad. 4.   
--ZnajdŸ klienta, który nigdy niczego nie kupi³, sprawdzaj¹c identyfikator klienta w tabeli zamówieñ. 

SELECT C.CompanyName
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL


--Zad. 5.
--Podaj nazwy produktów, które nie by³y sprzedawane latem (od czerwca do sierpnia).

SELECT P.ProductName
FROM Products P
LEFT JOIN [Order Details] OD ON P.ProductID = OD.ProductID
LEFT JOIN Orders O ON OD.OrderID = O.OrderID
GROUP BY P.ProductName
HAVING SUM
	(CASE WHEN MONTH(O.OrderDate) IN (6,7,8) 
		THEN 1
		ELSE 0
	END)
	= 0

--Zad. 6.
--Wyœwietl informacje o pracownikach, którzy zostali zatrudnieni po zatrudnieniu pracownika Steven Buchanan.

SELECT LastName, FirstName
FROM Employees
WHERE HireDate > (
	SELECT HireDate
	FROM Employees
	WHERE LastName LIKE 'Buchanan' AND FirstName LIKE 'Steven'
	)

	
--Zad. 7. 
--Podaj klientów, którzy z³o¿yli kolejne zamówienia po otrzymaniu dostawy z opóŸnieniem.  

SELECT DISTINCT C.CompanyName
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN Orders O1 ON C.CustomerID = O1.CustomerID
WHERE O.RequiredDate < O.ShippedDate AND O1.OrderDate = (
	SELECT MIN(O2.OrderDate)
	FROM Orders O2
	WHERE O2.CustomerID = C.CustomerID
	AND O2.OrderDate > O.ShippedDate
	)

--Zad. 8.
--Ile i jakiego rodzaju zamówieñ z³o¿yli poszczególni klienci?
--Utwórz odpowiedni widok.

--Rodzaje zamówieñ: ma³e - wartoœæ<500,
--œrednie - wartoœæ<1000,
--reszta to du¿e.

--Wyœwietl nazwê klienta, rodzaj zamówienia, liczbê zamówieñ.
--Na koniec nale¿y usun¹æ widok odpowiednim poleceniem.

CREATE VIEW LICZBA_ZAMOWIEN AS
SELECT C.CompanyName, COUNT(O.OrderID) AS LICZBA_ZAM
FROM Customers C
JOIN Orders O ON O.CustomerID = C.CustomerID
GROUP BY C.CompanyName

CREATE VIEW WARTOSC_ZAMOWIENIA AS
SELECT C.CompanyName, SUM(OD.UnitPrice*OD.Quantity) AS WAR_ZAM
FROM Customers C
JOIN Orders O ON O.CustomerID = C.CustomerID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY C.CompanyName


SELECT L.CompanyName, L.LICZBA_ZAM, 
		CASE
			WHEN W. WAR_ZAM < 500 THEN 'Male'
			WHEN (W.WAR_ZAM  >= 500 AND W.WAR_ZAM < 1000) THEN 'Srednie'
			WHEN W.WAR_ZAM >= 1000 THEN 'Duze'
		END AS RODZAJ_ZAM
FROM LICZBA_ZAMOWIEN L 
JOIN WARTOSC_ZAMOWIENIA W ON L.CompanyName = W.CompanyName

DROP VIEW LICZBA_ZAMOWIEN
DROP VIEW WARTOSC_ZAMOWIENIA



