DROP TABLE Booking CASCADE CONSTRAINTS;
DROP TABLE Room CASCADE CONSTRAINTS;
DROP TABLE Guest CASCADE CONSTRAINTS;
DROP TABLE Hotel CASCADE CONSTRAINTS;

create table Hotel (
HOTELNO varchar2 (10),
HOTELNAME varchar2 (30),
CITY varchar2 (30),
PRIMARY KEY (HOTELNO)
);

create table Room (
ROOMNO number (10),
HOTELNO varchar2 (10),
TYPE varchar2 (20),
PRICE number (10,2),
PRIMARY KEY (ROOMNO, HOTELNO),
FOREIGN KEY (HOTELNO) REFERENCES Hotel
);

create table Guest (
GUESTNO number (10),
GUESTNAME varchar2 (50),
ADDRESS varchar2 (50),
PRIMARY KEY (GUESTNO)
);

create table Booking (
HOTELNO varchar2 (10),
GUESTNO number (10),
CHECKINDATE DATE,
CHECKOUTDATE DATE,
ROOMNO number(10),
PRIMARY KEY (HOTELNO,GUESTNO,CHECKINDATE),
FOREIGN KEY (ROOMNO, HOTELNO) REFERENCES Room,
FOREIGN KEY (GUESTNO) REFERENCES Guest
);

INSERT INTO Hotel (HOTELNO, HOTELNAME, CITY)
VALUES
('fb01','Grosvenor','London');

INSERT INTO Hotel (HOTELNO, HOTELNAME, CITY)
VALUES
('fb02','Watergate','Paris');

INSERT INTO Hotel (HOTELNO, HOTELNAME, CITY)
VALUES
('ch01','Omni Shoreham','London');

INSERT INTO Hotel (HOTELNO, HOTELNAME, CITY)
VALUES
('ch02','Phoenix Park','London');

INSERT INTO Hotel (HOTELNO, HOTELNAME, CITY)
VALUES
('dc01','Latham','Berlin');

Insert into Room
values(501, 'fb01', 'single', 19);

Insert into Room
values(601, 'fb01', 'double', 29);

Insert into Room
values(701, 'fb01', 'family', 39);

Insert into Room
values(1001, 'fb02', 'single', 58);

Insert into Room
values(1101, 'fb02', 'double', 86);

Insert into Room
values(1001, 'ch01', 'single', 29.99);

Insert into Room
values(1101, 'ch01', 'family', 59.99);

Insert into Room
values(701, 'ch02', 'single', 10);

Insert into Room
values(801, 'ch02', 'double', 15);

Insert into Room
values(901, 'dc01', 'single', 18);

Insert into Room
values(1001, 'dc01', 'double', 30);

Insert into Room
values(1101, 'dc01', 'family', 35);

Insert into Guest
values(10001, 'John Kay', '56 High St, London');

Insert into Guest
values(10002, 'Mike Ritchie', '18 Tain St, London');

Insert into Guest
values(10003, 'Mary Tregear', '5 Tarbot Rd, Aberdeen');

Insert into Guest
values(10004, 'Joe Keogh', '2 Fergus Dr, Aberdeen');

Insert into Guest
values(10005, 'Carol Farrel', '6 Achray St, Glasgow');

Insert into Guest
values(10006, 'Tina Murphy', '63 Well St, Glasgow');

Insert into Guest
values(10007, 'Tony Shaw', '12 Park Pl, Glasgow');

Insert into Booking
values('fb01', 10001, '1-Apr-2014', '8-Apr-2014', 501);

Insert into Booking
values('fb01', 10004, '15-Apr-2015', '16-Apr-2015', 601);

Insert into Booking
values('fb02', 10003, '13-May-2016', '15-May-2016', 1001);

Insert into Booking
values('fb02', 10005, '19-Oct-2016', '24-Oct-2016', 1101);

Insert into Booking
values('ch01', 10006, '06-Jan-2017', '', 1101);

Insert into Booking
values('ch02', 10002, '07-Feb-2016', '01-May-2016', 801);

Insert into Booking
values('dc01', 10003, '12-Mar-2017', '', 1001);

select * from hotel;

select * from hotel
where City = 'Paris' or City = 'Berlin';

select g.guestname, g.address
from Guest g
where g.address like '%Glas%'
order by 1;

select *
from Room r
where (r.type = 'double' or r.type = 'family') and r.price < 40
order by r.price asc;

select *
from booking b
where b.checkoutdate is null;

update room
set price = 45
where roomno = '1101' and hotelno = 'dc01';

update booking
set checkoutdate = '07-April-17'
where guestno = '10006';

delete from guest
where guestno = '10007';

insert into booking
values ('fb01', '10007', '10-April-17');

alter table hotel
add Website varchar2 (30);

update Hotel
set website = 'www.Grosvenor.co.uk'
where hotelno = 'fb01';

update Hotel
set website = 'www.WaterGate.fr'
where hotelno = 'fb02';

update Hotel
set website = 'www.Omni-Shoreham.co.uk'
where hotelno = 'ch01';

update Hotel
set website = 'www.PhoenixPark.co.uk'
where hotelno = 'ch02';

update Hotel
set website = 'www.Latham.de'
where hotelno = 'dc01';

select * from hotel;

select * from room r
where r.price = (select min(r.price) from room r);

select * from room r
where r.price = (select max(r.price) from room r);

select count (*) from room;

delete from hotel
where city = 'Berlin';

delete from room
where roomno = '1101' and hotelno = 'fb02';
