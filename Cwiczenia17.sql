-- Zadanie 1
-- Podaæ dla klienta o indentyfikatorze ‘BERGS’ zbiorcz¹ analizê wydatków w rozbiciu na lata,
-- miesi¹ce, dni oraz wzglêdem Identyfikatora produktów. Porównaæ wydatki w poszczególnych okresach.

SELECT C.CompanyName, OD.ProductID, YEAR(O.OrderDate) AS ROK, MONTH(O.OrderDate) AS MIESIAC, DAY(O.OrderDate) AS DZIEN, SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS RAZEM
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
WHERE C.CustomerID = 'BERGS'
GROUP BY C.CompanyName, ROLLUP ( YEAR(O.OrderDate), MONTH(O.OrderDate), DAY(O.OrderDate), OD.ProductID)


--Zadanie 2
-- Podaæ, dla identyfikatora zamówieñ z przedzia³u (10264, 10253) oraz dla ceny jednostkowej
-- produktów <10 zbiorcz¹ analizê kosztów zamówienia wzglêdem identyfikatora zamówieñ i
-- identyfikatora produktu. Zanalizowaæ otrzymane wyniki.

SELECT O.OrderID, OD.ProductID, SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS RAZEM
FROM Orders O
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE O.OrderID BETWEEN 10253 AND 10263
	AND OD.UnitPrice < 10
GROUP BY CUBE (O.OrderID, OD.ProductID)
ORDER BY O.OrderID, OD.ProductID

--Zadanie 3
-- Podaæ zbiorcz¹ analizê zawieraj¹c¹: ile zamówieñ realizowali poszczególni pracownicy do
-- poszczególnych krajów, ile zamówieñ realizowali poszczególnie pracownicy ogó³em, oraz ile
-- zamówieñ przypada na ka¿dy kraj. 

SELECT EmployeeID, ShipCountry AS KRAJ, COUNT(OrderID) AS LICZBA_ZAMOWIEN
FROM Orders
GROUP BY GROUPING SETS ((EmployeeID, ShipCountry), (ShipCountry), (EmployeeID))
ORDER BY EmployeeID, ShipCountry

--Zadanie 4
--Dla zadania poprzedniego zamieniæ wartoœci NULL na dane opisowe: ‘³¹czne zamówienia dla
-- kraju’, ‘suma zrealizowanych zamówieñ przez pracownika’. U¿ycie funkcji grouping w
--klauzurze Select, (decode – Oracle, SQL Server – case … when … then … else … end ).

SELECT ( CASE GROUPING(EmployeeID) WHEN 0 THEN CAST(EmployeeID AS VARCHAR) ELSE '³aczne zamowienie dla kraju' END ) AS PRACOWNIK,
		(CASE GROUPING(Shipcountry) WHEN 0 THEN ShipCountry ELSE 'suma zrealizowanych zamowien przez pracownika' END) AS KRAJ, 
		COUNT(OrderID) AS LICZBA_ZAMOWIEN
FROM Orders
GROUP BY 
	GROUPING SETS ((EmployeeID, ShipCountry), (ShipCountry), (EmployeeID))
ORDER BY EmployeeID
