-- Zadanie 1
-- Wy�wietl OrderID, ShipCountry oraz dodatkow� kolumn� Region, kt�ra:
-- Zwraca "Europa" dla zam�wie� wysy�anych do Francji, Niemiec lub Wielkiej Brytanii.
-- Zwraca "Ameryka P�nocna" dla zam�wie� do USA lub Kanady.
-- Zwraca "Inny" dla pozosta�ych.

SELECT OrderID, ShipCountry, 
	CASE
		WHEN ShipCountry IN ('France', 'Germany', 'UK') THEN 'Europa'
		WHEN ShipCountry IN ('USA', 'Canada') THEN 'Ameryka Polnocna'
		ELSE 'Inny'
	END AS "Region"
FROM Orders

-- Zadanie 2
--Wy�wietl ProductName, UnitsInStock oraz now� kolumn� StanMagazynu, kt�ra:
   -- Zwraca "Niski" dla zapas�w mniejszych ni� 10.
   -- Zwraca "�redni" dla zapas�w mi�dzy 10 a 50.
   -- Zwraca "Wysoki" dla zapas�w powy�ej 50.

SELECT ProductName, UnitsInStock,
	CASE
		WHEN UnitsInStock < 10 THEN 'Niski'
		WHEN UnitsInStock BETWEEN 10 AND 50 THEN 'Sredni'
		WHEN UnitsInStock > 50 THEN 'Wysoki'
	END AS 'Stan Magazynu'
FROM Products


--Zadanie 3
--Wy�wietl ProductName, UnitPrice oraz now� kolumn� KategoriaCenowa, kt�ra:
   -- Zwraca "Tanie" dla produkt�w o cenie poni�ej 20.
   -- Zwraca "�rednie" dla produkt�w o cenie od 20 do 50.
   -- Zwraca "Drogie" dla produkt�w o cenie powy�ej 50.

SELECT ProductName, UnitPrice,
	CASE
		WHEN UnitPrice < 20 THEN 'Tanie'
		WHEN UnitPrice BETWEEN 20 AND 50 THEN 'Srednie'
		WHEN UnitPrice > 50 THEN 'Drogie'
	END AS 'Karegoria cenowa'
FROM Products


-- Zadanie 4
-- Wy�wietl OrderID, OrderDate, ShippedDate oraz now� kolumn� StatusZamowienia, kt�ra:
   -- Zwraca "Zrealizowane" dla zam�wie�, kt�re maj� dat� w kolumnie ShippedDate.
   -- Zwraca "Oczekuj�ce" dla zam�wie�, kt�re nie maj� daty wysy�ki.

   SELECT OrderID,OrderDate, ShippedDate,
	CASE
		WHEN ShippedDate IS NOT NULL THEN 'Zrealizowane'
		WHEN ShippedDate IS NULL THEN 'Oczekujace'
	END AS 'Status zamowienia'
   FROM Orders


-- Zadanie 5
-- Wy�wietl OrderID, Freight oraz now� kolumn� KosztPrzewozu, kt�ra:
    -- Zwraca "Niski" dla koszt�w mniejszych ni� 50.
    -- Zwraca "�redni" dla koszt�w mi�dzy 50 a 100.
    -- Zwraca "Wysoki" dla koszt�w powy�ej 100.

SELECT OrderID, Freight,
	CASE
		WHEN Freight < 50 THEN 'Niski'
		WHEN Freight BETWEEN 50 AND 100 THEN 'Sredni'
		WHEN Freight > 50 THEN 'Wysoki'
	END AS 'Koszt Przewozu'
FROM Orders