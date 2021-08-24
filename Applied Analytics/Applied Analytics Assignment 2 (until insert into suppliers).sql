/* drop tables */
DROP TABLE Order_Details2783 CASCADE CONSTRAINTS;
DROP TABLE Orders2783 CASCADE CONSTRAINTS;
DROP TABLE Products2783 CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEES2783 CASCADE CONSTRAINTS;
DROP TABLE CATEGORIES2783 CASCADE CONSTRAINTS;
DROP TABLE Customers2783 CASCADE CONSTRAINTS;
DROP TABLE Shippers2783 CASCADE CONSTRAINTS;
DROP TABLE Suppliers2783 CASCADE CONSTRAINTS;

/* create tables */
CREATE TABLE Employees2783 (
	EmployeeID number(10) NOT NULL ,
	LastName varchar2 (20) NOT NULL ,
	FirstName varchar2 (10) NOT NULL ,
	Title varchar2 (30) NULL ,
	TitleOfCourtesy varchar2 (25) NULL ,
	BirthDate date NULL, 
	HireDate date NULL ,
	Address varchar2 (60) NULL ,
	City varchar2 (30) NULL ,
	Region varchar2 (15) NULL ,
	PostalCode varchar2 (10) NULL ,
	Country varchar2 (15) NULL ,
	HomePhone varchar2 (24) NULL ,
	Extension varchar2 (4) NULL ,
	ReportsTo number NULL ,
	PRIMARY KEY(EmployeeID),
	CONSTRAINT FK_Employees_Employees FOREIGN KEY (ReportsTo) 
		REFERENCES Employees2783(EmployeeID)
);

CREATE TABLE Categories2783 (
	CategoryID number(10) NOT NULL ,
	CategoryName varchar2(15) NOT NULL ,
	Description varchar2(500) NULL,
	PRIMARY KEY(CategoryID)
	);

CREATE TABLE Customers2783 (
	CustomerID varchar2 (5) NOT NULL ,
	CompanyName varchar2 (40) NOT NULL ,
	ContactName varchar2 (30) NULL ,
	ContactTitle varchar2 (30) NULL ,
	Address varchar2 (60) NULL ,
	City varchar2 (30) NULL ,
	Region varchar2 (15) NULL ,
	PostalCode varchar2 (10) NULL ,
	Country varchar2 (15) NULL ,
	Phone varchar2 (24) NULL ,
	Fax varchar2 (24) NULL,
	PRIMARY KEY(CustomerID)
	);

CREATE TABLE Shippers2783 (
	ShipperID number(10) NOT NULL ,
	CompanyName varchar2 (40) NOT NULL ,
	Phone varchar2 (24) NULL,
	PRIMARY KEY(ShipperID)
	);


CREATE TABLE Suppliers2783 (
	SupplierID number(10) NOT NULL ,
	CompanyName varchar2 (40) NOT NULL ,
	ContactName varchar2 (30) NULL ,
	ContactTitle varchar2 (30) NULL ,
	Address varchar2 (60) NULL ,
	City varchar2 (30) NULL ,
	Region varchar2 (15) NULL ,
	PostalCode varchar2 (10) NULL ,
	Country varchar2 (15) NULL ,
	Phone varchar2 (24) NULL ,
	Fax varchar2 (24) NULL ,
	PRIMARY KEY(SupplierID)
	);


CREATE TABLE Orders2783 (
	OrderID number(10) NOT NULL ,
	CustomerID varchar2 (5) NULL ,
	EmployeeID number(10) NULL ,
	OrderDate DATE NULL ,
	RequiredDate DATE NULL ,
	ShippedDate DATE NULL ,
	ShipVia number(10) NULL ,
	Freight number(19,4) NULL,
	ShipName varchar2 (40) NULL ,
	ShipAddress varchar2 (60) NULL ,
	ShipCity varchar2 (30) NULL ,
	ShipRegion varchar2 (15) NULL ,
	ShipPostalCode varchar2 (10) NULL ,
	ShipCountry varchar2 (15) NULL,
	PRIMARY KEY(OrderID),
	CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) 
		REFERENCES Customers2783(CustomerID),
	CONSTRAINT FK_Orders_Employees FOREIGN KEY (EmployeeID) 
		REFERENCES Employees2783(EmployeeID),
	CONSTRAINT FK_Orders_Shippers FOREIGN KEY (ShipVia) 
		REFERENCES Shippers2783(ShipperID)
	);

