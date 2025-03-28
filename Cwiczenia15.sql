-- Zadanie 1
-- Napisz zapytani, kt�re zwr�ci list� klient�w, kt�rzy z�o�yli wi�cej ni� 10 zam�wie�.

SELECT C.CustomerID, C.CompanyName, COUNT(DISTINCT O.OrderID) AS ILOSC_ZAMOWIEN
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID 
GROUP BY C.CustomerID, C.CompanyName
HAVING COUNT(DISTINCT O.OrderID) > 10
ORDER BY COUNT(DISTINCT O.OrderID) DESC

-- Zadanie 2
-- Napisz zapytanie, kt�re zwr�ci trzech klient�w z najwi�ksz� ��czn� warto�ci� zam�wie� (Orders).

SELECT TOP 3 C.CustomerID, C.CompanyName, ROUND(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)),2) AS LACZNA_WARTOSC_ZAMOWIENIA 
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
GROUP BY C.CustomerID, C.CompanyName
ORDER BY LACZNA_WARTOSC_ZAMOWIENIA DESC

--Zadanie 3
-- Napisz zapytanie, kt�re zwr�ci 5 produkt�w z najwi�ksz� sum� warto�ci zam�wie� w historii, 
-- kt�re zosta�y zam�wione przynajmniej w 3 r�nych zam�wieniach.

SELECT TOP 5 P.ProductID, P.ProductName, ROUND(SUM(OD.UnitPrice * OD.Quantity * (1 -OD.Discount)),2) AS SUMA
FROM Products P
JOIN [Order Details] OD ON P.ProductID = OD.ProductID
JOIN Orders O ON OD.OrderID = O.OrderID
GROUP BY P.ProductID, P.ProductName
HAVING COUNT(DISTINCT O.OrderID) >= 3
ORDER BY SUMA DESC

--Zadanie 4
-- Napisz zapytanie, kt�re zwr�ci �redni� warto�� zam�wienia dla ka�dego klienta, 
-- kt�ry z�o�y� co najmniej 5 zam�wie�.

SELECT C.CustomerID, C.CompanyName, ROUND(AVG(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)),2) AS SREDNIA
FROM Customers C
JOIN Orders O ON O.CustomerID = C.CustomerID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID 
GROUP BY C.CustomerID, C.CompanyName
HAVING COUNT(DISTINCT O.OrderID) >=5
ORDER BY SREDNIA DESC
