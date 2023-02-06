/*В попередньому уроці створено три таблиці та поля з первинними ключами, які і є кластеризованими індексами*/
CREATE DATABASE MyJoinsDB;

USE MyJoinsDB;

CREATE TABLE Employees
  (Empl_ID int NOT NULL,
   FName nvarchar(15) NOT NULL,
   LName nvarchar(15) NOT NULL,
   phone  nvarchar(15) NOT NULL
   );
   
CREATE TABLE Positions
  (Empl_ID int NOT NULL ,   
   salary int NOT NULL,
   title varchar(60) NOT NULL
   );
   
CREATE TABLE Personal
  (Empl_ID int NOT NULL,
  Fam_status varchar(25) NOT NULL,
  Bthday date NOT NULL,
  Address nvarchar(45) NOT NULL
  );
  
  ALTER TABLE Employees
  ADD CONSTRAINT Employe_ID PRIMARY KEY (Empl_ID);
  
   ALTER TABLE Positions
  ADD CONSTRAINT Posit_ID PRIMARY KEY (Empl_ID);
  
   ALTER TABLE Personal
  ADD CONSTRAINT Pers_ID PRIMARY KEY (Empl_ID);
  
INSERT Employees
(Empl_ID, FName, LName, phone )
VALUES
(1, 'Петро', 'Петренко','0931112233'),
(2, 'Самійло', 'Дереча', '0965478956'),
(3, 'Марічка', 'Плис', '0963332211'),
(4, 'Ганна', 'Щеглова', '0936988774'),
(5, 'Вікентій', 'Рудик', '0981225265');

INSERT Positions 
(Empl_ID,  title, salary)
VALUES
(1, 'Директор', 50000),
(2, 'Менеджер', 30000 ),
(3, 'Менеджер', 28000),
(4, 'Робочий 1', 10000),
(5, 'Робочий 2', 10000);

INSERT Personal
(Empl_ID, Fam_status, Bthday, Address)
VALUES
(1, 'в шлюбі', '1976-10-01', 'вул. Молодіжна, 3'),
(2, 'в шлюбі', '1986-11-21', 'вул. Квітнева, 5, кв. 2'),
(3, 'не в шлюбі', '1989-02-28', 'вул. Сонячна, 45, кв. 34'),
(4, 'в шлюбі', '1992-12-14', 'вул. Лісова, 7'),
(5, 'в шлюбі', '1989-02-23', 'вул. Героїв Небесної сотні, 124, кв. 77');

select * from Employees;
select * from Positions;
select * from Personal;

-- Завдання 3
/*	індекси створюються залежно від потреб та умов пошуку в БД
	Для прикладу створимо індекс в таблиці Positions для поля title для пошуку співробітників за посадою таalter
	в  таблиці Personal для поля Fam_status для пошуку співробітників, які не в шлюбі*/
    
-- пошук за посадою без індекса
SELECT * FROM Positions
WHERE title = 'Менеджер';

EXPLAIN SELECT * FROM Positions
WHERE title = 'Менеджер';
-- пошук за посадою з індексом
CREATE INDEX index_title
ON Positions (title);

SELECT * FROM Positions
WHERE title = 'Менеджер';

EXPLAIN SELECT * FROM Positions
WHERE title = 'Менеджер';

-- пошук співробітника не в шлюбі без індекса
SELECT Employees.LName, Employees.FName, Personal.Fam_status
FROM Employees
INNER JOIN Personal
ON Employees.Empl_ID = Personal.Empl_ID
WHERE Personal.Fam_status = 'не в шлюбі';

EXPLAIN SELECT Employees.LName, Employees.FName, Personal.Fam_status
FROM Employees
INNER JOIN Personal
ON Employees.Empl_ID = Personal.Empl_ID
WHERE Personal.Fam_status = 'не в шлюбі';

-- пошук співробітника не в шлюбі без індекса
CREATE INDEX index_status
ON Personal (Fam_status);

SELECT Employees.LName, Employees.FName, Personal.Fam_status
FROM Employees
INNER JOIN Personal
ON Employees.Empl_ID = Personal.Empl_ID
WHERE Personal.Fam_status = 'не в шлюбі';

EXPLAIN SELECT Employees.LName, Employees.FName, Personal.Fam_status
FROM Employees
INNER JOIN Personal
ON Employees.Empl_ID = Personal.Empl_ID
WHERE Personal.Fam_status = 'не в шлюбі';

-- Завдання 4
-- представлення для пошуку контактних даних співробітників (телефон, адреса)
CREATE VIEW contacts
AS SELECT Employees.Empl_ID, Employees.phone, Personal.Address
FROM Employees
INNER JOIN Personal
ON Employees.Empl_ID = Personal.Empl_ID;

SELECT * FROM contacts;

-- предсвлення для пошуку телефонів та дати народження співробітників, які не в шлюб
CREATE VIEW fam_status
AS SELECT Employees.Empl_ID, Employees.phone, Personal.Bthday
FROM Employees
INNER JOIN Personal
ON Employees.Empl_ID = Personal.Empl_ID
WHERE Personal.Fam_status = 'не в шлюбі';

SELECT * FROM fam_status;

-- предсвлення для пошуку телефонів та дати народження співробітників на посаді "Менеджер"
CREATE VIEW title_manager
AS SELECT Employees.Empl_ID, Employees.phone, Personal.Bthday
FROM Employees
INNER JOIN Personal
ON Employees.Empl_ID = Personal.Empl_ID
INNER JOIN Positions
ON Personal.Empl_ID = Positions.Empl_ID
WHERE Positions.title = 'Менеджер';

SELECT * FROM title_manager;