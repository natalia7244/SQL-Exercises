
CREATE DATABASE swieczki
-- DROP DATABASE swieczki


-- Tabela HURTOWNIE przechowuje dane dostawców surowców
--DROP TABLE HURTOWNIE
CREATE TABLE HURTOWNIE (
ID INT IDENTITY(1,1) PRIMARY KEY,
NAZWA NVARCHAR(50) NOT NULL,
NIP  NVARCHAR(50) UNIQUE NOT NULL CHECK (LEN(NIP) = 10),
ADRES  NVARCHAR(300) NOT NULL,
TELEFON  NVARCHAR(20) NOT NULL,
EMAIL  NVARCHAR(250) UNIQUE NOT NULL,
STRONA_www  NVARCHAR(2083) NOT NULL
);
INSERT INTO HURTOWNIE (NAZWA, NIP, ADRES, TELEFON, EMAIL, STRONA_www)
VALUES
('ASPOL', '1234567890', 'ul. Przemys³owa 32, 05-240 T³uszcz', '+48 29 757 30 83', 'biuro@aspol.info', 'https://aspol.info'),
  ('EASYCANDLE', '8252197696', 'GRUPA EASY SP. Z O.O., ul. Polna 1A, 21-470 Krzywda, Poland', '+48 511 779 510', 'kontakt@easycandle.pl', 'https://easycandle.pl'),
  ('SISANO', '1234567891', 'ul. Czarnieckeigo 4, 05-191 Mogowo', '+48 608 868 182', 'kontakt@sisano.pl', 'https://sisano.pl'),
  ('Kraina Œwiec', '1234567892', 'ul. Trzyniecka 12, 45-361 Lublin', '+48 500 07 07 31', 'sklep@krainaswiec.pl', 'https://krainaswiec.pl'),
  ('Wosk i Knot', '1234567893', 'Gdañsk, Polska', '+ 48 111 222 333', 'kontakt@woskiknot.pl', 'https://woskiknot.pl');


  -- Tabela WARIANTY zawiera informacje o konkretnych wariantach produktu
-- DROP TABLE WARIANTY
CREATE TABLE WARIANTY (
	ID INT IDENTITY(1,1) PRIMARY KEY,
	ILOSC NVARCHAR(50) NOT NULL,
	JEDNOSTKA NVARCHAR(100)  NOT NULL
	);
INSERT INTO WARIANTY (ILOSC, JEDNOSTKA)
VALUES 
( 1, 'kg'),
(5, 'kg'),
(20, 'kg'),
(10, 'szt.'),
(100, 'szt.'),
(5000, 'szt.'),
(24, 'szt.'),
(1, 'szt'),
(15, 'szt.'),
(150, 'szt.'),
(500, 'ml'),
(1000, 'ml');


-- Tablea KATEGORIE zawiera informacje o klasyfikacji produków
-- DROP TABLE KATEGORIE
CREATE TABLE KATEGORIE (
	ID INT IDENTITY(1,1) PRIMARY KEY,
	NAZWA NVARCHAR(100) UNIQUE NOT NULL
	);
INSERT INTO KATEGORIE (NAZWA)
VALUES
('Wosk sojowy zalewane'),
('Wosk sojowy wolnostojace'),
('Olejek zapachowy wiosna'),
('Olejek zapachowy jesien'),
('Olejek zapachowy zima'),
('Olejek zapachowy lato'),
('Olejek zapachowy uniwersalny'),
('Barwnik w p³ynie'),
('Barwnik w proszku'),
('Knot bawe³niany niæ'),
('Knot bawe³niany z blaszk¹'),
('Knot drewniany'),
('Puszka'),
('Ma³e szk³o'),
('Srednie szk³o'),
('Du¿e szk³o'),
('Naklejka ostrzegawcza'),
('Naklejka informacyjna'),
('Opakowanie i dekoracja');


--Tabela PRODUKTY przechowuje dane o produktach dostêpnych w hurtowniach 
-- DROP TABLE PRODUKTY_HURT
CREATE TABLE PRODUKTY_HURT (
	ID INT IDENTITY(1,1) PRIMARY KEY,
	NAZWA NVARCHAR(250) NOT NULL,
	CENA DECIMAL(10,2) NOT NULL,
	WARIANT_ID INT,
	KATEGORIA_ID INT,
	HURTOWNIA_ID INT,
	CONSTRAINT FK_PRODUKTY_KATEGORIE FOREIGN KEY (KATEGORIA_ID) REFERENCES KATEGORIE(ID),  
    CONSTRAINT FK_PRODUKTY_HURTOWNIE FOREIGN KEY (HURTOWNIA_ID) REFERENCES HURTOWNIE(ID),  
    CONSTRAINT FK_PRODUKTY_WARIANTY FOREIGN KEY (WARIANT_ID) REFERENCES WARIANTY(ID)
	);
