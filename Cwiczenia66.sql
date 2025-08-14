--AdventureWorks2016
-- UPDATE, DELETE

CREATE TABLE HumanResources.Dzieci
(
id int IDENTITY(1,1) PRIMARY KEY,
imie varchar(255),
wiek int,
data_urodzenia date
);

INSERT INTO HumanResources.Dzieci(imie, wiek, data_urodzenia)
VALUES ('Jan', 12, '1996-05-08');

INSERT INTO HumanResources.Dzieci(imie, wiek, data_urodzenia)
VALUES ('Tomasz', 14, '1998-03-28');

INSERT INTO HumanResources.Dzieci(imie, wiek, data_urodzenia)
VALUES ('Jagoda', 16, '2000-11-08');

INSERT INTO HumanResources.Dzieci(imie, wiek, data_urodzenia)
VALUES ('Julia', 18, '2002-10-04');

INSERT INTO HumanResources.Dzieci(imie, wiek, data_urodzenia)
VALUES ('Micha³', 18, '2002-03-06');

--DROP TABLE HumanResources.Dzieci

CREATE TABLE HumanResources.Dzieci2
(
id int IDENTITY(1,1) PRIMARY KEY,
imie varchar(255),
wiek int,
data_urodzenia date
);

INSERT INTO HumanResources.Dzieci2(imie, wiek, data_urodzenia)
VALUES ('Jacek', 12, '1996-05-08');

INSERT INTO HumanResources.Dzieci2(imie, wiek, data_urodzenia)
VALUES ('Rafa³', 14, '1998-03-28');

INSERT INTO HumanResources.Dzieci2(imie, wiek, data_urodzenia)
VALUES ('Karina', 16, '2000-11-08');

INSERT INTO HumanResources.Dzieci2(imie, wiek, data_urodzenia)
VALUES ('Julia', 18, '2002-10-04');

INSERT INTO HumanResources.Dzieci2(imie, wiek, data_urodzenia)
VALUES ('Micha³', 18, '2002-03-06');

------------------------------------------
SELECT *
FROM HumanResources.Dzieci

UPDATE HumanResources.Dzieci
SET imie = 'Natalia'
WHERE id = 3

UPDATE HumanResources.Dzieci
SET wiek = (SELECT wiek
			FROM HumanResources.Dzieci
			WHERE imie = 'Natalia')
WHERE imie = 'Julia'

UPDATE HumanResources.Dzieci
SET wiek = 18
WHERE imie = 'Julia'

DELETE FROM HumanResources.Dzieci
WHERE id = 3

----------------------------
SELECT *
FROM HumanResources.Dzieci2

DELETE FROM HumanResources.Dzieci
WHERE imie IN (SELECT imie
				FROM HumanResources.Dzieci2)