CREATE TABLE Products2783 (
	ProductID number(10) NOT NULL,
	ProductName varchar2 (40) NOT NULL,
	SupplierID number(10) NULL,
	CategoryID number(10) NULL,
	QuantityPerUnit varchar2 (20) NULL,
	UnitPrice number(19,4) DEFAULT 0 NULL, 
	UnitsInStock number(5) DEFAULT 0 NULL,
	UnitsOnOrder number(5) DEFAULT 0 NULL,
	ReorderLevel number(5) DEFAULT 0 NULL,
	Discontinued number(3) DEFAULT 0 NOT NULL ,
	PRIMARY KEY(ProductID),
	CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID) 
		REFERENCES Categories2783(CategoryID),
	CONSTRAINT FK_Products_Suppliers FOREIGN KEY (SupplierID) 
		REFERENCES Suppliers2783(SupplierID),
	CONSTRAINT CK_Products_UnitPrice 
		CHECK (UnitPrice >= 0),
	CONSTRAINT CK_UnitsInStock 
		CHECK (UnitsInStock >= 0),
	CONSTRAINT CK_UnitsOnOrder 
		CHECK (UnitsOnOrder >= 0),
	CONSTRAINT CK_ReorderLevel 
		CHECK (ReorderLevel >= 0)
	);


CREATE TABLE Order_Details2783 (
	OrderID number(10) NOT NULL ,
	ProductID number(10) NOT NULL ,
	UnitPrice number(19,4) DEFAULT 0 NOT NULL,
	Quantity number(10) DEFAULT 1 NOT NULL,
	Discount float(23) DEFAULT 0 NOT NULL,
	CONSTRAINT PK_Order_Product PRIMARY KEY(OrderID, ProductID),
	CONSTRAINT FK_Order_Details_Orders FOREIGN KEY (OrderID) 
		REFERENCES Orders2783(OrderID),
	CONSTRAINT FK_Order_Details_Products FOREIGN KEY (ProductID) 
		REFERENCES Products2783(ProductID),
	CONSTRAINT "CK_UnitPrice" 
		CHECK (UnitPrice >= 0),
	CONSTRAINT "CK_Quantity" 
		CHECK (Quantity > 0),
	CONSTRAINT "CK_Discount" 
		CHECK (Discount >= 0 and (Discount <= 1))
	);
    
/* insert into categories */
INSERT INTO CATEGORIES2783 VALUES (1,'Beverages', 'Soft drinks, coffees, teas, beers, and ales');
INSERT INTO CATEGORIES2783 VALUES (2,'Condiments', 'Sweet and savory sauces, relishes, spreads, and seasonings');
INSERT INTO CATEGORIES2783 VALUES (3,'Confections', 'Desserts, candies, and sweet breads');
INSERT INTO CATEGORIES2783 VALUES (4,'Dairy Products', 'Cheeses');
INSERT INTO CATEGORIES2783 VALUES (5,'Grains/Cereals', 'Breads, crackers, pasta, and cereal');
INSERT INTO CATEGORIES2783 VALUES (6,'Meat/Poultry', 'Prepared meats');
INSERT INTO CATEGORIES2783 VALUES (7,'Produce', 'Dried fruit and bean curd');
INSERT INTO CATEGORIES2783 VALUES (8,'Seafood', 'Seaweed and fish');

