/*This is a Script that contains the answers of Assignment 2*/
/*
Please fill in the following Information:
*/
Prompt Student ID: 101212783   
Prompt Student Name: Aldalton Choo Chien Khin
Prompt Lab Session: Thursday


-- Before Adding your answers, make sure that you have:
-- Changed All Tables names in the file (AAB_ASSIGNMENT2_DATA.SQL) by adding the last 4 digits of your ID to each table name
-- 

Prompt -- PART 1 -- -- 

Prompt 1.	Write the SQL statement that will find out if there are any products that have never been ordered
-- add your answer below:
select p.productname
from order_details2783 od
inner join orders2783 o
on od.orderid = o.orderid
right outer join products2783 p
on od.productid = p.productid
where customerid is null;


Prompt 2.	Write the SQL statement that will find out which products have been ordered but never shipped out.
-- add your answer below:
select od.orderid as "Order ID", o.orderdate as "Order Date",p.productname as "Ordered Products"
from order_details2783 od
inner join orders2783 o
on od.orderid = o.orderid
inner join products2783 p
on od.productid = p.productid
where o.shippeddate is null
order by od.orderid asc;


Prompt 3.	Write the SQL statement that would answer the following question:
--“How many orders have been recorded by each country?”
-- add your answer below:
select o.shipcountry as "Country" , count(o.orderid) as "Number of recorded Orders"
from orders2783 o
group by o.shipcountry
order by "Number of recorded Orders" desc;



Prompt 4.	Modify your SQL in question 3 so that the result will also display the number of shipped orders as well. The result must be sorted as above.
-- add your answer below:
select o.shipcountry as "Country" , count(o.orderid) as "Number of recorded Orders", count(o.shippeddate) as " Number of Shipped Orders"
from orders2783 o
group by o.shipcountry
order by "Number of recorded Orders" desc;


Prompt 5.	Modify your answer in question 4 so that the result will show either of the following (for each country):
-- add your answer below:
select o.shipcountry as "Country" , count(o.orderid) as "Number of recorded Orders", count(o.shippeddate) as " Number of Shipped Orders",
case 
    when count(o.shippeddate) != count(o.orderid) then 'Not all Orders have been shipped'
    else 'All orders have been shipped'
    end as Status
from orders2783 o
group by o.shipcountry
order by "Number of recorded Orders" desc;


Prompt 6.	Write a SQL statement that will answer the following question:
--“What is the total sales per product?”
-- add your answer below:
select p.productname, sum(od.quantity * od.unitprice * (1-od.discount)) as "Total Sales"
from order_details2783 od
inner join products2783 p
on od.productid = p.productid
group by p.productname
order by "Total Sales" desc;


Prompt 7.	Write the necessary SQL statements to display the product category name of the highest total sales.
-- add your answer below:
select categoryname as "Product Category Name with Higest Total Sales"
from(
select c.categoryname, sum(od.quantity * od.unitprice * (1-od.discount)) as "Total Sales"
from products2783 p
inner join order_details2783 od
on od.productid = p.productid
inner join categories2783 c
on p.categoryid = c.categoryid
group by c.categoryname
order by "Total Sales" desc)
where rownum =1;



Prompt 8.	In a single SQL statement, display the following information about customers and suppliers
-- add your answer below:
select s.companyname, s.city, s.country,s.contacttitle ||' - '|| s.contactname as "Contact Person", 'Suppliers' as "User Type"
from suppliers2783 s
union
select c.companyname, c.city, c.country,c.contacttitle ||' - '|| c.contactname as "Contact Person", 'Customers' as "User Type"
from customers2783 c
order by country,"User Type" asc;


Prompt 9.	In a single SQL statement display employees’ names and their manager’s names.
-- add your answer below:
select e.titleofcourtesy ||' '|| e.firstname ||' '|| e.lastname as "Manager Name",emp.titleofcourtesy ||' '|| emp.firstname ||' '|| emp.lastname as "Employee Name"
from employees2783 e
inner join employees2783 emp
on e.employeeid = emp.reportsto
order by e.titleofcourtesy asc;


Prompt 10.	Write the SQL statement that will show invoices for all orders
-- add your answer below:
select o.shipname as "Ship Name", o.shipaddress ||','|| o.shipcity ||','|| o.shippostalcode ||','|| o.shipcountry as "Ship Address", o.customerid as "customer ID", c.contactname as "Customer Name", c.address ||','|| c.city ||','|| c.postalcode ||','|| c.country as "Customer Address",emp.titleofcourtesy ||' '|| emp.firstname ||' '|| emp.lastname as "Employee Name",o.orderid as "Order ID", o.orderdate as "Order Date", o.requireddate as "Require Date", o.shippeddate as "Shipped Date", sp.companyname as "Shipper Name",od.productid as "Product ID", p.productname as "Product Name",od.unitprice as "Unit Price",od.quantity as "Quantity",od.discount*100 || '%' as "Discount",
od.unitprice * od.quantity*(1-od.discount) as "Total Price", o.freight as "Freight"
from orders2783 o
inner join customers2783 c
on o.customerid = c.customerid
inner join employees2783 emp
on o.employeeid = emp.employeeid
inner join shippers2783 sp
on o.shipvia = sp.shipperid
inner join order_details2783 od
on o.orderid = od.orderid
inner join products2783 p
on od.productid = p.productid;


