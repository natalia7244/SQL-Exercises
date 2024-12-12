--6. Wybierz nazwy i adresy wszystkich klient�w maj�cych siedziby w Londynie 
SELECT CompanyName, Address 
FROM Customers 
WHERE City = 'London';

--7. Wybierz nazwy i adresy wszystkich klient�w maj�cych siedziby we Francji lub w Hiszpanii 
SELECT CompanyName, Address
FROM Customers
WHERE Country LIKE 'Spain' OR Country LIKE 'France';

--8. Wybierz nazwy i ceny produkt�w o cenie jednostkowej pomi�dzy 20.00 a 30.00 
SELECT ProductName, UnitPrice 
FROM Products
WHERE UnitPrice BETWEEN 20 AND 30;

--9. Wybierz nazwy i ceny produkt�w z kategorii 'seafood' 
SELECT 
    ProductName, 
    UnitPrice
FROM 
    Products
WHERE 
    CategoryID = (
        SELECT CategoryID
        FROM Categories
        WHERE CategoryName = 'seafood'
    );


--10. Wybierz nazwy produkt�w oraz inf. o stanie magazynu dla produkt�w dostarczanych przez firm� .Tokyo Traders. 
SELECT ProductName, UnitsInStock
FROM Products
WHERE SupplierID = (
	SELECT SupplierID
	FROM Suppliers
	WHERE Suppliers.CompanyName = 'Tokyo Traders'
	);

	SELECT SupplierID,CompanyName FROM Suppliers 
WHERE CompanyName = 'Tokyo Traders' 

SELECT ProductName, UnitsInStock FROM Products 
WHERE SupplierID = 4 

--11. Wybierz nazwy produkt�w, kt�rych nie ma w magazynie
SELECT ProductName, UnitsInStock
FROM Products
WHERE UnitsInStock = '0'; 

--12.Szukamy informacji o produktach sprzedawanych 
--w butelkach (bottle)
SELECT *
FROM Products
WHERE QuantityPerUnit LIKE '%bottle%';