/* insert into employees */
INSERT INTO EMPLOYEES2783 VALUES (1,'Davolio','Nancy','Sales Representative','Ms.',to_date('08-DEC-48','DD-MON-RR'),to_date('01-MAY-92','DD-MON-RR'),'507 - 20th Ave. E. Apt. 2A','Seattle','WA','98122','USA','(206) 555-9857','5467', null);
INSERT INTO EMPLOYEES2783 VALUES (2,'Fuller','Andrew','Vice President, Sales','Dr.',to_date('19-FEB-52','DD-MON-RR'),to_date('14-AUG-92','DD-MON-RR'),'908 W. Capital Way','Tacoma','WA','98401','USA','(206) 555-9482','3457', null);
INSERT INTO EMPLOYEES2783 VALUES (3,'Leverling','Janet','Sales Representative','Ms.',to_date('30-AUG-63','DD-MON-RR'),to_date('01-APR-92','DD-MON-RR'),'722 Moss Bay Blvd.','Kirkland','WA','98033','USA','(206) 555-3412','3355',2);
INSERT INTO EMPLOYEES2783 VALUES (4,'Peacock','Margaret','Sales Representative','Mrs.',to_date('19-SEP-37','DD-MON-RR'),to_date('03-MAY-93','DD-MON-RR'),'4110 Old Redmond Rd.','Redmond','WA','98052','USA','(206) 555-8122','5176',2);
INSERT INTO EMPLOYEES2783 VALUES (5,'Buchanan','Steven','Sales Manager','Mr.',to_date('04-MAR-55','DD-MON-RR'),to_date('17-OCT-93','DD-MON-RR'),'14 Garrett Hill','London',null,'SW1 8JR','UK','(71) 555-4848','3453',2);
INSERT INTO EMPLOYEES2783 VALUES (6,'Suyama','Michael','Sales Representative','Mr.',to_date('02-JUL-63','DD-MON-RR'),to_date('17-OCT-93','DD-MON-RR'),'Coventry House Miner Rd.','London',null,'EC2 7JR','UK','(71) 555-7773','428',5);
INSERT INTO EMPLOYEES2783 VALUES (7,'King','Robert','Sales Representative','Mr.',to_date('29-MAY-60','DD-MON-RR'),to_date('02-JAN-94','DD-MON-RR'),'Edgeham Hollow Winchester Way','London',null,'RG1 9SP','UK','(71) 555-5598','465',5);
INSERT INTO EMPLOYEES2783 VALUES (8,'Callahan','Laura','Inside Sales Coordinator','Ms.',to_date('09-JAN-58','DD-MON-RR'),to_date('05-MAR-94','DD-MON-RR'),'4726 - 11th Ave. N.E.','Seattle','WA','98105','USA','(206) 555-1189','2344',2);
INSERT INTO EMPLOYEES2783 VALUES (9,'Dodsworth','Anne','Sales Representative','Ms.',to_date('27-JAN-66','DD-MON-RR'),to_date('15-NOV-94','DD-MON-RR'),'7 Houndstooth Rd.','London',null,'WG2 7LT','UK','(71) 555-4444','452',5);