Prompt 11.	Write SQL statements for the following:
--a.	An insert statement that would produce an integrity constraint violation (parent key not found)
-- add your answer below:
insert into order_details2783 values (12629, 169, 69,69,0);


--b.	A delete statement that would produce an integrity constraint violation (child record found)
-- add your answer below:
delete from products2783 where productid = 11;




Prompt -- END OF PART I --

Prompt -- PART II --
Prompt 12.	Create all the tables in figure 2 based on the tables in figure 1 without adding the data
--a.	You should drop all the tables first
-- add your answer below:
DROP TABLE DW_ORDERS2783 CASCADE CONSTRAINTS;
DROP TABLE DW_PRODUCTS2783 CASCADE CONSTRAINTS;
DROP TABLE DW_DATE2783 CASCADE CONSTRAINTS;
DROP TABLE DW_CUSTOMERS2783 CASCADE CONSTRAINTS;
DROP TABLE DW_EMPLOYEES2783 CASCADE CONSTRAINTS;


--b.	Create all the tables using CREATE TABLE…AS SELECT
-- add your answer below:
create table DW_CUSTOMERS2783
as select * from (customers2783)
where 1=0;

create table DW_EMPLOYEES2783
as select * from (employees2783)
where 1=0;

create table DW_PRODUCTS2783
as select * from (select distinct p.productid,p.productname,s.supplierid,s.companyname,c.categoryid,c.categoryname,p.quantityperunit,p.unitprice,p.unitsinstock,p.unitsonorder,p.reorderlevel,p.discontinued
from products2783 p
inner join suppliers2783 s
on p.supplierid = s.supplierid
inner join categories2783 c
on p.categoryid = c.categoryid)
where 1=0;

create table DW_ORDERS2783
as select * from(select distinct o.customerid, o.employeeid, od.productid, o.orderdate, od.orderid,o.requireddate,o.shippeddate,o.shipvia,o.freight,od.unitprice,od.quantity,od.discount
from orders2783 o
join
order_details2783 od
on o.orderid = od.orderid)
where 1=0;

