--AdventureWorks2016

CREATE TABLE HumanResources.Dzieci
(
id int,
imie varchar(255),
wiek int,
data_urodzenia date
);

SELECT *
FROM HumanResources.Dzieci

alter table HumanResources.Dzieci
ADD miasto varchar(30);


alter table HumanResources.Dzieci
alter column miasto int;


alter table HumanResources.Dzieci
DROP COLUMN miasto;

sp_rename 'HumanResources.Dzieci', 'Dzieciaki'

sp_rename 'HumanResources.Dzieciaki.wiek', 'AktualnyWiek', 'column';

SELECT *
FROM HumanResources.Dzieciaki

-------------------------------
SELECT *
FROM Person.Person

SELECT BusinessEntityID, FirstName, LastName
INTO HumanResources.Rodzice
FROM Person.Person
WHERE LastName LIKE 'S%' and BusinessEntityID BETWEEN 1 AND 290;

select *
FROM HumanResources.Rodzice


------------------
CREATE VIEW Sales.Najwiêkszych10Zamówien AS
SELECT top 10 SalesOrderID, SUM(UnitPrice) AS Suma
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
ORDER BY Suma DESC;