/* insert into Customers */
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('ALFKI','Alfreds Futterkiste','Maria Anders','Sales Representative','Obere Str. 57','Berlin',null,'12209','Germany','030-0074321','030-0076545');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('ANATR','Ana Trujillo Emparedados y helados','Ana Trujillo','Owner','Avda. de la Constitución 2222','México D.F.',null,'05021','Mexico','(5) 555-4729','(5) 555-3745');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('ANTON','Antonio Moreno Taquería','Antonio Moreno','Owner','Mataderos  2312','México D.F.',null,'05023','Mexico','(5) 555-3932',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('AROUT','Around the Horn','Thomas Hardy','Sales Representative','120 Hanover Sq.','London',null,'WA1 1DP','UK','(171) 555-7788','(171) 555-6750');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('BERGS','Berglunds snabbköp','Christina Berglund','Order Administrator','Berguvsvägen  8','Luleå',null,'S-958 22','Sweden','0921-12 34 65','0921-12 34 67');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('BLAUS','Blauer See Delikatessen','Hanna Moos','Sales Representative','Forsterstr. 57','Mannheim',null,'68306','Germany','0621-08460','0621-08924');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('BLONP','Blondesddsl père et fils','Frédérique Citeaux','Marketing Manager','24, place Kléber','Strasbourg',null,'67000','France','88.60.15.31','88.60.15.32');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('BOLID','Bólido Comidas preparadas','Martín Sommer','Owner','C/ Araquil, 67','Madrid',null,'28023','Spain','(91) 555 22 82','(91) 555 91 99');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('BONAP','Bon app''','Laurence Lebihan','Owner','12, rue des Bouchers','Marseille',null,'13008','France','91.24.45.40','91.24.45.41');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('BOTTM','Bottom-Dollar Markets','Elizabeth Lincoln','Accounting Manager','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada','(604) 555-4729','(604) 555-3745');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('BSBEV','B''s Beverages','Victoria Ashworth','Sales Representative','Fauntleroy Circus','London',null,'EC2 5NT','UK','(171) 555-1212',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('CACTU','Cactus Comidas para llevar','Patricio Simpson','Sales Agent','Cerrito 333','Buenos Aires',null,'1010','Argentina','(1) 135-5555','(1) 135-4892');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('CENTC','Centro comercial Moctezuma','Francisco Chang','Marketing Manager','Sierras de Granada 9993','México D.F.',null,'05022','Mexico','(5) 555-3392','(5) 555-7293');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('CHOPS','Chop-suey Chinese','Yang Wang','Owner','Hauptstr. 29','Bern',null,'3012','Switzerland','0452-076545',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('COMMI','Comércio Mineiro','Pedro Afonso','Sales Associate','Av. dos Lusíadas, 23','Sao Paulo','SP','05432-043','Brazil','(11) 555-7647',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('CONSH','Consolidated Holdings','Elizabeth Brown','Sales Representative','Berkeley Gardens 12  Brewery','London',null,'WX1 6LT','UK','(171) 555-2282','(171) 555-9199');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('DRACD','Drachenblut Delikatessen','Sven Ottlieb','Order Administrator','Walserweg 21','Aachen',null,'52066','Germany','0241-039123','0241-059428');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('DUMON','Du monde entier','Janine Labrune','Owner','67, rue des Cinquante Otages','Nantes',null,'44000','France','40.67.88.88','40.67.89.89');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('EASTC','Eastern Connection','Ann Devon','Sales Agent','35 King George','London',null,'WX3 6FW','UK','(171) 555-0297','(171) 555-3373');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('ERNSH','Ernst Handel','Roland Mendel','Sales Manager','Kirchgasse 6','Graz',null,'8010','Austria','7675-3425','7675-3426');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('FAMIA','Familia Arquibaldo','Aria Cruz','Marketing Assistant','Rua Orós, 92','Sao Paulo','SP','05442-030','Brazil','(11) 555-9857',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('FISSA','FISSA Fabrica Inter. Salchichas S.A.','Diego Roel','Accounting Manager','C/ Moralzarzal, 86','Madrid',null,'28034','Spain','(91) 555 94 44','(91) 555 55 93');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('FOLIG','Folies gourmandes','Martine Rancé','Assistant Sales Agent','184, chaussée de Tournai','Lille',null,'59000','France','20.16.10.16','20.16.10.17');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('FOLKO','Folk och fä HB','Maria Larsson','Owner','Åkergatan 24','Bräcke',null,'S-844 67','Sweden','0695-34 67 21',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('FRANK','Frankenversand','Peter Franken','Marketing Manager','Berliner Platz 43','München',null,'80805','Germany','089-0877310','089-0877451');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('FRANR','France restauration','Carine Schmitt','Marketing Manager','54, rue Royale','Nantes',null,'44000','France','40.32.21.21','40.32.21.20');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('FRANS','Franchi S.p.A.','Paolo Accorti','Sales Representative','Via Monte Bianco 34','Torino',null,'10100','Italy','011-4988260','011-4988261');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('FURIB','Furia Bacalhau e Frutos do Mar','Lino Rodriguez','Sales Manager','Jardim das rosas n. 32','Lisboa',null,'1675','Portugal','(1) 354-2534','(1) 354-2535');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('GALED','Galería del gastrónomo','Eduardo Saavedra','Marketing Manager','Rambla de Cataluña, 23','Barcelona',null,'08022','Spain','(93) 203 4560','(93) 203 4561');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('GODOS','Godos Cocina Típica','José Pedro Freyre','Sales Manager','C/ Romero, 33','Sevilla',null,'41101','Spain','(95) 555 82 82',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('GOURL','Gourmet Lanchonetes','André Fonseca','Sales Associate','Av. Brasil, 442','Campinas','SP','04876-786','Brazil','(11) 555-9482',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('GREAL','Great Lakes Food Market','Howard Snyder','Marketing Manager','2732 Baker Blvd.','Eugene','OR','97403','USA','(503) 555-7555',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('GROSR','GROSELLA-Restaurante','Manuel Pereira','Owner','5ª Ave. Los Palos Grandes','Caracas','DF','1081','Venezuela','(2) 283-2951','(2) 283-3397');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('HANAR','Hanari Carnes','Mario Pontes','Accounting Manager','Rua do Paço, 67','Rio de Janeiro','RJ','05454-876','Brazil','(21) 555-0091','(21) 555-8765');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('HILAA','HILARION-Abastos','Carlos Hernández','Sales Representative','Carrera 22 con Ave. Carlos Soublette #8-35','San Cristóbal','Táchira','5022','Venezuela','(5) 555-1340','(5) 555-1948');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('HUNGC','Hungry Coyote Import Store','Yoshi Latimer','Sales Representative','City Center Plaza 516 Main St.','Elgin','OR','97827','USA','(503) 555-6874','(503) 555-2376');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('HUNGO','Hungry Owl All-Night Grocers','Patricia McKenna','Sales Associate','8 Johnstown Road','Cork','Co. Cork',null,'Ireland','2967 542','2967 3333');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('ISLAT','Island Trading','Helen Bennett','Marketing Manager','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK','(198) 555-8888',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('KOENE','Königlich Essen','Philip Cramer','Sales Associate','Maubelstr. 90','Brandenburg',null,'14776','Germany','0555-09876',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('LACOR','La corne d''abondance','Daniel Tonini','Sales Representative','67, avenue de l''Europe','Versailles',null,'78000','France','30.59.84.10','30.59.85.11');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('LAMAI','La maison d''Asie','Annette Roulet','Sales Manager','1 rue Alsace-Lorraine','Toulouse',null,'31000','France','61.77.61.10','61.77.61.11');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('LAUGB','Laughing Bacchus Wine Cellars','Yoshi Tannamuri','Marketing Assistant','1900 Oak St.','Vancouver','BC','V3F 2K1','Canada','(604) 555-3392','(604) 555-7293');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('LAZYK','Lazy K Kountry Store','John Steel','Marketing Manager','12 Orchestra Terrace','Walla Walla','WA','99362','USA','(509) 555-7969','(509) 555-6221');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('LEHMS','Lehmanns Marktstand','Renate Messner','Sales Representative','Magazinweg 7','Frankfurt a.M.',null,'60528','Germany','069-0245984','069-0245874');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('LETSS','Let''s Stop N Shop','Jaime Yorres','Owner','87 Polk St. Suite 5','San Francisco','CA','94117','USA','(415) 555-5938',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('LILAS','LILA-Supermercado','Carlos González','Accounting Manager','Carrera 52 con Ave. Bolívar #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela','(9) 331-6954','(9) 331-7256');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('LINOD','LINO-Delicateses','Felipe Izquierdo','Owner','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela','(8) 34-56-12','(8) 34-93-93');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('LONEP','Lonesome Pine Restaurant','Fran Wilson','Sales Manager','89 Chiaroscuro Rd.','Portland','OR','97219','USA','(503) 555-9573','(503) 555-9646');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('MAGAA','Magazzini Alimentari Riuniti','Giovanni Rovelli','Marketing Manager','Via Ludovico il Moro 22','Bergamo',null,'24100','Italy','035-640230','035-640231');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('MAISD','Maison Dewey','Catherine Dewey','Sales Agent','Rue Joseph-Bens 532','Bruxelles',null,'B-1180','Belgium','(02) 201 24 67','(02) 201 24 68');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('MEREP','Mère Paillarde','Jean Fresnière','Marketing Assistant','43 rue St. Laurent','Montréal','Québec','H1J 1C3','Canada','(514) 555-8054','(514) 555-8055');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('MORGK','Morgenstern Gesundkost','Alexander Feuer','Marketing Assistant','Heerstr. 22','Leipzig',null,'04179','Germany','0342-023176',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('NORTS','North/South','Simon Crowther','Sales Associate','South House 300 Queensbridge','London',null,'SW7 1RZ','UK','(171) 555-7733','(171) 555-2530');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('OCEAN','Océano Atlántico Ltda.','Yvonne Moncada','Sales Agent','Ing. Gustavo Moncada 8585 Piso 20-A','Buenos Aires',null,'1010','Argentina','(1) 135-5333','(1) 135-5535');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('OLDWO','Old World Delicatessen','Rene Phillips','Sales Representative','2743 Bering St.','Anchorage','AK','99508','USA','(907) 555-7584','(907) 555-2880');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('OTTIK','Ottilies Käseladen','Henriette Pfalzheim','Owner','Mehrheimerstr. 369','Köln',null,'50739','Germany','0221-0644327','0221-0765721');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('PARIS','Paris spécialités','Marie Bertrand','Owner','265, boulevard Charonne','Paris',null,'75012','France','(1) 42.34.22.66','(1) 42.34.22.77');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('PERIC','Pericles Comidas clásicas','Guillermo Fernández','Sales Representative','Calle Dr. Jorge Cash 321','México D.F.',null,'05033','Mexico','(5) 552-3745','(5) 545-3745');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('PICCO','Piccolo und mehr','Georg Pipps','Sales Manager','Geislweg 14','Salzburg',null,'5020','Austria','6562-1622','6562-1623');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('PRINI','Princesa Isabel Vinhos','Isabel de Castro','Sales Representative','Estrada da saúde n. 58','Lisboa',null,'1756','Portugal','(1) 356-5634',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('QUEDE','Que Delícia','Bernardo Batista','Accounting Manager','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brazil','(21) 555-4252','(21) 555-4545');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('QUEEN','Queen Cozinha','Lúcia Carvalho','Marketing Assistant','Alameda dos Canàrios, 891','Sao Paulo','SP','05487-020','Brazil','(11) 555-1189',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('QUICK','QUICK-Stop','Horst Kloss','Accounting Manager','Taucherstraße 10','Cunewalde',null,'01307','Germany','0372-035188',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('RANCH','Rancho grande','Sergio Gutiérrez','Sales Representative','Av. del Libertador 900','Buenos Aires',null,'1010','Argentina','(1) 123-5555','(1) 123-5556');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('RATTC','Rattlesnake Canyon Grocery','Paula Wilson','Assistant Sales Representative','2817 Milton Dr.','Albuquerque','NM','87110','USA','(505) 555-5939','(505) 555-3620');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('REGGC','Reggiani Caseifici','Maurizio Moroni','Sales Associate','Strada Provinciale 124','Reggio Emilia',null,'42100','Italy','0522-556721','0522-556722');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('RICAR','Ricardo Adocicados','Janete Limeira','Assistant Sales Agent','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil','(21) 555-3412',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('RICSU','Richter Supermarkt','Michael Holz','Sales Manager','Grenzacherweg 237','Genève',null,'1203','Switzerland','0897-034214',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('ROMEY','Romero y tomillo','Alejandra Camino','Accounting Manager','Gran Vía, 1','Madrid',null,'28001','Spain','(91) 745 6200','(91) 745 6210');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('SANTG','Santé Gourmet','Jonas Bergulfsen','Owner','Erling Skakkes gate 78','Stavern',null,'4110','Norway','07-98 92 35','07-98 92 47');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('SAVEA','Save-a-lot Markets','Jose Pavarotti','Sales Representative','187 Suffolk Ln.','Boise','ID','83720','USA','(208) 555-8097',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('SEVES','Seven Seas Imports','Hari Kumar','Sales Manager','90 Wadhurst Rd.','London',null,'OX15 4NB','UK','(171) 555-1717','(171) 555-5646');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('SIMOB','Simons bistro','Jytte Petersen','Owner','Vinbæltet 34','Kobenhavn',null,'1734','Denmark','31 12 34 56','31 13 35 57');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('SPECD','Spécialités du monde','Dominique Perrier','Marketing Manager','25, rue Lauriston','Paris',null,'75016','France','(1) 47.55.60.10','(1) 47.55.60.20');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('SPLIR','Split Rail Beer and Ale','Art Braunschweiger','Sales Manager','P.O. Box 555','Lander','WY','82520','USA','(307) 555-4680','(307) 555-6525');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('SUPRD','Suprêmes délices','Pascale Cartrain','Accounting Manager','Boulevard Tirou, 255','Charleroi',null,'B-6000','Belgium','(071) 23 67 22 20','(071) 23 67 22 21');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('THEBI','The Big Cheese','Liz Nixon','Marketing Manager','89 Jefferson Way Suite 2','Portland','OR','97201','USA','(503) 555-3612',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('THECR','The Cracker Box','Liu Wong','Marketing Assistant','55 Grizzly Peak Rd.','Butte','MT','59801','USA','(406) 555-5834','(406) 555-8083');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('TOMSP','Toms Spezialitäten','Karin Josephs','Marketing Manager','Luisenstr. 48','Münster',null,'44087','Germany','0251-031259','0251-035695');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('TORTU','Tortuga Restaurante','Miguel Angel Paolino','Owner','Avda. Azteca 123','México D.F.',null,'05033','Mexico','(5) 555-2933',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('TRADH','Tradição Hipermercados','Anabela Domingues','Sales Representative','Av. Inês de Castro, 414','Sao Paulo','SP','05634-030','Brazil','(11) 555-2167','(11) 555-2168');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('TRAIH','Trail''s Head Gourmet Provisioners','Helvetius Nagy','Sales Associate','722 DaVinci Blvd.','Kirkland','WA','98034','USA','(206) 555-8257','(206) 555-2174');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('VAFFE','Vaffeljernet','Palle Ibsen','Sales Manager','Smagsloget 45','Århus',null,'8200','Denmark','86 21 32 43','86 22 33 44');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('VICTE','Victuailles en stock','Mary Saveley','Sales Agent','2, rue du Commerce','Lyon',null,'69004','France','78.32.54.86','78.32.54.87');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('VINET','Vins et alcools Chevalier','Paul Henriot','Accounting Manager','59 rue de l''Abbaye','Reims',null,'51100','France','26.47.15.10','26.47.15.11');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('WANDK','Die Wandernde Kuh','Rita Müller','Sales Representative','Adenauerallee 900','Stuttgart',null,'70563','Germany','0711-020361','0711-035428');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('WARTH','Wartian Herkku','Pirkko Koskitalo','Accounting Manager','Torikatu 38','Oulu',null,'90110','Finland','981-443655','981-443655');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('WELLI','Wellington Importadora','Paula Parente','Sales Manager','Rua do Mercado, 12','Resende','SP','08737-363','Brazil','(14) 555-8122',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('WHITC','White Clover Markets','Karl Jablonski','Owner','305 - 14th Ave. S. Suite 3B','Seattle','WA','98128','USA','(206) 555-4112','(206) 555-4115');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('WILMK','Wilman Kala','Matti Karttunen','Owner/Marketing Assistant','Keskuskatu 45','Helsinki',null,'21240','Finland','90-224 8858','90-224 8858');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('WOLZA','Wolski  Zajazd','Zbyszek Piestrzeniewicz','Owner','ul. Filtrowa 68','Warszawa',null,'01-012','Poland','(26) 642-7012','(26) 642-7012');

/* insert into shipper */
INSERT INTO Shippers2783(ShipperID,CompanyName,Phone) VALUES(1,'Speedy Express','(503) 555-9831');
INSERT INTO Shippers2783(ShipperID,CompanyName,Phone) VALUES(2,'United Package','(503) 555-3199');
INSERT INTO Shippers2783(ShipperID,CompanyName,Phone) VALUES(3,'Federal Shipping','(503) 555-9931');

/* insert into suppliers */
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(1,'Exotic Liquids','Charlotte Cooper','Purchasing Manager','49 Gilbert St.','London',NULL,'EC1 4SD','UK','(171) 555-2222',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(2,'New Orleans Cajun Delights','Shelley Burke','Order Administrator','P.O. Box 78934','New Orleans','LA','70117','USA','(100) 555-4822',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(3,'Grandma Kelly''s Homestead','Regina Murphy','Sales Representative','707 Oxford Rd.','Ann Arbor','MI','48104','USA','(313) 555-5735','(313) 555-3349');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(4,'Tokyo Traders','Yoshi Nagase','Marketing Manager','9-8 Sekimai Musashino-shi','Tokyo',NULL,'100','Japan','(03) 3555-5011',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(5,'Cooperativa de Quesos ''Las Cabras''','Antonio del Valle Saavedra','Export Administrator','Calle del Rosal 4','Oviedo','Asturias','33007','Spain','(98) 598 76 54',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(6,'Mayumi''s','Mayumi Ohno','Marketing Representative','92 Setsuko Chuo-ku','Osaka',NULL,'545','Japan','(06) 431-7877',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(7,'Pavlova, Ltd.','Ian Devling','Marketing Manager','74 Rose St. Moonie Ponds','Melbourne','Victoria','3058','Australia','(03) 444-2343','(03) 444-6588');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(8,'Specialty Biscuits, Ltd.','Peter Wilson','Sales Representative','29 King''s Way','Manchester',NULL,'M14 GSD','UK','(161) 555-4448',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(9,'PB Knäckebröd AB','Lars Peterson','Sales Agent','Kaloadagatan 13','Göteborg',NULL,'S-345 67','Sweden','031-987 65 43','031-987 65 91');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(10,'Refrescos Americanas LTDA','Carlos Diaz','Marketing Manager','Av. das Americanas 12.890','Sao Paulo',NULL,'5442','Brazil','(11) 555 4640',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(11,'Heli Süßwaren GmbH and Co. KG','Petra Winkler','Sales Manager','Tiergartenstraße 5','Berlin',NULL,'10785','Germany','(010) 9984510',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(12,'Plutzer Lebensmittelgroßmärkte AG','Martin Bein','International Marketing Mgr.','Bogenallee 51','Frankfurt',NULL,'60439','Germany','(069) 992755',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(13,'Nord-Ost-Fisch Handelsgesellschaft mbH','Sven Petersen','Coordinator Foreign Markets','Frahmredder 112a','Cuxhaven',NULL,'27478','Germany','(04721) 8713','(04721) 8714');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(14,'Formaggi Fortini s.r.l.','Elio Rossi','Sales Representative','Viale Dante, 75','Ravenna',NULL,'48100','Italy','(0544) 60323','(0544) 60603');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(15,'Norske Meierier','Beate Vileid','Marketing Manager','Hatlevegen 5','Sandvika',NULL,'1320','Norway','(0)2-953010',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(16,'Bigfoot Breweries','Cheryl Saylor','Regional Account Rep.','3400 - 8th Avenue Suite 210','Bend','OR','97101','USA','(503) 555-9931',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(17,'Svensk Sjöföda AB','Michael Björn','Sales Representative','Brovallavägen 231','Stockholm',NULL,'S-123 45','Sweden','08-123 45 67',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(18,'Aux joyeux ecclésiastiques','Guylène Nodier','Sales Manager','203, Rue des Francs-Bourgeois','Paris',NULL,'75004','France','(1) 03.83.00.68','(1) 03.83.00.62');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(19,'New England Seafood Cannery','Robb Merchant','Wholesale Account Agent','Order Processing Dept. 2100 Paul Revere Blvd.','Boston','MA','02134','USA','(617) 555-3267','(617) 555-3389');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(20,'Leka Trading','Chandra Leka','Owner','471 Serangoon Loop, Suite #402','Singapore',NULL,'0512','Singapore','555-8787',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(21,'Lyngbysild','Niels Petersen','Sales Manager','Lyngbysild Fiskebakken 10','Lyngby',NULL,'2800','Denmark','43844108','43844115');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(22,'Zaanse Snoepfabriek','Dirk Luchte','Accounting Manager','Verkoop Rijnweg 22','Zaandam',NULL,'9999 ZZ','Netherlands','(12345) 1212','(12345) 1210');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(23,'Karkki Oy','Anne Heikkonen','Product Manager','Valtakatu 12','Lappeenranta',NULL,'53120','Finland','(953) 10956',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(24,'G''day, Mate','Wendy Mackenzie','Sales Representative','170 Prince Edward Parade Hunter''s Hill','Sydney','NSW','2042','Australia','(02) 555-5914','(02) 555-4873');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(25,'Ma Maison','Jean-Guy Lauzon','Marketing Manager','2960 Rue St. Laurent','Montréal','Québec','H1J 1C3','Canada','(514) 555-9022',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(26,'Pasta Buttini s.r.l.','Giovanni Giudici','Order Administrator','Via dei Gelsomini, 153','Salerno',NULL,'84100','Italy','(089) 6547665','(089) 6547667');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(27,'Escargots Nouveaux','Marie Delamare','Sales Manager','22, rue H. Voiron','Montceau',NULL,'71300','France','85.57.00.07',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(28,'Gai pâturage','Eliane Noz','Sales Representative','Bat. B 3, rue des Alpes','Annecy',NULL,'74000','France','38.76.98.06','38.76.98.58');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(29,'Forêts d''érables','Chantal Goulet','Accounting Manager','148 rue Chasseur','Ste-Hyacinthe','Québec','J2S 7S8','Canada','(514) 555-2955','(514) 555-2921');