-----------------------------------------------------------------------------------------------------------------------------
-- TABLE DW_DATE
DROP TABLE DW_DATE2783 cascade constraints;
CREATE TABLE DW_DATE2783 AS
    SELECT
       TO_DATE('31/12/2014','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day') AS Full_Date,
       TO_CHAR(TO_DATE('31/12/2014','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'YYYY') AS YEAR,
       TO_CHAR(TO_DATE('31/12/2014','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'Q') AS QUARTER,
       TO_CHAR(TO_DATE('31/12/2014','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'Month') AS Month,
       TO_CHAR(TO_DATE('31/12/2014','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'WW') AS Week, 
       TO_CHAR(TO_DATE('31/12/2014','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DD') AS Day      
      
   FROM (
   SELECT LEVEL n
   FROM dual
   CONNECT BY LEVEL <= 2000
   );
ALTER TABLE DW_DATE2783
ADD primary key (Full_date);
----------------------------------------------------------------------------------------------------------------------------
Prompt 13.	Modify the structure of the tables in question 12 to match the design given in figure 2.
--a.	Remove columns
-- add your answer below:
/* alter dw_customers2783 table*/
alter table dw_customers2783
drop column contactname;
alter table dw_customers2783
drop column contacttitle;
alter table dw_customers2783
drop column phone;
alter table dw_customers2783
drop column fax;
alter table dw_customers2783

/* alter dw_employees2783 table*/
alter table dw_employees2783
drop column title;
alter table dw_employees2783
drop column titleofcourtesy;
alter table dw_employees2783
drop column birthdate;
alter table dw_employees2783
drop column hiredate;
alter table dw_employees2783
drop column homephone;
alter table dw_employees2783
drop column extension;

/* alter DW_ORDERS2783 */
alter table dw_orders2783
drop column OID;
 

--b.	Add columns
-- add your answer below:
/* alter DW_ORDERS2783 */
alter table dw_orders2783  
add OID number (10) not null;

--c.	Add Primary key constraints
-- add your answer below:
/* alter dw_customers2783 table*/
alter table dw_customers2783
add constraint PK_DW_CUSTOMERS2783
primary key (customerid);

/* alter dw_employees2783 table*/
alter table dw_employees2783
add constraint PK_DW_EMPLOYEES2783
primary key (employeeid);

/* alter DW_PRODUCTS2783 */
alter table dw_products2783
add constraint PK_DW_PRODUCTS2783
primary key (productid);

/* alter DW_ORDERS2783 */
alter table dw_orders2783 
add constraint PK_DW_ORDERS2783
primary key (OID);


--d.	Add Foreign key constraints
-- add your answer below:
/* alter DW_ORDERS2783 */

alter table dw_orders2783
add constraint FK_DW_ORDERS2783_CUSTOMERID
foreign key(customerid) references dw_customers2783(customerid);

alter table dw_orders2783
add constraint FK_DW_ORDERS2783_EMPLOYEEID
foreign key(employeeid) references dw_employees2783(employeeid);

alter table dw_orders2783
add constraint FK_DW_ORDERS2783_PRODUCTID
foreign key(productid) references dw_products2783(productid);

alter table dw_orders2783
add constraint FK_DW_ORDERS2783_ORDERDATE
foreign key(orderdate) references dw_date2783(full_date);


Prompt 14.	Using INSERT…SELECT, populate the dimension tables from the source tables.
-- add your answer below:
/* insert into dw_customers2783 table*/
insert into DW_CUSTOMERS2783
select  c.customerid, c.companyname, c.address, c.city, c.region, c.postalcode, c.country
from customers2783 c;

/* insert into dw_employees2783 table*/
insert into dw_employees2783
select emp.employeeid, emp.lastname, emp.firstname, emp.address, emp.city, emp.region, emp.postalcode, emp.country, emp.reportsto
from employees2783 emp;

/* insert into dw_products2783 table*/
insert into dw_products2783
select p.productid,p.productname,s.supplierid,s.companyname,c.categoryid,c.categoryname,p.quantityperunit,p.unitprice,p.unitsinstock,p.unitsonorder,p.reorderlevel,p.discontinued
from products2783 p
inner join suppliers2783 s
on p.supplierid = s.supplierid
inner join categories2783 c
on p.categoryid = c.categoryid;


Prompt 15.	Using INSERT…SELECT, populate the fact table with the data from the source table(s) 
-- add your answer below:
drop sequence oid_sequence;

create sequence oid_sequence
minvalue 0
start with 1
increment by 1;

/* insert into dw_orders2783*/
insert into dw_orders2783
select o.customerid, o.employeeid, od.productid, o.orderdate, od.orderid,o.requireddate,o.shippeddate,o.shipvia,o.freight,od.unitprice,od.quantity,od.discount,oid_sequence.nextval
from orders2783 o
inner join order_details2783 od
on o.orderid = od.orderid
where o.shippeddate is not null;

Prompt 16.	Write the SQL statement that would Find the total revenues in the first quarter of the years 2015 and 2016 
-- add your answer below:
select dwd.year, sum(dwo.quantity * dwo.unitprice * (1-dwo.discount)) as "Total Revenues", dwd.quarter
from dw_orders2783 dwo
right outer join dw_date2783 dwd
on dwo.orderdate = dwd.full_date
where dwd.quarter = 1 and (dwd.year = 2015 or dwd.year = 2016)
group by (dwd.year,dwd.quarter);


Prompt 17.	Write the SQL statement that would find the total purchases made by country and customers within each country. 
-- add your answer below:
select dwc.companyname as "Company Name",dwc.country,round(sum(dwo.quantity * dwo.unitprice * (1-dwo.discount)),0) as "Total Purchase"
from dw_orders2783 dwo
inner join dw_customers2783 dwc
on dwo.customerid = dwc.customerid
group by (dwc.companyname,dwc.country)
order by dwc.country asc,"Total Purchase" desc;


Prompt 18.	Modify your answer in question 17 so that the result will show total purchases by quarter in the year 2017
-- add your answer below:
select dwc.companyname as "Company Name",dwc.country,round(sum(dwo.quantity * dwo.unitprice * (1-dwo.discount)),0) as "Total Purchase",dwd.quarter
from dw_orders2783 dwo
inner join dw_customers2783 dwc
on dwo.customerid = dwc.customerid
inner join dw_date2783 dwd
on dwo.orderdate = dwd.full_date
where year = 2017
having sum(dwo.quantity * dwo.unitprice * (1-dwo.discount)) > 10000
group by (dwc.companyname,dwc.country,dwd.quarter)
order by dwd.quarter asc,"Total Purchase" desc;


Prompt 19.	Write the SQL statement that would show the rank of products by their total sales
-- add your answer below:
select dwp.productname as "Product name",round(sum(dwo.quantity * dwo.unitprice * (1-dwo.discount)),0) as "Total Sales", rank() over(order by(sum(dwo.quantity * dwo.unitprice * (1-dwo.discount)))desc) as "Ranking by Sales"
from dw_orders2783 dwo
inner join dw_products2783 dwp
on dwo.productid = dwp.productid
group by (dwp.productname);



Prompt 20.	Write two SQL statements to show A rollup operation
-- add your answer below:
select dwc.companyname as "Company Name",dwc.country,round(sum(dwo.quantity * dwo.unitprice * (1-dwo.discount)),0) as "Total Purchase"
from dw_orders2783 dwo
inner join dw_customers2783 dwc
on dwo.customerid = dwc.customerid
group by rollup(dwc.companyname,dwc.country);



Prompt 20.	Write two SQL statements to show A cube operation
-- add your answer below:
select dwc.companyname as "Company Name",dwc.country,round(sum(dwo.quantity * dwo.unitprice * (1-dwo.discount)),0) as "Total Purchase"
from dw_orders2783 dwo
inner join dw_customers2783 dwc
on dwo.customerid = dwc.customerid
group by cube(dwc.companyname,dwc.country);
