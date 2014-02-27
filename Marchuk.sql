CREATE DATABASE TestDb
ON PRIMARY (NAME=TestDb, FILENAME='c:\db\TestDb.mdf', SIZE=100MB, MAXSIZE=UNLIMITED ,FILEGROWTH=20)
LOG ON
(NAME=Testdblog, FILENAME='c:\db\TestDblog.ldf', SIZE=100MB, MAXSIZE=UNLIMITED, FILEGROWTH=20);


CREATE TABLE  Student
(
Nzalik VARCHAR (8)
CONSTRAINT StudentPrimary PRIMARY KEY,
PIB VARCHAR (15)
CONSTRAINT StudtntPIBUnique UNIQUE,
StName VARCHAR (50),
IDGroup VARCHAR (6),
SPasport VARCHAR(2),
NPasport varchar(6),
DataPasport Date,
NameDeptPasport VARCHAR(50),
CONSTRAINT StudentPasportUnique  UNIQUE (SPasport, NPasport, DataPasport, NameDeptPasport)
);

CREATE TABLE Subject
(IDSubject INT IDENTITY
CONSTRAINT SubjectPrimary PRIMARY KEY,
NameSubject VARCHAR(35) NOT NULL
CONSTRAINT SubjectNameSubjectUnique UNIQUE);

CREATE TABLE  Progress
(NZalik VARCHAR(8)
CONSTRAINT ProgressStudentForeign FOREIGN KEY
REFERENCES Student,
 IDSubject INT,
NTerm VARCHAR(2),
Mark SMALLINT
CONSTRAINT ProgressMarkCheck CHECK(Mark BETWEEN 2 and 5),
CONSTRAINT ProgressPrimary PRIMARY KEY (NZalik, IDSubject, NTerm),
CONSTRAINT ProgressSubjectForeign FOREIGN KEY (IDSubject)
REFERENCES Subject ON DELETE CASCADE);

--Заповнення цих таблиць
INSERT INTO Student (NZalik, PIB, StName, IDGroup, SPasport, NPasport, DataPasport, NameDeptPasport)
VALUES('12345677', 'Ivanov I I', 'Ivan', 'FI-11', 'AA', '223344', '2007-05-08', 'Kiev RVUMVS');

INSERT INTO Student (NZalik, PIB, StName, IDGroup, SPasport, NPasport, DataPasport, NameDeptPasport)
VALUES('18493046', 'Tarak S P', 'Stanislav', 'Fb-91', 'VN', '874913', '2009-12-01', 'Kiev RVUMVS');

INSERT INTO Student (NZalik, PIB, StName, IDGroup, SPasport, NPasport, DataPasport, NameDeptPasport)
VALUES('18494522', 'Антонець О О', 'Олена', 'Фі-91', 'МК', '536782', '2008-06-12', 'Київ');

INSERT INTO Subject (NameSubject)
VALUES('Dilova mova');

INSERT INTO Subject (NameSubject)
VALUES('MATAN');

INSERT INTO Subject (NameSubject)
VALUES('Difury');

INSERT INTO Subject (NameSubject)
VALUES('QA&qc');

INSERT INTO Progress (NZalik, IDSubject, NTerm, Mark)
VALUES('12345677', 1, '2', '4');

INSERT INTO Progress (NZalik, IDSubject, NTerm, Mark)
VALUES('12345677', 2, '2', '4');

INSERT INTO Progress (NZalik, IDSubject, NTerm, Mark)
VALUES('18494522', 1, '1', '2');

INSERT INTO Progress (NZalik, IDSubject, NTerm, Mark)
VALUES('18494522', 2, '1', '2');

INSERT INTO Progress (NZalik, IDSubject, NTerm, Mark)
VALUES('18494522', 3, '1', '2');

INSERT INTO Progress (NZalik, IDSubject, NTerm, Mark)
VALUES('18494522', 4, '1', '2');

--Запити:
--Вибір з однієї таблиці
SELECT * FROM Progress;

SELECT PIB [ПІБ] 
FROM Student;

--Вибір з декількох таблиць
SELECT NZalik [Номер заліковки], IDSubject, NTerm [номер семестру], Mark [оцінка]
FROM Progress
JOIN Student ON Student.NZalik=Progress.NZalik
JOIN Subject ON Subject.IDSubject=Progress.IDSubject;

SELECT NZalik [номер заліковки], Student.PIB [ПІБ], Progress.Mark [Оцінка]
FROM Student, Progress
WHERE Student.NZalik=Progress.NZalik
AND Mark BETWEEN 4 and 5;

--Лічильник рядків для будь-якої таблиці
SELECT COUNT (*)
FROM Subject;

