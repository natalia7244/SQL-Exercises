--13. Wyszukaj informacje o stanowisku pracowników, 
--których nazwiska zaczynaj¹ siê na literê z zakresu od B do L 
SELECT * 
FROM Employees
WHERE LastName LIKE '[B-L]%';

--14. Wyszukaj informacje o stanowisku pracowników, 
--których nazwiska zaczynaj¹ siê na literê B lub L 
SELECT LastName, Title
FROM Employees
WHERE LastName LIKE 'B%' 
		OR  
	  LastName LIKE'L%' ;

--15. ZnajdŸ nazwy kategorii, które w opisie zawieraj¹
-- przecinek 
SELECT CategoryName, Description
FROM Categories
WHERE Description LIKE '%,%';

--16. ZnajdŸ klientów, którzy w swojej nazwie maj¹ 
--w którymœ miejscu s³owo Store.
SELECT CompanyName
FROM Customers
WHERE CompanyName LIKE '%Store%';

--17. Szukamy informacji o produktach o cenach 
--mniejszych ni¿ 10 lub wiêkszych ni¿ 20
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice NOT BETWEEN 10 AND 20;

--18. Wybierz nazwy i kraje wszystkich klientów, 
--wyniki posortuj wed³ug kraju od Z do A, w ramach danego 
--kraju nazwy firm posortuj alfabetycznie
SELECT CompanyName, Country
FROM Customers
ORDER BY Country DESC, CompanyName ASC;

--19. Wybierz informacjê o produktach (kategoria, nazwa, cena), 
--produkty posortuj wg kategorii, 
--a w kategoriach malej¹co wg ceny 
SELECT CategoryID, ProductName, UnitPrice
FROM Products
ORDER BY CategoryID, UnitPrice DESC;


--20. Wybierz nazwy i kraje wszystkich klientów maj¹cych 
--siedziby w Niemczech (Germany) lub we W³oszech (Italy), 
--wyniki posortuj wed³ug kraju, w ramach danego kraju 
--nazwy firm posortuj alfabetycznie
SELECT CompanyName, Country
FROM Customers
WHERE Country LIKE 'Germany' OR Country LIKE 'Italy'
ORDER BY Country ASC, CompanyName ASC;

--21.Stwórz listê pracowników i ich daty urodzenia
--Dane wyœwietl w dwóch kolumnach.
SELECT FirstName + ' ' + LastName AS EmployeeName, BirthDate
FROM Employees;

--22.Poka¿ wszystkie zamówienia obs³ugiwane przez spedytorów 
--'Speedy Express' id 1 i 'Federal Shipping' id 3.
SELECT ShipperID, CompanyName
FROM Shippers
WHERE CompanyName IN ('Speedy Express','Federal Shipping')

SELECT *
FROM Orders
WHERE ShipVia IN ('1','3')
ORDER BY ShipVia;

--23.Poka¿ 10 pierwszych zamówieñ dla pracownika o ID 3.
SELECT top 10 OrderID
FROM Orders
WHERE EmployeeID LIKE '3'
ORDER BY OrderDate;


--24.Wyœwietl listê krajów, z których pochodz¹ klienci. 
SELECT DISTINCT Country
FROM Customers
ORDER BY Country;

--25.Poka¿ wszystkie niewys³ane zamówienia
SELECT OrderID, ShippedDate
FROM Orders
WHERE ShippedDate IS NULL;

--26.Wyœwietl listê produktów wycofanych
SELECT ProductName, Discontinued
FROM Products
WHERE Discontinued LIKE '1';

--27.ZnajdŸ dostawców tofu
SELECT ProductName, SupplierID
FROM Products
WHERE ProductName LIKE '%tofu%';

SELECT *
FROM Suppliers
WHERE SupplierID IN('6','4');

--28.ZnajdŸ dostawców czekolady
SELECT *
FROM Products
WHERE ProductName LIKE '%schok%'
OR ProductName LIKE '%chocola%';

SELECT CompanyName
FROM Suppliers
WHERE SupplierID IN (8, 11, 22);


--29.Wyœwietl produkty sprzedawane w butelkach lub w s³oikach, 
--dla których cena jest mniejsza ni¿ 10 i wiêksza od 20.
SELECT *
FROM Products
WHERE (QuantityPerUnit LIKE '%bottle%'
OR QuantityPerUnit LIKE '%jar%')
AND (UnitPrice < '10' OR UnitPrice > '20');


