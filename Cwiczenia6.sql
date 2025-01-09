-- Zadanie 1
-- Wyœwietl OrderID, ShipCountry oraz dodatkow¹ kolumnê Region, która:
-- Zwraca "Europa" dla zamówieñ wysy³anych do Francji, Niemiec lub Wielkiej Brytanii.
-- Zwraca "Ameryka Pó³nocna" dla zamówieñ do USA lub Kanady.
-- Zwraca "Inny" dla pozosta³ych.

SELECT OrderID, ShipCountry, 
	CASE
		WHEN ShipCountry IN ('France', 'Germany', 'UK') THEN 'Europa'
		WHEN ShipCountry IN ('USA', 'Canada') THEN 'Ameryka Polnocna'
		ELSE 'Inny'
	END AS "Region"
FROM Orders

-- Zadanie 2
--Wyœwietl ProductName, UnitsInStock oraz now¹ kolumnê StanMagazynu, która:
   -- Zwraca "Niski" dla zapasów mniejszych ni¿ 10.
   -- Zwraca "Œredni" dla zapasów miêdzy 10 a 50.
   -- Zwraca "Wysoki" dla zapasów powy¿ej 50.

SELECT ProductName, UnitsInStock,
	CASE
		WHEN UnitsInStock < 10 THEN 'Niski'
		WHEN UnitsInStock BETWEEN 10 AND 50 THEN 'Sredni'
		WHEN UnitsInStock > 50 THEN 'Wysoki'
	END AS 'Stan Magazynu'
FROM Products


--Zadanie 3
--Wyœwietl ProductName, UnitPrice oraz now¹ kolumnê KategoriaCenowa, która:
   -- Zwraca "Tanie" dla produktów o cenie poni¿ej 20.
   -- Zwraca "Œrednie" dla produktów o cenie od 20 do 50.
   -- Zwraca "Drogie" dla produktów o cenie powy¿ej 50.

SELECT ProductName, UnitPrice,
	CASE
		WHEN UnitPrice < 20 THEN 'Tanie'
		WHEN UnitPrice BETWEEN 20 AND 50 THEN 'Srednie'
		WHEN UnitPrice > 50 THEN 'Drogie'
	END AS 'Karegoria cenowa'
FROM Products


-- Zadanie 4
-- Wyœwietl OrderID, OrderDate, ShippedDate oraz now¹ kolumnê StatusZamowienia, która:
   -- Zwraca "Zrealizowane" dla zamówieñ, które maj¹ datê w kolumnie ShippedDate.
   -- Zwraca "Oczekuj¹ce" dla zamówieñ, które nie maj¹ daty wysy³ki.

   SELECT OrderID,OrderDate, ShippedDate,
	CASE
		WHEN ShippedDate IS NOT NULL THEN 'Zrealizowane'
		WHEN ShippedDate IS NULL THEN 'Oczekujace'
	END AS 'Status zamowienia'
   FROM Orders


-- Zadanie 5
-- Wyœwietl OrderID, Freight oraz now¹ kolumnê KosztPrzewozu, która:
    -- Zwraca "Niski" dla kosztów mniejszych ni¿ 50.
    -- Zwraca "Œredni" dla kosztów miêdzy 50 a 100.
    -- Zwraca "Wysoki" dla kosztów powy¿ej 100.

SELECT OrderID, Freight,
	CASE
		WHEN Freight < 50 THEN 'Niski'
		WHEN Freight BETWEEN 50 AND 100 THEN 'Sredni'
		WHEN Freight > 50 THEN 'Wysoki'
	END AS 'Koszt Przewozu'
FROM Orders