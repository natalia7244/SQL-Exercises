--Zadanie 1
--Podaj pracowników, którzy zrealizowali przynajmniej 200 zamówieñ, których ca³kowita wartoœæ wynios³a powy¿ej 10000.

SELECT E.EmployeeID, E.LastName, E.FirstName, COUNT(O.OrderID) AS Liczba_Zamowien, SUM(OD.UnitPrice * OD.Quantity* (1-OD.Discount)) AS Laczna_Wartosc
FROM Employees E 
JOIN Orders O ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY E.EmployeeID, E.LastName, E.FirstName
HAVING COUNT(O.OrderID) >= 200 AND (SUM(OD.UnitPrice * OD.Quantity* (1-OD.Discount)) > 10000)

--Zadanie 2
-- ZnajdŸ wszystkich dostawców, którzy dostarczaj¹ produkty w kategorii "Napoje" i których produkty zosta³y zamówione przez co najmniej 10 ró¿nych klientów.

SELECT S.SupplierID, S.CompanyName, COUNT(DISTINCT O.CustomerID) AS Liczba_KLIENTOW
FROM Suppliers S
JOIN Products P ON S.SupplierID = P.SupplierID
JOIN Categories C ON P.CategoryID = C.CategoryID
JOIN "Order Details" OD ON P.ProductID = OD.ProductID
JOIN Orders O ON OD.OrderID = O.OrderID
WHERE C.Description LIKE '%drink%'
GROUP BY S.SupplierID, S.CompanyName
HAVING COUNT(DISTINCT O.CustomerID) >= 10

-- Zadanie 3
-- ZnajdŸ pracowników, którzy zrealizowali przynajmniej 3 zamówienia w 1997 roku.

SELECT E.EmployeeID, E.LastName, E.FirstName, COUNT(O.OrderID) AS Liczba_Zamowien
FROM Employees E 
JOIN Orders O ON E.EmployeeID = O.EmployeeID
WHERE YEAR(O.ShippedDate) = 1997
GROUP BY E.EmployeeID, E.LastName, E.FirstName
HAVING COUNT(O.OrderID) >= 3


--Zadanie 4
--Poka¿ produkty, które by³y zamawiane przez wiêcej ni¿ 5 ró¿nych klientów w okresie od stycznia 1997 do grudnia 1997.

SELECT P.ProductName,  COUNT(DISTINCT C.CustomerID) AS Klienci
FROM Products P
JOIN [Order Details] OD ON OD.ProductID = P.ProductID
JOIN Orders O ON O.OrderID = OD.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY P.ProductName
HAVING COUNT(DISTINCT C.CustomerID) > 5