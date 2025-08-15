-- UNION, UNION ALL, INTERSECT, EXCEPT

SELECT *
FROM HumanResources.Dzieci

SELECT * 
FROM HumanResources.Dzieci2

INSERT INTO HumanResources.Dzieci (imie, wiek, data_urodzenia) values
('Jacek', 12, '1996-05-08'),
('Kamil', 12, '1996-10-01');

INSERT INTO HumanResources.Dzieci2 (imie, wiek, data_urodzenia) values
('Jacek', 12, '1996-05-08'),
('Kamil', 12, '1996-10-01');


SELECT *
FROM HumanResources.Dzieci
UNION
SELECT *
FROM HumanResources.Dzieci2

SELECT *
FROM HumanResources.Dzieci
UNION ALL
SELECT *
FROM HumanResources.Dzieci2

SELECT *, 
FROM HumanResources.Dzieci
EXCEPT
SELECT *
FROM HumanResources.Dzieci2
ORDER BY wiek DESC

SELECT *
FROM HumanResources.Dzieci
INTERSECT
SELECT *
FROM HumanResources.Dzieci2


-- IFF, CASE
-- Zad 1
SELECT Name, 
		CASE Name WHEN 'English' THEN 'Angielski'
					WHEN 'Spanish' THEN 'Hiszpanski'
					WHEN 'Arabic' THEN CONVERT(varchar, GETDATE(), 102)
					WHEN 'Thai' THEN LEFT(name, 1)
					ELSE 'Nie znam'
				END AS 'Jêzyk'
FROM Production.Culture

-- Zad 2
SELECT BusinessEntityID, Gender, VacationHours,
		CASE Gender WHEN 'F' THEN VacationHours +16
		ELSE VacationHours
		END AS 'Wolne po zmianie'
FROM HumanResources.Employee

-- Zad 3
SELECT Description, DiscountPct,
		CASE WHEN DiscountPct <= 0.1 THEN 'Ma³a obni¿ka'
		 WHEN DiscountPct <= 0.2 THEN 'Srednia obni¿ka'
		 WHEN DiscountPct <= 0.3 THEN 'Dobra obni¿ka'
		 WHEN DiscountPct <= 0.4 THEN 'Super obni¿ka'
		ELSE 'Prawie Darmo'
		END AS 'Status obni¿ki'
FROM Sales.SpecialOffer

-- Zad 4
SELECT SalesYTD, SalesLastYear,
		CASE WHEN SalesYTD > SalesLastYear THEN 'Wiecej'
		ELSE 'Zosta³o' + CAST(SalesLastYear - SalesYTD  AS VARCHAR)
		END AS 'Porowanie lat'
FROM Sales.SalesPerson

-- Zad 5
SELECT BusinessEntityID, Gender, VacationHours,
		CASE Gender WHEN 'F' THEN VacationHours +16
		ELSE VacationHours
		END AS 'Wolne po zmianie'
FROM HumanResources.Employee

-- Zad 6
SELECT BusinessEntityID, Gender, VacationHours,
		CASE WHEN MaritalStatus = 'M' AND Gender = 'F' THEN VacationHours + 32
		WHEN Gender = 'F' THEN VacationHours + 16
		ELSE VacationHours
		END AS 'Wolne po zmianie'
FROM HumanResources.Employee