DROP TABLE ACTION;
DROP TABLE ALLOCATION;
DROP TABLE EMPLOYEE;
DROP TABLE ACTIVITY;

CREATE TABLE ACTIVITY(
ACTID NUMBER(4),
DESCRIPTION VARCHAR(30),
CATEGORYCODE VARCHAR(1),
PRIMARY KEY (ACTID)
);
CREATE TABLE EMPLOYEE(
EMPID NUMBER(4),
EMPNAME VARCHAR(30),
EMPGENDER VARCHAR(1),
YEARSSERVICE NUMBER(4),
STATUS VARCHAR(30),
PRIMARY KEY (EMPID)
);

CREATE TABLE ALLOCATION(
ACTID NUMBER(4) NOT NULL,
EMPID NUMBER(4) NOT NULL,
HOURLYRATE NUMBER(5,2),
CONSTRAINT PK_ALLOCATION_ACTID_EMPID PRIMARY KEY (ACTID, EMPID),
CONSTRAINT FK_ALLOCATION_ACTID FOREIGN KEY (ACTID) REFERENCES ACTIVITY,
CONSTRAINT FK_ALLOCATION_EMPID FOREIGN KEY (EMPID) REFERENCES EMPLOYEE,
CONSTRAINT CK_ALLOCATION_RATE CHECK (HOURLYRATE BETWEEN 0.00 AND 299.99)
);

CREATE TABLE ACTION(
ACTID NUMBER(4) NOT NULL,
EMPID NUMBER(4) NOT NULL,
WEEKNO NUMBER(2),
HRSWORKED NUMBER(4,1),
CONSTRAINT PK_ACTION_WEEKNO_ACTID_EMPID PRIMARY KEY (WEEKNO, ACTID, EMPID),
CONSTRAINT FK_ACTION_ACTID FOREIGN KEY (ACTID, EMPID) REFERENCES ALLOCATION (actid,empid) 
);


INSERT INTO ACTIVITY (ACTID, DESCRIPTION, CATEGORYCODE) VALUES (151, 'Web Design', 'A');
INSERT INTO ACTIVITY (ACTID, DESCRIPTION, CATEGORYCODE) VALUES (155, 'Python Coding', 'A');
INSERT INTO ACTIVITY (ACTID, DESCRIPTION, CATEGORYCODE) VALUES (163, 'Sales and Marketing', 'B');
INSERT INTO ACTIVITY (ACTID, DESCRIPTION, CATEGORYCODE) VALUES (165, 'Testing', 'C');
INSERT INTO ACTIVITY (ACTID, DESCRIPTION, CATEGORYCODE) VALUES (171, 'Documentation', 'C');
INSERT INTO ACTIVITY (ACTID, DESCRIPTION, CATEGORYCODE) VALUES (174, 'Telephone Support', 'C');




INSERT INTO EMPLOYEE (EMPID, EMPNAME, EMPGENDER, STATUS, YEARSSERVICE) VALUES (1, 'Clyde', 'M', 'International', 2);
INSERT INTO EMPLOYEE (EMPID, EMPNAME, EMPGENDER, STATUS, YEARSSERVICE) VALUES (2, 'Sally', 'F', 'Local', 9);
INSERT INTO EMPLOYEE (EMPID, EMPNAME, EMPGENDER, STATUS, YEARSSERVICE) VALUES (3, 'Imogen', 'F', 'International', 4);
INSERT INTO EMPLOYEE (EMPID, EMPNAME, EMPGENDER, STATUS, YEARSSERVICE) VALUES (4, 'James', 'M', 'Local', 3);
INSERT INTO EMPLOYEE (EMPID, EMPNAME, EMPGENDER, STATUS, YEARSSERVICE) VALUES (5, 'Tara', 'F', 'International', 6);


INSERT INTO ALLOCATION (EMPID, ACTID, HOURLYRATE) VALUES (1, 163, 45.50);
INSERT INTO ALLOCATION (EMPID, ACTID, HOURLYRATE) VALUES (2, 155, 30.00);
INSERT INTO ALLOCATION (EMPID, ACTID, HOURLYRATE) VALUES (5, 165, 30.00);
INSERT INTO ALLOCATION (EMPID, ACTID, HOURLYRATE) VALUES (3, 163, 65.00);
INSERT INTO ALLOCATION (EMPID, ACTID, HOURLYRATE) VALUES (5, 155, 27.00);
INSERT INTO ALLOCATION (EMPID, ACTID, HOURLYRATE) VALUES (5, 151, 25.00);
INSERT INTO ALLOCATION (EMPID, ACTID, HOURLYRATE) VALUES (2, 165, 25.00);
INSERT INTO ALLOCATION (EMPID, ACTID, HOURLYRATE) VALUES (1, 151, 50.75);



