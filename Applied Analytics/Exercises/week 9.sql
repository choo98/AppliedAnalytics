DROP TABLE CUSTOMER_X;
DROP TABLE CUSTOMER_Y;
DROP TABLE DW_CUSTOMER;
DROP TABLE ERROR_EVENT;
-- 1 create customer tables:

CREATE TABLE CUSTOMER_X(
Customer_id number primary key,
Customer_name varchar2(30),
Gender varchar2(1)
);

CREATE TABLE CUSTOMER_Y(
Customer_id number primary key,
Customer_name varchar2(30),
Gender varchar2(1)
);

-- 1 insert to customer_x

INSERT INTO CUSTOMER_X VALUES(1122, 'Joyce', 'F');
INSERT INTO CUSTOMER_X VALUES(1134, 'Haze', 'M');
INSERT INTO CUSTOMER_X VALUES(1135, 'Kelly', 'F');
select * from customer_x;
-- 1 insert to customer_y

INSERT INTO CUSTOMER_Y VALUES(2125, 'Joyce', 'F');
INSERT INTO CUSTOMER_Y VALUES(2128, 'Henry', 'M');
INSERT INTO CUSTOMER_Y VALUES(2169, 'Catherine', 'F');
INSERT INTO CUSTOMER_Y VALUES(2175, 'Kelly', 'F');
INSERT INTO CUSTOMER_Y VALUES(2185, 'Peace', 'M');
select * from customer_y;

-- 2  insert into customer_x with null gender
insert into customer_x values(1125, 'Kemp',null);

-- 3  CREATE A DATA WAREHOUSE CALLED DW_CUSTOMER AS CUSTOMER_X 
drop table DW_CUSTOMER cascade constraints;

create table DW_CUSTOMER
as SELECT * from CUSTOMER_X where 1=0;

select * from DW_CUSTOMER;

-- 4 CREATE ERROR_EVENT TABLE
CREATE table ERROR_EVENT(
ROW_ID ROWID,
TABLE_NAME VARCHAR2 (25),
FILTER_ID NUMBER,
DATE_TIME DATE,
ACTION VARCHAR2(10) CHECK (ACTION IN ('SKIP','MODIFY'))
);

insert into error_event
select rowid, 'CUSTOMER_X', 1, sysdate, 'SKIP'
from customer_x x
where x.gender is null;

insert into dw_customer
select x.customer_id, x.customer_name, x.gender
from customer_x x
where x.rowid not in (select row_id from error_event);

select * from dw_customer;

insert into error_event 
select y.rowid, 'CUSOMTER_Y', 2, sysdate, 'SKIP'
from customer_y y, dw_customer d
where y.customer_name = d.customer_name;

insert into dw_customer
select y.customer_id, y.customer_name, y.gender
from customer_y y
where y.rowid not in (select row_id from error_event);

select * from dw_customer;


