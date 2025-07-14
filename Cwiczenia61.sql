--AdventureWorks2016

SELECT BusinessEntityID, VacationHours
FROM HumanResources.Employee
WHERE VacationHours > ( SELECT VacationHours
						FROM HumanResources.Employee
						WHERE BusinessEntityID = 49)
						AND
						MaritalStatus = (SELECT MaritalStatus
						FROM HumanResources.Employee
						WHERE BusinessEntityID = 49);


SELECT BusinessEntityID, VacationHours
FROM HumanResources.Employee
WHERE VacationHours = ( SELECT MIN(VacationHours)
						FROM HumanResources.Employee)
						AND
						MaritalStatus = (SELECT MaritalStatus
						FROM HumanResources.Employee
						WHERE BusinessEntityID = 49);

SELECT JobTitle, AVG(VacationHours)
FROM HumanResources.Employee
GROUP BY JobTitle
HAVING AVG(VacationHours) > (SELECT AVG(VacationHours) 
							FROM HumanResources.Employee);

SELECT *
FROM (SELECT BusinessEntityID, VacationHours
		FROM HumanResources.Employee ) AS Subqueries
WHERE BusinessEntityID BETWEEN 100 AND 150;


SELECT B.BusinessEntityID, (SELECT City
							FROM Person.Address AS A
							WHERE B.AddressID = A.AddressID) AS Miasto
FROM Person.BusinessEntityAddress  AS B;


SELECT *
FROM Person.Address AS A;