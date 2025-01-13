--Zadanie 1
-- Wyœwietl nazwy produktów i cenê jednostkow¹, 
-- dodaj¹c kolumnê informuj¹c¹, czy produkt jest drogi (cena > 30) czy tani.

SELECT ProductName, UnitPrice,
IIF(UnitPrice > 30, 'Drogi', 'Tani') AS Informacja
FROM Products


-- Zadanie 2
-- W tabeli Orders dodaj kolumnê, która poka¿e, czy zamówienie zosta³o wys³ane czy oczekuje na realizacjê.

SELECT *, IIF(ShippedDate IS NOT NULL, 'Wyslane','Oczekuj¹ce') AS Realizacja
FROM Orders


-- Zadanie 3
-- W tabeli Suppliers dodaj kolumnê, która klasyfikuje dostawców na du¿ych (wiêcej ni¿ 5 produktów) i ma³ych (5 lub mniej produktów).

SELECT S.SupplierID, S.CompanyName, IIF(COUNT(P.SupplierID) > 5, 'Duzy', 'Maly') AS Kategoria
FROM Suppliers S
LEFT JOIN Products P ON S.SupplierID = P.SupplierID
GROUP BY S.SupplierID, S.CompanyName


-- Zadanie 4
-- W tabeli Order Details dodaj kolumnê, która wska¿e, czy zysk z zamówienia (UnitPrice * Quantity) przekracza 1000, czy jest mniejszy.

SELECT *, IIF(UnitPrice * Quantity > 1000, 'Wiekszy', 'Mniejszy') AS Zysk
FROM "Order Details"


-- Zadanie 5 
-- W tabeli Customers dodaj kolumnê informuj¹c¹, czy klient jest z lokalnego kraju (np. "USA") czy z zagranicy.

SELECT *, IIF(Country = 'USA', 'Lokalny', 'Zagraniczny') AS Pochodzenie
FROM Customers

