-- Zadanie 1
-- Napisz zapytani, które zwróci listê klientów, którzy z³o¿yli wiêcej ni¿ 10 zamówieñ.

SELECT C.CustomerID, C.CompanyName, COUNT(DISTINCT O.OrderID) AS ILOSC_ZAMOWIEN
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID 
GROUP BY C.CustomerID, C.CompanyName
HAVING COUNT(DISTINCT O.OrderID) > 10
ORDER BY COUNT(DISTINCT O.OrderID) DESC

-- Zadanie 2
-- Napisz zapytanie, które zwróci trzech klientów z najwiêksz¹ ³¹czn¹ wartoœci¹ zamówieñ (Orders).

SELECT TOP 3 C.CustomerID, C.CompanyName, ROUND(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)),2) AS LACZNA_WARTOSC_ZAMOWIENIA 
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
GROUP BY C.CustomerID, C.CompanyName
ORDER BY LACZNA_WARTOSC_ZAMOWIENIA DESC

--Zadanie 3
-- Napisz zapytanie, które zwróci 5 produktów z najwiêksz¹ sum¹ wartoœci zamówieñ w historii, 
-- które zosta³y zamówione przynajmniej w 3 ró¿nych zamówieniach.

SELECT TOP 5 P.ProductID, P.ProductName, ROUND(SUM(OD.UnitPrice * OD.Quantity * (1 -OD.Discount)),2) AS SUMA
FROM Products P
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
JOIN Orders O ON OD.OrderID = O.OrderID
GROUP BY P.ProductID, P.ProductName
HAVING COUNT(DISTINCT O.OrderID) >= 3
ORDER BY SUMA DESC

--Zadanie 4
-- Napisz zapytanie, które zwróci œredni¹ wartoœæ zamówienia dla ka¿dego klienta, 
-- który z³o¿y³ co najmniej 5 zamówieñ.

SELECT C.CustomerID, C.CompanyName, ROUND(AVG(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)),2) AS SREDNIA
FROM Customers C
JOIN Orders O ON O.CustomerID = C.CustomerID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID 
GROUP BY C.CustomerID, C.CompanyName
HAVING COUNT(DISTINCT O.OrderID) >=5
ORDER BY SREDNIA DESC