INSERT INTO PRODUKTY_HURT(NAZWA, KATEGORIA_ID, HURTOWNIA_ID, WARIANT_ID, CENA)
VALUES
('Kerasoy Pillar', 2, 1, 1, 30.00),
('Kerasoy Pillar', 2, 1, 2, 145.00),
('Kerasoy Pillar', 2, 1, 3, 540.00),
('Kerasoy Container', 1, 1, 1, 30.00),
('Kerasoy Container', 1, 1, 2, 145.00),
('Kerasoy Container', 1, 1, 3, 540.00),
('Kerasoy Pillar', 2, 2, 1, 31.90),
('Kerasoy Pillar', 2, 2, 2, 145.00),
('Kerasoy Pillar', 2, 2, 3, 560.00),
('Kerasoy Container', 1, 2, 1, 32.90),
('Kerasoy Container', 1, 2, 2, 160.00),
('Kerasoy Container', 1, 2, 3, 599.00),
('GoldenWax Y50', 1, 2, 1, 21.90),
('GoldenWax Y50', 1, 2, 2, 104.90),
('GoldenWax Y50', 1, 2, 3, 200.00),
('Wedo ECO 4', 11, 2, 4, 6.90),
('Wedo ECO 8', 11, 2, 4, 7.49),
('Wedo ECO 12', 11, 2, 4, 7.49),
('Wedo ECO 16', 11, 2, 4, 7.99),
('Wedo ECO 4', 11, 2, 5, 55.00),
('Wedo ECO 8', 11, 2, 5, 57.90),
('Wedo ECO 12', 11, 2, 5, 57.90),
('Wedo ECO 16', 11, 2, 5, 59.90),
('Wedo ECO 4', 11, 2, 6, 1800.00),
('Wedo ECO 8', 11, 2, 6, 1900.00),
('Wedo ECO 12', 11, 2, 6, 2000.00),
('Wedo ECO 16', 11, 2, 6, 2050.00),
('Puszka GOLD', 13, 3, 7, 70.00),
('Puszka BLACK', 13, 3, 7, 70.00),
('Puszka ROSE GOLD', 13, 3, 7, 70.00),
('Szklo 90ml', 14, 2, 8, 3.99),
('Szklo 90ml', 14, 2, 9, 44.90),
('Szklo 90ml', 14, 2, 10, 285.00),
('Lilac', 3, 1, 11, 99.99),
('Lilac', 3, 1, 12, 189.99),
('Peri Berry', 3, 1, 11, 99.99),
('Peri Berry', 3, 1, 12, 199.99);


--Tabela ZAKUPY przechowuje dane o zamówieniach z hurtownii
-- DROP TABLE ZAKUPY
CREATE TABLE ZAKUPY (
    ZAKUPY_ID INT IDENTITY(1,1) PRIMARY KEY,
    DATA_ZAMÓWIENIA DATE NOT NULL DEFAULT GETDATE(),
    DATA_REALIZACJI DATE NULL,
    HURTOWNIA_ID INT NOT NULL,
    STATUS_REALIZACJI NVARCHAR(50) NOT NULL DEFAULT 'w realizacji' 
        CHECK (STATUS_REALIZACJI IN ('w realizacji', 'zrealizowane', 'anulowane', 'w trakcie realizacji')),
    UWAGI NVARCHAR(500) NULL,
    CONSTRAINT FK_ZAKUPY_HURTOWNIE FOREIGN KEY (HURTOWNIA_ID) REFERENCES HURTOWNIE(ID)
);
INSERT INTO ZAKUPY (DATA_ZAMÓWIENIA, DATA_REALIZACJI, HURTOWNIA_ID, STATUS_REALIZACJI, UWAGI)
VALUES
('2024-11-11', '2024-11-12', 2, 'zrealizowane', 'knoty, wosk'),
('2024-12-09', '2024-12-10', 2, 'zrealizowane', 'knoty, wosk'),
('2024-12-30', '2025-01-03', 2, 'zrealizowane', 'szk³o, knoty'),
('2025-02-26', '2025-02-27', 2, 'zrealizowane', 'knoty, wosk'),
('2025-03-13', NULL, 2, 'w trakcie realizacji', 'szk³o, knoty'),
('2025-03-13', NULL, 3, 'w trakcie realizacji', 'puszki, formy');



--PRÓBY

SELECT*FROM HURTOWNIE
SELECT* FROM
KATEGORIE

SELECT * FROM PRODUKTY_HURT
SELECT * FROM WARIANTY

SELECT PH.NAZWA, K.NAZWA,  W.ILOSC, W.JEDNOSTKA, PH.CENA
FROM PRODUKTY_HURT PH
JOIN WARIANTY W ON PH.WARIANT_ID = W.ID
JOIN KATEGORIE K ON PH.KATEGORIA_ID = K.ID



--Tablela MAGAZYN, która zawiera dane o aktualnym stanie magazynu
-- Tabela SWIECE zawiera produkty poytzebne do wykonania danego rodzaju œwiecy
-- Tabela ZAMÓWIENIA zawiera informacje o zamóweniach na œwiece 
-- Tablela KLIENCI zawiera informacje o klientach zamawiaj¹cych œwiece 
-- Tabela TRANSAKCJE pozwala œledziæ transakcje finansowe