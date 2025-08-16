-- Tran

SELECT *
FROM HumanResources.Dzieci

BEGIN TRAN

INSERT INTO HumanResources.Dzieci
(imie, wiek, data_urodzenia)
VALUES ('Jola', 17, '1991-10-23')

SAVE TRAN a;

UPDATE HumanResources.Dzieci
SET imie = 'Natalia'
WHERE id = 1;

ROLLBACK TRAN a;

SELECT *
FROM HumanResources.Dzieci

COMMIT TRAN;