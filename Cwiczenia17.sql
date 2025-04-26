-- Zadanie 1
-- Poda� dla klienta o indentyfikatorze �BERGS� zbiorcz� analiz� wydatk�w w rozbiciu na lata,
-- miesi�ce, dni oraz wzgl�dem Identyfikatora produkt�w. Por�wna� wydatki w poszczeg�lnych okresach.

SELECT C.CompanyName, OD.ProductID, YEAR(O.OrderDate) AS ROK, MONTH(O.OrderDate) AS MIESIAC, DAY(O.OrderDate) AS DZIEN, SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS RAZEM
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
WHERE C.CustomerID = 'BERGS'
GROUP BY C.CompanyName, ROLLUP ( YEAR(O.OrderDate), MONTH(O.OrderDate), DAY(O.OrderDate), OD.ProductID)


--Zadanie 2
-- Poda�, dla identyfikatora zam�wie� z przedzia�u (10264, 10253) oraz dla ceny jednostkowej
-- produkt�w <10 zbiorcz� analiz� koszt�w zam�wienia wzgl�dem identyfikatora zam�wie� i
-- identyfikatora produktu. Zanalizowa� otrzymane wyniki.

SELECT O.OrderID, OD.ProductID, SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS RAZEM
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE O.OrderID BETWEEN 10253 AND 10263
	AND OD.UnitPrice < 10
GROUP BY CUBE (O.OrderID, OD.ProductID)
ORDER BY O.OrderID, OD.ProductID

--Zadanie 3
-- Poda� zbiorcz� analiz� zawieraj�c�: ile zam�wie� realizowali poszczeg�lni pracownicy do
-- poszczeg�lnych kraj�w, ile zam�wie� realizowali poszczeg�lnie pracownicy og�em, oraz ile
-- zam�wie� przypada na ka�dy kraj. 

SELECT EmployeeID, ShipCountry AS KRAJ, COUNT(OrderID) AS LICZBA_ZAMOWIEN
FROM Orders
GROUP BY GROUPING SETS ((EmployeeID, ShipCountry), (ShipCountry), (EmployeeID))
ORDER BY EmployeeID, ShipCountry

--Zadanie 4
--Dla zadania poprzedniego zamieni� warto�ci NULL na dane opisowe: ���czne zam�wienia dla
-- kraju�, �suma zrealizowanych zam�wie� przez pracownika�. U�ycie funkcji grouping w
--klauzurze Select, (decode � Oracle, SQL Server � case � when � then � else � end ).

SELECT ( CASE GROUPING(EmployeeID) WHEN 0 THEN CAST(EmployeeID AS VARCHAR) ELSE '�aczne zamowienie dla kraju' END ) AS PRACOWNIK,
		(CASE GROUPING(Shipcountry) WHEN 0 THEN ShipCountry ELSE 'suma zrealizowanych zamowien przez pracownika' END) AS KRAJ, 
		COUNT(OrderID) AS LICZBA_ZAMOWIEN
FROM Orders
GROUP BY 
	GROUPING SETS ((EmployeeID, ShipCountry), (ShipCountry), (EmployeeID))
ORDER BY EmployeeID
