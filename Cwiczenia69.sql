-- RANK, DENSE RANK, ROW_NUMBER, NTILE

SELECT BusinessEntityID, VacationHours, RANK() OVER (ORDER BY Vacationhours desc) AS " Ranking godzin"
FROM HumanResources.Employee

SELECT BusinessEntityID, VacationHours, DENSE_RANK() OVER (ORDER BY Vacationhours desc) AS " Ranking godzin"
FROM HumanResources.Employee

SELECT BusinessEntityID, VacationHours, ROW_NUMBER() OVER (ORDER BY Vacationhours desc) AS " Ranking godzin"
FROM HumanResources.Employee

SELECT BusinessEntityID, VacationHours, NTILE(4) OVER (ORDER BY Vacationhours desc) AS " Ranking godzin"
FROM HumanResources.Employee


-------

SELECT BusinessEntityID, HireDate, DENSE_RANK() OVER (ORDER BY Hiredate ASC) AS " Ranking"
FROM HumanResources.Employee

SELECT BusinessEntityID, JobTitle, DENSE_RANK() OVER (ORDER BY JobTitle ASC) AS " Ranking"
FROM HumanResources.Employee

SELECT BusinessEntityID, HireDate, Gender, MaritalStatus,  DENSE_RANK() OVER (PARTITION BY Gender, MaritalStatus ORDER BY Hiredate ASC) AS " Ranking godzin"
FROM HumanResources.Employee
