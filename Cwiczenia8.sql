--Zadanie 1
-- Wy�wietl nazwy produkt�w i cen� jednostkow�, 
-- dodaj�c kolumn� informuj�c�, czy produkt jest drogi (cena > 30) czy tani.

SELECT ProductName, UnitPrice,
IIF(UnitPrice > 30, 'Drogi', 'Tani') AS Informacja
FROM Products


-- Zadanie 2
-- W tabeli Orders dodaj kolumn�, kt�ra poka�e, czy zam�wienie zosta�o wys�ane czy oczekuje na realizacj�.

SELECT *, IIF(ShippedDate IS NOT NULL, 'Wyslane','Oczekuj�ce') AS Realizacja
FROM Orders


-- Zadanie 3
-- W tabeli Suppliers dodaj kolumn�, kt�ra klasyfikuje dostawc�w na du�ych (wi�cej ni� 5 produkt�w) i ma�ych (5 lub mniej produkt�w).

SELECT S.SupplierID, S.CompanyName, IIF(COUNT(P.SupplierID) > 5, 'Duzy', 'Maly') AS Kategoria
FROM Suppliers S
LEFT JOIN Products P ON S.SupplierID = P.SupplierID
GROUP BY S.SupplierID, S.CompanyName


-- Zadanie 4
-- W tabeli Order Details dodaj kolumn�, kt�ra wska�e, czy zysk z zam�wienia (UnitPrice * Quantity) przekracza 1000, czy jest mniejszy.

SELECT *, IIF(UnitPrice * Quantity > 1000, 'Wiekszy', 'Mniejszy') AS Zysk
FROM "Order Details"


-- Zadanie 5 
-- W tabeli Customers dodaj kolumn� informuj�c�, czy klient jest z lokalnego kraju (np. "USA") czy z zagranicy.

SELECT *, IIF(Country = 'USA', 'Lokalny', 'Zagraniczny') AS Pochodzenie
FROM Customers