INSERT INTO ACTION (EMPID, ACTID, WEEKNO, HRSWORKED) VALUES (1, 163, 39, 10);
INSERT INTO ACTION (EMPID, ACTID, WEEKNO, HRSWORKED) VALUES (1, 151, 42, 5.5);
INSERT INTO ACTION (EMPID, ACTID, WEEKNO, HRSWORKED) VALUES (2, 155, 42, 10);
INSERT INTO ACTION (EMPID, ACTID, WEEKNO, HRSWORKED) VALUES (2, 165, 40, 20);
INSERT INTO ACTION (EMPID, ACTID, WEEKNO, HRSWORKED) VALUES (2, 155, 41, 10);
INSERT INTO ACTION (EMPID, ACTID, WEEKNO, HRSWORKED) VALUES (5, 155, 39, 8);
INSERT INTO ACTION (EMPID, ACTID, WEEKNO, HRSWORKED) VALUES (5, 155, 41, 5);

--Q1
SELECT *
FROM EMPLOYEE
WHERE (EMPGENDER = 'm' OR YEARSSERVICE>=3)
AND STATUS = 'INTERNATIONAL';

SELECT *
FROM EMPLOYEE
WHERE EMPGENDER = 'm' AND YEARSSERVICE>3
OR STATUS = 'INTERNATIONAL';

SELECT *
FROM EMPLOYEE
WHERE EMPGENDER = 'm' OR YEARSSERVICE>3 OR STATUS = 'INTERNATIONAL';

SELECT *
FROM EMPLOYEE
WHERE EMPGENDER = 'F' OR YEARSSERVICE>3
OR UPPER(STATUS) = 'INTERNATIONAL';

SELECT EMPNAME, DESCRIPTION
FROM EMPLOYEE E
LEFT JOIN ALLOCATION AL
ON E.EMPID = AL.EMPID
LEFT OUTER JOIN ACTIVITY AC
ON AL.ACTID = AC.ACTID
WHERE CATEGORYCODE = 'B';

--Q2
select AL.empid, AC.description, sum(AL.hourlyrate * A.hrsworked) as "Total earnings"
from allocation AL
inner join activity AC
on AL.actid = ac.actid
inner join action A
on AL.empid = A.empid
group by (al.empid, ac.description);

--Q3
select * from allocation al
where al.hourlyrate >= (select avg(hourlyrate) from allocation);

--Q4
select e.empname, al.actid, al.hourlyrate
from employee e
inner join allocation al
on e.empid = al.empid
order by 1 asc;

select e.empname, al.actid, al.hourlyrate
from employee e
left outer join allocation al
on e.empid = al.empid
order by 1 asc;

--Q5
select e.status, e.empgender, count(e.empid) as "no of employees"
from employee e
group by (e.status, e.empgender)
order by 1 asc;

--Q6
select al.empid, e.empname, a.actid, a.description, ac.weekno, ac.hrsworked
from allocation al
inner join employee e
on al.empid = e.empid
inner join activity a
on al.actid = a.actid
inner join action ac
on al.actid = ac.actid;

--Q7
select e.empname, round(avg(al.hourlyrate),1) as "Average paid hourly rate"
from employee e
left outer join allocation al
on e.empid = al.empid
group by e.empname
order by 2 asc;

--Q8
select e.empname, sum(al.hourlyrate * ac.hrsworked) as "total payment"
from employee e
left outer join allocation al
on e.empid = al.empid
left outer join action ac
on al.empid = ac.empid
group by (e.empname)
order by "total payment" asc;

--Q9
select ac.weekno, count(ac.actid),sum(ac.hrsworked)
from action ac
group by ac.weekno;

--Q10
select a.description, al.empid
from activity a
left outer join allocation al
on a.actid = al.actid
where empid is null;






