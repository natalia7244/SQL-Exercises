--1. Wybierz nazwy i adresy wszystkich klient�w 
SELECT Address, CompanyName from Customers;

--2. Wybierz nazwiska i numery telefon�w pracownik�w 
SELECT LastName, homePhone from Employees;

--3. Wybierz nazwy i ceny produkt�w 
SELECT ProductName, UnitPrice from Products;

--4. Poka� wszystkie kategorie produkt�w (nazwy i opisy) 
SELECT CategoryName, Description from Categories;

--5. Poka� nazwy i adresy stron www dostawc�w. Kt�rzy dostawcy nie maj� strony www? 
SELECT CompanyName, HomePage from Suppliers
WHERE HomePage IS NULL;

