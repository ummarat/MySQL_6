-- Завдання 6
use shopdb;

DROP TABLE Customers;

CREATE TABLE Customers
(
CustumerNo int,
FName varchar(15) NOT NULL,
LName varchar(15) NOT NULL,
MName varchar(15) NOT NULL,
Adrress varchar(50) NOT NULL,
City char(10) NOT NULL,
Phone char(12) NOT NULL,
DateInSystem date NOT NULL 
);

INSERT INTO Customers
(CustumerNo, FName, LName, MName, Adrress, City, Phone, DateInSystem)
VALUES
(1,'Анатолій', 'Петрик', 'Миколайович', 'Лугова, 23', 'Київ', '(063)1112233', '2008-12-05'),
(2,'Петро', 'Мельник', 'Васильович', 'Квіткова, 5', 'Миколаїв', '(093)5556688', '2010-11-25'),
(3,'Оксана', 'Боженко', 'Сергіївна', 'Сонячна, 67', 'Київ', '(066)6669988', '2003-08-09'),
(4,'Вікторія', 'Низенко', 'Микитівна', 'Снігова, 8', 'Херсон', '(093)3336688', '2009-11-30');

SELECT * FROM Customers;
EXPLAIN SELECT * FROM Customers
WHERE CustumerNo = 3;

ALTER TABLE Customers
ADD CONSTRAINT PRIMARY KEY (CustumerNo);

EXPLAIN SELECT * FROM Customers
WHERE CustumerNo = 3;

-- додаємо індекси для аналізу
CREATE INDEX city
ON Customers (City);

EXPLAIN SELECT * FROM Customers
WHERE City = 'Київ';

CREATE INDEX phon
ON Customers (Phone);

EXPLAIN SELECT * FROM Customers
WHERE Phone = '(066)6669988';

