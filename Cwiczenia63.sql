-- AdventureWorks2016

WITH Pracownicy AS (
SELECT P.FirstName + ' ' + P.LastName AS Name, E.BirthDate
FROM HumanResources.Employee AS E
JOIN Person.Person AS P
ON E.BusinessEntityID = P.BusinessEntityID
)

SELECT *
FROM Pracownicy AS P1
JOIN Pracownicy AS P2 
ON P1.BirthDate = P2.BirthDate
WHERE P1.Name <> P2.Name


--------------------------------------
declare @stanowisko varchar(30)
set @stanowisko = 'Tool designer';

SELECT BusinessEntityID
FROM HumanResources.Employee
WHERE JobTitle = @stanowisko


--------------------------------------
create function WszyscyZDepartamentu
(@departament as varchar(255)) RETURNS VARCHAR(255)
AS

BEGIN

declare @nazwisko as varchar(255) = ' ';
SELECT @nazwisko = @nazwisko + LastName + ' , '
FROM HumanResources.vEmployeeDepartment
WHERE Department = @departament;

RETURN LEFT(@nazwisko, len(@nazwisko) -1)

end

SELECT DISTINCT dbo.WszyscyZDepartamentu (Department) AS 'Koledzy i kolezanki z dzia³u'
FROM HumanResources.vEmployeeDepartment;

drop function  WszyscyZDepartamentu