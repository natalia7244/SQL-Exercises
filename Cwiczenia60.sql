-- AdventureWorks2016, TEST

-- Zad1 
SELECT DepartmentID AS Numer_Departamentu, Name AS "Nazwa departamentu"
FROM HumanResources.Department

--Zad2
SELECT AddressID, AddressLine1 + ' ' + City + ', ' + PostalCode AS Adres
FROM Person.Address

--Zad3
SELECT *
FROM HumanResources.EmployeeDepartmentHistory
WHERE BusinessEntityID >= 200 AND (DepartmentID = 4 OR DepartmentID = 6)

--Zad4
SELECT BusinessEntityID, Rate, RateChangeDate
FROM HumanResources.EmployeePayHistory
WHERE (Rate BETWEEN 60 AND 100) AND RateChangeDate > '20090101'

--Zad5
SELECT TOP 1 LocationID, Name, CostRate
FROM Production.Location
ORDER BY CostRate DESC

--Zad6
SELECT Name, ProductNumber, ListPrice, 
		CASE WHEN Color IS NOT NULL THEN Color
			ELSE 'No color' 
			END AS Color		
FROM Production.Product
WHERE ListPrice BETWEEN 100 AND 200
ORDER BY ListPrice ASC

select Name, ProductNumber,
ListPrice,
isnull(Color,'No color') as Color
from Production.Product
where ListPrice between 100 and 200
order by ListPrice;


--Zad7
SELECT MAX(SalesQuota) AS Maksymalna, AVG(SalesQuota) AS AVG_, SUM(SalesQuota)/COUNT(*) AS AVG_Recznie
FROM Sales.SalesPerson

select max(SalesQuota) as "max z SalesQuota",
avg(SalesQuota) as "œrednia z SalesQuota - b³êdna",
avg(isnull(SalesQuota,0)) as "œrednia z SalesQuota -
prawid³owa"
from Sales.SalesPerson;


--Zad8
SELECT JobTitle, Gender, AVG(VacationHours) As Srdenia
FROM HumanResources.Employee
GROUP BY JobTitle, Gender
ORDER BY JobTitle ASC, Gender ASC

--Zad9
SELECT T.[Group], H.SalesOrderID
FROM Sales.SalesTerritory AS T
JOIN Sales.SalesOrderHeader AS H ON T.TerritoryID = H.TerritoryID


SELECT * FROM Sales.SalesTerritory
SELECT * FROM Sales.SalesOrderHeader

--Zad10
SELECT * FROM Person.BusinessEntityAddress
SELECT * FROM Person.Address
SELECT * FROM Person.AddressType

SELECT B.BusinessEntityID, Name, A.AddressLine1 + ' ' + A.PostalCode AS Adres
FROM Person.AddressType AS T
JOIN Person.Address AS A ON T.AddressTypeID = A.AddressID
JOIN Person.BusinessEntityAddress AS B ON A.AddressID = B.AddressID