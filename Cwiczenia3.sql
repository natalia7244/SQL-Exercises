--13. Wyszukaj informacje o stanowisku pracownik�w, 
--kt�rych nazwiska zaczynaj� si� na liter� z zakresu od B do L 
SELECT * 
FROM Employees
WHERE LastName LIKE '[B-L]%';

--14. Wyszukaj informacje o stanowisku pracownik�w, 
--kt�rych nazwiska zaczynaj� si� na liter� B lub L 
SELECT LastName, Title
FROM Employees
WHERE LastName LIKE 'B%' 
		OR  
	  LastName LIKE'L%' ;

--15. Znajd� nazwy kategorii, kt�re w opisie zawieraj�
-- przecinek 
SELECT CategoryName, Description
FROM Categories
WHERE Description LIKE '%,%';

--16. Znajd� klient�w, kt�rzy w swojej nazwie maj� 
--w kt�rym� miejscu s�owo Store.
SELECT CompanyName
FROM Customers
WHERE CompanyName LIKE '%Store%';

--17. Szukamy informacji o produktach o cenach 
--mniejszych ni� 10 lub wi�kszych ni� 20
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice NOT BETWEEN 10 AND 20;

--18. Wybierz nazwy i kraje wszystkich klient�w, 
--wyniki posortuj wed�ug kraju od Z do A, w ramach danego 
--kraju nazwy firm posortuj alfabetycznie
SELECT CompanyName, Country
FROM Customers
ORDER BY Country DESC, CompanyName ASC;

--19. Wybierz informacj� o produktach (kategoria, nazwa, cena), 
--produkty posortuj wg kategorii, 
--a w kategoriach malej�co wg ceny 
SELECT CategoryID, ProductName, UnitPrice
FROM Products
ORDER BY CategoryID, UnitPrice DESC;


--20. Wybierz nazwy i kraje wszystkich klient�w maj�cych 
--siedziby w Niemczech (Germany) lub we W�oszech (Italy), 
--wyniki posortuj wed�ug kraju, w ramach danego kraju 
--nazwy firm posortuj alfabetycznie
SELECT CompanyName, Country
FROM Customers
WHERE Country LIKE 'Germany' OR Country LIKE 'Italy'
ORDER BY Country ASC, CompanyName ASC;

--21.Stw�rz list� pracownik�w i ich daty urodzenia
--Dane wy�wietl w dw�ch kolumnach.
SELECT FirstName + ' ' + LastName AS EmployeeName, BirthDate
FROM Employees;

--22.Poka� wszystkie zam�wienia obs�ugiwane przez spedytor�w 
--'Speedy Express' id 1 i 'Federal Shipping' id 3.
SELECT ShipperID, CompanyName
FROM Shippers
WHERE CompanyName IN ('Speedy Express','Federal Shipping')

SELECT *
FROM Orders
WHERE ShipVia IN ('1','3')
ORDER BY ShipVia;

--23.Poka� 10 pierwszych zam�wie� dla pracownika o ID 3.
SELECT top 10 OrderID
FROM Orders
WHERE EmployeeID LIKE '3'
ORDER BY OrderDate;


--24.Wy�wietl list� kraj�w, z kt�rych pochodz� klienci. 
SELECT DISTINCT Country
FROM Customers
ORDER BY Country;

--25.Poka� wszystkie niewys�ane zam�wienia
SELECT OrderID, ShippedDate
FROM Orders
WHERE ShippedDate IS NULL;

--26.Wy�wietl list� produkt�w wycofanych
SELECT ProductName, Discontinued
FROM Products
WHERE Discontinued LIKE '1';

--27.Znajd� dostawc�w tofu
SELECT ProductName, SupplierID
FROM Products
WHERE ProductName LIKE '%tofu%';

SELECT *
FROM Suppliers
WHERE SupplierID IN('6','4');

--28.Znajd� dostawc�w czekolady
SELECT *
FROM Products
WHERE ProductName LIKE '%schok%'
OR ProductName LIKE '%chocola%';

SELECT CompanyName
FROM Suppliers
WHERE SupplierID IN (8, 11, 22);


--29.Wy�wietl produkty sprzedawane w butelkach lub w s�oikach, 
--dla kt�rych cena jest mniejsza ni� 10 i wi�ksza od 20.
SELECT *
FROM Products
WHERE (QuantityPerUnit LIKE '%bottle%'
OR QuantityPerUnit LIKE '%jar%')
AND (UnitPrice < '10' OR UnitPrice > '20');


