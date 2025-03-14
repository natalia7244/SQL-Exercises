--Zad. 1
--Podaj klient�w (z nazwy), kt�rzy w 1997 roku z�o�yli przynajmniej 3 zam�wienia na produkty w s�oikach.
--Nazwy kolumn w kolejno�ci NAZWA_KLIENTA, LICZBA_ZAM

SELECT C.CompanyName As NAZWA_KLIENTA, COUNT(O.OrderID) AS "LICZBA_ZAMOWIEN"
FROM Products P
JOIN "Order Details" OD ON P.ProductID = OD.ProductID
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE Year(O.OrderDate) = 1997 AND P.QuantityPerUnit LIKE '%jar%'
GROUP BY C.CompanyName
HAVING COUNT(O.OrderID) >= 3

--Zad. 2.
--Znajd� wszystkich klient�w pochodz�cych z Niemiec, kt�rych ��czna warto�� zakupionego towaru jest wi�ksza ni� 5000.
--Posortuj list� alfabetycznie wed�ug klient�w.
--Wy�wietl nazwy kolumn w kolejno�ci: NAZWA_KLIENTA, WARTO��_ZAM

SELECT C.CompanyName AS NAZWA_KLIENTA, SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS WARTOSC_ZAM
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN "Order Details" OD ON OD.OrderID = O.OrderID
WHERE C.Country = 'Germany'
GROUP BY C.CompanyName
HAVING SUM(OD.UnitPrice * OD.Quantity) > 5000
ORDER BY C.CompanyName ASC


--Zad. 3. 
--Poda� pracownik�w oraz liczb� zam�wie� zrealizowanych w terminie, w latach 1997-1998
--Dane wy�wietl w kolejno�ci od najwi�kszej liczby zam�wie�.
--Nazwy kolumn w kolejno�ci IMIE, NAZWISKO, LICZBA_ZAM

SELECT E.FirstName AS IMIE, E.LastName AS NAZWISKO,  COUNT(O.OrderID) AS LICZBA_ZAM
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
WHERE (YEAR(O.ShippedDate) BETWEEN 1997 AND 1998) AND (O.RequiredDate >= O.ShippedDate)
GROUP BY E.EmployeeID, E.FirstName, E.LastName
ORDER BY LICZBA_ZAM DESC

--Zad. 4.   
--Znajd� klienta, kt�ry nigdy niczego nie kupi�, sprawdzaj�c identyfikator klienta w tabeli zam�wie�. 

SELECT C.CompanyName
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL


--Zad. 5.
--Podaj nazwy produkt�w, kt�re nie by�y sprzedawane latem (od czerwca do sierpnia).

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
--Wy�wietl informacje o pracownikach, kt�rzy zostali zatrudnieni po zatrudnieniu pracownika Steven Buchanan.

SELECT LastName, FirstName
FROM Employees
WHERE HireDate > (
	SELECT HireDate
	FROM Employees
	WHERE LastName LIKE 'Buchanan' AND FirstName LIKE 'Steven'
	)

	
--Zad. 7. 
--Podaj klient�w, kt�rzy z�o�yli kolejne zam�wienia po otrzymaniu dostawy z op�nieniem.  

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
--Ile i jakiego rodzaju zam�wie� z�o�yli poszczeg�lni klienci?
--Utw�rz odpowiedni widok.

--Rodzaje zam�wie�: ma�e - warto��<500,
--�rednie - warto��<1000,
--reszta to du�e.

--Wy�wietl nazw� klienta, rodzaj zam�wienia, liczb� zam�wie�.
--Na koniec nale�y usun�� widok odpowiednim poleceniem.

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



