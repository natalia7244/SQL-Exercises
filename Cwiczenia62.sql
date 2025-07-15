-- ALL, ANY, IN

SELECT distinct NumberEmployees
FROM Sales.vStoreWithDemographics
WHERE YearOpened = '1990'

SELECT Name, YearOpened, NumberEmployees
FROM Sales.vStoreWithDemographics
WHERE NumberEmployees < ALL (SELECT distinct NumberEmployees
							FROM Sales.vStoreWithDemographics
							WHERE YearOpened = '1990' )
				AND YearOpened <> '1990'
ORDER BY NumberEmployees;


-------------------------------

SELECT E.OrganizationNode, D.*
FROM Production.Document as D
LEFT JOIN HumanResources.Employee AS E ON D.DocumentNode = E.OrganizationNode


SELECT *
FROM Production.Document as D
WHERE NOT EXISTS ( SELECT * 
					FROM HumanResources.Employee AS E
					WHERE D.DocumentNode = E.OrganizationNode;

---------------------------------------

SELECT *
FROM HumanResources.Employee
WHERE BusinessEntityID NOT IN ( SELECT BusinessEntityID
								FROM HumanResources.JobCandidate
								WHERE BusinessEntityID IS NOT NULL);