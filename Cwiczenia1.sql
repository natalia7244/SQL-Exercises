--1. Wybierz nazwy i adresy wszystkich klientów 
SELECT Address, CompanyName from Customers;

--2. Wybierz nazwiska i numery telefonów pracowników 
SELECT LastName, homePhone from Employees;

--3. Wybierz nazwy i ceny produktów 
SELECT ProductName, UnitPrice from Products;

--4. Poka¿ wszystkie kategorie produktów (nazwy i opisy) 
SELECT CategoryName, Description from Categories;

--5. Poka¿ nazwy i adresy stron www dostawców. Którzy dostawcy nie maj¹ strony www? 
SELECT CompanyName, HomePage from Suppliers
WHERE HomePage IS NULL;

