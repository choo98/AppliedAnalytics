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
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('ANATR','Ana Trujillo Emparedados y helados','Ana Trujillo','Owner','Avda. de la Constituci?n 2222','M?xico D.F.',null,'05021','Mexico','(5) 555-4729','(5) 555-3745');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('ANTON','Antonio Moreno Taquer?a','Antonio Moreno','Owner','Mataderos  2312','M?xico D.F.',null,'05023','Mexico','(5) 555-3932',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('AROUT','Around the Horn','Thomas Hardy','Sales Representative','120 Hanover Sq.','London',null,'WA1 1DP','UK','(171) 555-7788','(171) 555-6750');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('BERGS','Berglunds snabbk?p','Christina Berglund','Order Administrator','Berguvsv?gen  8','Lule?',null,'S-958 22','Sweden','0921-12 34 65','0921-12 34 67');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('BLAUS','Blauer See Delikatessen','Hanna Moos','Sales Representative','Forsterstr. 57','Mannheim',null,'68306','Germany','0621-08460','0621-08924');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('BLONP','Blondesddsl p?re et fils','Fr?d?rique Citeaux','Marketing Manager','24, place Kl?ber','Strasbourg',null,'67000','France','88.60.15.31','88.60.15.32');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('BOLID','B?lido Comidas preparadas','Mart?n Sommer','Owner','C/ Araquil, 67','Madrid',null,'28023','Spain','(91) 555 22 82','(91) 555 91 99');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('BONAP','Bon app''','Laurence Lebihan','Owner','12, rue des Bouchers','Marseille',null,'13008','France','91.24.45.40','91.24.45.41');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('BOTTM','Bottom-Dollar Markets','Elizabeth Lincoln','Accounting Manager','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada','(604) 555-4729','(604) 555-3745');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('BSBEV','B''s Beverages','Victoria Ashworth','Sales Representative','Fauntleroy Circus','London',null,'EC2 5NT','UK','(171) 555-1212',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('CACTU','Cactus Comidas para llevar','Patricio Simpson','Sales Agent','Cerrito 333','Buenos Aires',null,'1010','Argentina','(1) 135-5555','(1) 135-4892');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('CENTC','Centro comercial Moctezuma','Francisco Chang','Marketing Manager','Sierras de Granada 9993','M?xico D.F.',null,'05022','Mexico','(5) 555-3392','(5) 555-7293');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('CHOPS','Chop-suey Chinese','Yang Wang','Owner','Hauptstr. 29','Bern',null,'3012','Switzerland','0452-076545',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('COMMI','Com?rcio Mineiro','Pedro Afonso','Sales Associate','Av. dos Lus?adas, 23','Sao Paulo','SP','05432-043','Brazil','(11) 555-7647',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('CONSH','Consolidated Holdings','Elizabeth Brown','Sales Representative','Berkeley Gardens 12  Brewery','London',null,'WX1 6LT','UK','(171) 555-2282','(171) 555-9199');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('DRACD','Drachenblut Delikatessen','Sven Ottlieb','Order Administrator','Walserweg 21','Aachen',null,'52066','Germany','0241-039123','0241-059428');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('DUMON','Du monde entier','Janine Labrune','Owner','67, rue des Cinquante Otages','Nantes',null,'44000','France','40.67.88.88','40.67.89.89');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('EASTC','Eastern Connection','Ann Devon','Sales Agent','35 King George','London',null,'WX3 6FW','UK','(171) 555-0297','(171) 555-3373');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('ERNSH','Ernst Handel','Roland Mendel','Sales Manager','Kirchgasse 6','Graz',null,'8010','Austria','7675-3425','7675-3426');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('FAMIA','Familia Arquibaldo','Aria Cruz','Marketing Assistant','Rua Or?s, 92','Sao Paulo','SP','05442-030','Brazil','(11) 555-9857',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('FISSA','FISSA Fabrica Inter. Salchichas S.A.','Diego Roel','Accounting Manager','C/ Moralzarzal, 86','Madrid',null,'28034','Spain','(91) 555 94 44','(91) 555 55 93');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('FOLIG','Folies gourmandes','Martine Ranc?','Assistant Sales Agent','184, chauss?e de Tournai','Lille',null,'59000','France','20.16.10.16','20.16.10.17');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('FOLKO','Folk och f? HB','Maria Larsson','Owner','?kergatan 24','Br?cke',null,'S-844 67','Sweden','0695-34 67 21',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('FRANK','Frankenversand','Peter Franken','Marketing Manager','Berliner Platz 43','M?nchen',null,'80805','Germany','089-0877310','089-0877451');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('FRANR','France restauration','Carine Schmitt','Marketing Manager','54, rue Royale','Nantes',null,'44000','France','40.32.21.21','40.32.21.20');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('FRANS','Franchi S.p.A.','Paolo Accorti','Sales Representative','Via Monte Bianco 34','Torino',null,'10100','Italy','011-4988260','011-4988261');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('FURIB','Furia Bacalhau e Frutos do Mar','Lino Rodriguez','Sales Manager','Jardim das rosas n. 32','Lisboa',null,'1675','Portugal','(1) 354-2534','(1) 354-2535');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('GALED','Galer?a del gastr?nomo','Eduardo Saavedra','Marketing Manager','Rambla de Catalu?a, 23','Barcelona',null,'08022','Spain','(93) 203 4560','(93) 203 4561');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('GODOS','Godos Cocina T?pica','Jos? Pedro Freyre','Sales Manager','C/ Romero, 33','Sevilla',null,'41101','Spain','(95) 555 82 82',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('GOURL','Gourmet Lanchonetes','Andr? Fonseca','Sales Associate','Av. Brasil, 442','Campinas','SP','04876-786','Brazil','(11) 555-9482',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('GREAL','Great Lakes Food Market','Howard Snyder','Marketing Manager','2732 Baker Blvd.','Eugene','OR','97403','USA','(503) 555-7555',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('GROSR','GROSELLA-Restaurante','Manuel Pereira','Owner','5? Ave. Los Palos Grandes','Caracas','DF','1081','Venezuela','(2) 283-2951','(2) 283-3397');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('HANAR','Hanari Carnes','Mario Pontes','Accounting Manager','Rua do Pa?o, 67','Rio de Janeiro','RJ','05454-876','Brazil','(21) 555-0091','(21) 555-8765');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('HILAA','HILARION-Abastos','Carlos Hern?ndez','Sales Representative','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist?bal','T?chira','5022','Venezuela','(5) 555-1340','(5) 555-1948');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('HUNGC','Hungry Coyote Import Store','Yoshi Latimer','Sales Representative','City Center Plaza 516 Main St.','Elgin','OR','97827','USA','(503) 555-6874','(503) 555-2376');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('HUNGO','Hungry Owl All-Night Grocers','Patricia McKenna','Sales Associate','8 Johnstown Road','Cork','Co. Cork',null,'Ireland','2967 542','2967 3333');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('ISLAT','Island Trading','Helen Bennett','Marketing Manager','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK','(198) 555-8888',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('KOENE','K?niglich Essen','Philip Cramer','Sales Associate','Maubelstr. 90','Brandenburg',null,'14776','Germany','0555-09876',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('LACOR','La corne d''abondance','Daniel Tonini','Sales Representative','67, avenue de l''Europe','Versailles',null,'78000','France','30.59.84.10','30.59.85.11');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('LAMAI','La maison d''Asie','Annette Roulet','Sales Manager','1 rue Alsace-Lorraine','Toulouse',null,'31000','France','61.77.61.10','61.77.61.11');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('LAUGB','Laughing Bacchus Wine Cellars','Yoshi Tannamuri','Marketing Assistant','1900 Oak St.','Vancouver','BC','V3F 2K1','Canada','(604) 555-3392','(604) 555-7293');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('LAZYK','Lazy K Kountry Store','John Steel','Marketing Manager','12 Orchestra Terrace','Walla Walla','WA','99362','USA','(509) 555-7969','(509) 555-6221');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('LEHMS','Lehmanns Marktstand','Renate Messner','Sales Representative','Magazinweg 7','Frankfurt a.M.',null,'60528','Germany','069-0245984','069-0245874');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('LETSS','Let''s Stop N Shop','Jaime Yorres','Owner','87 Polk St. Suite 5','San Francisco','CA','94117','USA','(415) 555-5938',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('LILAS','LILA-Supermercado','Carlos Gonz?lez','Accounting Manager','Carrera 52 con Ave. Bol?var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela','(9) 331-6954','(9) 331-7256');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('LINOD','LINO-Delicateses','Felipe Izquierdo','Owner','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela','(8) 34-56-12','(8) 34-93-93');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('LONEP','Lonesome Pine Restaurant','Fran Wilson','Sales Manager','89 Chiaroscuro Rd.','Portland','OR','97219','USA','(503) 555-9573','(503) 555-9646');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('MAGAA','Magazzini Alimentari Riuniti','Giovanni Rovelli','Marketing Manager','Via Ludovico il Moro 22','Bergamo',null,'24100','Italy','035-640230','035-640231');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('MAISD','Maison Dewey','Catherine Dewey','Sales Agent','Rue Joseph-Bens 532','Bruxelles',null,'B-1180','Belgium','(02) 201 24 67','(02) 201 24 68');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('MEREP','M?re Paillarde','Jean Fresni?re','Marketing Assistant','43 rue St. Laurent','Montr?al','Qu?bec','H1J 1C3','Canada','(514) 555-8054','(514) 555-8055');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('MORGK','Morgenstern Gesundkost','Alexander Feuer','Marketing Assistant','Heerstr. 22','Leipzig',null,'04179','Germany','0342-023176',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('NORTS','North/South','Simon Crowther','Sales Associate','South House 300 Queensbridge','London',null,'SW7 1RZ','UK','(171) 555-7733','(171) 555-2530');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('OCEAN','Oc?ano Atl?ntico Ltda.','Yvonne Moncada','Sales Agent','Ing. Gustavo Moncada 8585 Piso 20-A','Buenos Aires',null,'1010','Argentina','(1) 135-5333','(1) 135-5535');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('OLDWO','Old World Delicatessen','Rene Phillips','Sales Representative','2743 Bering St.','Anchorage','AK','99508','USA','(907) 555-7584','(907) 555-2880');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('OTTIK','Ottilies K?seladen','Henriette Pfalzheim','Owner','Mehrheimerstr. 369','K?ln',null,'50739','Germany','0221-0644327','0221-0765721');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('PARIS','Paris sp?cialit?s','Marie Bertrand','Owner','265, boulevard Charonne','Paris',null,'75012','France','(1) 42.34.22.66','(1) 42.34.22.77');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('PERIC','Pericles Comidas cl?sicas','Guillermo Fern?ndez','Sales Representative','Calle Dr. Jorge Cash 321','M?xico D.F.',null,'05033','Mexico','(5) 552-3745','(5) 545-3745');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('PICCO','Piccolo und mehr','Georg Pipps','Sales Manager','Geislweg 14','Salzburg',null,'5020','Austria','6562-1622','6562-1623');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('PRINI','Princesa Isabel Vinhos','Isabel de Castro','Sales Representative','Estrada da sa?de n. 58','Lisboa',null,'1756','Portugal','(1) 356-5634',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('QUEDE','Que Del?cia','Bernardo Batista','Accounting Manager','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brazil','(21) 555-4252','(21) 555-4545');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('QUEEN','Queen Cozinha','L?cia Carvalho','Marketing Assistant','Alameda dos Can?rios, 891','Sao Paulo','SP','05487-020','Brazil','(11) 555-1189',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('QUICK','QUICK-Stop','Horst Kloss','Accounting Manager','Taucherstra?e 10','Cunewalde',null,'01307','Germany','0372-035188',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('RANCH','Rancho grande','Sergio Guti?rrez','Sales Representative','Av. del Libertador 900','Buenos Aires',null,'1010','Argentina','(1) 123-5555','(1) 123-5556');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('RATTC','Rattlesnake Canyon Grocery','Paula Wilson','Assistant Sales Representative','2817 Milton Dr.','Albuquerque','NM','87110','USA','(505) 555-5939','(505) 555-3620');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('REGGC','Reggiani Caseifici','Maurizio Moroni','Sales Associate','Strada Provinciale 124','Reggio Emilia',null,'42100','Italy','0522-556721','0522-556722');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('RICAR','Ricardo Adocicados','Janete Limeira','Assistant Sales Agent','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil','(21) 555-3412',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('RICSU','Richter Supermarkt','Michael Holz','Sales Manager','Grenzacherweg 237','Gen?ve',null,'1203','Switzerland','0897-034214',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('ROMEY','Romero y tomillo','Alejandra Camino','Accounting Manager','Gran V?a, 1','Madrid',null,'28001','Spain','(91) 745 6200','(91) 745 6210');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('SANTG','Sant? Gourmet','Jonas Bergulfsen','Owner','Erling Skakkes gate 78','Stavern',null,'4110','Norway','07-98 92 35','07-98 92 47');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('SAVEA','Save-a-lot Markets','Jose Pavarotti','Sales Representative','187 Suffolk Ln.','Boise','ID','83720','USA','(208) 555-8097',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('SEVES','Seven Seas Imports','Hari Kumar','Sales Manager','90 Wadhurst Rd.','London',null,'OX15 4NB','UK','(171) 555-1717','(171) 555-5646');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('SIMOB','Simons bistro','Jytte Petersen','Owner','Vinb?ltet 34','Kobenhavn',null,'1734','Denmark','31 12 34 56','31 13 35 57');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('SPECD','Sp?cialit?s du monde','Dominique Perrier','Marketing Manager','25, rue Lauriston','Paris',null,'75016','France','(1) 47.55.60.10','(1) 47.55.60.20');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('SPLIR','Split Rail Beer and Ale','Art Braunschweiger','Sales Manager','P.O. Box 555','Lander','WY','82520','USA','(307) 555-4680','(307) 555-6525');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('SUPRD','Supr?mes d?lices','Pascale Cartrain','Accounting Manager','Boulevard Tirou, 255','Charleroi',null,'B-6000','Belgium','(071) 23 67 22 20','(071) 23 67 22 21');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('THEBI','The Big Cheese','Liz Nixon','Marketing Manager','89 Jefferson Way Suite 2','Portland','OR','97201','USA','(503) 555-3612',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('THECR','The Cracker Box','Liu Wong','Marketing Assistant','55 Grizzly Peak Rd.','Butte','MT','59801','USA','(406) 555-5834','(406) 555-8083');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('TOMSP','Toms Spezialit?ten','Karin Josephs','Marketing Manager','Luisenstr. 48','M?nster',null,'44087','Germany','0251-031259','0251-035695');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('TORTU','Tortuga Restaurante','Miguel Angel Paolino','Owner','Avda. Azteca 123','M?xico D.F.',null,'05033','Mexico','(5) 555-2933',null);
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('TRADH','Tradi??o Hipermercados','Anabela Domingues','Sales Representative','Av. In?s de Castro, 414','Sao Paulo','SP','05634-030','Brazil','(11) 555-2167','(11) 555-2168');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('TRAIH','Trail''s Head Gourmet Provisioners','Helvetius Nagy','Sales Associate','722 DaVinci Blvd.','Kirkland','WA','98034','USA','(206) 555-8257','(206) 555-2174');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('VAFFE','Vaffeljernet','Palle Ibsen','Sales Manager','Smagsloget 45','?rhus',null,'8200','Denmark','86 21 32 43','86 22 33 44');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('VICTE','Victuailles en stock','Mary Saveley','Sales Agent','2, rue du Commerce','Lyon',null,'69004','France','78.32.54.86','78.32.54.87');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('VINET','Vins et alcools Chevalier','Paul Henriot','Accounting Manager','59 rue de l''Abbaye','Reims',null,'51100','France','26.47.15.10','26.47.15.11');
Insert into CUSTOMERS2783 (CUSTOMERID,COMPANYNAME,CONTACTNAME,CONTACTTITLE,ADDRESS,CITY,REGION,POSTALCODE,COUNTRY,PHONE,FAX) values ('WANDK','Die Wandernde Kuh','Rita M?ller','Sales Representative','Adenauerallee 900','Stuttgart',null,'70563','Germany','0711-020361','0711-035428');
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
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(9,'PB Kn?ckebr?d AB','Lars Peterson','Sales Agent','Kaloadagatan 13','G?teborg',NULL,'S-345 67','Sweden','031-987 65 43','031-987 65 91');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(10,'Refrescos Americanas LTDA','Carlos Diaz','Marketing Manager','Av. das Americanas 12.890','Sao Paulo',NULL,'5442','Brazil','(11) 555 4640',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(11,'Heli S??waren GmbH and Co. KG','Petra Winkler','Sales Manager','Tiergartenstra?e 5','Berlin',NULL,'10785','Germany','(010) 9984510',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(12,'Plutzer Lebensmittelgro?m?rkte AG','Martin Bein','International Marketing Mgr.','Bogenallee 51','Frankfurt',NULL,'60439','Germany','(069) 992755',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(13,'Nord-Ost-Fisch Handelsgesellschaft mbH','Sven Petersen','Coordinator Foreign Markets','Frahmredder 112a','Cuxhaven',NULL,'27478','Germany','(04721) 8713','(04721) 8714');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(14,'Formaggi Fortini s.r.l.','Elio Rossi','Sales Representative','Viale Dante, 75','Ravenna',NULL,'48100','Italy','(0544) 60323','(0544) 60603');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(15,'Norske Meierier','Beate Vileid','Marketing Manager','Hatlevegen 5','Sandvika',NULL,'1320','Norway','(0)2-953010',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(16,'Bigfoot Breweries','Cheryl Saylor','Regional Account Rep.','3400 - 8th Avenue Suite 210','Bend','OR','97101','USA','(503) 555-9931',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(17,'Svensk Sj?f?da AB','Michael Bj?rn','Sales Representative','Brovallav?gen 231','Stockholm',NULL,'S-123 45','Sweden','08-123 45 67',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(18,'Aux joyeux eccl?siastiques','Guyl?ne Nodier','Sales Manager','203, Rue des Francs-Bourgeois','Paris',NULL,'75004','France','(1) 03.83.00.68','(1) 03.83.00.62');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(19,'New England Seafood Cannery','Robb Merchant','Wholesale Account Agent','Order Processing Dept. 2100 Paul Revere Blvd.','Boston','MA','02134','USA','(617) 555-3267','(617) 555-3389');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(20,'Leka Trading','Chandra Leka','Owner','471 Serangoon Loop, Suite #402','Singapore',NULL,'0512','Singapore','555-8787',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(21,'Lyngbysild','Niels Petersen','Sales Manager','Lyngbysild Fiskebakken 10','Lyngby',NULL,'2800','Denmark','43844108','43844115');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(22,'Zaanse Snoepfabriek','Dirk Luchte','Accounting Manager','Verkoop Rijnweg 22','Zaandam',NULL,'9999 ZZ','Netherlands','(12345) 1212','(12345) 1210');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(23,'Karkki Oy','Anne Heikkonen','Product Manager','Valtakatu 12','Lappeenranta',NULL,'53120','Finland','(953) 10956',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(24,'G''day, Mate','Wendy Mackenzie','Sales Representative','170 Prince Edward Parade Hunter''s Hill','Sydney','NSW','2042','Australia','(02) 555-5914','(02) 555-4873');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(25,'Ma Maison','Jean-Guy Lauzon','Marketing Manager','2960 Rue St. Laurent','Montr?al','Qu?bec','H1J 1C3','Canada','(514) 555-9022',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(26,'Pasta Buttini s.r.l.','Giovanni Giudici','Order Administrator','Via dei Gelsomini, 153','Salerno',NULL,'84100','Italy','(089) 6547665','(089) 6547667');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(27,'Escargots Nouveaux','Marie Delamare','Sales Manager','22, rue H. Voiron','Montceau',NULL,'71300','France','85.57.00.07',NULL);
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(28,'Gai p?turage','Eliane Noz','Sales Representative','Bat. B 3, rue des Alpes','Annecy',NULL,'74000','France','38.76.98.06','38.76.98.58');
INSERT INTO Suppliers2783(SupplierID,CompanyName,ContactName,ContactTitle,Address,City,Region,PostalCode,Country,Phone,Fax) VALUES(29,'For?ts d''?rables','Chantal Goulet','Accounting Manager','148 rue Chasseur','Ste-Hyacinthe','Qu?bec','J2S 7S8','Canada','(514) 555-2955','(514) 555-2921');

/* insert into products */
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(1,'Chai',1,1,'10 boxes x 20 bags',18,39,0,10,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(2,'Chang',1,1,'24 - 12 oz bottles',19,17,40,25,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(3,'Aniseed Syrup',1,2,'12 - 550 ml bottles',10,13,70,25,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(4,'Chef Anton''s Cajun Seasoning',2,2,'48 - 6 oz jars',22,53,0,0,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(5,'Chef Anton''s Gumbo Mix',2,2,'36 boxes',21.35,0,0,0,1);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(6,'Grandma''s Boysenberry Spread',3,2,'12 - 8 oz jars',25,120,0,25,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(7,'Uncle Bob''s Organic Dried Pears',3,7,'12 - 1 lb pkgs.',30,15,0,10,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(8,'Northwoods Cranberry Sauce',3,2,'12 - 12 oz jars',40,6,0,0,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(9,'Mishi Kobe Niku',4,6,'18 - 500 g pkgs.',97,29,0,0,1);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(10,'Ikura',4,8,'12 - 200 ml jars',31,31,0,0,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(11,'Queso Cabrales',5,4,'1 kg pkg.',21,22,30,30,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(12,'Queso Manchego La Pastora',5,4,'10 - 500 g pkgs.',38,86,0,0,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(13,'Konbu',6,8,'2 kg box',6,24,0,5,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(14,'Tofu',6,7,'40 - 100 g pkgs.',23.25,35,0,0,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(15,'Genen Shouyu',6,2,'24 - 250 ml bottles',15.5,39,0,5,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(16,'Pavlova',7,3,'32 - 500 g boxes',17.45,29,0,10,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(17,'Alice Mutton',7,6,'20 - 1 kg tins',39,0,0,0,1);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(18,'Carnarvon Tigers',7,8,'16 kg pkg.',62.5,42,0,0,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(19,'Teatime Chocolate Biscuits',8,3,'10 boxes x 12 pieces',9.2,25,0,5,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(20,'Sir Rodney''s Marmalade',8,3,'30 gift boxes',81,40,0,0,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(21,'Sir Rodney''s Scones',8,3,'24 pkgs. x 4 pieces',10,3,40,5,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(22,'Gustaf''s Kn?ckebr?d',9,5,'24 - 500 g pkgs.',21,104,0,25,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(23,'Tunnbr?d',9,5,'12 - 250 g pkgs.',9,61,0,25,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(24,'Guaran? Fant?stica',10,1,'12 - 355 ml cans',4.5,20,0,0,1);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(25,'NuNuCa Nu?-Nougat-Creme',11,3,'20 - 450 g glasses',14,76,0,30,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(26,'Gumb?r Gummib?rchen',11,3,'100 - 250 g bags',31.23,15,0,0,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(27,'Schoggi Schokolade',11,3,'100 - 100 g pieces',43.9,49,0,30,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(28,'R?ssle Sauerkraut',12,7,'25 - 825 g cans',45.6,26,0,0,1);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(29,'Th?ringer Rostbratwurst',12,6,'50 bags x 30 sausgs.',123.79,0,0,0,1);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(30,'Nord-Ost Matjeshering',13,8,'10 - 200 g glasses',25.89,10,0,15,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(31,'Gorgonzola Telino',14,4,'12 - 100 g pkgs',12.5,0,70,20,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(32,'Mascarpone Fabioli',14,4,'24 - 200 g pkgs.',32,9,40,25,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(33,'Geitost',15,4,'500 g',2.5,112,0,20,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(34,'Sasquatch Ale',16,1,'24 - 12 oz bottles',14,111,0,15,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(35,'Steeleye Stout',16,1,'24 - 12 oz bottles',18,20,0,15,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(36,'Inlagd Sill',17,8,'24 - 250 g  jars',19,112,0,20,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(37,'Gravad lax',17,8,'12 - 500 g pkgs.',26,11,50,25,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(38,'C?te de Blaye',18,1,'12 - 75 cl bottles',263.5,17,0,15,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(39,'Chartreuse verte',18,1,'750 cc per bottle',18,69,0,5,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(40,'Boston Crab Meat',19,8,'24 - 4 oz tins',18.4,123,0,30,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(41,'Jack''s New England Clam Chowder',19,8,'12 - 12 oz cans',9.65,85,0,10,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(42,'Singaporean Hokkien Fried Mee',20,5,'32 - 1 kg pkgs.',14,26,0,0,1);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(43,'Ipoh Coffee',20,1,'16 - 500 g tins',46,17,10,25,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(44,'Gula Malacca',20,2,'20 - 2 kg bags',19.45,27,0,15,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(45,'Rogede sild',21,8,'1k pkg.',9.5,5,70,15,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(46,'Spegesild',21,8,'4 - 450 g glasses',12,95,0,0,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(47,'Zaanse koeken',22,3,'10 - 4 oz boxes',9.5,36,0,0,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(48,'Chocolade',22,3,'10 pkgs.',12.75,15,70,25,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(49,'Maxilaku',23,3,'24 - 50 g pkgs.',20,10,60,15,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(50,'Valkoinen suklaa',23,3,'12 - 100 g bars',16.25,65,0,30,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(51,'Manjimup Dried Apples',24,7,'50 - 300 g pkgs.',53,20,0,10,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(52,'Filo Mix',24,5,'16 - 2 kg boxes',7,38,0,25,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(53,'Perth Pasties',24,6,'48 pieces',32.8,0,0,0,1);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(54,'Tourti?re',25,6,'16 pies',7.45,21,0,10,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(55,'P?t? chinois',25,6,'24 boxes x 2 pies',24,115,0,20,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(56,'Gnocchi di nonna Alice',26,5,'24 - 250 g pkgs.',38,21,10,30,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(57,'Ravioli Angelo',26,5,'24 - 250 g pkgs.',19.5,36,0,20,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(58,'Escargots de Bourgogne',27,8,'24 pieces',13.25,62,0,20,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(59,'Raclette Courdavault',28,4,'5 kg pkg.',55,79,0,0,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(60,'Camembert Pierrot',28,4,'15 - 300 g rounds',34,19,0,0,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(61,'Sirop d''?rable',29,2,'24 - 500 ml bottles',28.5,113,0,25,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(62,'Tarte au sucre',29,3,'48 pies',49.3,17,0,0,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(63,'Vegie-spread',7,2,'15 - 625 g jars',43.9,24,0,5,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(64,'Wimmers gute Semmelkn?del',12,5,'20 bags x 4 pieces',33.25,22,80,30,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(65,'Louisiana Fiery Hot Pepper Sauce',2,2,'32 - 8 oz bottles',21.05,76,0,0,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(66,'Louisiana Hot Spiced Okra',2,2,'24 - 8 oz jars',17,4,100,20,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(67,'Laughing Lumberjack Lager',16,1,'24 - 12 oz bottles',14,52,0,10,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(68,'Scottish Longbreads',8,3,'10 boxes x 8 pieces',12.5,6,10,15,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(69,'Gudbrandsdalsost',15,4,'10 kg pkg.',36,26,0,15,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(70,'Outback Lager',7,1,'24 - 355 ml bottles',15,15,10,30,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(71,'Flotemysost',15,4,'10 - 500 g pkgs.',21.5,26,0,0,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(72,'Mozzarella di Giovanni',14,4,'24 - 200 g pkgs.',34.8,14,0,0,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(73,'R?d Kaviar',17,8,'24 - 150 g jars',15,101,0,5,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(74,'Longlife Tofu',4,7,'5 kg pkg.',10,4,20,5,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(75,'Rh?nbr?u Klosterbier',12,1,'24 - 0.5 l bottles',7.75,125,0,25,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(76,'Lakkalik??ri',23,1,'500 ml',18,57,0,20,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(77,'Original Frankfurter gr?ne So?e',12,2,'12 boxes',13,32,0,15,0);
INSERT INTO Products2783(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued) VALUES(78,'Kit Kat',22,3,'25 Bars',2.5,50,0,15,0);

/* insert into orders */ 
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10248,'VINET',5,'04-JUL-15 ','01-AUG-15 ','16-JUL-15 ',3,32.38,'Vins et alcools Chevalier','59 rue de l''Abbaye','Reims','Test','51100','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10249,'TOMSP',6,'05-JUL-15 ','16-AUG-15 ','10-JUL-15 ',1,11.61,'Toms Spezialit?ten','Luisenstr. 48','M?nster',null,'44087','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10250,'HANAR',4,'08-JUL-15 ','05-AUG-15 ','12-JUL-15 ',2,65.83,'Hanari Carnes','Rua do Pa?o, 67','Rio de Janeiro','RJ','05454-876','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10251,'VICTE',3,'08-JUL-15 ','05-AUG-15 ','15-JUL-15 ',1,41.34,'Victuailles en stock','2, rue du Commerce','Lyon',null,'69004','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10252,'SUPRD',4,'09-JUL-15 ','06-AUG-15 ','11-JUL-15 ',2,51.3,'Supr?mes d?lices','Boulevard Tirou, 255','Charleroi',null,'B-6000','Belgium');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10253,'HANAR',3,'10-JUL-15 ','24-JUL-15 ','16-JUL-15 ',2,58.17,'Hanari Carnes','Rua do Pa?o, 67','Rio de Janeiro','RJ','05454-876','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10254,'CHOPS',5,'11-JUL-15 ','08-AUG-15 ','23-JUL-15 ',2,22.98,'Chop-suey Chinese','Hauptstr. 31','Bern',null,'3012','Switzerland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10255,'RICSU',9,'12-JUL-15 ','09-AUG-15 ','15-JUL-15 ',3,148.33,'Richter Supermarkt','Starenweg 5','Gen?ve',null,'1204','Switzerland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10256,'WELLI',3,'15-JUL-15 ','12-AUG-15 ','17-JUL-15 ',2,13.97,'Wellington Importadora','Rua do Mercado, 12','Resende','SP','08737-363','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10257,'HILAA',4,'16-JUL-15 ','13-AUG-15 ','22-JUL-15 ',3,81.91,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist?bal','T?chira','5022','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10258,'ERNSH',1,'17-JUL-15 ','14-AUG-15 ','23-JUL-15 ',1,140.51,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10259,'CENTC',4,'18-JUL-15 ','15-AUG-15 ','25-JUL-15 ',3,3.25,'Centro comercial Moctezuma','Sierras de Granada 9993','M?xico D.F.',null,'05022','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10260,'OTTIK',4,'19-JUL-15 ','16-AUG-15 ','29-JUL-15 ',1,55.09,'Ottilies K?seladen','Mehrheimerstr. 369','K?ln',null,'50739','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10261,'QUEDE',4,'19-JUL-15 ','16-AUG-15 ','30-JUL-15 ',2,3.05,'Que Del?cia','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10262,'RATTC',8,'22-JUL-15 ','19-AUG-15 ','25-JUL-15 ',3,48.29,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10263,'ERNSH',9,'23-JUL-15 ','20-AUG-15 ','31-JUL-15 ',3,146.06,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10264,'FOLKO',6,'24-JUL-15 ','21-AUG-15 ','23-AUG-15 ',3,3.67,'Folk och f? HB','?kergatan 24','Br?cke',null,'S-844 67','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10265,'BLONP',2,'25-JUL-15 ','22-AUG-15 ','12-AUG-15 ',1,55.28,'Blondel p?re et fils','24, place Kl?ber','Strasbourg',null,'67000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10266,'WARTH',3,'26-JUL-15 ','06-SEP-15 ','31-JUL-15 ',3,25.73,'Wartian Herkku','Torikatu 38','Oulu',null,'90110','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10267,'FRANK',4,'29-JUL-15 ','26-AUG-15 ','06-AUG-15 ',1,208.58,'Frankenversand','Berliner Platz 43','M?nchen',null,'80805','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10268,'GROSR',8,'30-JUL-15 ','27-AUG-15 ','02-AUG-15 ',3,66.29,'GROSELLA-Restaurante','5? Ave. Los Palos Grandes','Caracas','DF','1081','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10269,'WHITC',5,'31-JUL-15 ','14-AUG-15 ','09-AUG-15 ',1,4.56,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10270,'WARTH',1,'01-AUG-15 ','29-AUG-15 ','02-AUG-15 ',1,136.54,'Wartian Herkku','Torikatu 38','Oulu',null,'90110','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10271,'SPLIR',6,'01-AUG-15 ','29-AUG-15 ','30-AUG-15 ',2,4.54,'Split Rail Beer and Ale','P.O. Box 555','Lander','WY','82520','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10272,'RATTC',6,'02-AUG-15 ','30-AUG-15 ','06-AUG-15 ',2,98.03,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10273,'QUICK',3,'05-AUG-15 ','02-SEP-15 ','12-AUG-15 ',3,76.07,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10274,'VINET',6,'06-AUG-15 ','03-SEP-15 ','16-AUG-15 ',1,6.01,'Vins et alcools Chevalier','59 rue de l''Abbaye','Reims',null,'51100','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10275,'MAGAA',1,'07-AUG-15 ','04-SEP-15 ','09-AUG-15 ',1,26.93,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo',null,'24100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10276,'TORTU',8,'08-AUG-15 ','22-AUG-15 ','14-AUG-15 ',3,13.84,'Tortuga Restaurante','Avda. Azteca 123','M?xico D.F.',null,'05033','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10277,'MORGK',2,'09-AUG-15 ','06-SEP-15 ','13-AUG-15 ',3,125.77,'Morgenstern Gesundkost','Heerstr. 22','Leipzig',null,'04179','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10278,'BERGS',8,'12-AUG-15 ','09-SEP-15 ','16-AUG-15 ',2,92.69,'Berglunds snabbk?p','Berguvsv?gen  8','Lule?',null,'S-958 22','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10279,'LEHMS',8,'13-AUG-15 ','10-SEP-15 ','16-AUG-15 ',2,25.83,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',null,'60528','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10280,'BERGS',2,'14-AUG-15 ','11-SEP-15 ','12-SEP-15 ',1,8.98,'Berglunds snabbk?p','Berguvsv?gen  8','Lule?',null,'S-958 22','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10281,'ROMEY',4,'14-AUG-15 ','28-AUG-15 ','21-AUG-15 ',1,2.94,'Romero y tomillo','Gran V?a, 1','Madrid',null,'28001','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10282,'ROMEY',4,'15-AUG-15 ','12-SEP-15 ','21-AUG-15 ',1,12.69,'Romero y tomillo','Gran V?a, 1','Madrid',null,'28001','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10283,'LILAS',3,'16-AUG-15 ','13-SEP-15 ','23-AUG-15 ',3,84.81,'LILA-Supermercado','Carrera 52 con Ave. Bol?var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10284,'LEHMS',4,'19-AUG-15 ','16-SEP-15 ','27-AUG-15 ',1,76.56,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',null,'60528','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10285,'QUICK',1,'20-AUG-15 ','17-SEP-15 ','26-AUG-15 ',2,76.83,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10286,'QUICK',8,'21-AUG-15 ','18-SEP-15 ','30-AUG-15 ',3,229.24,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10287,'RICAR',8,'22-AUG-15 ','19-SEP-15 ','28-AUG-15 ',3,12.76,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10288,'REGGC',4,'23-AUG-15 ','20-SEP-15 ','03-SEP-15 ',1,7.45,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',null,'42100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10289,'BSBEV',7,'26-AUG-15 ','23-SEP-15 ','28-AUG-15 ',3,22.77,'B''s Beverages','Fauntleroy Circus','London',null,'EC2 5NT','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10290,'COMMI',8,'27-AUG-15 ','24-SEP-15 ','03-SEP-15 ',1,79.7,'Com?rcio Mineiro','Av. dos Lus?adas, 23','Sao Paulo','SP','05432-043','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10291,'QUEDE',6,'27-AUG-15 ','24-SEP-15 ','04-SEP-15 ',2,6.4,'Que Del?cia','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10292,'TRADH',1,'28-AUG-15 ','25-SEP-15 ','02-SEP-15 ',2,1.35,'Tradi?ao Hipermercados','Av. In?s de Castro, 414','Sao Paulo','SP','05634-030','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10293,'TORTU',1,'29-AUG-15 ','26-SEP-15 ','11-SEP-15 ',3,21.18,'Tortuga Restaurante','Avda. Azteca 123','M?xico D.F.',null,'05033','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10294,'RATTC',4,'30-AUG-15 ','27-SEP-15 ','05-SEP-15 ',2,147.26,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10295,'VINET',2,'02-SEP-15 ','30-SEP-15 ','10-SEP-15 ',2,1.15,'Vins et alcools Chevalier','59 rue de l''Abbaye','Reims',null,'51100','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10296,'LILAS',6,'03-SEP-15 ','01-OCT-15 ','11-SEP-15 ',1,0.12,'LILA-Supermercado','Carrera 52 con Ave. Bol?var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10297,'BLONP',5,'04-SEP-15 ','16-OCT-15 ','10-SEP-15 ',2,5.74,'Blondel p?re et fils','24, place Kl?ber','Strasbourg',null,'67000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10298,'HUNGO',6,'05-SEP-15 ','03-OCT-15 ','11-SEP-15 ',2,168.22,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',null,'Ireland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10299,'RICAR',4,'06-SEP-15 ','04-OCT-15 ','13-SEP-15 ',2,29.76,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10300,'MAGAA',2,'09-SEP-15 ','07-OCT-15 ','18-SEP-15 ',2,17.68,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo',null,'24100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10301,'WANDK',8,'09-SEP-15 ','07-OCT-15 ','17-SEP-15 ',2,45.08,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart',null,'70563','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10302,'SUPRD',4,'10-SEP-15 ','08-OCT-15 ','09-OCT-15 ',2,6.27,'Supr?mes d?lices','Boulevard Tirou, 255','Charleroi',null,'B-6000','Belgium');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10303,'GODOS',7,'11-SEP-15 ','09-OCT-15 ','18-SEP-15 ',2,107.83,'Godos Cocina T?pica','C/ Romero, 33','Sevilla',null,'41101','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10304,'TORTU',1,'12-SEP-15 ','10-OCT-15 ','17-SEP-15 ',2,63.79,'Tortuga Restaurante','Avda. Azteca 123','M?xico D.F.',null,'05033','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10305,'OLDWO',8,'13-SEP-15 ','11-OCT-15 ','09-OCT-15 ',3,257.62,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10306,'ROMEY',1,'16-SEP-15 ','14-OCT-15 ','23-SEP-15 ',3,7.56,'Romero y tomillo','Gran V?a, 1','Madrid',null,'28001','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10307,'LONEP',2,'17-SEP-15 ','15-OCT-15 ','25-SEP-15 ',2,0.56,'Lonesome Pine Restaurant','89 Chiaroscuro Rd.','Portland','OR','97219','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10308,'ANATR',7,'18-SEP-15 ','16-OCT-15 ','24-SEP-15 ',3,1.61,'Ana Trujillo Emparedados y helados','Avda. de la Constituci?n 2222','M?xico D.F.',null,'05021','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10309,'HUNGO',3,'19-SEP-15 ','17-OCT-15 ','23-OCT-15 ',1,47.3,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',null,'Ireland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10310,'THEBI',8,'20-SEP-15 ','18-OCT-15 ','27-SEP-15 ',2,17.52,'The Big Cheese','89 Jefferson Way Suite 2','Portland','OR','97201','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10311,'DUMON',1,'20-SEP-15 ','04-OCT-15 ','26-SEP-15 ',3,24.69,'Du monde entier','67, rue des Cinquante Otages','Nantes',null,'44000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10312,'WANDK',2,'23-SEP-15 ','21-OCT-15 ','03-OCT-15 ',2,40.26,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart',null,'70563','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10313,'QUICK',2,'24-SEP-15 ','22-OCT-15 ','04-OCT-15 ',2,1.96,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10314,'RATTC',1,'25-SEP-15 ','23-OCT-15 ','04-OCT-15 ',2,74.16,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10315,'ISLAT',4,'26-SEP-15 ','24-OCT-15 ','03-OCT-15 ',2,41.76,'Island Trading','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10316,'RATTC',1,'27-SEP-15 ','25-OCT-15 ','08-OCT-15 ',3,150.15,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10317,'LONEP',6,'30-SEP-15 ','28-OCT-15 ','10-OCT-15 ',1,12.69,'Lonesome Pine Restaurant','89 Chiaroscuro Rd.','Portland','OR','97219','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10318,'ISLAT',8,'01-OCT-15 ','29-OCT-15 ','04-OCT-15 ',2,4.73,'Island Trading','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10319,'TORTU',7,'02-OCT-15 ','30-OCT-15 ','11-OCT-15 ',3,64.5,'Tortuga Restaurante','Avda. Azteca 123','M?xico D.F.',null,'05033','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10320,'WARTH',5,'03-OCT-15 ','17-OCT-15 ','18-OCT-15 ',3,34.57,'Wartian Herkku','Torikatu 38','Oulu',null,'90110','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10321,'ISLAT',3,'03-OCT-15 ','31-OCT-15 ','11-OCT-15 ',2,3.43,'Island Trading','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10322,'PERIC',7,'04-OCT-15 ','01-NOV-15 ','23-OCT-15 ',3,0.4,'Pericles Comidas cl?sicas','Calle Dr. Jorge Cash 321','M?xico D.F.',null,'05033','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10323,'KOENE',4,'07-OCT-15 ','04-NOV-15 ','14-OCT-15 ',1,4.88,'K?niglich Essen','Maubelstr. 90','Brandenburg',null,'14776','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10324,'SAVEA',9,'08-OCT-15 ','05-NOV-15 ','10-OCT-15 ',1,214.27,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10325,'KOENE',1,'09-OCT-15 ','23-OCT-15 ','14-OCT-15 ',3,64.86,'K?niglich Essen','Maubelstr. 90','Brandenburg',null,'14776','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10326,'BOLID',4,'10-OCT-15 ','07-NOV-15 ','14-OCT-15 ',2,77.92,'B?lido Comidas preparadas','C/ Araquil, 67','Madrid',null,'28023','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10327,'FOLKO',2,'11-OCT-15 ','08-NOV-15 ','14-OCT-15 ',1,63.36,'Folk och f? HB','?kergatan 24','Br?cke',null,'S-844 67','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10328,'FURIB',4,'14-OCT-15 ','11-NOV-15 ','17-OCT-15 ',3,87.03,'Furia Bacalhau e Frutos do Mar','Jardim das rosas n. 32','Lisboa',null,'1675','Portugal');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10329,'SPLIR',4,'15-OCT-15 ','26-NOV-15 ','23-OCT-15 ',2,191.67,'Split Rail Beer and Ale','P.O. Box 555','Lander','WY','82520','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10330,'LILAS',3,'16-OCT-15 ','13-NOV-15 ','28-OCT-15 ',1,12.75,'LILA-Supermercado','Carrera 52 con Ave. Bol?var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10331,'BONAP',9,'16-OCT-15 ','27-NOV-15 ','21-OCT-15 ',1,10.19,'Bon app''','12, rue des Bouchers','Marseille',null,'13008','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10332,'MEREP',3,'17-OCT-15 ','28-NOV-15 ','21-OCT-15 ',2,52.84,'M?re Paillarde','43 rue St. Laurent','Montr?al','Qu?bec','H1J 1C3','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10333,'WARTH',5,'18-OCT-15 ','15-NOV-15 ','25-OCT-15 ',3,0.59,'Wartian Herkku','Torikatu 38','Oulu',null,'90110','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10334,'VICTE',8,'21-OCT-15 ','18-NOV-15 ','28-OCT-15 ',2,8.56,'Victuailles en stock','2, rue du Commerce','Lyon',null,'69004','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10335,'HUNGO',7,'22-OCT-15 ','19-NOV-15 ','24-OCT-15 ',2,42.11,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',null,'Ireland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10336,'PRINI',7,'23-OCT-15 ','20-NOV-15 ','25-OCT-15 ',2,15.51,'Princesa Isabel Vinhos','Estrada da sa?de n. 58','Lisboa',null,'1756','Portugal');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10337,'FRANK',4,'24-OCT-15 ','21-NOV-15 ','29-OCT-15 ',3,108.26,'Frankenversand','Berliner Platz 43','M?nchen',null,'80805','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10338,'OLDWO',4,'25-OCT-15 ','22-NOV-15 ','29-OCT-15 ',3,84.21,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10339,'MEREP',2,'28-OCT-15 ','25-NOV-15 ','04-NOV-15 ',2,15.66,'M?re Paillarde','43 rue St. Laurent','Montr?al','Qu?bec','H1J 1C3','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10340,'BONAP',1,'29-OCT-15 ','26-NOV-15 ','08-NOV-15 ',3,166.31,'Bon app''','12, rue des Bouchers','Marseille',null,'13008','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10341,'SIMOB',7,'29-OCT-15 ','26-NOV-15 ','05-NOV-15 ',3,26.78,'Simons bistro','Vinb?ltet 34','Kobenhavn',null,'1734','Denmark');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10342,'FRANK',4,'30-OCT-15 ','13-NOV-15 ','04-NOV-15 ',2,54.83,'Frankenversand','Berliner Platz 43','M?nchen',null,'80805','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10343,'LEHMS',4,'31-OCT-15 ','28-NOV-15 ','06-NOV-15 ',1,110.37,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',null,'60528','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10344,'WHITC',4,'01-NOV-15 ','29-NOV-15 ','05-NOV-15 ',2,23.29,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10345,'QUICK',2,'04-NOV-15 ','02-DEC-15 ','11-NOV-15 ',2,249.06,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10346,'RATTC',3,'05-NOV-15 ','17-DEC-15 ','08-NOV-15 ',3,142.08,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10347,'FAMIA',4,'06-NOV-15 ','04-DEC-15 ','08-NOV-15 ',3,3.1,'Familia Arquibaldo','Rua Or?s, 92','Sao Paulo','SP','05442-030','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10348,'WANDK',4,'07-NOV-15 ','05-DEC-15 ','15-NOV-15 ',2,0.78,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart',null,'70563','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10349,'SPLIR',7,'08-NOV-15 ','06-DEC-15 ','15-NOV-15 ',1,8.63,'Split Rail Beer and Ale','P.O. Box 555','Lander','WY','82520','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10350,'LAMAI',6,'11-NOV-15 ','09-DEC-15 ','03-DEC-15 ',2,64.19,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',null,'31000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10351,'ERNSH',1,'11-NOV-15 ','09-DEC-15 ','20-NOV-15 ',1,162.33,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10352,'FURIB',3,'12-NOV-15 ','26-NOV-15 ','18-NOV-15 ',3,1.3,'Furia Bacalhau e Frutos do Mar','Jardim das rosas n. 32','Lisboa',null,'1675','Portugal');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10353,'PICCO',7,'13-NOV-15 ','11-DEC-15 ','25-NOV-15 ',3,360.63,'Piccolo und mehr','Geislweg 14','Salzburg',null,'5020','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10354,'PERIC',8,'14-NOV-15 ','12-DEC-15 ','20-NOV-15 ',3,53.8,'Pericles Comidas cl?sicas','Calle Dr. Jorge Cash 321','M?xico D.F.',null,'05033','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10355,'AROUT',6,'15-NOV-15 ','13-DEC-15 ','20-NOV-15 ',1,41.95,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10356,'WANDK',6,'18-NOV-15 ','16-DEC-15 ','27-NOV-15 ',2,36.71,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart',null,'70563','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10357,'LILAS',1,'19-NOV-15 ','17-DEC-15 ','02-DEC-15 ',3,34.88,'LILA-Supermercado','Carrera 52 con Ave. Bol?var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10358,'LAMAI',5,'20-NOV-15 ','18-DEC-15 ','27-NOV-15 ',1,19.64,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',null,'31000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10359,'SEVES',5,'21-NOV-15 ','19-DEC-15 ','26-NOV-15 ',3,288.43,'Seven Seas Imports','90 Wadhurst Rd.','London',null,'OX15 4NB','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10360,'BLONP',4,'22-NOV-15 ','20-DEC-15 ','02-DEC-15 ',3,131.7,'Blondel p?re et fils','24, place Kl?ber','Strasbourg',null,'67000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10361,'QUICK',1,'22-NOV-15 ','20-DEC-15 ','03-DEC-15 ',2,183.17,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10362,'BONAP',3,'25-NOV-15 ','23-DEC-15 ','28-NOV-15 ',1,96.04,'Bon app''','12, rue des Bouchers','Marseille',null,'13008','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10363,'DRACD',4,'26-NOV-15 ','24-DEC-15 ','04-DEC-15 ',3,30.54,'Drachenblut Delikatessen','Walserweg 21','Aachen',null,'52066','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10364,'EASTC',1,'26-NOV-15 ','07-JAN-16 ','04-DEC-15 ',1,71.97,'Eastern Connection','35 King George','London',null,'WX3 6FW','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10365,'ANTON',3,'27-NOV-15 ','25-DEC-15 ','02-DEC-15 ',2,22,'Antonio Moreno Taquer?a','Mataderos  2312','M?xico D.F.',null,'05023','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10366,'GALED',8,'28-NOV-15 ','09-JAN-16 ','30-DEC-15 ',2,10.14,'Galer?a del gastron?mo','Rambla de Catalu?a, 23','Barcelona',null,'8022','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10367,'VAFFE',7,'28-NOV-15 ','26-DEC-15 ','02-DEC-15 ',3,13.55,'Vaffeljernet','Smagsloget 45','?rhus',null,'8200','Denmark');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10368,'ERNSH',2,'29-NOV-15 ','27-DEC-15 ','02-DEC-15 ',2,101.95,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10369,'SPLIR',8,'02-DEC-15 ','30-DEC-15 ','09-DEC-15 ',2,195.68,'Split Rail Beer and Ale','P.O. Box 555','Lander','WY','82520','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10370,'CHOPS',6,'03-DEC-15 ','31-DEC-15 ','27-DEC-15 ',2,1.17,'Chop-suey Chinese','Hauptstr. 31','Bern',null,'3012','Switzerland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10371,'LAMAI',1,'03-DEC-15 ','31-DEC-15 ','24-DEC-15 ',1,0.45,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',null,'31000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10372,'QUEEN',5,'04-DEC-15 ','01-JAN-16 ','09-DEC-15 ',2,890.78,'Queen Cozinha','Alameda dos Can?rios, 891','Sao Paulo','SP','05487-020','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10373,'HUNGO',4,'05-DEC-15 ','02-JAN-16 ','11-DEC-15 ',3,124.12,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',null,'Ireland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10374,'WOLZA',1,'05-DEC-15 ','02-JAN-16 ','09-DEC-15 ',3,3.94,'Wolski Zajazd','ul. Filtrowa 68','Warszawa',null,'01-012','Poland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10500,'LAMAI',6,'09-APR-16 ','07-MAY-16 ','17-APR-16 ',1,42.68,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',null,'31000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10501,'BLAUS',9,'09-APR-16 ','07-MAY-16 ','16-APR-16 ',3,8.85,'Blauer See Delikatessen','Forsterstr. 57','Mannheim',null,'68306','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10502,'PERIC',2,'10-APR-16 ','08-MAY-16 ','29-APR-16 ',1,69.32,'Pericles Comidas cl?sicas','Calle Dr. Jorge Cash 321','M?xico D.F.',null,'05033','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10503,'HUNGO',6,'11-APR-16 ','09-MAY-16 ','16-APR-16 ',2,16.74,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',null,'Ireland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10504,'WHITC',4,'11-APR-16 ','09-MAY-16 ','18-APR-16 ',3,59.13,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10505,'MEREP',3,'14-APR-16 ','12-MAY-16 ','21-APR-16 ',3,7.13,'M?re Paillarde','43 rue St. Laurent','Montr?al','Qu?bec','H1J 1C3','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10506,'KOENE',9,'15-APR-16 ','13-MAY-16 ','02-MAY-16 ',2,21.19,'K?niglich Essen','Maubelstr. 90','Brandenburg',null,'14776','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10507,'ANTON',7,'15-APR-16 ','13-MAY-16 ','22-APR-16 ',1,47.45,'Antonio Moreno Taquer?a','Mataderos  2312','M?xico D.F.',null,'05023','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10508,'OTTIK',1,'16-APR-16 ','14-MAY-16 ','13-MAY-16 ',2,4.99,'Ottilies K?seladen','Mehrheimerstr. 369','K?ln',null,'50739','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10509,'BLAUS',4,'17-APR-16 ','15-MAY-16 ','29-APR-16 ',1,0.15,'Blauer See Delikatessen','Forsterstr. 57','Mannheim',null,'68306','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10510,'SAVEA',6,'18-APR-16 ','16-MAY-16 ','28-APR-16 ',3,367.63,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10511,'BONAP',4,'18-APR-16 ','16-MAY-16 ','21-APR-16 ',3,350.64,'Bon app''','12, rue des Bouchers','Marseille',null,'13008','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10512,'FAMIA',7,'21-APR-16 ','19-MAY-16 ','24-APR-16 ',2,3.53,'Familia Arquibaldo','Rua Or?s, 92','Sao Paulo','SP','05442-030','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10513,'WANDK',7,'22-APR-16 ','03-JUN-16 ','28-APR-16 ',1,105.65,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart',null,'70563','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10514,'ERNSH',3,'22-APR-16 ','20-MAY-16 ','16-MAY-16 ',2,789.95,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10515,'QUICK',2,'23-APR-16 ','07-MAY-16 ','23-MAY-16 ',1,204.47,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10516,'HUNGO',2,'24-APR-16 ','22-MAY-16 ','01-MAY-16 ',3,62.78,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',null,'Ireland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10517,'NORTS',3,'24-APR-16 ','22-MAY-16 ','29-APR-16 ',3,32.07,'North/South','South House 300 Queensbridge','London',null,'SW7 1RZ','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10518,'TORTU',4,'25-APR-16 ','09-MAY-16 ','05-MAY-16 ',2,218.15,'Tortuga Restaurante','Avda. Azteca 123','M?xico D.F.',null,'05033','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10519,'CHOPS',6,'28-APR-16 ','26-MAY-16 ','01-MAY-16 ',3,91.76,'Chop-suey Chinese','Hauptstr. 31','Bern',null,'3012','Switzerland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10520,'SANTG',7,'29-APR-16 ','27-MAY-16 ','01-MAY-16 ',1,13.37,'Sant? Gourmet','Erling Skakkes gate 78','Stavern',null,'4110','Norway');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10521,'CACTU',8,'29-APR-16 ','27-MAY-16 ','02-MAY-16 ',2,17.22,'Cactus Comidas para llevar','Cerrito 333','Buenos Aires',null,'1010','Argentina');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10522,'LEHMS',4,'30-APR-16 ','28-MAY-16 ','06-MAY-16 ',1,45.33,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',null,'60528','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10523,'SEVES',7,'01-MAY-16 ','29-MAY-16 ','30-MAY-16 ',2,77.63,'Seven Seas Imports','90 Wadhurst Rd.','London',null,'OX15 4NB','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10524,'BERGS',1,'01-MAY-16 ','29-MAY-16 ','07-MAY-16 ',2,244.79,'Berglunds snabbk?p','Berguvsv?gen  8','Lule?',null,'S-958 22','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10525,'BONAP',1,'02-MAY-16 ','30-MAY-16 ','23-MAY-16 ',2,11.06,'Bon app''','12, rue des Bouchers','Marseille',null,'13008','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10526,'WARTH',4,'05-MAY-16 ','02-JUN-16 ','15-MAY-16 ',2,58.59,'Wartian Herkku','Torikatu 38','Oulu',null,'90110','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10527,'QUICK',7,'05-MAY-16 ','02-JUN-16 ','07-MAY-16 ',1,41.9,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10528,'GREAL',6,'06-MAY-16 ','20-MAY-16 ','09-MAY-16 ',2,3.35,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10529,'MAISD',5,'07-MAY-16 ','04-JUN-16 ','09-MAY-16 ',2,66.69,'Maison Dewey','Rue Joseph-Bens 532','Bruxelles',null,'B-1180','Belgium');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10530,'PICCO',3,'08-MAY-16 ','05-JUN-16 ','12-MAY-16 ',2,339.22,'Piccolo und mehr','Geislweg 14','Salzburg',null,'5020','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10531,'OCEAN',7,'08-MAY-16 ','05-JUN-16 ','19-MAY-16 ',1,8.12,'Oc?ano Atl?ntico Ltda.','Ing. Gustavo Moncada 8585 Piso 20-A','Buenos Aires',null,'1010','Argentina');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10532,'EASTC',7,'09-MAY-16 ','06-JUN-16 ','12-MAY-16 ',3,74.46,'Eastern Connection','35 King George','London',null,'WX3 6FW','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10533,'FOLKO',8,'12-MAY-16 ','09-JUN-16 ','22-MAY-16 ',1,188.04,'Folk och f? HB','?kergatan 24','Br?cke',null,'S-844 67','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10534,'LEHMS',8,'12-MAY-16 ','09-JUN-16 ','14-MAY-16 ',2,27.94,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',null,'60528','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10535,'ANTON',4,'13-MAY-16 ','10-JUN-16 ','21-MAY-16 ',1,15.64,'Antonio Moreno Taquer?a','Mataderos  2312','M?xico D.F.',null,'05023','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10536,'LEHMS',3,'14-MAY-16 ','11-JUN-16 ','06-JUN-16 ',2,58.88,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',null,'60528','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10537,'RICSU',1,'14-MAY-16 ','28-MAY-16 ','19-MAY-16 ',1,78.85,'Richter Supermarkt','Starenweg 5','Gen?ve',null,'1204','Switzerland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10538,'BSBEV',9,'15-MAY-16 ','12-JUN-16 ','16-MAY-16 ',3,4.87,'B''s Beverages','Fauntleroy Circus','London',null,'EC2 5NT','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10539,'BSBEV',6,'16-MAY-16 ','13-JUN-16 ','23-MAY-16 ',3,12.36,'B''s Beverages','Fauntleroy Circus','London',null,'EC2 5NT','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10540,'QUICK',3,'19-MAY-16 ','16-JUN-16 ','13-JUN-16 ',3,1007.64,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10541,'HANAR',2,'19-MAY-16 ','16-JUN-16 ','29-MAY-16 ',1,68.65,'Hanari Carnes','Rua do Pa?o, 67','Rio de Janeiro','RJ','05454-876','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10542,'KOENE',1,'20-MAY-16 ','17-JUN-16 ','26-MAY-16 ',3,10.95,'K?niglich Essen','Maubelstr. 90','Brandenburg',null,'14776','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10543,'LILAS',8,'21-MAY-16 ','18-JUN-16 ','23-MAY-16 ',2,48.17,'LILA-Supermercado','Carrera 52 con Ave. Bol?var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10544,'LONEP',4,'21-MAY-16 ','18-JUN-16 ','30-MAY-16 ',1,24.91,'Lonesome Pine Restaurant','89 Chiaroscuro Rd.','Portland','OR','97219','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10545,'LAZYK',8,'22-MAY-16 ','19-JUN-16 ','26-JUN-16 ',2,11.92,'Lazy K Kountry Store','12 Orchestra Terrace','Walla Walla','WA','99362','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10546,'VICTE',1,'23-MAY-16 ','20-JUN-16 ','27-MAY-16 ',3,194.72,'Victuailles en stock','2, rue du Commerce','Lyon',null,'69004','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10547,'SEVES',3,'23-MAY-16 ','20-JUN-16 ','02-JUN-16 ',2,178.43,'Seven Seas Imports','90 Wadhurst Rd.','London',null,'OX15 4NB','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10548,'TOMSP',3,'26-MAY-16 ','23-JUN-16 ','02-JUN-16 ',2,1.43,'Toms Spezialit?ten','Luisenstr. 48','M?nster',null,'44087','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10549,'QUICK',5,'27-MAY-16 ','10-JUN-16 ','30-MAY-16 ',1,171.24,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10550,'GODOS',7,'28-MAY-16 ','25-JUN-16 ','06-JUN-16 ',3,4.32,'Godos Cocina T?pica','C/ Romero, 33','Sevilla',null,'41101','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10551,'FURIB',4,'28-MAY-16 ','09-JUL-16 ','06-JUN-16 ',3,72.95,'Furia Bacalhau e Frutos do Mar','Jardim das rosas n. 32','Lisboa',null,'1675','Portugal');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10552,'HILAA',2,'29-MAY-16 ','26-JUN-16 ','05-JUN-16 ',1,83.22,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist?bal','T?chira','5022','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10553,'WARTH',2,'30-MAY-16 ','27-JUN-16 ','03-JUN-16 ',2,149.49,'Wartian Herkku','Torikatu 38','Oulu',null,'90110','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10554,'OTTIK',4,'30-MAY-16 ','27-JUN-16 ','05-JUN-16 ',3,120.97,'Ottilies K?seladen','Mehrheimerstr. 369','K?ln',null,'50739','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10555,'SAVEA',6,'02-JUN-16 ','30-JUN-16 ','04-JUN-16 ',3,252.49,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10556,'SIMOB',2,'03-JUN-16 ','15-JUL-16 ','13-JUN-16 ',1,9.8,'Simons bistro','Vinb?ltet 34','Kobenhavn',null,'1734','Denmark');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10557,'LEHMS',9,'03-JUN-16 ','17-JUN-16 ','06-JUN-16 ',2,96.72,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',null,'60528','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10558,'AROUT',1,'04-JUN-16 ','02-JUL-16 ','10-JUN-16 ',2,72.97,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10559,'BLONP',6,'05-JUN-16 ','03-JUL-16 ','13-JUN-16 ',1,8.05,'Blondel p?re et fils','24, place Kl?ber','Strasbourg',null,'67000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10560,'FRANK',8,'06-JUN-16 ','04-JUL-16 ','09-JUN-16 ',1,36.65,'Frankenversand','Berliner Platz 43','M?nchen',null,'80805','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10561,'FOLKO',2,'06-JUN-16 ','04-JUL-16 ','09-JUN-16 ',2,242.21,'Folk och f? HB','?kergatan 24','Br?cke',null,'S-844 67','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10562,'REGGC',1,'09-JUN-16 ','07-JUL-16 ','12-JUN-16 ',1,22.95,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',null,'42100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10563,'RICAR',2,'10-JUN-16 ','22-JUL-16 ','24-JUN-16 ',2,60.43,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10375,'HUNGC',3,'06-DEC-15 ','03-JAN-16 ','09-DEC-15 ',2,20.12,'Hungry Coyote Import Store','City Center Plaza 516 Main St.','Elgin','OR','97827','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10376,'MEREP',1,'09-DEC-15 ','06-JAN-16 ','13-DEC-15 ',2,20.39,'M?re Paillarde','43 rue St. Laurent','Montr?al','Qu?bec','H1J 1C3','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10377,'SEVES',1,'09-DEC-15 ','06-JAN-16 ','13-DEC-15 ',3,22.21,'Seven Seas Imports','90 Wadhurst Rd.','London',null,'OX15 4NB','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10378,'FOLKO',5,'10-DEC-15 ','07-JAN-16 ','19-DEC-15 ',3,5.44,'Folk och f? HB','?kergatan 24','Br?cke',null,'S-844 67','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10379,'QUEDE',2,'11-DEC-15 ','08-JAN-16 ','13-DEC-15 ',1,45.03,'Que Del?cia','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10380,'HUNGO',8,'12-DEC-15 ','09-JAN-16 ','16-JAN-16 ',3,35.03,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',null,'Ireland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10381,'LILAS',3,'12-DEC-15 ','09-JAN-16 ','13-DEC-15 ',3,7.99,'LILA-Supermercado','Carrera 52 con Ave. Bol?var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10382,'ERNSH',4,'13-DEC-15 ','10-JAN-16 ','16-DEC-15 ',1,94.77,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10383,'AROUT',8,'16-DEC-15 ','13-JAN-16 ','18-DEC-15 ',3,34.24,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10384,'BERGS',3,'16-DEC-15 ','13-JAN-16 ','20-DEC-15 ',3,168.64,'Berglunds snabbk?p','Berguvsv?gen  8','Lule?',null,'S-958 22','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10385,'SPLIR',1,'17-DEC-15 ','14-JAN-16 ','23-DEC-15 ',2,30.96,'Split Rail Beer and Ale','P.O. Box 555','Lander','WY','82520','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10386,'FAMIA',9,'18-DEC-15 ','01-JAN-16 ','25-DEC-15 ',3,13.99,'Familia Arquibaldo','Rua Or?s, 92','Sao Paulo','SP','05442-030','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10387,'SANTG',1,'18-DEC-15 ','15-JAN-16 ','20-DEC-15 ',2,93.63,'Sant? Gourmet','Erling Skakkes gate 78','Stavern',null,'4110','Norway');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10388,'SEVES',2,'19-DEC-15 ','16-JAN-16 ','20-DEC-15 ',1,34.86,'Seven Seas Imports','90 Wadhurst Rd.','London',null,'OX15 4NB','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10389,'BOTTM',4,'20-DEC-15 ','17-JAN-16 ','24-DEC-15 ',2,47.42,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10390,'ERNSH',6,'23-DEC-15 ','20-JAN-16 ','26-DEC-15 ',1,126.38,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10391,'DRACD',3,'23-DEC-15 ','20-JAN-16 ','31-DEC-15 ',3,5.45,'Drachenblut Delikatessen','Walserweg 21','Aachen',null,'52066','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10392,'PICCO',2,'24-DEC-15 ','21-JAN-16 ','01-JAN-16 ',3,122.46,'Piccolo und mehr','Geislweg 14','Salzburg',null,'5020','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10393,'SAVEA',1,'25-DEC-15 ','22-JAN-16 ','03-JAN-16 ',3,126.56,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10394,'HUNGC',1,'25-DEC-15 ','22-JAN-16 ','03-JAN-16 ',3,30.34,'Hungry Coyote Import Store','City Center Plaza 516 Main St.','Elgin','OR','97827','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10395,'HILAA',6,'26-DEC-15 ','23-JAN-16 ','03-JAN-16 ',1,184.41,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist?bal','T?chira','5022','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10396,'FRANK',1,'27-DEC-15 ','10-JAN-16 ','06-JAN-16 ',3,135.35,'Frankenversand','Berliner Platz 43','M?nchen',null,'80805','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10397,'PRINI',5,'27-DEC-15 ','24-JAN-16 ','02-JAN-16 ',1,60.26,'Princesa Isabel Vinhos','Estrada da sa?de n. 58','Lisboa',null,'1756','Portugal');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10398,'SAVEA',2,'30-DEC-15 ','27-JAN-16 ','09-JAN-16 ',3,89.16,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10399,'VAFFE',8,'31-DEC-15 ','14-JAN-16 ','08-JAN-16 ',3,27.36,'Vaffeljernet','Smagsloget 45','?rhus',null,'8200','Denmark');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10400,'EASTC',1,'01-JAN-16 ','29-JAN-16 ','16-JAN-16 ',3,83.93,'Eastern Connection','35 King George','London',null,'WX3 6FW','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10401,'RATTC',1,'01-JAN-16 ','29-JAN-16 ','10-JAN-16 ',1,12.51,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10402,'ERNSH',8,'02-JAN-16 ','13-FEB-16 ','10-JAN-16 ',2,67.88,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10403,'ERNSH',4,'03-JAN-16 ','31-JAN-16 ','09-JAN-16 ',3,73.79,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10404,'MAGAA',2,'03-JAN-16 ','31-JAN-16 ','08-JAN-16 ',1,155.97,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo',null,'24100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10405,'LINOD',1,'06-JAN-16 ','03-FEB-16 ','22-JAN-16 ',1,34.82,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10406,'QUEEN',7,'07-JAN-16 ','18-FEB-16 ','13-JAN-16 ',1,108.04,'Queen Cozinha','Alameda dos Can?rios, 891','Sao Paulo','SP','05487-020','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10407,'OTTIK',2,'07-JAN-16 ','04-FEB-16 ','30-JAN-16 ',2,91.48,'Ottilies K?seladen','Mehrheimerstr. 369','K?ln',null,'50739','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10408,'FOLIG',8,'08-JAN-16 ','05-FEB-16 ','14-JAN-16 ',1,11.26,'Folies gourmandes','184, chauss?e de Tournai','Lille',null,'59000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10409,'OCEAN',3,'09-JAN-16 ','06-FEB-16 ','14-JAN-16 ',1,29.83,'Oc?ano Atl?ntico Ltda.','Ing. Gustavo Moncada 8585 Piso 20-A','Buenos Aires',null,'1010','Argentina');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10410,'BOTTM',3,'10-JAN-16 ','07-FEB-16 ','15-JAN-16 ',3,2.4,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10411,'BOTTM',9,'10-JAN-16 ','07-FEB-16 ','21-JAN-16 ',3,23.65,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10412,'WARTH',8,'13-JAN-16 ','10-FEB-16 ','15-JAN-16 ',2,3.77,'Wartian Herkku','Torikatu 38','Oulu',null,'90110','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10413,'LAMAI',3,'14-JAN-16 ','11-FEB-16 ','16-JAN-16 ',2,95.66,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',null,'31000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10414,'FAMIA',2,'14-JAN-16 ','11-FEB-16 ','17-JAN-16 ',3,21.48,'Familia Arquibaldo','Rua Or?s, 92','Sao Paulo','SP','05442-030','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10415,'HUNGC',3,'15-JAN-16 ','12-FEB-16 ','24-JAN-16 ',1,0.2,'Hungry Coyote Import Store','City Center Plaza 516 Main St.','Elgin','OR','97827','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10416,'WARTH',8,'16-JAN-16 ','13-FEB-16 ','27-JAN-16 ',3,22.72,'Wartian Herkku','Torikatu 38','Oulu',null,'90110','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10417,'SIMOB',4,'16-JAN-16 ','13-FEB-16 ','28-JAN-16 ',3,70.29,'Simons bistro','Vinb?ltet 34','Kobenhavn',null,'1734','Denmark');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10418,'QUICK',4,'17-JAN-16 ','14-FEB-16 ','24-JAN-16 ',1,17.55,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10419,'RICSU',4,'20-JAN-16 ','17-FEB-16 ','30-JAN-16 ',2,137.35,'Richter Supermarkt','Starenweg 5','Gen?ve',null,'1204','Switzerland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10420,'WELLI',3,'21-JAN-16 ','18-FEB-16 ','27-JAN-16 ',1,44.12,'Wellington Importadora','Rua do Mercado, 12','Resende','SP','08737-363','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10421,'QUEDE',8,'21-JAN-16 ','04-MAR-16 ','27-JAN-16 ',1,99.23,'Que Del?cia','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10422,'FRANS',2,'22-JAN-16 ','19-FEB-16 ','31-JAN-16 ',1,3.02,'Franchi S.p.A.','Via Monte Bianco 34','Torino',null,'10100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10423,'GOURL',6,'23-JAN-16 ','06-FEB-16 ','24-FEB-16 ',3,24.5,'Gourmet Lanchonetes','Av. Brasil, 442','Campinas','SP','04876-786','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10424,'MEREP',7,'23-JAN-16 ','20-FEB-16 ','27-JAN-16 ',2,370.61,'M?re Paillarde','43 rue St. Laurent','Montr?al','Qu?bec','H1J 1C3','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10425,'LAMAI',6,'24-JAN-16 ','21-FEB-16 ','14-FEB-16 ',2,7.93,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',null,'31000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10426,'GALED',4,'27-JAN-16 ','24-FEB-16 ','06-FEB-16 ',1,18.69,'Galer?a del gastron?mo','Rambla de Catalu?a, 23','Barcelona',null,'8022','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10427,'PICCO',4,'27-JAN-16 ','24-FEB-16 ','03-MAR-16 ',2,31.29,'Piccolo und mehr','Geislweg 14','Salzburg',null,'5020','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10428,'REGGC',7,'28-JAN-16 ','25-FEB-16 ','04-FEB-16 ',1,11.09,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',null,'42100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10429,'HUNGO',3,'29-JAN-16 ','12-MAR-16 ','07-FEB-16 ',2,56.63,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',null,'Ireland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10430,'ERNSH',4,'30-JAN-16 ','13-FEB-16 ','03-FEB-16 ',1,458.78,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10431,'BOTTM',4,'30-JAN-16 ','13-FEB-16 ','07-FEB-16 ',2,44.17,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10432,'SPLIR',3,'31-JAN-16 ','14-FEB-16 ','07-FEB-16 ',2,4.34,'Split Rail Beer and Ale','P.O. Box 555','Lander','WY','82520','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10433,'PRINI',3,'03-FEB-16 ','03-MAR-16 ','04-MAR-16 ',3,73.83,'Princesa Isabel Vinhos','Estrada da sa?de n. 58','Lisboa',null,'1756','Portugal');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10434,'FOLKO',3,'03-FEB-16 ','03-MAR-16 ','13-FEB-16 ',2,17.92,'Folk och f? HB','?kergatan 24','Br?cke',null,'S-844 67','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10435,'CONSH',8,'04-FEB-16 ','18-MAR-16 ','07-FEB-16 ',2,9.21,'Consolidated Holdings','Berkeley Gardens 12  Brewery','London',null,'WX1 6LT','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10436,'BLONP',3,'05-FEB-16 ','05-MAR-16 ','11-FEB-16 ',2,156.66,'Blondel p?re et fils','24, place Kl?ber','Strasbourg',null,'67000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10437,'WARTH',8,'05-FEB-16 ','05-MAR-16 ','12-FEB-16 ',1,19.97,'Wartian Herkku','Torikatu 38','Oulu',null,'90110','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10438,'TOMSP',3,'06-FEB-16 ','06-MAR-16 ','14-FEB-16 ',2,8.24,'Toms Spezialit?ten','Luisenstr. 48','M?nster',null,'44087','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10439,'MEREP',6,'07-FEB-16 ','07-MAR-16 ','10-FEB-16 ',3,4.07,'M?re Paillarde','43 rue St. Laurent','Montr?al','Qu?bec','H1J 1C3','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10440,'SAVEA',4,'10-FEB-16 ','10-MAR-16 ','28-FEB-16 ',2,86.53,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10441,'OLDWO',3,'10-FEB-16 ','24-MAR-16 ','14-MAR-16 ',2,73.02,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10442,'ERNSH',3,'11-FEB-16 ','11-MAR-16 ','18-FEB-16 ',2,47.94,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10443,'REGGC',8,'12-FEB-16 ','12-MAR-16 ','14-FEB-16 ',1,13.95,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',null,'42100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10444,'BERGS',3,'12-FEB-16 ','12-MAR-16 ','21-FEB-16 ',3,3.5,'Berglunds snabbk?p','Berguvsv?gen  8','Lule?',null,'S-958 22','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10445,'BERGS',3,'13-FEB-16 ','13-MAR-16 ','20-FEB-16 ',1,9.3,'Berglunds snabbk?p','Berguvsv?gen  8','Lule?',null,'S-958 22','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10446,'TOMSP',6,'14-FEB-16 ','14-MAR-16 ','19-FEB-16 ',1,14.68,'Toms Spezialit?ten','Luisenstr. 48','M?nster',null,'44087','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10447,'RICAR',4,'14-FEB-16 ','14-MAR-16 ','07-MAR-16 ',2,68.66,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10448,'RANCH',4,'17-FEB-16 ','17-MAR-16 ','24-FEB-16 ',2,38.82,'Rancho grande','Av. del Libertador 900','Buenos Aires',null,'1010','Argentina');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10449,'BLONP',3,'18-FEB-16 ','18-MAR-16 ','27-FEB-16 ',2,53.3,'Blondel p?re et fils','24, place Kl?ber','Strasbourg',null,'67000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10450,'VICTE',8,'19-FEB-16 ','19-MAR-16 ','11-MAR-16 ',2,7.23,'Victuailles en stock','2, rue du Commerce','Lyon',null,'69004','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10451,'QUICK',4,'19-FEB-16 ','05-MAR-16 ','12-MAR-16 ',3,189.09,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10452,'SAVEA',8,'20-FEB-16 ','20-MAR-16 ','26-FEB-16 ',1,140.26,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10453,'AROUT',1,'21-FEB-16 ','21-MAR-16 ','26-FEB-16 ',2,25.36,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10454,'LAMAI',4,'21-FEB-16 ','21-MAR-16 ','25-FEB-16 ',3,2.74,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',null,'31000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10455,'WARTH',8,'24-FEB-16 ','07-APR-16 ','03-MAR-16 ',2,180.45,'Wartian Herkku','Torikatu 38','Oulu',null,'90110','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10456,'KOENE',8,'25-FEB-16 ','08-APR-16 ','28-FEB-16 ',2,8.12,'K?niglich Essen','Maubelstr. 90','Brandenburg',null,'14776','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10457,'KOENE',2,'25-FEB-16 ','25-MAR-16 ','03-MAR-16 ',1,11.57,'K?niglich Essen','Maubelstr. 90','Brandenburg',null,'14776','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10458,'SUPRD',7,'26-FEB-16 ','26-MAR-16 ','04-MAR-16 ',3,147.06,'Supr?mes d?lices','Boulevard Tirou, 255','Charleroi',null,'B-6000','Belgium');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10459,'VICTE',4,'27-FEB-16 ','27-MAR-16 ','28-FEB-16 ',2,25.09,'Victuailles en stock','2, rue du Commerce','Lyon',null,'69004','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10460,'FOLKO',8,'28-FEB-16 ','28-MAR-16 ','03-MAR-16 ',1,16.27,'Folk och f? HB','?kergatan 24','Br?cke',null,'S-844 67','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10461,'LILAS',1,'28-FEB-16 ','28-MAR-16 ','05-MAR-16 ',3,148.61,'LILA-Supermercado','Carrera 52 con Ave. Bol?var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10462,'CONSH',2,'03-MAR-16 ','31-MAR-16 ','18-MAR-16 ',1,6.17,'Consolidated Holdings','Berkeley Gardens 12  Brewery','London',null,'WX1 6LT','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10463,'SUPRD',5,'04-MAR-16 ','01-APR-16 ','06-MAR-16 ',3,14.78,'Supr?mes d?lices','Boulevard Tirou, 255','Charleroi',null,'B-6000','Belgium');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10464,'FURIB',4,'04-MAR-16 ','01-APR-16 ','14-MAR-16 ',2,89,'Furia Bacalhau e Frutos do Mar','Jardim das rosas n. 32','Lisboa',null,'1675','Portugal');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10465,'VAFFE',1,'05-MAR-16 ','02-APR-16 ','14-MAR-16 ',3,145.04,'Vaffeljernet','Smagsloget 45','?rhus',null,'8200','Denmark');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10466,'COMMI',4,'06-MAR-16 ','03-APR-16 ','13-MAR-16 ',1,11.93,'Com?rcio Mineiro','Av. dos Lus?adas, 23','Sao Paulo','SP','05432-043','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10467,'MAGAA',8,'06-MAR-16 ','03-APR-16 ','11-MAR-16 ',2,4.93,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo',null,'24100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10468,'KOENE',3,'07-MAR-16 ','04-APR-16 ','12-MAR-16 ',3,44.12,'K?niglich Essen','Maubelstr. 90','Brandenburg',null,'14776','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10469,'WHITC',1,'10-MAR-16 ','07-APR-16 ','14-MAR-16 ',1,60.18,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10470,'BONAP',4,'11-MAR-16 ','08-APR-16 ','14-MAR-16 ',2,64.56,'Bon app''','12, rue des Bouchers','Marseille',null,'13008','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10471,'BSBEV',2,'11-MAR-16 ','08-APR-16 ','18-MAR-16 ',3,45.59,'B''s Beverages','Fauntleroy Circus','London',null,'EC2 5NT','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10472,'SEVES',8,'12-MAR-16 ','09-APR-16 ','19-MAR-16 ',1,4.2,'Seven Seas Imports','90 Wadhurst Rd.','London',null,'OX15 4NB','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10473,'ISLAT',1,'13-MAR-16 ','27-MAR-16 ','21-MAR-16 ',3,16.37,'Island Trading','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10474,'PERIC',5,'13-MAR-16 ','10-APR-16 ','21-MAR-16 ',2,83.49,'Pericles Comidas cl?sicas','Calle Dr. Jorge Cash 321','M?xico D.F.',null,'05033','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10475,'SUPRD',9,'14-MAR-16 ','11-APR-16 ','04-APR-16 ',1,68.52,'Supr?mes d?lices','Boulevard Tirou, 255','Charleroi',null,'B-6000','Belgium');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10476,'HILAA',8,'17-MAR-16 ','14-APR-16 ','24-MAR-16 ',3,4.41,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist?bal','T?chira','5022','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10477,'PRINI',5,'17-MAR-16 ','14-APR-16 ','25-MAR-16 ',2,13.02,'Princesa Isabel Vinhos','Estrada da sa?de n. 58','Lisboa',null,'1756','Portugal');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10478,'VICTE',2,'18-MAR-16 ','01-APR-16 ','26-MAR-16 ',3,4.81,'Victuailles en stock','2, rue du Commerce','Lyon',null,'69004','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10479,'RATTC',3,'19-MAR-16 ','16-APR-16 ','21-MAR-16 ',3,708.95,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10480,'FOLIG',6,'20-MAR-16 ','17-APR-16 ','24-MAR-16 ',2,1.35,'Folies gourmandes','184, chauss?e de Tournai','Lille',null,'59000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10481,'RICAR',8,'20-MAR-16 ','17-APR-16 ','25-MAR-16 ',2,64.33,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10482,'LAZYK',1,'21-MAR-16 ','18-APR-16 ','10-APR-16 ',3,7.48,'Lazy K Kountry Store','12 Orchestra Terrace','Walla Walla','WA','99362','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10483,'WHITC',7,'24-MAR-16 ','21-APR-16 ','25-APR-16 ',2,15.28,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10484,'BSBEV',3,'24-MAR-16 ','21-APR-16 ','01-APR-16 ',3,6.88,'B''s Beverages','Fauntleroy Circus','London',null,'EC2 5NT','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10485,'LINOD',4,'25-MAR-16 ','08-APR-16 ','31-MAR-16 ',2,64.45,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10486,'HILAA',1,'26-MAR-16 ','23-APR-16 ','02-APR-16 ',2,30.53,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist?bal','T?chira','5022','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10487,'QUEEN',2,'26-MAR-16 ','23-APR-16 ','28-MAR-16 ',2,71.07,'Queen Cozinha','Alameda dos Can?rios, 891','Sao Paulo','SP','05487-020','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10488,'FRANK',8,'27-MAR-16 ','24-APR-16 ','02-APR-16 ',2,4.93,'Frankenversand','Berliner Platz 43','M?nchen',null,'80805','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10489,'PICCO',6,'28-MAR-16 ','25-APR-16 ','09-APR-16 ',2,5.29,'Piccolo und mehr','Geislweg 14','Salzburg',null,'5020','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10490,'HILAA',7,'31-MAR-16 ','28-APR-16 ','03-APR-16 ',2,210.19,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist?bal','T?chira','5022','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10491,'FURIB',8,'31-MAR-16 ','28-APR-16 ','08-APR-16 ',3,16.96,'Furia Bacalhau e Frutos do Mar','Jardim das rosas n. 32','Lisboa',null,'1675','Portugal');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10492,'BOTTM',3,'01-APR-16 ','29-APR-16 ','11-APR-16 ',1,62.89,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10493,'LAMAI',4,'02-APR-16 ','30-APR-16 ','10-APR-16 ',3,10.64,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',null,'31000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10494,'COMMI',4,'02-APR-16 ','30-APR-16 ','09-APR-16 ',2,65.99,'Com?rcio Mineiro','Av. dos Lus?adas, 23','Sao Paulo','SP','05432-043','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10495,'LAUGB',3,'03-APR-16 ','01-MAY-16 ','11-APR-16 ',3,4.65,'Laughing Bacchus Wine Cellars','2319 Elm St.','Vancouver','BC','V3F 2K1','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10496,'TRADH',7,'04-APR-16 ','02-MAY-16 ','07-APR-16 ',2,46.77,'Tradi?ao Hipermercados','Av. In?s de Castro, 414','Sao Paulo','SP','05634-030','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10497,'LEHMS',7,'04-APR-16 ','02-MAY-16 ','07-APR-16 ',1,36.21,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',null,'60528','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10498,'HILAA',8,'07-APR-16 ','05-MAY-16 ','11-APR-16 ',2,29.75,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist?bal','T?chira','5022','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10499,'LILAS',4,'08-APR-16 ','06-MAY-16 ','16-APR-16 ',2,102.02,'LILA-Supermercado','Carrera 52 con Ave. Bol?var #65-17 Llano Largo','Barquisimeto','Lara','3508','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10691,'QUICK',2,'03-OCT-16 ','14-NOV-16 ','22-OCT-16 ',2,810.05,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10692,'ALFKI',4,'03-OCT-16 ','31-OCT-16 ','13-OCT-16 ',2,61.02,'Alfred''s Futterkiste','Obere Str. 57','Berlin',null,'12209','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10693,'WHITC',3,'06-OCT-16 ','20-OCT-16 ','10-OCT-16 ',3,139.34,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10694,'QUICK',8,'06-OCT-16 ','03-NOV-16 ','09-OCT-16 ',3,398.36,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10695,'WILMK',7,'07-OCT-16 ','18-NOV-16 ','14-OCT-16 ',1,16.72,'Wilman Kala','Keskuskatu 45','Helsinki',null,'21240','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10696,'WHITC',8,'08-OCT-16 ','19-NOV-16 ','14-OCT-16 ',3,102.55,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10697,'LINOD',3,'08-OCT-16 ','05-NOV-16 ','14-OCT-16 ',1,45.52,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10698,'ERNSH',4,'09-OCT-16 ','06-NOV-16 ','17-OCT-16 ',1,272.47,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10699,'MORGK',3,'09-OCT-16 ','06-NOV-16 ','13-OCT-16 ',3,0.58,'Morgenstern Gesundkost','Heerstr. 22','Leipzig',null,'04179','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10700,'SAVEA',3,'10-OCT-16 ','07-NOV-16 ','16-OCT-16 ',1,65.1,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10701,'HUNGO',6,'13-OCT-16 ','27-OCT-16 ','15-OCT-16 ',3,220.31,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',null,'Ireland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10702,'ALFKI',4,'13-OCT-16 ','24-NOV-16 ','21-OCT-16 ',1,23.94,'Alfred''s Futterkiste','Obere Str. 57','Berlin',null,'12209','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10703,'FOLKO',6,'14-OCT-16 ','11-NOV-16 ','20-OCT-16 ',2,152.3,'Folk och f? HB','?kergatan 24','Br?cke',null,'S-844 67','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10704,'QUEEN',6,'14-OCT-16 ','11-NOV-16 ','07-NOV-16 ',1,4.78,'Queen Cozinha','Alameda dos Can?rios, 891','Sao Paulo','SP','05487-020','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10705,'HILAA',9,'15-OCT-16 ','12-NOV-16 ','18-NOV-16 ',2,3.52,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist?bal','T?chira','5022','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10706,'OLDWO',8,'16-OCT-16 ','13-NOV-16 ','21-OCT-16 ',3,135.63,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10707,'AROUT',4,'16-OCT-16 ','30-OCT-16 ','23-OCT-16 ',3,21.74,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10708,'THEBI',6,'17-OCT-16 ','28-NOV-16 ','05-NOV-16 ',2,2.96,'The Big Cheese','89 Jefferson Way Suite 2','Portland','OR','97201','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10709,'GOURL',1,'17-OCT-16 ','14-NOV-16 ','20-NOV-16 ',3,210.8,'Gourmet Lanchonetes','Av. Brasil, 442','Campinas','SP','04876-786','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10710,'FRANS',1,'20-OCT-16 ','17-NOV-16 ','23-OCT-16 ',1,4.98,'Franchi S.p.A.','Via Monte Bianco 34','Torino',null,'10100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10711,'SAVEA',5,'21-OCT-16 ','02-DEC-16 ','29-OCT-16 ',2,52.41,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10712,'HUNGO',3,'21-OCT-16 ','18-NOV-16 ','31-OCT-16 ',1,89.93,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',null,'Ireland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10713,'SAVEA',1,'22-OCT-16 ','19-NOV-16 ','24-OCT-16 ',1,167.05,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10714,'SAVEA',5,'22-OCT-16 ','19-NOV-16 ','27-OCT-16 ',3,24.49,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10715,'BONAP',3,'23-OCT-16 ','06-NOV-16 ','29-OCT-16 ',1,63.2,'Bon app''','12, rue des Bouchers','Marseille',null,'13008','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10716,'RANCH',4,'24-OCT-16 ','21-NOV-16 ','27-OCT-16 ',2,22.57,'Rancho grande','Av. del Libertador 900','Buenos Aires',null,'1010','Argentina');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10717,'FRANK',1,'24-OCT-16 ','21-NOV-16 ','29-OCT-16 ',2,59.25,'Frankenversand','Berliner Platz 43','M?nchen',null,'80805','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10718,'KOENE',1,'27-OCT-16 ','24-NOV-16 ','29-OCT-16 ',3,170.88,'K?niglich Essen','Maubelstr. 90','Brandenburg',null,'14776','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10719,'LETSS',8,'27-OCT-16 ','24-NOV-16 ','05-NOV-16 ',2,51.44,'Let''s Stop N Shop','87 Polk St. Suite 5','San Francisco','CA','94117','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10720,'QUEDE',8,'28-OCT-16 ','11-NOV-16 ','05-NOV-16 ',2,9.53,'Que Del?cia','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10721,'QUICK',5,'29-OCT-16 ','26-NOV-16 ','31-OCT-16 ',3,48.92,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10722,'SAVEA',8,'29-OCT-16 ','10-DEC-16 ','04-NOV-16 ',1,74.58,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10723,'WHITC',3,'30-OCT-16 ','27-NOV-16 ','25-NOV-16 ',1,21.72,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10724,'MEREP',8,'30-OCT-16 ','11-DEC-16 ','05-NOV-16 ',2,57.75,'M?re Paillarde','43 rue St. Laurent','Montr?al','Qu?bec','H1J 1C3','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10725,'FAMIA',4,'31-OCT-16 ','28-NOV-16 ','05-NOV-16 ',3,10.83,'Familia Arquibaldo','Rua Or?s, 92','Sao Paulo','SP','05442-030','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10726,'EASTC',4,'03-NOV-16 ','17-NOV-16 ','05-DEC-16 ',1,16.56,'Eastern Connection','35 King George','London',null,'WX3 6FW','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10727,'REGGC',2,'03-NOV-16 ','01-DEC-16 ','05-DEC-16 ',1,89.9,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',null,'42100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10728,'QUEEN',4,'04-NOV-16 ','02-DEC-16 ','11-NOV-16 ',2,58.33,'Queen Cozinha','Alameda dos Can?rios, 891','Sao Paulo','SP','05487-020','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10729,'LINOD',8,'04-NOV-16 ','16-DEC-16 ','14-NOV-16 ',3,141.06,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10730,'BONAP',5,'05-NOV-16 ','03-DEC-16 ','14-NOV-16 ',1,20.12,'Bon app''','12, rue des Bouchers','Marseille',null,'13008','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10731,'CHOPS',7,'06-NOV-16 ','04-DEC-16 ','14-NOV-16 ',1,96.65,'Chop-suey Chinese','Hauptstr. 31','Bern',null,'3012','Switzerland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10732,'BONAP',3,'06-NOV-16 ','04-DEC-16 ','07-NOV-16 ',1,16.97,'Bon app''','12, rue des Bouchers','Marseille',null,'13008','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10733,'BERGS',1,'07-NOV-16 ','05-DEC-16 ','10-NOV-16 ',3,110.11,'Berglunds snabbk?p','Berguvsv?gen  8','Lule?',null,'S-958 22','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10734,'GOURL',2,'07-NOV-16 ','05-DEC-16 ','12-NOV-16 ',3,1.63,'Gourmet Lanchonetes','Av. Brasil, 442','Campinas','SP','04876-786','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10735,'LETSS',6,'10-NOV-16 ','08-DEC-16 ','21-NOV-16 ',2,45.97,'Let''s Stop N Shop','87 Polk St. Suite 5','San Francisco','CA','94117','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10736,'HUNGO',9,'11-NOV-16 ','09-DEC-16 ','21-NOV-16 ',2,44.1,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',null,'Ireland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10737,'VINET',2,'11-NOV-16 ','09-DEC-16 ','18-NOV-16 ',2,7.79,'Vins et alcools Chevalier','59 rue de l''Abbaye','Reims',null,'51100','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10738,'SPECD',2,'12-NOV-16 ','10-DEC-16 ','18-NOV-16 ',1,2.91,'Sp?cialit?s du monde','25, rue Lauriston','Paris',null,'75016','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10739,'VINET',3,'12-NOV-16 ','10-DEC-16 ','17-NOV-16 ',3,11.08,'Vins et alcools Chevalier','59 rue de l''Abbaye','Reims',null,'51100','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10740,'WHITC',4,'13-NOV-16 ','11-DEC-16 ','25-NOV-16 ',2,81.88,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10741,'AROUT',4,'14-NOV-16 ','28-NOV-16 ','18-NOV-16 ',3,10.96,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10742,'BOTTM',3,'14-NOV-16 ','12-DEC-16 ','18-NOV-16 ',3,243.73,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10743,'AROUT',1,'17-NOV-16 ','15-DEC-16 ','21-NOV-16 ',2,23.72,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10744,'VAFFE',6,'17-NOV-16 ','15-DEC-16 ','24-NOV-16 ',1,69.19,'Vaffeljernet','Smagsloget 45','?rhus',null,'8200','Denmark');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10745,'QUICK',9,'18-NOV-16 ','16-DEC-16 ','27-NOV-16 ',1,3.52,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10746,'CHOPS',1,'19-NOV-16 ','17-DEC-16 ','21-NOV-16 ',3,31.43,'Chop-suey Chinese','Hauptstr. 31','Bern',null,'3012','Switzerland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10747,'PICCO',6,'19-NOV-16 ','17-DEC-16 ','26-NOV-16 ',1,117.33,'Piccolo und mehr','Geislweg 14','Salzburg',null,'5020','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10748,'SAVEA',3,'20-NOV-16 ','18-DEC-16 ','28-NOV-16 ',1,232.55,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10749,'ISLAT',4,'20-NOV-16 ','18-DEC-16 ','19-DEC-16 ',2,61.53,'Island Trading','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10750,'WARTH',9,'21-NOV-16 ','19-DEC-16 ','24-NOV-16 ',1,79.3,'Wartian Herkku','Torikatu 38','Oulu',null,'90110','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10751,'RICSU',3,'24-NOV-16 ','22-DEC-16 ','03-DEC-16 ',3,130.79,'Richter Supermarkt','Starenweg 5','Gen?ve',null,'1204','Switzerland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10752,'NORTS',2,'24-NOV-16 ','22-DEC-16 ','28-NOV-16 ',3,1.39,'North/South','South House 300 Queensbridge','London',null,'SW7 1RZ','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10753,'FRANS',3,'25-NOV-16 ','23-DEC-16 ','27-NOV-16 ',1,7.7,'Franchi S.p.A.','Via Monte Bianco 34','Torino',null,'10100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10754,'MAGAA',6,'25-NOV-16 ','23-DEC-16 ','27-NOV-16 ',3,2.38,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo',null,'24100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10755,'BONAP',4,'26-NOV-16 ','24-DEC-16 ','28-NOV-16 ',2,16.71,'Bon app''','12, rue des Bouchers','Marseille',null,'13008','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10756,'SPLIR',8,'27-NOV-16 ','25-DEC-16 ','02-DEC-16 ',2,73.21,'Split Rail Beer and Ale','P.O. Box 555','Lander','WY','82520','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10757,'SAVEA',6,'27-NOV-16 ','25-DEC-16 ','15-DEC-16 ',1,8.19,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10758,'RICSU',3,'28-NOV-16 ','26-DEC-16 ','04-DEC-16 ',3,138.17,'Richter Supermarkt','Starenweg 5','Gen?ve',null,'1204','Switzerland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10759,'ANATR',3,'28-NOV-16 ','26-DEC-16 ','12-DEC-16 ',3,11.99,'Ana Trujillo Emparedados y helados','Avda. de la Constituci?n 2222','M?xico D.F.',null,'05021','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10760,'MAISD',4,'01-DEC-16 ','29-DEC-16 ','10-DEC-16 ',1,155.64,'Maison Dewey','Rue Joseph-Bens 532','Bruxelles',null,'B-1180','Belgium');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10761,'RATTC',5,'02-DEC-16 ','30-DEC-16 ','08-DEC-16 ',2,18.66,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10762,'FOLKO',3,'02-DEC-16 ','30-DEC-16 ','09-DEC-16 ',1,328.74,'Folk och f? HB','?kergatan 24','Br?cke',null,'S-844 67','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10763,'FOLIG',3,'03-DEC-16 ','31-DEC-16 ','08-DEC-16 ',3,37.35,'Folies gourmandes','184, chauss?e de Tournai','Lille',null,'59000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10764,'ERNSH',6,'03-DEC-16 ','31-DEC-16 ','08-DEC-16 ',3,145.45,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10765,'QUICK',3,'04-DEC-16 ','01-JAN-17 ','09-DEC-16 ',3,42.74,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10766,'OTTIK',4,'05-DEC-16 ','02-JAN-17 ','09-DEC-16 ',1,157.55,'Ottilies K?seladen','Mehrheimerstr. 369','K?ln',null,'50739','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10767,'SUPRD',4,'05-DEC-16 ','02-JAN-17 ','15-DEC-16 ',3,1.59,'Supr?mes d?lices','Boulevard Tirou, 255','Charleroi',null,'B-6000','Belgium');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10768,'AROUT',3,'08-DEC-16 ','05-JAN-17 ','15-DEC-16 ',2,146.32,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10769,'VAFFE',3,'08-DEC-16 ','05-JAN-17 ','12-DEC-16 ',1,65.06,'Vaffeljernet','Smagsloget 45','?rhus',null,'8200','Denmark');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10770,'HANAR',8,'09-DEC-16 ','06-JAN-17 ','17-DEC-16 ',3,5.32,'Hanari Carnes','Rua do Pa?o, 67','Rio de Janeiro','RJ','05454-876','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10771,'ERNSH',9,'10-DEC-16 ','07-JAN-17 ','02-JAN-17 ',2,11.19,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10772,'LEHMS',3,'10-DEC-16 ','07-JAN-17 ','19-DEC-16 ',2,91.28,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',null,'60528','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10773,'ERNSH',1,'11-DEC-16 ','08-JAN-17 ','16-DEC-16 ',3,96.43,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10774,'FOLKO',4,'11-DEC-16 ','25-DEC-16 ','12-DEC-16 ',1,48.2,'Folk och f? HB','?kergatan 24','Br?cke',null,'S-844 67','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10775,'THECR',7,'12-DEC-16 ','09-JAN-17 ','26-DEC-16 ',1,20.25,'The Cracker Box','55 Grizzly Peak Rd.','Butte','MT','59801','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10776,'ERNSH',1,'15-DEC-16 ','12-JAN-17 ','18-DEC-16 ',3,351.53,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10777,'GOURL',7,'15-DEC-16 ','29-DEC-16 ','21-JAN-17 ',2,3.01,'Gourmet Lanchonetes','Av. Brasil, 442','Campinas','SP','04876-786','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10778,'BERGS',3,'16-DEC-16 ','13-JAN-17 ','24-DEC-16 ',1,6.79,'Berglunds snabbk?p','Berguvsv?gen  8','Lule?',null,'S-958 22','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10779,'MORGK',3,'16-DEC-16 ','13-JAN-17 ','14-JAN-17 ',2,58.13,'Morgenstern Gesundkost','Heerstr. 22','Leipzig',null,'04179','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10780,'LILAS',2,'16-DEC-16 ','30-DEC-16 ','25-DEC-16 ',1,42.13,'LILA-Supermercado','Carrera 52 con Ave. Bol?var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10781,'WARTH',2,'17-DEC-16 ','14-JAN-17 ','19-DEC-16 ',3,73.16,'Wartian Herkku','Torikatu 38','Oulu',null,'90110','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10782,'CACTU',9,'17-DEC-16 ','14-JAN-17 ','22-DEC-16 ',3,1.1,'Cactus Comidas para llevar','Cerrito 333','Buenos Aires',null,'1010','Argentina');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10783,'HANAR',4,'18-DEC-16 ','15-JAN-17 ','19-DEC-16 ',2,124.98,'Hanari Carnes','Rua do Pa?o, 67','Rio de Janeiro','RJ','05454-876','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10784,'MAGAA',4,'18-DEC-16 ','15-JAN-17 ','22-DEC-16 ',3,70.09,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo',null,'24100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10785,'GROSR',1,'18-DEC-16 ','15-JAN-17 ','24-DEC-16 ',3,1.51,'GROSELLA-Restaurante','5? Ave. Los Palos Grandes','Caracas','DF','1081','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10786,'QUEEN',8,'19-DEC-16 ','16-JAN-17 ','23-DEC-16 ',1,110.87,'Queen Cozinha','Alameda dos Can?rios, 891','Sao Paulo','SP','05487-020','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10787,'LAMAI',2,'19-DEC-16 ','02-JAN-17 ','26-DEC-16 ',1,249.93,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',null,'31000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10788,'QUICK',1,'22-DEC-16 ','19-JAN-17 ','19-JAN-17 ',2,42.7,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10789,'FOLIG',1,'22-DEC-16 ','19-JAN-17 ','31-DEC-16 ',2,100.6,'Folies gourmandes','184, chauss?e de Tournai','Lille',null,'59000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10790,'GOURL',6,'22-DEC-16 ','19-JAN-17 ','26-DEC-16 ',1,28.23,'Gourmet Lanchonetes','Av. Brasil, 442','Campinas','SP','04876-786','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10791,'FRANK',6,'23-DEC-16 ','20-JAN-17 ','01-JAN-17 ',2,16.85,'Frankenversand','Berliner Platz 43','M?nchen',null,'80805','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10792,'WOLZA',1,'23-DEC-16 ','20-JAN-17 ','31-DEC-16 ',3,23.79,'Wolski Zajazd','ul. Filtrowa 68','Warszawa',null,'01-012','Poland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10793,'AROUT',3,'24-DEC-16 ','21-JAN-17 ','08-JAN-17 ',3,4.52,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10794,'QUEDE',6,'24-DEC-16 ','21-JAN-17 ','02-JAN-17 ',1,21.49,'Que Del?cia','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10795,'ERNSH',8,'24-DEC-16 ','21-JAN-17 ','20-JAN-17 ',2,126.66,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10796,'HILAA',3,'25-DEC-16 ','22-JAN-17 ','14-JAN-17 ',1,26.52,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist?bal','T?chira','5022','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10797,'DRACD',7,'25-DEC-16 ','22-JAN-17 ','05-JAN-17 ',2,33.35,'Drachenblut Delikatessen','Walserweg 21','Aachen',null,'52066','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10798,'ISLAT',2,'26-DEC-16 ','23-JAN-17 ','05-JAN-17 ',1,2.33,'Island Trading','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10799,'KOENE',9,'26-DEC-16 ','06-FEB-17 ','05-JAN-17 ',3,30.76,'K?niglich Essen','Maubelstr. 90','Brandenburg',null,'14776','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10800,'SEVES',1,'26-DEC-16 ','23-JAN-17 ','05-JAN-17 ',3,137.44,'Seven Seas Imports','90 Wadhurst Rd.','London',null,'OX15 4NB','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10801,'BOLID',4,'29-DEC-16 ','26-JAN-17 ','31-DEC-16 ',2,97.09,'B?lido Comidas preparadas','C/ Araquil, 67','Madrid',null,'28023','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10802,'SIMOB',4,'29-DEC-16 ','26-JAN-17 ','02-JAN-17 ',2,257.26,'Simons bistro','Vinb?ltet 34','Kobenhavn',null,'1734','Denmark');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10803,'WELLI',4,'30-DEC-16 ','27-JAN-17 ','06-JAN-17 ',1,55.23,'Wellington Importadora','Rua do Mercado, 12','Resende','SP','08737-363','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10804,'SEVES',6,'30-DEC-16 ','27-JAN-17 ','07-JAN-17 ',2,27.33,'Seven Seas Imports','90 Wadhurst Rd.','London',null,'OX15 4NB','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10805,'THEBI',2,'30-DEC-16 ','27-JAN-17 ','09-JAN-17 ',3,237.34,'The Big Cheese','89 Jefferson Way Suite 2','Portland','OR','97201','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10806,'VICTE',3,'31-DEC-16 ','28-JAN-17 ','05-JAN-17 ',2,22.11,'Victuailles en stock','2, rue du Commerce','Lyon',null,'69004','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10807,'FRANS',4,'31-DEC-16 ','28-JAN-17 ','30-JAN-17 ',1,1.36,'Franchi S.p.A.','Via Monte Bianco 34','Torino',null,'10100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10808,'OLDWO',2,'01-JAN-17 ','29-JAN-17 ','09-JAN-17 ',3,45.53,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10809,'WELLI',7,'01-JAN-17 ','29-JAN-17 ','07-JAN-17 ',1,4.87,'Wellington Importadora','Rua do Mercado, 12','Resende','SP','08737-363','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10810,'LAUGB',2,'01-JAN-17 ','29-JAN-17 ','07-JAN-17 ',3,4.33,'Laughing Bacchus Wine Cellars','2319 Elm St.','Vancouver','BC','V3F 2K1','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10811,'LINOD',8,'02-JAN-17 ','30-JAN-17 ','08-JAN-17 ',1,31.22,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10812,'REGGC',5,'02-JAN-17 ','30-JAN-17 ','12-JAN-17 ',1,59.78,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',null,'42100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10813,'RICAR',1,'05-JAN-17 ','02-FEB-17 ','09-JAN-17 ',1,47.38,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10814,'VICTE',3,'05-JAN-17 ','02-FEB-17 ','14-JAN-17 ',3,130.94,'Victuailles en stock','2, rue du Commerce','Lyon',null,'69004','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10815,'SAVEA',2,'05-JAN-17 ','02-FEB-17 ','14-JAN-17 ',3,14.62,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10816,'GREAL',4,'06-JAN-17 ','03-FEB-17 ','04-FEB-17 ',2,719.78,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10817,'KOENE',3,'06-JAN-17 ','20-JAN-17 ','13-JAN-17 ',2,306.07,'K?niglich Essen','Maubelstr. 90','Brandenburg',null,'14776','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10818,'MAGAA',7,'07-JAN-17 ','04-FEB-17 ','12-JAN-17 ',3,65.48,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo',null,'24100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11008,'ERNSH',7,'08-APR-17 ','06-MAY-17 ',null,3,79.46,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11009,'GODOS',2,'08-APR-17 ','06-MAY-17 ','10-APR-17 ',1,59.11,'Godos Cocina T?pica','C/ Romero, 33','Sevilla',null,'41101','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11010,'REGGC',2,'09-APR-17 ','07-MAY-17 ','21-APR-17 ',2,28.71,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',null,'42100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11011,'ALFKI',3,'09-APR-17 ','07-MAY-17 ','13-APR-17 ',1,1.21,'Alfred''s Futterkiste','Obere Str. 57','Berlin',null,'12209','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11012,'FRANK',1,'09-APR-17 ','23-APR-17 ','17-APR-17 ',3,242.95,'Frankenversand','Berliner Platz 43','M?nchen',null,'80805','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11013,'ROMEY',2,'09-APR-17 ','07-MAY-17 ','10-APR-17 ',1,32.99,'Romero y tomillo','Gran V?a, 1','Madrid',null,'28001','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11014,'LINOD',2,'10-APR-17 ','08-MAY-17 ','15-APR-17 ',3,23.6,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11015,'SANTG',2,'10-APR-17 ','24-APR-17 ','20-APR-17 ',2,4.62,'Sant? Gourmet','Erling Skakkes gate 78','Stavern',null,'4110','Norway');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11016,'AROUT',9,'10-APR-17 ','08-MAY-17 ','13-APR-17 ',2,33.8,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11017,'ERNSH',9,'13-APR-17 ','11-MAY-17 ','20-APR-17 ',2,754.26,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11018,'LONEP',4,'13-APR-17 ','11-MAY-17 ','16-APR-17 ',2,11.65,'Lonesome Pine Restaurant','89 Chiaroscuro Rd.','Portland','OR','97219','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11019,'RANCH',6,'13-APR-17 ','11-MAY-17 ',null,3,3.17,'Rancho grande','Av. del Libertador 900','Buenos Aires',null,'1010','Argentina');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11020,'OTTIK',2,'14-APR-17 ','12-MAY-17 ','16-APR-17 ',2,43.3,'Ottilies K?seladen','Mehrheimerstr. 369','K?ln',null,'50739','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11021,'QUICK',3,'14-APR-17 ','12-MAY-17 ','21-APR-17 ',1,297.18,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11022,'HANAR',9,'14-APR-17 ','12-MAY-17 ','04-MAY-17 ',2,6.27,'Hanari Carnes','Rua do Pa?o, 67','Rio de Janeiro','RJ','05454-876','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11023,'BSBEV',1,'14-APR-17 ','28-APR-17 ','24-APR-17 ',2,123.83,'B''s Beverages','Fauntleroy Circus','London',null,'EC2 5NT','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11024,'EASTC',4,'15-APR-17 ','13-MAY-17 ','20-APR-17 ',1,74.36,'Eastern Connection','35 King George','London',null,'WX3 6FW','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11025,'WARTH',6,'15-APR-17 ','13-MAY-17 ','24-APR-17 ',3,29.17,'Wartian Herkku','Torikatu 38','Oulu',null,'90110','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11026,'FRANS',4,'15-APR-17 ','13-MAY-17 ','28-APR-17 ',1,47.09,'Franchi S.p.A.','Via Monte Bianco 34','Torino',null,'10100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11027,'BOTTM',1,'16-APR-17 ','14-MAY-17 ','20-APR-17 ',1,52.52,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11028,'KOENE',2,'16-APR-17 ','14-MAY-17 ','22-APR-17 ',1,29.59,'K?niglich Essen','Maubelstr. 90','Brandenburg',null,'14776','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11029,'CHOPS',4,'16-APR-17 ','14-MAY-17 ','27-APR-17 ',1,47.84,'Chop-suey Chinese','Hauptstr. 31','Bern',null,'3012','Switzerland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11030,'SAVEA',7,'17-APR-17 ','15-MAY-17 ','27-APR-17 ',2,830.75,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11031,'SAVEA',6,'17-APR-17 ','15-MAY-17 ','24-APR-17 ',2,227.22,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11032,'WHITC',2,'17-APR-17 ','15-MAY-17 ','23-APR-17 ',3,606.19,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11033,'RICSU',7,'17-APR-17 ','15-MAY-17 ','23-APR-17 ',3,84.74,'Richter Supermarkt','Starenweg 5','Gen?ve',null,'1204','Switzerland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11034,'OLDWO',8,'20-APR-17 ','01-JUN-17 ','27-APR-17 ',1,40.32,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11035,'SUPRD',2,'20-APR-17 ','18-MAY-17 ','24-APR-17 ',2,0.17,'Supr?mes d?lices','Boulevard Tirou, 255','Charleroi',null,'B-6000','Belgium');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11036,'DRACD',8,'20-APR-17 ','18-MAY-17 ','22-APR-17 ',3,149.47,'Drachenblut Delikatessen','Walserweg 21','Aachen',null,'52066','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11037,'GODOS',7,'21-APR-17 ','19-MAY-17 ','27-APR-17 ',1,3.2,'Godos Cocina T?pica','C/ Romero, 33','Sevilla',null,'41101','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11038,'SUPRD',1,'21-APR-17 ','19-MAY-17 ','30-APR-17 ',2,29.59,'Supr?mes d?lices','Boulevard Tirou, 255','Charleroi',null,'B-6000','Belgium');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11039,'LINOD',1,'21-APR-17 ','19-MAY-17 ',null,2,65,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11040,'GREAL',4,'22-APR-17 ','20-MAY-17 ',null,3,18.84,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11041,'CHOPS',3,'22-APR-17 ','20-MAY-17 ','28-APR-17 ',2,48.22,'Chop-suey Chinese','Hauptstr. 31','Bern',null,'3012','Switzerland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11042,'COMMI',2,'22-APR-17 ','06-MAY-17 ','01-MAY-17 ',1,29.99,'Com?rcio Mineiro','Av. dos Lus?adas, 23','Sao Paulo','SP','05432-043','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11043,'SPECD',5,'22-APR-17 ','20-MAY-17 ','29-APR-17 ',2,8.8,'Sp?cialit?s du monde','25, rue Lauriston','Paris',null,'75016','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11044,'WOLZA',4,'23-APR-17 ','21-MAY-17 ','01-MAY-17 ',1,8.72,'Wolski Zajazd','ul. Filtrowa 68','Warszawa',null,'01-012','Poland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11045,'BOTTM',6,'23-APR-17 ','21-MAY-17 ',null,2,70.58,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11046,'WANDK',8,'23-APR-17 ','21-MAY-17 ','24-APR-17 ',2,71.64,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart',null,'70563','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11047,'EASTC',7,'24-APR-17 ','22-MAY-17 ','01-MAY-17 ',3,46.62,'Eastern Connection','35 King George','London',null,'WX3 6FW','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11048,'BOTTM',7,'24-APR-17 ','22-MAY-17 ','30-APR-17 ',3,24.12,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11049,'GOURL',3,'24-APR-17 ','22-MAY-17 ','04-MAY-17 ',1,8.34,'Gourmet Lanchonetes','Av. Brasil, 442','Campinas','SP','04876-786','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11050,'FOLKO',8,'27-APR-17 ','25-MAY-17 ','05-MAY-17 ',2,59.41,'Folk och f? HB','?kergatan 24','Br?cke',null,'S-844 67','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11051,'LAMAI',7,'27-APR-17 ','25-MAY-17 ',null,3,2.79,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',null,'31000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11052,'HANAR',3,'27-APR-17 ','25-MAY-17 ','01-MAY-17 ',1,67.26,'Hanari Carnes','Rua do Pa?o, 67','Rio de Janeiro','RJ','05454-876','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11053,'PICCO',2,'27-APR-17 ','25-MAY-17 ','29-APR-17 ',2,53.05,'Piccolo und mehr','Geislweg 14','Salzburg',null,'5020','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11054,'CACTU',8,'28-APR-17 ','26-MAY-17 ',null,1,0.33,'Cactus Comidas para llevar','Cerrito 333','Buenos Aires',null,'1010','Argentina');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11055,'HILAA',7,'28-APR-17 ','26-MAY-17 ','05-MAY-17 ',2,120.92,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist?bal','T?chira','5022','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11056,'EASTC',8,'28-APR-17 ','12-MAY-17 ','01-MAY-17 ',2,278.96,'Eastern Connection','35 King George','London',null,'WX3 6FW','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11057,'NORTS',3,'29-APR-17 ','27-MAY-17 ','01-MAY-17 ',3,4.13,'North/South','South House 300 Queensbridge','London',null,'SW7 1RZ','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11058,'BLAUS',9,'29-APR-17 ','27-MAY-17 ',null,3,31.14,'Blauer See Delikatessen','Forsterstr. 57','Mannheim',null,'68306','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11059,'RICAR',2,'29-APR-17 ','10-JUN-17 ',null,2,85.8,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11060,'FRANS',2,'30-APR-17 ','28-MAY-17 ','04-MAY-17 ',2,10.98,'Franchi S.p.A.','Via Monte Bianco 34','Torino',null,'10100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11061,'GREAL',4,'30-APR-17 ','11-JUN-17 ',null,3,14.01,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11062,'REGGC',4,'30-APR-17 ','28-MAY-17 ',null,2,29.93,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',null,'42100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11063,'HUNGO',3,'30-APR-17 ','28-MAY-17 ','06-MAY-17 ',2,81.73,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',null,'Ireland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11064,'SAVEA',1,'01-MAY-17 ','29-MAY-17 ','04-MAY-17 ',1,30.09,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11065,'LILAS',8,'01-MAY-17 ','29-MAY-17 ',null,1,12.91,'LILA-Supermercado','Carrera 52 con Ave. Bol?var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11066,'WHITC',7,'01-MAY-17 ','29-MAY-17 ','04-MAY-17 ',2,44.72,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11067,'DRACD',1,'04-MAY-17 ','18-MAY-17 ','06-MAY-17 ',2,7.98,'Drachenblut Delikatessen','Walserweg 21','Aachen',null,'52066','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11068,'QUEEN',8,'04-MAY-17 ','01-JUN-17 ',null,2,81.75,'Queen Cozinha','Alameda dos Can?rios, 891','Sao Paulo','SP','05487-020','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11069,'TORTU',1,'04-MAY-17 ','01-JUN-17 ','06-MAY-17 ',2,15.67,'Tortuga Restaurante','Avda. Azteca 123','M?xico D.F.',null,'05033','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11070,'LEHMS',2,'05-MAY-17 ','02-JUN-17 ',null,1,136,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',null,'60528','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11071,'LILAS',1,'05-MAY-17 ','02-JUN-17 ',null,1,0.93,'LILA-Supermercado','Carrera 52 con Ave. Bol?var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11072,'ERNSH',4,'05-MAY-17 ','02-JUN-17 ',null,2,258.64,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10819,'CACTU',2,'07-JAN-17 ','04-FEB-17 ','16-JAN-17 ',3,19.76,'Cactus Comidas para llevar','Cerrito 333','Buenos Aires',null,'1010','Argentina');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10820,'RATTC',3,'07-JAN-17 ','04-FEB-17 ','13-JAN-17 ',2,37.52,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10821,'SPLIR',1,'08-JAN-17 ','05-FEB-17 ','15-JAN-17 ',1,36.68,'Split Rail Beer and Ale','P.O. Box 555','Lander','WY','82520','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10822,'TRAIH',6,'08-JAN-17 ','05-FEB-17 ','16-JAN-17 ',3,7,'Trail''s Head Gourmet Provisioners','722 DaVinci Blvd.','Kirkland','WA','98034','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10823,'LILAS',5,'09-JAN-17 ','06-FEB-17 ','13-JAN-17 ',2,163.97,'LILA-Supermercado','Carrera 52 con Ave. Bol?var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10824,'FOLKO',8,'09-JAN-17 ','06-FEB-17 ','30-JAN-17 ',1,1.23,'Folk och f? HB','?kergatan 24','Br?cke',null,'S-844 67','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10825,'DRACD',1,'09-JAN-17 ','06-FEB-17 ','14-JAN-17 ',1,79.25,'Drachenblut Delikatessen','Walserweg 21','Aachen',null,'52066','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10826,'BLONP',6,'12-JAN-17 ','09-FEB-17 ','06-FEB-17 ',1,7.09,'Blondel p?re et fils','24, place Kl?ber','Strasbourg',null,'67000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10827,'BONAP',1,'12-JAN-17 ','26-JAN-17 ','06-FEB-17 ',2,63.54,'Bon app''','12, rue des Bouchers','Marseille',null,'13008','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10828,'RANCH',9,'13-JAN-17 ','27-JAN-17 ','04-FEB-17 ',1,90.85,'Rancho grande','Av. del Libertador 900','Buenos Aires',null,'1010','Argentina');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10829,'ISLAT',9,'13-JAN-17 ','10-FEB-17 ','23-JAN-17 ',1,154.72,'Island Trading','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10830,'TRADH',4,'13-JAN-17 ','24-FEB-17 ','21-JAN-17 ',2,81.83,'Tradi?ao Hipermercados','Av. In?s de Castro, 414','Sao Paulo','SP','05634-030','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10831,'SANTG',3,'14-JAN-17 ','11-FEB-17 ','23-JAN-17 ',2,72.19,'Sant? Gourmet','Erling Skakkes gate 78','Stavern',null,'4110','Norway');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10832,'LAMAI',2,'14-JAN-17 ','11-FEB-17 ','19-JAN-17 ',2,43.26,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',null,'31000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10833,'OTTIK',6,'15-JAN-17 ','12-FEB-17 ','23-JAN-17 ',2,71.49,'Ottilies K?seladen','Mehrheimerstr. 369','K?ln',null,'50739','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10834,'TRADH',1,'15-JAN-17 ','12-FEB-17 ','19-JAN-17 ',3,29.78,'Tradi?ao Hipermercados','Av. In?s de Castro, 414','Sao Paulo','SP','05634-030','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10835,'ALFKI',1,'15-JAN-17 ','12-FEB-17 ','21-JAN-17 ',3,69.53,'Alfred''s Futterkiste','Obere Str. 57','Berlin',null,'12209','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10836,'ERNSH',7,'16-JAN-17 ','13-FEB-17 ','21-JAN-17 ',1,411.88,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10837,'BERGS',9,'16-JAN-17 ','13-FEB-17 ','23-JAN-17 ',3,13.32,'Berglunds snabbk?p','Berguvsv?gen  8','Lule?',null,'S-958 22','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10838,'LINOD',3,'19-JAN-17 ','16-FEB-17 ','23-JAN-17 ',3,59.28,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10839,'TRADH',3,'19-JAN-17 ','16-FEB-17 ','22-JAN-17 ',3,35.43,'Tradi?ao Hipermercados','Av. In?s de Castro, 414','Sao Paulo','SP','05634-030','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10840,'LINOD',4,'19-JAN-17 ','02-MAR-17 ','16-FEB-17 ',2,2.71,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10841,'SUPRD',5,'20-JAN-17 ','17-FEB-17 ','29-JAN-17 ',2,424.3,'Supr?mes d?lices','Boulevard Tirou, 255','Charleroi',null,'B-6000','Belgium');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10842,'TORTU',1,'20-JAN-17 ','17-FEB-17 ','29-JAN-17 ',3,54.42,'Tortuga Restaurante','Avda. Azteca 123','M?xico D.F.',null,'05033','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10843,'VICTE',4,'21-JAN-17 ','18-FEB-17 ','26-JAN-17 ',2,9.26,'Victuailles en stock','2, rue du Commerce','Lyon',null,'69004','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10844,'PICCO',8,'21-JAN-17 ','18-FEB-17 ','26-JAN-17 ',2,25.22,'Piccolo und mehr','Geislweg 14','Salzburg',null,'5020','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10845,'QUICK',8,'21-JAN-17 ','04-FEB-17 ','30-JAN-17 ',1,212.98,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10846,'SUPRD',2,'22-JAN-17 ','05-MAR-17 ','23-JAN-17 ',3,56.46,'Supr?mes d?lices','Boulevard Tirou, 255','Charleroi',null,'B-6000','Belgium');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10847,'SAVEA',4,'22-JAN-17 ','05-FEB-17 ','10-FEB-17 ',3,487.57,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10848,'CONSH',7,'23-JAN-17 ','20-FEB-17 ','29-JAN-17 ',2,38.24,'Consolidated Holdings','Berkeley Gardens 12  Brewery','London',null,'WX1 6LT','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10849,'KOENE',9,'23-JAN-17 ','20-FEB-17 ','30-JAN-17 ',2,0.56,'K?niglich Essen','Maubelstr. 90','Brandenburg',null,'14776','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10850,'VICTE',1,'23-JAN-17 ','06-MAR-17 ','30-JAN-17 ',1,49.19,'Victuailles en stock','2, rue du Commerce','Lyon',null,'69004','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10851,'RICAR',5,'26-JAN-17 ','23-FEB-17 ','02-FEB-17 ',1,160.55,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10852,'RATTC',8,'26-JAN-17 ','09-FEB-17 ','30-JAN-17 ',1,174.05,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10853,'BLAUS',9,'27-JAN-17 ','24-FEB-17 ','03-FEB-17 ',2,53.83,'Blauer See Delikatessen','Forsterstr. 57','Mannheim',null,'68306','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10854,'ERNSH',3,'27-JAN-17 ','24-FEB-17 ','05-FEB-17 ',2,100.22,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10855,'OLDWO',3,'27-JAN-17 ','24-FEB-17 ','04-FEB-17 ',1,170.97,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10856,'ANTON',3,'28-JAN-17 ','25-FEB-17 ','10-FEB-17 ',2,58.43,'Antonio Moreno Taquer?a','Mataderos  2312','M?xico D.F.',null,'05023','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10857,'BERGS',8,'28-JAN-17 ','25-FEB-17 ','06-FEB-17 ',2,188.85,'Berglunds snabbk?p','Berguvsv?gen  8','Lule?',null,'S-958 22','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10858,'LACOR',2,'29-JAN-17 ','26-FEB-17 ','03-FEB-17 ',1,52.51,'La corne d''abondance','67, avenue de l''Europe','Versailles',null,'78000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10859,'FRANK',1,'29-JAN-17 ','26-FEB-17 ','02-FEB-17 ',2,76.1,'Frankenversand','Berliner Platz 43','M?nchen',null,'80805','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10860,'FRANR',3,'29-JAN-17 ','26-FEB-17 ','04-FEB-17 ',3,19.26,'France restauration','54, rue Royale','Nantes',null,'44000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10861,'WHITC',4,'30-JAN-17 ','27-FEB-17 ','17-FEB-17 ',2,14.93,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10862,'LEHMS',8,'30-JAN-17 ','13-MAR-17 ','02-FEB-17 ',2,53.23,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',null,'60528','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10863,'HILAA',4,'02-FEB-17 ','02-MAR-17 ','17-FEB-17 ',2,30.26,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist?bal','T?chira','5022','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10864,'AROUT',4,'02-FEB-17 ','02-MAR-17 ','09-FEB-17 ',2,3.04,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10865,'QUICK',2,'02-FEB-17 ','16-FEB-17 ','12-FEB-17 ',1,348.14,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10866,'BERGS',5,'03-FEB-17 ','03-MAR-17 ','12-FEB-17 ',1,109.11,'Berglunds snabbk?p','Berguvsv?gen  8','Lule?',null,'S-958 22','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10867,'LONEP',6,'03-FEB-17 ','17-MAR-17 ','11-FEB-17 ',1,1.93,'Lonesome Pine Restaurant','89 Chiaroscuro Rd.','Portland','OR','97219','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10868,'QUEEN',7,'04-FEB-17 ','04-MAR-17 ','23-FEB-17 ',2,191.27,'Queen Cozinha','Alameda dos Can?rios, 891','Sao Paulo','SP','05487-020','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10869,'SEVES',5,'04-FEB-17 ','04-MAR-17 ','09-FEB-17 ',1,143.28,'Seven Seas Imports','90 Wadhurst Rd.','London',null,'OX15 4NB','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10870,'WOLZA',5,'04-FEB-17 ','04-MAR-17 ','13-FEB-17 ',3,12.04,'Wolski Zajazd','ul. Filtrowa 68','Warszawa',null,'01-012','Poland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10871,'BONAP',9,'05-FEB-17 ','05-MAR-17 ','10-FEB-17 ',2,112.27,'Bon app''','12, rue des Bouchers','Marseille',null,'13008','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10872,'GODOS',5,'05-FEB-17 ','05-MAR-17 ','09-FEB-17 ',2,175.32,'Godos Cocina T?pica','C/ Romero, 33','Sevilla',null,'41101','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10873,'WILMK',4,'06-FEB-17 ','06-MAR-17 ','09-FEB-17 ',1,0.82,'Wilman Kala','Keskuskatu 45','Helsinki',null,'21240','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10874,'GODOS',5,'06-FEB-17 ','06-MAR-17 ','11-FEB-17 ',2,19.58,'Godos Cocina T?pica','C/ Romero, 33','Sevilla',null,'41101','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10875,'BERGS',4,'06-FEB-17 ','06-MAR-17 ','03-MAR-17 ',2,32.37,'Berglunds snabbk?p','Berguvsv?gen  8','Lule?',null,'S-958 22','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10876,'BONAP',7,'09-FEB-17 ','09-MAR-17 ','12-FEB-17 ',3,60.42,'Bon app''','12, rue des Bouchers','Marseille',null,'13008','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10877,'RICAR',1,'09-FEB-17 ','09-MAR-17 ','19-FEB-17 ',1,38.06,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10878,'QUICK',4,'10-FEB-17 ','10-MAR-17 ','12-FEB-17 ',1,46.69,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10879,'WILMK',3,'10-FEB-17 ','10-MAR-17 ','12-FEB-17 ',3,8.5,'Wilman Kala','Keskuskatu 45','Helsinki',null,'21240','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10880,'FOLKO',7,'10-FEB-17 ','24-MAR-17 ','18-FEB-17 ',1,88.01,'Folk och f? HB','?kergatan 24','Br?cke',null,'S-844 67','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10881,'CACTU',4,'11-FEB-17 ','11-MAR-17 ','18-FEB-17 ',1,2.84,'Cactus Comidas para llevar','Cerrito 333','Buenos Aires',null,'1010','Argentina');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10882,'SAVEA',4,'11-FEB-17 ','11-MAR-17 ','20-FEB-17 ',3,23.1,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10883,'LONEP',8,'12-FEB-17 ','12-MAR-17 ','20-FEB-17 ',3,0.53,'Lonesome Pine Restaurant','89 Chiaroscuro Rd.','Portland','OR','97219','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10884,'LETSS',4,'12-FEB-17 ','12-MAR-17 ','13-FEB-17 ',2,90.97,'Let''s Stop N Shop','87 Polk St. Suite 5','San Francisco','CA','94117','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10885,'SUPRD',6,'12-FEB-17 ','12-MAR-17 ','18-FEB-17 ',3,5.64,'Supr?mes d?lices','Boulevard Tirou, 255','Charleroi',null,'B-6000','Belgium');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10886,'HANAR',1,'13-FEB-17 ','13-MAR-17 ','02-MAR-17 ',1,4.99,'Hanari Carnes','Rua do Pa?o, 67','Rio de Janeiro','RJ','05454-876','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10887,'GALED',8,'13-FEB-17 ','13-MAR-17 ','16-FEB-17 ',3,1.25,'Galer?a del gastron?mo','Rambla de Catalu?a, 23','Barcelona',null,'8022','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10888,'GODOS',1,'16-FEB-17 ','16-MAR-17 ','23-FEB-17 ',2,51.87,'Godos Cocina T?pica','C/ Romero, 33','Sevilla',null,'41101','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10889,'RATTC',9,'16-FEB-17 ','16-MAR-17 ','23-FEB-17 ',3,280.61,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10890,'DUMON',7,'16-FEB-17 ','16-MAR-17 ','18-FEB-17 ',1,32.76,'Du monde entier','67, rue des Cinquante Otages','Nantes',null,'44000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10891,'LEHMS',7,'17-FEB-17 ','17-MAR-17 ','19-FEB-17 ',2,20.37,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',null,'60528','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10892,'MAISD',4,'17-FEB-17 ','17-MAR-17 ','19-FEB-17 ',2,120.27,'Maison Dewey','Rue Joseph-Bens 532','Bruxelles',null,'B-1180','Belgium');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10893,'KOENE',9,'18-FEB-17 ','18-MAR-17 ','20-FEB-17 ',2,77.78,'K?niglich Essen','Maubelstr. 90','Brandenburg',null,'14776','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10894,'SAVEA',1,'18-FEB-17 ','18-MAR-17 ','20-FEB-17 ',1,116.13,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10895,'ERNSH',3,'18-FEB-17 ','18-MAR-17 ','23-FEB-17 ',1,162.75,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10896,'MAISD',7,'19-FEB-17 ','19-MAR-17 ','27-FEB-17 ',3,32.45,'Maison Dewey','Rue Joseph-Bens 532','Bruxelles',null,'B-1180','Belgium');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10897,'HUNGO',3,'19-FEB-17 ','19-MAR-17 ','25-FEB-17 ',2,603.54,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',null,'Ireland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10898,'OCEAN',4,'20-FEB-17 ','20-MAR-17 ','06-MAR-17 ',2,1.27,'Oc?ano Atl?ntico Ltda.','Ing. Gustavo Moncada 8585 Piso 20-A','Buenos Aires',null,'1010','Argentina');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10899,'LILAS',5,'20-FEB-17 ','20-MAR-17 ','26-FEB-17 ',3,1.21,'LILA-Supermercado','Carrera 52 con Ave. Bol?var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10900,'WELLI',1,'20-FEB-17 ','20-MAR-17 ','04-MAR-17 ',2,1.66,'Wellington Importadora','Rua do Mercado, 12','Resende','SP','08737-363','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10901,'HILAA',4,'23-FEB-17 ','23-MAR-17 ','26-FEB-17 ',1,62.09,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist?bal','T?chira','5022','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10902,'FOLKO',1,'23-FEB-17 ','23-MAR-17 ','03-MAR-17 ',1,44.15,'Folk och f? HB','?kergatan 24','Br?cke',null,'S-844 67','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10903,'HANAR',3,'24-FEB-17 ','24-MAR-17 ','04-MAR-17 ',3,36.71,'Hanari Carnes','Rua do Pa?o, 67','Rio de Janeiro','RJ','05454-876','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10904,'WHITC',3,'24-FEB-17 ','24-MAR-17 ','27-FEB-17 ',3,162.95,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10905,'WELLI',9,'24-FEB-17 ','24-MAR-17 ','06-MAR-17 ',2,13.72,'Wellington Importadora','Rua do Mercado, 12','Resende','SP','08737-363','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10906,'WOLZA',4,'25-FEB-17 ','11-MAR-17 ','03-MAR-17 ',3,26.29,'Wolski Zajazd','ul. Filtrowa 68','Warszawa',null,'01-012','Poland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10907,'SPECD',6,'25-FEB-17 ','25-MAR-17 ','27-FEB-17 ',3,9.19,'Sp?cialit?s du monde','25, rue Lauriston','Paris',null,'75016','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10908,'REGGC',4,'26-FEB-17 ','26-MAR-17 ','06-MAR-17 ',2,32.96,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',null,'42100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10909,'SANTG',1,'26-FEB-17 ','26-MAR-17 ','10-MAR-17 ',2,53.05,'Sant? Gourmet','Erling Skakkes gate 78','Stavern',null,'4110','Norway');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10910,'WILMK',1,'26-FEB-17 ','26-MAR-17 ','04-MAR-17 ',3,38.11,'Wilman Kala','Keskuskatu 45','Helsinki',null,'21240','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10911,'GODOS',3,'26-FEB-17 ','26-MAR-17 ','05-MAR-17 ',1,38.19,'Godos Cocina T?pica','C/ Romero, 33','Sevilla',null,'41101','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10912,'HUNGO',2,'26-FEB-17 ','26-MAR-17 ','18-MAR-17 ',2,580.91,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',null,'Ireland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10913,'QUEEN',4,'26-FEB-17 ','26-MAR-17 ','04-MAR-17 ',1,33.05,'Queen Cozinha','Alameda dos Can?rios, 891','Sao Paulo','SP','05487-020','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10914,'QUEEN',6,'27-FEB-17 ','27-MAR-17 ','02-MAR-17 ',1,21.19,'Queen Cozinha','Alameda dos Can?rios, 891','Sao Paulo','SP','05487-020','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10915,'TORTU',2,'27-FEB-17 ','27-MAR-17 ','02-MAR-17 ',2,3.51,'Tortuga Restaurante','Avda. Azteca 123','M?xico D.F.',null,'05033','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10916,'RANCH',1,'27-FEB-17 ','27-MAR-17 ','09-MAR-17 ',2,63.77,'Rancho grande','Av. del Libertador 900','Buenos Aires',null,'1010','Argentina');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10917,'ROMEY',4,'02-MAR-17 ','30-MAR-17 ','11-MAR-17 ',2,8.29,'Romero y tomillo','Gran V?a, 1','Madrid',null,'28001','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10918,'BOTTM',3,'02-MAR-17 ','30-MAR-17 ','11-MAR-17 ',3,48.83,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10919,'LINOD',2,'02-MAR-17 ','30-MAR-17 ','04-MAR-17 ',2,19.8,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10920,'AROUT',4,'03-MAR-17 ','31-MAR-17 ','09-MAR-17 ',2,29.61,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10921,'VAFFE',1,'03-MAR-17 ','14-APR-17 ','09-MAR-17 ',1,176.48,'Vaffeljernet','Smagsloget 45','?rhus',null,'8200','Denmark');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10922,'HANAR',5,'03-MAR-17 ','31-MAR-17 ','05-MAR-17 ',3,62.74,'Hanari Carnes','Rua do Pa?o, 67','Rio de Janeiro','RJ','05454-876','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10923,'LAMAI',7,'03-MAR-17 ','14-APR-17 ','13-MAR-17 ',3,68.26,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',null,'31000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10924,'BERGS',3,'04-MAR-17 ','01-APR-17 ','08-APR-17 ',2,151.52,'Berglunds snabbk?p','Berguvsv?gen  8','Lule?',null,'S-958 22','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10925,'HANAR',3,'04-MAR-17 ','01-APR-17 ','13-MAR-17 ',1,2.27,'Hanari Carnes','Rua do Pa?o, 67','Rio de Janeiro','RJ','05454-876','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10926,'ANATR',4,'04-MAR-17 ','01-APR-17 ','11-MAR-17 ',3,39.92,'Ana Trujillo Emparedados y helados','Avda. de la Constituci?n 2222','M?xico D.F.',null,'05021','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10927,'LACOR',4,'05-MAR-17 ','02-APR-17 ','08-APR-17 ',1,19.79,'La corne d''abondance','67, avenue de l''Europe','Versailles',null,'78000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10928,'GALED',1,'05-MAR-17 ','02-APR-17 ','18-MAR-17 ',1,1.36,'Galer?a del gastron?mo','Rambla de Catalu?a, 23','Barcelona',null,'8022','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10929,'FRANK',6,'05-MAR-17 ','02-APR-17 ','12-MAR-17 ',1,33.93,'Frankenversand','Berliner Platz 43','M?nchen',null,'80805','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10930,'SUPRD',4,'06-MAR-17 ','17-APR-17 ','18-MAR-17 ',3,15.55,'Supr?mes d?lices','Boulevard Tirou, 255','Charleroi',null,'B-6000','Belgium');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10931,'RICSU',4,'06-MAR-17 ','20-MAR-17 ','19-MAR-17 ',2,13.6,'Richter Supermarkt','Starenweg 5','Gen?ve',null,'1204','Switzerland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10932,'BONAP',8,'06-MAR-17 ','03-APR-17 ','24-MAR-17 ',1,134.64,'Bon app''','12, rue des Bouchers','Marseille',null,'13008','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10933,'ISLAT',6,'06-MAR-17 ','03-APR-17 ','16-MAR-17 ',3,54.15,'Island Trading','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10934,'LEHMS',3,'09-MAR-17 ','06-APR-17 ','12-MAR-17 ',3,32.01,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',null,'60528','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10935,'WELLI',4,'09-MAR-17 ','06-APR-17 ','18-MAR-17 ',3,47.59,'Wellington Importadora','Rua do Mercado, 12','Resende','SP','08737-363','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10936,'GREAL',3,'09-MAR-17 ','06-APR-17 ','18-MAR-17 ',2,33.68,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10937,'CACTU',7,'10-MAR-17 ','24-MAR-17 ','13-MAR-17 ',3,31.51,'Cactus Comidas para llevar','Cerrito 333','Buenos Aires',null,'1010','Argentina');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10938,'QUICK',3,'10-MAR-17 ','07-APR-17 ','16-MAR-17 ',2,31.89,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10939,'MAGAA',2,'10-MAR-17 ','07-APR-17 ','13-MAR-17 ',2,76.33,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo',null,'24100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10940,'BONAP',8,'11-MAR-17 ','08-APR-17 ','23-MAR-17 ',3,19.77,'Bon app''','12, rue des Bouchers','Marseille',null,'13008','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10941,'SAVEA',7,'11-MAR-17 ','08-APR-17 ','20-MAR-17 ',2,400.81,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10942,'REGGC',9,'11-MAR-17 ','08-APR-17 ','18-MAR-17 ',3,17.95,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',null,'42100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10943,'BSBEV',4,'11-MAR-17 ','08-APR-17 ','19-MAR-17 ',2,2.17,'B''s Beverages','Fauntleroy Circus','London',null,'EC2 5NT','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10944,'BOTTM',6,'12-MAR-17 ','26-MAR-17 ','13-MAR-17 ',3,52.92,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10945,'MORGK',4,'12-MAR-17 ','09-APR-17 ','18-MAR-17 ',1,10.22,'Morgenstern Gesundkost','Heerstr. 22','Leipzig',null,'04179','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10946,'VAFFE',1,'12-MAR-17 ','09-APR-17 ','19-MAR-17 ',2,27.2,'Vaffeljernet','Smagsloget 45','?rhus',null,'8200','Denmark');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10947,'BSBEV',3,'13-MAR-17 ','10-APR-17 ','16-MAR-17 ',2,3.26,'B''s Beverages','Fauntleroy Circus','London',null,'EC2 5NT','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10948,'GODOS',3,'13-MAR-17 ','10-APR-17 ','19-MAR-17 ',3,23.39,'Godos Cocina T?pica','C/ Romero, 33','Sevilla',null,'41101','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10949,'BOTTM',2,'13-MAR-17 ','10-APR-17 ','17-MAR-17 ',3,74.44,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10950,'MAGAA',1,'16-MAR-17 ','13-APR-17 ','23-MAR-17 ',2,2.5,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo',null,'24100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10951,'RICSU',9,'16-MAR-17 ','27-APR-17 ','07-APR-17 ',2,30.85,'Richter Supermarkt','Starenweg 5','Gen?ve',null,'1204','Switzerland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10952,'ALFKI',1,'16-MAR-17 ','27-APR-17 ','24-MAR-17 ',1,40.42,'Alfred''s Futterkiste','Obere Str. 57','Berlin',null,'12209','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10953,'AROUT',9,'16-MAR-17 ','30-MAR-17 ','25-MAR-17 ',2,23.72,'Around the Horn','Brook Farm Stratford St. Mary','Colchester','Essex','CO7 6JX','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10954,'LINOD',5,'17-MAR-17 ','28-APR-17 ','20-MAR-17 ',1,27.91,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10955,'FOLKO',8,'17-MAR-17 ','14-APR-17 ','20-MAR-17 ',2,3.26,'Folk och f? HB','?kergatan 24','Br?cke',null,'S-844 67','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10956,'BLAUS',6,'17-MAR-17 ','28-APR-17 ','20-MAR-17 ',2,44.65,'Blauer See Delikatessen','Forsterstr. 57','Mannheim',null,'68306','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10957,'HILAA',8,'18-MAR-17 ','15-APR-17 ','27-MAR-17 ',3,105.36,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist?bal','T?chira','5022','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10958,'OCEAN',7,'18-MAR-17 ','15-APR-17 ','27-MAR-17 ',2,49.56,'Oc?ano Atl?ntico Ltda.','Ing. Gustavo Moncada 8585 Piso 20-A','Buenos Aires',null,'1010','Argentina');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10959,'GOURL',6,'18-MAR-17 ','29-APR-17 ','23-MAR-17 ',2,4.98,'Gourmet Lanchonetes','Av. Brasil, 442','Campinas','SP','04876-786','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10960,'HILAA',3,'19-MAR-17 ','02-APR-17 ','08-APR-17 ',1,2.08,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist?bal','T?chira','5022','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10961,'QUEEN',8,'19-MAR-17 ','16-APR-17 ','30-MAR-17 ',1,104.47,'Queen Cozinha','Alameda dos Can?rios, 891','Sao Paulo','SP','05487-020','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10962,'QUICK',8,'19-MAR-17 ','16-APR-17 ','23-MAR-17 ',2,275.79,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10963,'FURIB',9,'19-MAR-17 ','16-APR-17 ','26-MAR-17 ',3,2.7,'Furia Bacalhau e Frutos do Mar','Jardim das rosas n. 32','Lisboa',null,'1675','Portugal');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10964,'SPECD',3,'20-MAR-17 ','17-APR-17 ','24-MAR-17 ',2,87.38,'Sp?cialit?s du monde','25, rue Lauriston','Paris',null,'75016','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10965,'OLDWO',6,'20-MAR-17 ','17-APR-17 ','30-MAR-17 ',3,144.38,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10966,'CHOPS',4,'20-MAR-17 ','17-APR-17 ','08-APR-17 ',1,27.19,'Chop-suey Chinese','Hauptstr. 31','Bern',null,'3012','Switzerland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10967,'TOMSP',2,'23-MAR-17 ','20-APR-17 ','02-APR-17 ',2,62.22,'Toms Spezialit?ten','Luisenstr. 48','M?nster',null,'44087','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10968,'ERNSH',1,'23-MAR-17 ','20-APR-17 ','01-APR-17 ',3,74.6,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10969,'COMMI',1,'23-MAR-17 ','20-APR-17 ','30-MAR-17 ',2,0.21,'Com?rcio Mineiro','Av. dos Lus?adas, 23','Sao Paulo','SP','05432-043','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10970,'BOLID',9,'24-MAR-17 ','07-APR-17 ','24-APR-17 ',1,16.16,'B?lido Comidas preparadas','C/ Araquil, 67','Madrid',null,'28023','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10971,'FRANR',2,'24-MAR-17 ','21-APR-17 ','02-APR-17 ',2,121.82,'France restauration','54, rue Royale','Nantes',null,'44000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10972,'LACOR',4,'24-MAR-17 ','21-APR-17 ','26-MAR-17 ',2,0.02,'La corne d''abondance','67, avenue de l''Europe','Versailles',null,'78000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10973,'LACOR',6,'24-MAR-17 ','21-APR-17 ','27-MAR-17 ',2,15.17,'La corne d''abondance','67, avenue de l''Europe','Versailles',null,'78000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10974,'SPLIR',3,'25-MAR-17 ','08-APR-17 ','03-APR-17 ',3,12.96,'Split Rail Beer and Ale','P.O. Box 555','Lander','WY','82520','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10975,'BOTTM',1,'25-MAR-17 ','22-APR-17 ','27-MAR-17 ',3,32.27,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10976,'HILAA',1,'25-MAR-17 ','06-MAY-17 ','03-APR-17 ',1,37.97,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist?bal','T?chira','5022','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10977,'FOLKO',8,'26-MAR-17 ','23-APR-17 ','10-APR-17 ',3,208.5,'Folk och f? HB','?kergatan 24','Br?cke',null,'S-844 67','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10978,'MAISD',9,'26-MAR-17 ','23-APR-17 ','23-APR-17 ',2,32.82,'Maison Dewey','Rue Joseph-Bens 532','Bruxelles',null,'B-1180','Belgium');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10979,'ERNSH',8,'26-MAR-17 ','23-APR-17 ','31-MAR-17 ',2,353.07,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10980,'FOLKO',4,'27-MAR-17 ','08-MAY-17 ','17-APR-17 ',1,1.26,'Folk och f? HB','?kergatan 24','Br?cke',null,'S-844 67','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10981,'HANAR',1,'27-MAR-17 ','24-APR-17 ','02-APR-17 ',2,193.37,'Hanari Carnes','Rua do Pa?o, 67','Rio de Janeiro','RJ','05454-876','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10982,'BOTTM',2,'27-MAR-17 ','24-APR-17 ','08-APR-17 ',1,14.01,'Bottom-Dollar Markets','23 Tsawassen Blvd.','Tsawassen','BC','T2F 8M4','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10983,'SAVEA',2,'27-MAR-17 ','24-APR-17 ','06-APR-17 ',2,657.54,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10984,'SAVEA',1,'30-MAR-17 ','27-APR-17 ','03-APR-17 ',3,211.22,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10985,'HUNGO',2,'30-MAR-17 ','27-APR-17 ','02-APR-17 ',1,91.51,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',null,'Ireland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10986,'OCEAN',8,'30-MAR-17 ','27-APR-17 ','21-APR-17 ',2,217.86,'Oc?ano Atl?ntico Ltda.','Ing. Gustavo Moncada 8585 Piso 20-A','Buenos Aires',null,'1010','Argentina');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10987,'EASTC',8,'31-MAR-17 ','28-APR-17 ','06-APR-17 ',1,185.48,'Eastern Connection','35 King George','London',null,'WX3 6FW','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10988,'RATTC',3,'31-MAR-17 ','28-APR-17 ','10-APR-17 ',2,61.14,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10989,'QUEDE',2,'31-MAR-17 ','28-APR-17 ','02-APR-17 ',1,34.76,'Que Del?cia','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10990,'ERNSH',2,'01-APR-17 ','13-MAY-17 ','07-APR-17 ',3,117.61,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10991,'QUICK',1,'01-APR-17 ','29-APR-17 ','07-APR-17 ',1,38.51,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10992,'THEBI',1,'01-APR-17 ','29-APR-17 ','03-APR-17 ',3,4.27,'The Big Cheese','89 Jefferson Way Suite 2','Portland','OR','97201','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10993,'FOLKO',7,'01-APR-17 ','29-APR-17 ','10-APR-17 ',3,8.81,'Folk och f? HB','?kergatan 24','Br?cke',null,'S-844 67','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10994,'VAFFE',2,'02-APR-17 ','16-APR-17 ','09-APR-17 ',3,65.53,'Vaffeljernet','Smagsloget 45','?rhus',null,'8200','Denmark');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10995,'PERIC',1,'02-APR-17 ','30-APR-17 ','06-APR-17 ',3,46,'Pericles Comidas cl?sicas','Calle Dr. Jorge Cash 321','M?xico D.F.',null,'05033','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10996,'QUICK',4,'02-APR-17 ','30-APR-17 ','10-APR-17 ',2,1.12,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10997,'LILAS',8,'03-APR-17 ','15-MAY-17 ','13-APR-17 ',2,73.91,'LILA-Supermercado','Carrera 52 con Ave. Bol?var #65-98 Llano Largo','Barquisimeto','Lara','3508','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10998,'WOLZA',8,'03-APR-17 ','17-APR-17 ','17-APR-17 ',2,20.31,'Wolski Zajazd','ul. Filtrowa 68','Warszawa',null,'01-012','Poland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10999,'OTTIK',6,'03-APR-17 ','01-MAY-17 ','10-APR-17 ',2,96.35,'Ottilies K?seladen','Mehrheimerstr. 369','K?ln',null,'50739','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11000,'RATTC',2,'06-APR-17 ','04-MAY-17 ','14-APR-17 ',3,55.12,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11001,'FOLKO',2,'06-APR-17 ','04-MAY-17 ','14-APR-17 ',2,197.3,'Folk och f? HB','?kergatan 24','Br?cke',null,'S-844 67','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11002,'SAVEA',4,'06-APR-17 ','04-MAY-17 ','16-APR-17 ',1,141.16,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11003,'THECR',3,'06-APR-17 ','04-MAY-17 ','08-APR-17 ',3,14.91,'The Cracker Box','55 Grizzly Peak Rd.','Butte','MT','59801','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11004,'MAISD',3,'07-APR-17 ','05-MAY-17 ','20-APR-17 ',1,44.84,'Maison Dewey','Rue Joseph-Bens 532','Bruxelles',null,'B-1180','Belgium');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11005,'WILMK',2,'07-APR-17 ','05-MAY-17 ','10-APR-17 ',1,0.75,'Wilman Kala','Keskuskatu 45','Helsinki',null,'21240','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11006,'GREAL',3,'07-APR-17 ','05-MAY-17 ','15-APR-17 ',2,25.19,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11007,'PRINI',8,'08-APR-17 ','06-MAY-17 ','13-APR-17 ',2,202.24,'Princesa Isabel Vinhos','Estrada da sa?de n. 58','Lisboa',null,'1756','Portugal');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10564,'RATTC',4,'10-JUN-16 ','08-JUL-16 ','16-JUN-16 ',3,13.75,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10565,'MEREP',8,'11-JUN-16 ','09-JUL-16 ','18-JUN-16 ',2,7.15,'M?re Paillarde','43 rue St. Laurent','Montr?al','Qu?bec','H1J 1C3','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10566,'BLONP',9,'12-JUN-16 ','10-JUL-16 ','18-JUN-16 ',1,88.4,'Blondel p?re et fils','24, place Kl?ber','Strasbourg',null,'67000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10567,'HUNGO',1,'12-JUN-16 ','10-JUL-16 ','17-JUN-16 ',1,33.97,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',null,'Ireland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10568,'GALED',3,'13-JUN-16 ','11-JUL-16 ','09-JUL-16 ',3,6.54,'Galer?a del gastron?mo','Rambla de Catalu?a, 23','Barcelona',null,'8022','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10569,'RATTC',5,'16-JUN-16 ','14-JUL-16 ','11-JUL-16 ',1,58.98,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10570,'MEREP',3,'17-JUN-16 ','15-JUL-16 ','19-JUN-16 ',3,188.99,'M?re Paillarde','43 rue St. Laurent','Montr?al','Qu?bec','H1J 1C3','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10571,'ERNSH',8,'17-JUN-16 ','29-JUL-16 ','04-JUL-16 ',3,26.06,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10572,'BERGS',3,'18-JUN-16 ','16-JUL-16 ','25-JUN-16 ',2,116.43,'Berglunds snabbk?p','Berguvsv?gen  8','Lule?',null,'S-958 22','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10573,'ANTON',7,'19-JUN-16 ','17-JUL-16 ','20-JUN-16 ',3,84.84,'Antonio Moreno Taquer?a','Mataderos  2312','M?xico D.F.',null,'05023','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10574,'TRAIH',4,'19-JUN-16 ','17-JUL-16 ','30-JUN-16 ',2,37.6,'Trail''s Head Gourmet Provisioners','722 DaVinci Blvd.','Kirkland','WA','98034','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10575,'MORGK',5,'20-JUN-16 ','04-JUL-16 ','30-JUN-16 ',1,127.34,'Morgenstern Gesundkost','Heerstr. 22','Leipzig',null,'04179','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10576,'TORTU',3,'23-JUN-16 ','07-JUL-16 ','30-JUN-16 ',3,18.56,'Tortuga Restaurante','Avda. Azteca 123','M?xico D.F.',null,'05033','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10577,'TRAIH',9,'23-JUN-16 ','04-AUG-16 ','30-JUN-16 ',2,25.41,'Trail''s Head Gourmet Provisioners','722 DaVinci Blvd.','Kirkland','WA','98034','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10578,'BSBEV',4,'24-JUN-16 ','22-JUL-16 ','25-JUL-16 ',3,29.6,'B''s Beverages','Fauntleroy Circus','London',null,'EC2 5NT','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10579,'LETSS',1,'25-JUN-16 ','23-JUL-16 ','04-JUL-16 ',2,13.73,'Let''s Stop N Shop','87 Polk St. Suite 5','San Francisco','CA','94117','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10580,'OTTIK',4,'26-JUN-16 ','24-JUL-16 ','01-JUL-16 ',3,75.89,'Ottilies K?seladen','Mehrheimerstr. 369','K?ln',null,'50739','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10581,'FAMIA',3,'26-JUN-16 ','24-JUL-16 ','02-JUL-16 ',1,3.01,'Familia Arquibaldo','Rua Or?s, 92','Sao Paulo','SP','05442-030','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10582,'BLAUS',3,'27-JUN-16 ','25-JUL-16 ','14-JUL-16 ',2,27.71,'Blauer See Delikatessen','Forsterstr. 57','Mannheim',null,'68306','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10583,'WARTH',2,'30-JUN-16 ','28-JUL-16 ','04-JUL-16 ',2,7.28,'Wartian Herkku','Torikatu 38','Oulu',null,'90110','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10584,'BLONP',4,'30-JUN-16 ','28-JUL-16 ','04-JUL-16 ',1,59.14,'Blondel p?re et fils','24, place Kl?ber','Strasbourg',null,'67000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10585,'WELLI',7,'01-JUL-16 ','29-JUL-16 ','10-JUL-16 ',1,13.41,'Wellington Importadora','Rua do Mercado, 12','Resende','SP','08737-363','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10586,'REGGC',9,'02-JUL-16 ','30-JUL-16 ','09-JUL-16 ',1,0.48,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',null,'42100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10587,'QUEDE',1,'02-JUL-16 ','30-JUL-16 ','09-JUL-16 ',1,62.52,'Que Del?cia','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10588,'QUICK',2,'03-JUL-16 ','31-JUL-16 ','10-JUL-16 ',3,194.67,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10589,'GREAL',8,'04-JUL-16 ','01-AUG-16 ','14-JUL-16 ',2,4.42,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10590,'MEREP',4,'07-JUL-16 ','04-AUG-16 ','14-JUL-16 ',3,44.77,'M?re Paillarde','43 rue St. Laurent','Montr?al','Qu?bec','H1J 1C3','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10591,'VAFFE',1,'07-JUL-16 ','21-JUL-16 ','16-JUL-16 ',1,55.92,'Vaffeljernet','Smagsloget 45','?rhus',null,'8200','Denmark');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10592,'LEHMS',3,'08-JUL-16 ','05-AUG-16 ','16-JUL-16 ',1,32.1,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',null,'60528','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10593,'LEHMS',7,'09-JUL-16 ','06-AUG-16 ','13-AUG-16 ',2,174.2,'Lehmanns Marktstand','Magazinweg 7','Frankfurt a.M.',null,'60528','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10594,'OLDWO',3,'09-JUL-16 ','06-AUG-16 ','16-JUL-16 ',2,5.24,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10595,'ERNSH',2,'10-JUL-16 ','07-AUG-16 ','14-JUL-16 ',1,96.78,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10596,'WHITC',8,'11-JUL-16 ','08-AUG-16 ','12-AUG-16 ',1,16.34,'White Clover Markets','1029 - 12th Ave. S.','Seattle','WA','98124','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10597,'PICCO',7,'11-JUL-16 ','08-AUG-16 ','18-JUL-16 ',3,35.12,'Piccolo und mehr','Geislweg 14','Salzburg',null,'5020','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10598,'RATTC',1,'14-JUL-16 ','11-AUG-16 ','18-JUL-16 ',3,44.42,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10599,'BSBEV',6,'15-JUL-16 ','26-AUG-16 ','21-JUL-16 ',3,29.98,'B''s Beverages','Fauntleroy Circus','London',null,'EC2 5NT','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10600,'HUNGC',4,'16-JUL-16 ','13-AUG-16 ','21-JUL-16 ',1,45.13,'Hungry Coyote Import Store','City Center Plaza 516 Main St.','Elgin','OR','97827','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10601,'HILAA',7,'16-JUL-16 ','27-AUG-16 ','22-JUL-16 ',1,58.3,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist?bal','T?chira','5022','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10602,'VAFFE',8,'17-JUL-16 ','14-AUG-16 ','22-JUL-16 ',2,2.92,'Vaffeljernet','Smagsloget 45','?rhus',null,'8200','Denmark');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10603,'SAVEA',8,'18-JUL-16 ','15-AUG-16 ','08-AUG-16 ',2,48.77,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10604,'FURIB',1,'18-JUL-16 ','15-AUG-16 ','29-JUL-16 ',1,7.46,'Furia Bacalhau e Frutos do Mar','Jardim das rosas n. 32','Lisboa',null,'1675','Portugal');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10605,'MEREP',1,'21-JUL-16 ','18-AUG-16 ','29-JUL-16 ',2,379.13,'M?re Paillarde','43 rue St. Laurent','Montr?al','Qu?bec','H1J 1C3','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10606,'TRADH',4,'22-JUL-16 ','19-AUG-16 ','31-JUL-16 ',3,79.4,'Tradi?ao Hipermercados','Av. In?s de Castro, 414','Sao Paulo','SP','05634-030','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10607,'SAVEA',5,'22-JUL-16 ','19-AUG-16 ','25-JUL-16 ',1,200.24,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10608,'TOMSP',4,'23-JUL-16 ','20-AUG-16 ','01-AUG-16 ',2,27.79,'Toms Spezialit?ten','Luisenstr. 48','M?nster',null,'44087','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10609,'DUMON',7,'24-JUL-16 ','21-AUG-16 ','30-JUL-16 ',2,1.85,'Du monde entier','67, rue des Cinquante Otages','Nantes',null,'44000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10610,'LAMAI',8,'25-JUL-16 ','22-AUG-16 ','06-AUG-16 ',1,26.78,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',null,'31000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10611,'WOLZA',6,'25-JUL-16 ','22-AUG-16 ','01-AUG-16 ',2,80.65,'Wolski Zajazd','ul. Filtrowa 68','Warszawa',null,'01-012','Poland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10612,'SAVEA',1,'28-JUL-16 ','25-AUG-16 ','01-AUG-16 ',2,544.08,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10613,'HILAA',4,'29-JUL-16 ','26-AUG-16 ','01-AUG-16 ',2,8.11,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist?bal','T?chira','5022','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10614,'BLAUS',8,'29-JUL-16 ','26-AUG-16 ','01-AUG-16 ',3,1.93,'Blauer See Delikatessen','Forsterstr. 57','Mannheim',null,'68306','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10615,'WILMK',2,'30-JUL-16 ','27-AUG-16 ','06-AUG-16 ',3,0.75,'Wilman Kala','Keskuskatu 45','Helsinki',null,'21240','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10616,'GREAL',1,'31-JUL-16 ','28-AUG-16 ','05-AUG-16 ',2,116.53,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10617,'GREAL',4,'31-JUL-16 ','28-AUG-16 ','04-AUG-16 ',2,18.53,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10618,'MEREP',1,'01-AUG-16 ','12-SEP-16 ','08-AUG-16 ',1,154.68,'M?re Paillarde','43 rue St. Laurent','Montr?al','Qu?bec','H1J 1C3','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10619,'MEREP',3,'04-AUG-16 ','01-SEP-16 ','07-AUG-16 ',3,91.05,'M?re Paillarde','43 rue St. Laurent','Montr?al','Qu?bec','H1J 1C3','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10620,'LAUGB',2,'05-AUG-16 ','02-SEP-16 ','14-AUG-16 ',3,0.94,'Laughing Bacchus Wine Cellars','2319 Elm St.','Vancouver','BC','V3F 2K1','Canada');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10621,'ISLAT',4,'05-AUG-16 ','02-SEP-16 ','11-AUG-16 ',2,23.73,'Island Trading','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10622,'RICAR',4,'06-AUG-16 ','03-SEP-16 ','11-AUG-16 ',3,50.97,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10623,'FRANK',8,'07-AUG-16 ','04-SEP-16 ','12-AUG-16 ',2,97.18,'Frankenversand','Berliner Platz 43','M?nchen',null,'80805','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10624,'THECR',4,'07-AUG-16 ','04-SEP-16 ','19-AUG-16 ',2,94.8,'The Cracker Box','55 Grizzly Peak Rd.','Butte','MT','59801','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10625,'ANATR',3,'08-AUG-16 ','05-SEP-16 ','14-AUG-16 ',1,43.9,'Ana Trujillo Emparedados y helados','Avda. de la Constituci?n 2222','M?xico D.F.',null,'05021','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10626,'BERGS',1,'11-AUG-16 ','08-SEP-16 ','20-AUG-16 ',2,138.69,'Berglunds snabbk?p','Berguvsv?gen  8','Lule?',null,'S-958 22','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10627,'SAVEA',8,'11-AUG-16 ','22-SEP-16 ','21-AUG-16 ',3,107.46,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10628,'BLONP',4,'12-AUG-16 ','09-SEP-16 ','20-AUG-16 ',3,30.36,'Blondel p?re et fils','24, place Kl?ber','Strasbourg',null,'67000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10629,'GODOS',4,'12-AUG-16 ','09-SEP-16 ','20-AUG-16 ',3,85.46,'Godos Cocina T?pica','C/ Romero, 33','Sevilla',null,'41101','Spain');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10630,'KOENE',1,'13-AUG-16 ','10-SEP-16 ','19-AUG-16 ',2,32.35,'K?niglich Essen','Maubelstr. 90','Brandenburg',null,'14776','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10631,'LAMAI',8,'14-AUG-16 ','11-SEP-16 ','15-AUG-16 ',1,0.87,'La maison d''Asie','1 rue Alsace-Lorraine','Toulouse',null,'31000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10632,'WANDK',8,'14-AUG-16 ','11-SEP-16 ','19-AUG-16 ',1,41.38,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart',null,'70563','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10633,'ERNSH',7,'15-AUG-16 ','12-SEP-16 ','18-AUG-16 ',3,477.9,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10634,'FOLIG',4,'15-AUG-16 ','12-SEP-16 ','21-AUG-16 ',3,487.38,'Folies gourmandes','184, chauss?e de Tournai','Lille',null,'59000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10635,'MAGAA',8,'18-AUG-16 ','15-SEP-16 ','21-AUG-16 ',3,47.46,'Magazzini Alimentari Riuniti','Via Ludovico il Moro 22','Bergamo',null,'24100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10636,'WARTH',4,'19-AUG-16 ','16-SEP-16 ','26-AUG-16 ',1,1.15,'Wartian Herkku','Torikatu 38','Oulu',null,'90110','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10637,'QUEEN',6,'19-AUG-16 ','16-SEP-16 ','26-AUG-16 ',1,201.29,'Queen Cozinha','Alameda dos Can?rios, 891','Sao Paulo','SP','05487-020','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10638,'LINOD',3,'20-AUG-16 ','17-SEP-16 ','01-SEP-16 ',1,158.44,'LINO-Delicateses','Ave. 5 de Mayo Porlamar','I. de Margarita','Nueva Esparta','4980','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10639,'SANTG',7,'20-AUG-16 ','17-SEP-16 ','27-AUG-16 ',3,38.64,'Sant? Gourmet','Erling Skakkes gate 78','Stavern',null,'4110','Norway');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10640,'WANDK',4,'21-AUG-16 ','18-SEP-16 ','28-AUG-16 ',1,23.55,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart',null,'70563','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10641,'HILAA',4,'22-AUG-16 ','19-SEP-16 ','26-AUG-16 ',2,179.61,'HILARION-Abastos','Carrera 22 con Ave. Carlos Soublette #8-35','San Crist?bal','T?chira','5022','Venezuela');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10642,'SIMOB',7,'22-AUG-16 ','19-SEP-16 ','05-SEP-16 ',3,41.89,'Simons bistro','Vinb?ltet 34','Kobenhavn',null,'1734','Denmark');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10643,'ALFKI',6,'25-AUG-16 ','22-SEP-16 ','02-SEP-16 ',1,29.46,'Alfreds Futterkiste','Obere Str. 57','Berlin',null,'12209','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10644,'WELLI',3,'25-AUG-16 ','22-SEP-16 ','01-SEP-16 ',2,0.14,'Wellington Importadora','Rua do Mercado, 12','Resende','SP','08737-363','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10645,'HANAR',4,'26-AUG-16 ','23-SEP-16 ','02-SEP-16 ',1,12.41,'Hanari Carnes','Rua do Pa?o, 67','Rio de Janeiro','RJ','05454-876','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10646,'HUNGO',9,'27-AUG-16 ','08-OCT-16 ','03-SEP-16 ',3,142.33,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',null,'Ireland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10647,'QUEDE',4,'27-AUG-16 ','10-SEP-16 ','03-SEP-16 ',2,45.54,'Que Del?cia','Rua da Panificadora, 12','Rio de Janeiro','RJ','02389-673','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10648,'RICAR',5,'28-AUG-16 ','09-OCT-16 ','09-SEP-16 ',2,14.25,'Ricardo Adocicados','Av. Copacabana, 267','Rio de Janeiro','RJ','02389-890','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10649,'MAISD',5,'28-AUG-16 ','25-SEP-16 ','29-AUG-16 ',3,6.2,'Maison Dewey','Rue Joseph-Bens 532','Bruxelles',null,'B-1180','Belgium');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10650,'FAMIA',5,'29-AUG-16 ','26-SEP-16 ','03-SEP-16 ',3,176.81,'Familia Arquibaldo','Rua Or?s, 92','Sao Paulo','SP','05442-030','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10651,'WANDK',8,'01-SEP-16 ','29-SEP-16 ','11-SEP-16 ',2,20.6,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart',null,'70563','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10652,'GOURL',4,'01-SEP-16 ','29-SEP-16 ','08-SEP-16 ',2,7.14,'Gourmet Lanchonetes','Av. Brasil, 442','Campinas','SP','04876-786','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10653,'FRANK',1,'02-SEP-16 ','30-SEP-16 ','19-SEP-16 ',1,93.25,'Frankenversand','Berliner Platz 43','M?nchen',null,'80805','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10654,'BERGS',5,'02-SEP-16 ','30-SEP-16 ','11-SEP-16 ',1,55.26,'Berglunds snabbk?p','Berguvsv?gen  8','Lule?',null,'S-958 22','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10655,'REGGC',1,'03-SEP-16 ','01-OCT-16 ','11-SEP-16 ',2,4.41,'Reggiani Caseifici','Strada Provinciale 124','Reggio Emilia',null,'42100','Italy');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10656,'GREAL',6,'04-SEP-16 ','02-OCT-16 ','10-SEP-16 ',1,57.15,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10657,'SAVEA',2,'04-SEP-16 ','02-OCT-16 ','15-SEP-16 ',2,352.69,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10658,'QUICK',4,'05-SEP-16 ','03-OCT-16 ','08-SEP-16 ',1,364.15,'QUICK-Stop','Taucherstra?e 10','Cunewalde',null,'01307','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10659,'QUEEN',7,'05-SEP-16 ','03-OCT-16 ','10-SEP-16 ',2,105.81,'Queen Cozinha','Alameda dos Can?rios, 891','Sao Paulo','SP','05487-020','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10660,'HUNGC',8,'08-SEP-16 ','06-OCT-16 ','15-OCT-16 ',1,111.29,'Hungry Coyote Import Store','City Center Plaza 516 Main St.','Elgin','OR','97827','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10661,'HUNGO',7,'09-SEP-16 ','07-OCT-16 ','15-SEP-16 ',3,17.55,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',null,'Ireland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10662,'LONEP',3,'09-SEP-16 ','07-OCT-16 ','18-SEP-16 ',2,1.28,'Lonesome Pine Restaurant','89 Chiaroscuro Rd.','Portland','OR','97219','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10663,'BONAP',2,'10-SEP-16 ','24-SEP-16 ','03-OCT-16 ',2,113.15,'Bon app''','12, rue des Bouchers','Marseille',null,'13008','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10664,'FURIB',1,'10-SEP-16 ','08-OCT-16 ','19-SEP-16 ',3,1.27,'Furia Bacalhau e Frutos do Mar','Jardim das rosas n. 32','Lisboa',null,'1675','Portugal');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10665,'LONEP',1,'11-SEP-16 ','09-OCT-16 ','17-SEP-16 ',2,26.31,'Lonesome Pine Restaurant','89 Chiaroscuro Rd.','Portland','OR','97219','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10666,'RICSU',7,'12-SEP-16 ','10-OCT-16 ','22-SEP-16 ',2,232.42,'Richter Supermarkt','Starenweg 5','Gen?ve',null,'1204','Switzerland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10667,'ERNSH',7,'12-SEP-16 ','10-OCT-16 ','19-SEP-16 ',1,78.09,'Ernst Handel','Kirchgasse 6','Graz',null,'8010','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10668,'WANDK',1,'15-SEP-16 ','13-OCT-16 ','23-SEP-16 ',2,47.22,'Die Wandernde Kuh','Adenauerallee 900','Stuttgart',null,'70563','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10669,'SIMOB',2,'15-SEP-16 ','13-OCT-16 ','22-SEP-16 ',1,24.39,'Simons bistro','Vinb?ltet 34','Kobenhavn',null,'1734','Denmark');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10670,'FRANK',4,'16-SEP-16 ','14-OCT-16 ','18-SEP-16 ',1,203.48,'Frankenversand','Berliner Platz 43','M?nchen',null,'80805','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10671,'FRANR',1,'17-SEP-16 ','15-OCT-16 ','24-SEP-16 ',1,30.34,'France restauration','54, rue Royale','Nantes',null,'44000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10672,'BERGS',9,'17-SEP-16 ','01-OCT-16 ','26-SEP-16 ',2,95.75,'Berglunds snabbk?p','Berguvsv?gen  8','Lule?',null,'S-958 22','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10673,'WILMK',2,'18-SEP-16 ','16-OCT-16 ','19-SEP-16 ',1,22.76,'Wilman Kala','Keskuskatu 45','Helsinki',null,'21240','Finland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10674,'ISLAT',4,'18-SEP-16 ','16-OCT-16 ','30-SEP-16 ',2,0.9,'Island Trading','Garden House Crowther Way','Cowes','Isle of Wight','PO31 7PJ','UK');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10675,'FRANK',5,'19-SEP-16 ','17-OCT-16 ','23-SEP-16 ',2,31.85,'Frankenversand','Berliner Platz 43','M?nchen',null,'80805','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10676,'TORTU',2,'22-SEP-16 ','20-OCT-16 ','29-SEP-16 ',2,2.01,'Tortuga Restaurante','Avda. Azteca 123','M?xico D.F.',null,'05033','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10677,'ANTON',1,'22-SEP-16 ','20-OCT-16 ','26-SEP-16 ',3,4.03,'Antonio Moreno Taquer?a','Mataderos  2312','M?xico D.F.',null,'05023','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10678,'SAVEA',7,'23-SEP-16 ','21-OCT-16 ','16-OCT-16 ',3,388.98,'Save-a-lot Markets','187 Suffolk Ln.','Boise','ID','83720','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10679,'BLONP',8,'23-SEP-16 ','21-OCT-16 ','30-SEP-16 ',3,27.94,'Blondel p?re et fils','24, place Kl?ber','Strasbourg',null,'67000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10680,'OLDWO',1,'24-SEP-16 ','22-OCT-16 ','26-SEP-16 ',1,26.61,'Old World Delicatessen','2743 Bering St.','Anchorage','AK','99508','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10681,'GREAL',3,'25-SEP-16 ','23-OCT-16 ','30-SEP-16 ',3,76.13,'Great Lakes Food Market','2732 Baker Blvd.','Eugene','OR','97403','USA');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10682,'ANTON',3,'25-SEP-16 ','23-OCT-16 ','01-OCT-16 ',2,36.13,'Antonio Moreno Taquer?a','Mataderos  2312','M?xico D.F.',null,'05023','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10683,'DUMON',2,'26-SEP-16 ','24-OCT-16 ','01-OCT-16 ',1,4.4,'Du monde entier','67, rue des Cinquante Otages','Nantes',null,'44000','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10684,'OTTIK',3,'26-SEP-16 ','24-OCT-16 ','30-SEP-16 ',1,145.63,'Ottilies K?seladen','Mehrheimerstr. 369','K?ln',null,'50739','Germany');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10685,'GOURL',4,'29-SEP-16 ','13-OCT-16 ','03-OCT-16 ',2,33.75,'Gourmet Lanchonetes','Av. Brasil, 442','Campinas','SP','04876-786','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10686,'PICCO',2,'30-SEP-16 ','28-OCT-16 ','08-OCT-16 ',1,96.5,'Piccolo und mehr','Geislweg 14','Salzburg',null,'5020','Austria');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10687,'HUNGO',9,'30-SEP-16 ','28-OCT-16 ','30-OCT-16 ',2,296.43,'Hungry Owl All-Night Grocers','8 Johnstown Road','Cork','Co. Cork',null,'Ireland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10688,'VAFFE',4,'01-OCT-16 ','15-OCT-16 ','07-OCT-16 ',2,299.09,'Vaffeljernet','Smagsloget 45','?rhus',null,'8200','Denmark');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10689,'BERGS',1,'01-OCT-16 ','29-OCT-16 ','07-OCT-16 ',2,13.42,'Berglunds snabbk?p','Berguvsv?gen  8','Lule?',null,'S-958 22','Sweden');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (10690,'HANAR',1,'02-OCT-16 ','30-OCT-16 ','03-OCT-16 ',1,15.8,'Hanari Carnes','Rua do Pa?o, 67','Rio de Janeiro','RJ','05454-876','Brazil');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11073,'PERIC',2,'05-MAY-17 ','02-JUN-17 ',null,2,24.95,'Pericles Comidas cl?sicas','Calle Dr. Jorge Cash 321','M?xico D.F.',null,'05033','Mexico');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11074,'SIMOB',7,'06-MAY-17 ','03-JUN-17 ',null,2,18.44,'Simons bistro','Vinb?ltet 34','Kobenhavn',null,'1734','Denmark');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11075,'RICSU',8,'06-MAY-17 ','03-JUN-17 ',null,2,6.19,'Richter Supermarkt','Starenweg 5','Gen?ve',null,'1204','Switzerland');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11076,'BONAP',4,'06-MAY-17 ','03-JUN-17 ',null,2,38.28,'Bon app''','12, rue des Bouchers','Marseille',null,'13008','France');
Insert into ORDERS2783 (ORDERID,CUSTOMERID,EMPLOYEEID,ORDERDATE,REQUIREDDATE,SHIPPEDDATE,SHIPVIA,FREIGHT,SHIPNAME,SHIPADDRESS,SHIPCITY,SHIPREGION,SHIPPOSTALCODE,SHIPCOUNTRY) values (11077,'RATTC',1,'06-MAY-17 ','03-JUN-17 ',null,2,8.53,'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque','NM','87110','USA');

/* insert into order_Details */
INSERT INTO Order_Details2783 VALUES(10248,11,14,12,0);
INSERT INTO Order_Details2783 VALUES(10248,42,9.8,10,0);
INSERT INTO Order_Details2783 VALUES(10248,72,34.8,5,0);
INSERT INTO Order_Details2783 VALUES(10249,14,18.6,9,0);
INSERT INTO Order_Details2783 VALUES(10249,51,42.4,40,0);
INSERT INTO Order_Details2783 VALUES(10250,41,7.7,10,0);
INSERT INTO Order_Details2783 VALUES(10250,51,42.4,35,0.15);
INSERT INTO Order_Details2783 VALUES(10250,65,16.8,15,0.15);
INSERT INTO Order_Details2783 VALUES(10251,22,16.8,6,0.05);
INSERT INTO Order_Details2783 VALUES(10251,57,15.6,15,0.05);
INSERT INTO Order_Details2783 VALUES(10251,65,16.8,20,0);
INSERT INTO Order_Details2783 VALUES(10252,20,64.8,40,0.05);
INSERT INTO Order_Details2783 VALUES(10252,33,2,25,0.05);
INSERT INTO Order_Details2783 VALUES(10252,60,27.2,40,0);
INSERT INTO Order_Details2783 VALUES(10253,31,10,20,0);
INSERT INTO Order_Details2783 VALUES(10253,39,14.4,42,0);
INSERT INTO Order_Details2783 VALUES(10253,49,16,40,0);
INSERT INTO Order_Details2783 VALUES(10254,24,3.6,15,0.15);
INSERT INTO Order_Details2783 VALUES(10254,55,19.2,21,0.15);
INSERT INTO Order_Details2783 VALUES(10254,74,8,21,0);
INSERT INTO Order_Details2783 VALUES(10255,2,15.2,20,0);
INSERT INTO Order_Details2783 VALUES(10255,16,13.9,35,0);
INSERT INTO Order_Details2783 VALUES(10255,36,15.2,25,0);
INSERT INTO Order_Details2783 VALUES(10255,59,44,30,0);
INSERT INTO Order_Details2783 VALUES(10256,53,26.2,15,0);
INSERT INTO Order_Details2783 VALUES(10256,77,10.4,12,0);
INSERT INTO Order_Details2783 VALUES(10257,27,35.1,25,0);
INSERT INTO Order_Details2783 VALUES(10257,39,14.4,6,0);
INSERT INTO Order_Details2783 VALUES(10257,77,10.4,15,0);
INSERT INTO Order_Details2783 VALUES(10258,2,15.2,50,0.2);
INSERT INTO Order_Details2783 VALUES(10258,5,17,65,0.2);
INSERT INTO Order_Details2783 VALUES(10258,32,25.6,6,0.2);
INSERT INTO Order_Details2783 VALUES(10259,21,8,10,0);
INSERT INTO Order_Details2783 VALUES(10259,37,20.8,1,0);
INSERT INTO Order_Details2783 VALUES(10260,41,7.7,16,0.25);
INSERT INTO Order_Details2783 VALUES(10260,57,15.6,50,0);
INSERT INTO Order_Details2783 VALUES(10260,62,39.4,15,0.25);
INSERT INTO Order_Details2783 VALUES(10260,70,12,21,0.25);
INSERT INTO Order_Details2783 VALUES(10261,21,8,20,0);
INSERT INTO Order_Details2783 VALUES(10261,35,14.4,20,0);
INSERT INTO Order_Details2783 VALUES(10262,5,17,12,0.2);
INSERT INTO Order_Details2783 VALUES(10262,7,24,15,0);
INSERT INTO Order_Details2783 VALUES(10262,56,30.4,2,0);
INSERT INTO Order_Details2783 VALUES(10263,16,13.9,60,0.25);
INSERT INTO Order_Details2783 VALUES(10263,24,3.6,28,0);
INSERT INTO Order_Details2783 VALUES(10263,30,20.7,60,0.25);
INSERT INTO Order_Details2783 VALUES(10263,74,8,36,0.25);
INSERT INTO Order_Details2783 VALUES(10264,2,15.2,35,0);
INSERT INTO Order_Details2783 VALUES(10264,41,7.7,25,0.15);
INSERT INTO Order_Details2783 VALUES(10265,17,31.2,30,0);
INSERT INTO Order_Details2783 VALUES(10265,70,12,20,0);
INSERT INTO Order_Details2783 VALUES(10266,12,30.4,12,0.05);
INSERT INTO Order_Details2783 VALUES(10267,40,14.7,50,0);
INSERT INTO Order_Details2783 VALUES(10267,59,44,70,0.15);
INSERT INTO Order_Details2783 VALUES(10267,76,14.4,15,0.15);
INSERT INTO Order_Details2783 VALUES(10268,29,99,10,0);
INSERT INTO Order_Details2783 VALUES(10268,72,27.8,4,0);
INSERT INTO Order_Details2783 VALUES(10269,33,2,60,0.05);
INSERT INTO Order_Details2783 VALUES(10269,72,27.8,20,0.05);
INSERT INTO Order_Details2783 VALUES(10270,36,15.2,30,0);
INSERT INTO Order_Details2783 VALUES(10270,43,36.8,25,0);
INSERT INTO Order_Details2783 VALUES(10271,33,2,24,0);
INSERT INTO Order_Details2783 VALUES(10272,20,64.8,6,0);
INSERT INTO Order_Details2783 VALUES(10272,31,10,40,0);
INSERT INTO Order_Details2783 VALUES(10272,72,27.8,24,0);
INSERT INTO Order_Details2783 VALUES(10273,10,24.8,24,0.05);
INSERT INTO Order_Details2783 VALUES(10273,31,10,15,0.05);
INSERT INTO Order_Details2783 VALUES(10273,33,2,20,0);
INSERT INTO Order_Details2783 VALUES(10273,40,14.7,60,0.05);
INSERT INTO Order_Details2783 VALUES(10273,76,14.4,33,0.05);
INSERT INTO Order_Details2783 VALUES(10274,71,17.2,20,0);
INSERT INTO Order_Details2783 VALUES(10274,72,27.8,7,0);
INSERT INTO Order_Details2783 VALUES(10275,24,3.6,12,0.05);
INSERT INTO Order_Details2783 VALUES(10275,59,44,6,0.05);
INSERT INTO Order_Details2783 VALUES(10276,10,24.8,15,0);
INSERT INTO Order_Details2783 VALUES(10276,13,4.8,10,0);
INSERT INTO Order_Details2783 VALUES(10277,28,36.4,20,0);
INSERT INTO Order_Details2783 VALUES(10277,62,39.4,12,0);
INSERT INTO Order_Details2783 VALUES(10278,44,15.5,16,0);
INSERT INTO Order_Details2783 VALUES(10278,59,44,15,0);
INSERT INTO Order_Details2783 VALUES(10278,63,35.1,8,0);
INSERT INTO Order_Details2783 VALUES(10278,73,12,25,0);
INSERT INTO Order_Details2783 VALUES(10279,17,31.2,15,0.25);
INSERT INTO Order_Details2783 VALUES(10280,24,3.6,12,0);
INSERT INTO Order_Details2783 VALUES(10280,55,19.2,20,0);
INSERT INTO Order_Details2783 VALUES(10280,75,6.2,30,0);
INSERT INTO Order_Details2783 VALUES(10281,19,7.3,1,0);
INSERT INTO Order_Details2783 VALUES(10281,24,3.6,6,0);
INSERT INTO Order_Details2783 VALUES(10281,35,14.4,4,0);
INSERT INTO Order_Details2783 VALUES(10282,30,20.7,6,0);
INSERT INTO Order_Details2783 VALUES(10282,57,15.6,2,0);
INSERT INTO Order_Details2783 VALUES(10283,15,12.4,20,0);
INSERT INTO Order_Details2783 VALUES(10283,19,7.3,18,0);
INSERT INTO Order_Details2783 VALUES(10283,60,27.2,35,0);
INSERT INTO Order_Details2783 VALUES(10283,72,27.8,3,0);
INSERT INTO Order_Details2783 VALUES(10284,27,35.1,15,0.25);
INSERT INTO Order_Details2783 VALUES(10284,44,15.5,21,0);
INSERT INTO Order_Details2783 VALUES(10284,60,27.2,20,0.25);
INSERT INTO Order_Details2783 VALUES(10284,67,11.2,5,0.25);
INSERT INTO Order_Details2783 VALUES(10285,1,14.4,45,0.2);
INSERT INTO Order_Details2783 VALUES(10285,40,14.7,40,0.2);
INSERT INTO Order_Details2783 VALUES(10285,53,26.2,36,0.2);
INSERT INTO Order_Details2783 VALUES(10286,35,14.4,100,0);
INSERT INTO Order_Details2783 VALUES(10286,62,39.4,40,0);
INSERT INTO Order_Details2783 VALUES(10287,16,13.9,40,0.15);
INSERT INTO Order_Details2783 VALUES(10287,34,11.2,20,0);
INSERT INTO Order_Details2783 VALUES(10287,46,9.6,15,0.15);
INSERT INTO Order_Details2783 VALUES(10288,54,5.9,10,0.1);
INSERT INTO Order_Details2783 VALUES(10288,68,10,3,0.1);
INSERT INTO Order_Details2783 VALUES(10289,3,8,30,0);
INSERT INTO Order_Details2783 VALUES(10289,64,26.6,9,0);
INSERT INTO Order_Details2783 VALUES(10290,5,17,20,0);
INSERT INTO Order_Details2783 VALUES(10290,29,99,15,0);
INSERT INTO Order_Details2783 VALUES(10290,49,16,15,0);
INSERT INTO Order_Details2783 VALUES(10290,77,10.4,10,0);
INSERT INTO Order_Details2783 VALUES(10291,13,4.8,20,0.1);
INSERT INTO Order_Details2783 VALUES(10291,44,15.5,24,0.1);
INSERT INTO Order_Details2783 VALUES(10291,51,42.4,2,0.1);
INSERT INTO Order_Details2783 VALUES(10292,20,64.8,20,0);
INSERT INTO Order_Details2783 VALUES(10293,18,50,12,0);
INSERT INTO Order_Details2783 VALUES(10293,24,3.6,10,0);
INSERT INTO Order_Details2783 VALUES(10293,63,35.1,5,0);
INSERT INTO Order_Details2783 VALUES(10293,75,6.2,6,0);
INSERT INTO Order_Details2783 VALUES(10294,1,14.4,18,0);
INSERT INTO Order_Details2783 VALUES(10294,17,31.2,15,0);
INSERT INTO Order_Details2783 VALUES(10294,43,36.8,15,0);
INSERT INTO Order_Details2783 VALUES(10294,60,27.2,21,0);
INSERT INTO Order_Details2783 VALUES(10294,75,6.2,6,0);
INSERT INTO Order_Details2783 VALUES(10295,56,30.4,4,0);
INSERT INTO Order_Details2783 VALUES(10296,11,16.8,12,0);
INSERT INTO Order_Details2783 VALUES(10296,16,13.9,30,0);
INSERT INTO Order_Details2783 VALUES(10296,69,28.8,15,0);
INSERT INTO Order_Details2783 VALUES(10297,39,14.4,60,0);
INSERT INTO Order_Details2783 VALUES(10297,72,27.8,20,0);
INSERT INTO Order_Details2783 VALUES(10298,2,15.2,40,0);
INSERT INTO Order_Details2783 VALUES(10298,36,15.2,40,0.25);
INSERT INTO Order_Details2783 VALUES(10298,59,44,30,0.25);
INSERT INTO Order_Details2783 VALUES(10298,62,39.4,15,0);
INSERT INTO Order_Details2783 VALUES(10299,19,7.3,15,0);
INSERT INTO Order_Details2783 VALUES(10299,70,12,20,0);
INSERT INTO Order_Details2783 VALUES(10300,66,13.6,30,0);
INSERT INTO Order_Details2783 VALUES(10300,68,10,20,0);
INSERT INTO Order_Details2783 VALUES(10301,40,14.7,10,0);
INSERT INTO Order_Details2783 VALUES(10301,56,30.4,20,0);
INSERT INTO Order_Details2783 VALUES(10302,17,31.2,40,0);
INSERT INTO Order_Details2783 VALUES(10302,28,36.4,28,0);
INSERT INTO Order_Details2783 VALUES(10302,43,36.8,12,0);
INSERT INTO Order_Details2783 VALUES(10303,40,14.7,40,0.1);
INSERT INTO Order_Details2783 VALUES(10303,65,16.8,30,0.1);
INSERT INTO Order_Details2783 VALUES(10303,68,10,15,0.1);
INSERT INTO Order_Details2783 VALUES(10304,49,16,30,0);
INSERT INTO Order_Details2783 VALUES(10304,59,44,10,0);
INSERT INTO Order_Details2783 VALUES(10304,71,17.2,2,0);
INSERT INTO Order_Details2783 VALUES(10305,18,50,25,0.1);
INSERT INTO Order_Details2783 VALUES(10305,29,99,25,0.1);
INSERT INTO Order_Details2783 VALUES(10305,39,14.4,30,0.1);
INSERT INTO Order_Details2783 VALUES(10306,30,20.7,10,0);
INSERT INTO Order_Details2783 VALUES(10306,53,26.2,10,0);
INSERT INTO Order_Details2783 VALUES(10306,54,5.9,5,0);
INSERT INTO Order_Details2783 VALUES(10307,62,39.4,10,0);
INSERT INTO Order_Details2783 VALUES(10307,68,10,3,0);
INSERT INTO Order_Details2783 VALUES(10308,69,28.8,1,0);
INSERT INTO Order_Details2783 VALUES(10308,70,12,5,0);
INSERT INTO Order_Details2783 VALUES(10309,4,17.6,20,0);
INSERT INTO Order_Details2783 VALUES(10309,6,20,30,0);
INSERT INTO Order_Details2783 VALUES(10309,42,11.2,2,0);
INSERT INTO Order_Details2783 VALUES(10309,43,36.8,20,0);
INSERT INTO Order_Details2783 VALUES(10309,71,17.2,3,0);
INSERT INTO Order_Details2783 VALUES(10310,16,13.9,10,0);
INSERT INTO Order_Details2783 VALUES(10310,62,39.4,5,0);
INSERT INTO Order_Details2783 VALUES(10311,42,11.2,6,0);
INSERT INTO Order_Details2783 VALUES(10311,69,28.8,7,0);
INSERT INTO Order_Details2783 VALUES(10312,28,36.4,4,0);
INSERT INTO Order_Details2783 VALUES(10312,43,36.8,24,0);
INSERT INTO Order_Details2783 VALUES(10312,53,26.2,20,0);
INSERT INTO Order_Details2783 VALUES(10312,75,6.2,10,0);
INSERT INTO Order_Details2783 VALUES(10313,36,15.2,12,0);
INSERT INTO Order_Details2783 VALUES(10314,32,25.6,40,0.1);
INSERT INTO Order_Details2783 VALUES(10314,58,10.6,30,0.1);
INSERT INTO Order_Details2783 VALUES(10314,62,39.4,25,0.1);
INSERT INTO Order_Details2783 VALUES(10315,34,11.2,14,0);
INSERT INTO Order_Details2783 VALUES(10315,70,12,30,0);
INSERT INTO Order_Details2783 VALUES(10316,41,7.7,10,0);
INSERT INTO Order_Details2783 VALUES(10316,62,39.4,70,0);
INSERT INTO Order_Details2783 VALUES(10317,1,14.4,20,0);
INSERT INTO Order_Details2783 VALUES(10318,41,7.7,20,0);
INSERT INTO Order_Details2783 VALUES(10318,76,14.4,6,0);
INSERT INTO Order_Details2783 VALUES(10319,17,31.2,8,0);
INSERT INTO Order_Details2783 VALUES(10319,28,36.4,14,0);
INSERT INTO Order_Details2783 VALUES(10319,76,14.4,30,0);
INSERT INTO Order_Details2783 VALUES(10320,71,17.2,30,0);
INSERT INTO Order_Details2783 VALUES(10321,35,14.4,10,0);
INSERT INTO Order_Details2783 VALUES(10322,52,5.6,20,0);
INSERT INTO Order_Details2783 VALUES(10323,15,12.4,5,0);
INSERT INTO Order_Details2783 VALUES(10323,25,11.2,4,0);
INSERT INTO Order_Details2783 VALUES(10323,39,14.4,4,0);
INSERT INTO Order_Details2783 VALUES(10324,16,13.9,21,0.15);
INSERT INTO Order_Details2783 VALUES(10324,35,14.4,70,0.15);
INSERT INTO Order_Details2783 VALUES(10324,46,9.6,30,0);
INSERT INTO Order_Details2783 VALUES(10324,59,44,40,0.15);
INSERT INTO Order_Details2783 VALUES(10324,63,35.1,80,0.15);
INSERT INTO Order_Details2783 VALUES(10325,6,20,6,0);
INSERT INTO Order_Details2783 VALUES(10325,13,4.8,12,0);
INSERT INTO Order_Details2783 VALUES(10325,14,18.6,9,0);
INSERT INTO Order_Details2783 VALUES(10325,31,10,4,0);
INSERT INTO Order_Details2783 VALUES(10325,72,27.8,40,0);
INSERT INTO Order_Details2783 VALUES(10326,4,17.6,24,0);
INSERT INTO Order_Details2783 VALUES(10326,57,15.6,16,0);
INSERT INTO Order_Details2783 VALUES(10326,75,6.2,50,0);
INSERT INTO Order_Details2783 VALUES(10327,2,15.2,25,0.2);
INSERT INTO Order_Details2783 VALUES(10327,11,16.8,50,0.2);
INSERT INTO Order_Details2783 VALUES(10327,30,20.7,35,0.2);
INSERT INTO Order_Details2783 VALUES(10327,58,10.6,30,0.2);
INSERT INTO Order_Details2783 VALUES(10328,59,44,9,0);
INSERT INTO Order_Details2783 VALUES(10328,65,16.8,40,0);
INSERT INTO Order_Details2783 VALUES(10328,68,10,10,0);
INSERT INTO Order_Details2783 VALUES(10329,19,7.3,10,0.05);
INSERT INTO Order_Details2783 VALUES(10329,30,20.7,8,0.05);
INSERT INTO Order_Details2783 VALUES(10329,38,210.8,20,0.05);
INSERT INTO Order_Details2783 VALUES(10329,56,30.4,12,0.05);
INSERT INTO Order_Details2783 VALUES(10330,26,24.9,50,0.15);
INSERT INTO Order_Details2783 VALUES(10330,72,27.8,25,0.15);
INSERT INTO Order_Details2783 VALUES(10331,54,5.9,15,0);
INSERT INTO Order_Details2783 VALUES(10332,18,50,40,0.2);
INSERT INTO Order_Details2783 VALUES(10332,42,11.2,10,0.2);
INSERT INTO Order_Details2783 VALUES(10332,47,7.6,16,0.2);
INSERT INTO Order_Details2783 VALUES(10333,14,18.6,10,0);
INSERT INTO Order_Details2783 VALUES(10333,21,8,10,0.1);
INSERT INTO Order_Details2783 VALUES(10333,71,17.2,40,0.1);
INSERT INTO Order_Details2783 VALUES(10334,52,5.6,8,0);
INSERT INTO Order_Details2783 VALUES(10334,68,10,10,0);
INSERT INTO Order_Details2783 VALUES(10335,2,15.2,7,0.2);
INSERT INTO Order_Details2783 VALUES(10335,31,10,25,0.2);
INSERT INTO Order_Details2783 VALUES(10335,32,25.6,6,0.2);
INSERT INTO Order_Details2783 VALUES(10335,51,42.4,48,0.2);
INSERT INTO Order_Details2783 VALUES(10336,4,17.6,18,0.1);
INSERT INTO Order_Details2783 VALUES(10337,23,7.2,40,0);
INSERT INTO Order_Details2783 VALUES(10337,26,24.9,24,0);
INSERT INTO Order_Details2783 VALUES(10337,36,15.2,20,0);
INSERT INTO Order_Details2783 VALUES(10337,37,20.8,28,0);
INSERT INTO Order_Details2783 VALUES(10337,72,27.8,25,0);
INSERT INTO Order_Details2783 VALUES(10338,17,31.2,20,0);
INSERT INTO Order_Details2783 VALUES(10338,30,20.7,15,0);
INSERT INTO Order_Details2783 VALUES(10339,4,17.6,10,0);
INSERT INTO Order_Details2783 VALUES(10339,17,31.2,70,0.05);
INSERT INTO Order_Details2783 VALUES(10339,62,39.4,28,0);
INSERT INTO Order_Details2783 VALUES(10340,18,50,20,0.05);
INSERT INTO Order_Details2783 VALUES(10340,41,7.7,12,0.05);
INSERT INTO Order_Details2783 VALUES(10340,43,36.8,40,0.05);
INSERT INTO Order_Details2783 VALUES(10341,33,2,8,0);
INSERT INTO Order_Details2783 VALUES(10341,59,44,9,0.15);
INSERT INTO Order_Details2783 VALUES(10342,2,15.2,24,0.2);
INSERT INTO Order_Details2783 VALUES(10342,31,10,56,0.2);
INSERT INTO Order_Details2783 VALUES(10342,36,15.2,40,0.2);
INSERT INTO Order_Details2783 VALUES(10342,55,19.2,40,0.2);
INSERT INTO Order_Details2783 VALUES(10343,64,26.6,50,0);
INSERT INTO Order_Details2783 VALUES(10343,68,10,4,0.05);
INSERT INTO Order_Details2783 VALUES(10343,76,14.4,15,0);
INSERT INTO Order_Details2783 VALUES(10344,4,17.6,35,0);
INSERT INTO Order_Details2783 VALUES(10344,8,32,70,0.25);
INSERT INTO Order_Details2783 VALUES(10345,8,32,70,0);
INSERT INTO Order_Details2783 VALUES(10345,19,7.3,80,0);
INSERT INTO Order_Details2783 VALUES(10345,42,11.2,9,0);
INSERT INTO Order_Details2783 VALUES(10346,17,31.2,36,0.1);
INSERT INTO Order_Details2783 VALUES(10346,56,30.4,20,0);
INSERT INTO Order_Details2783 VALUES(10347,25,11.2,10,0);
INSERT INTO Order_Details2783 VALUES(10347,39,14.4,50,0.15);
INSERT INTO Order_Details2783 VALUES(10347,40,14.7,4,0);
INSERT INTO Order_Details2783 VALUES(10347,75,6.2,6,0.15);
INSERT INTO Order_Details2783 VALUES(10348,1,14.4,15,0.15);
INSERT INTO Order_Details2783 VALUES(10348,23,7.2,25,0);
INSERT INTO Order_Details2783 VALUES(10349,54,5.9,24,0);
INSERT INTO Order_Details2783 VALUES(10350,50,13,15,0.1);
INSERT INTO Order_Details2783 VALUES(10350,69,28.8,18,0.1);
INSERT INTO Order_Details2783 VALUES(10351,38,210.8,20,0.05);
INSERT INTO Order_Details2783 VALUES(10351,41,7.7,13,0);
INSERT INTO Order_Details2783 VALUES(10351,44,15.5,77,0.05);
INSERT INTO Order_Details2783 VALUES(10351,65,16.8,10,0.05);
INSERT INTO Order_Details2783 VALUES(10352,24,3.6,10,0);
INSERT INTO Order_Details2783 VALUES(10352,54,5.9,20,0.15);
INSERT INTO Order_Details2783 VALUES(10353,11,16.8,12,0.2);
INSERT INTO Order_Details2783 VALUES(10353,38,210.8,50,0.2);
INSERT INTO Order_Details2783 VALUES(10354,1,14.4,12,0);
INSERT INTO Order_Details2783 VALUES(10354,29,99,4,0);
INSERT INTO Order_Details2783 VALUES(10355,24,3.6,25,0);
INSERT INTO Order_Details2783 VALUES(10355,57,15.6,25,0);
INSERT INTO Order_Details2783 VALUES(10356,31,10,30,0);
INSERT INTO Order_Details2783 VALUES(10356,55,19.2,12,0);
INSERT INTO Order_Details2783 VALUES(10356,69,28.8,20,0);
INSERT INTO Order_Details2783 VALUES(10357,10,24.8,30,0.2);
INSERT INTO Order_Details2783 VALUES(10357,26,24.9,16,0);
INSERT INTO Order_Details2783 VALUES(10357,60,27.2,8,0.2);
INSERT INTO Order_Details2783 VALUES(10358,24,3.6,10,0.05);
INSERT INTO Order_Details2783 VALUES(10358,34,11.2,10,0.05);
INSERT INTO Order_Details2783 VALUES(10358,36,15.2,20,0.05);
INSERT INTO Order_Details2783 VALUES(10359,16,13.9,56,0.05);
INSERT INTO Order_Details2783 VALUES(10359,31,10,70,0.05);
INSERT INTO Order_Details2783 VALUES(10359,60,27.2,80,0.05);
INSERT INTO Order_Details2783 VALUES(10360,28,36.4,30,0);
INSERT INTO Order_Details2783 VALUES(10360,29,99,35,0);
INSERT INTO Order_Details2783 VALUES(10360,38,210.8,10,0);
INSERT INTO Order_Details2783 VALUES(10360,49,16,35,0);
INSERT INTO Order_Details2783 VALUES(10360,54,5.9,28,0);
INSERT INTO Order_Details2783 VALUES(10361,39,14.4,54,0.1);
INSERT INTO Order_Details2783 VALUES(10361,60,27.2,55,0.1);
INSERT INTO Order_Details2783 VALUES(10362,25,11.2,50,0);
INSERT INTO Order_Details2783 VALUES(10362,51,42.4,20,0);
INSERT INTO Order_Details2783 VALUES(10362,54,5.9,24,0);
INSERT INTO Order_Details2783 VALUES(10363,31,10,20,0);
INSERT INTO Order_Details2783 VALUES(10363,75,6.2,12,0);
INSERT INTO Order_Details2783 VALUES(10363,76,14.4,12,0);
INSERT INTO Order_Details2783 VALUES(10364,69,28.8,30,0);
INSERT INTO Order_Details2783 VALUES(10364,71,17.2,5,0);
INSERT INTO Order_Details2783 VALUES(10365,11,16.8,24,0);
INSERT INTO Order_Details2783 VALUES(10366,65,16.8,5,0);
INSERT INTO Order_Details2783 VALUES(10366,77,10.4,5,0);
INSERT INTO Order_Details2783 VALUES(10367,34,11.2,36,0);
INSERT INTO Order_Details2783 VALUES(10367,54,5.9,18,0);
INSERT INTO Order_Details2783 VALUES(10367,65,16.8,15,0);
INSERT INTO Order_Details2783 VALUES(10367,77,10.4,7,0);
INSERT INTO Order_Details2783 VALUES(10368,21,8,5,0.1);
INSERT INTO Order_Details2783 VALUES(10368,28,36.4,13,0.1);
INSERT INTO Order_Details2783 VALUES(10368,57,15.6,25,0);
INSERT INTO Order_Details2783 VALUES(10368,64,26.6,35,0.1);
INSERT INTO Order_Details2783 VALUES(10369,29,99,20,0);
INSERT INTO Order_Details2783 VALUES(10369,56,30.4,18,0.25);
INSERT INTO Order_Details2783 VALUES(10370,1,14.4,15,0.15);
INSERT INTO Order_Details2783 VALUES(10370,64,26.6,30,0);
INSERT INTO Order_Details2783 VALUES(10370,74,8,20,0.15);
INSERT INTO Order_Details2783 VALUES(10371,36,15.2,6,0.2);
INSERT INTO Order_Details2783 VALUES(10372,20,64.8,12,0.25);
INSERT INTO Order_Details2783 VALUES(10372,38,210.8,40,0.25);
INSERT INTO Order_Details2783 VALUES(10372,60,27.2,70,0.25);
INSERT INTO Order_Details2783 VALUES(10372,72,27.8,42,0.25);
INSERT INTO Order_Details2783 VALUES(10373,58,10.6,80,0.2);
INSERT INTO Order_Details2783 VALUES(10373,71,17.2,50,0.2);
INSERT INTO Order_Details2783 VALUES(10374,31,10,30,0);
INSERT INTO Order_Details2783 VALUES(10374,58,10.6,15,0);
INSERT INTO Order_Details2783 VALUES(10375,14,18.6,15,0);
INSERT INTO Order_Details2783 VALUES(10375,54,5.9,10,0);
INSERT INTO Order_Details2783 VALUES(10376,31,10,42,0.05);
INSERT INTO Order_Details2783 VALUES(10377,28,36.4,20,0.15);
INSERT INTO Order_Details2783 VALUES(10377,39,14.4,20,0.15);
INSERT INTO Order_Details2783 VALUES(10378,71,17.2,6,0);
INSERT INTO Order_Details2783 VALUES(10379,41,7.7,8,0.1);
INSERT INTO Order_Details2783 VALUES(10379,63,35.1,16,0.1);
INSERT INTO Order_Details2783 VALUES(10379,65,16.8,20,0.1);
INSERT INTO Order_Details2783 VALUES(10380,30,20.7,18,0.1);
INSERT INTO Order_Details2783 VALUES(10380,53,26.2,20,0.1);
INSERT INTO Order_Details2783 VALUES(10380,60,27.2,6,0.1);
INSERT INTO Order_Details2783 VALUES(10380,70,12,30,0);
INSERT INTO Order_Details2783 VALUES(10381,74,8,14,0);
INSERT INTO Order_Details2783 VALUES(10382,5,17,32,0);
INSERT INTO Order_Details2783 VALUES(10382,18,50,9,0);
INSERT INTO Order_Details2783 VALUES(10382,29,99,14,0);
INSERT INTO Order_Details2783 VALUES(10382,33,2,60,0);
INSERT INTO Order_Details2783 VALUES(10382,74,8,50,0);
INSERT INTO Order_Details2783 VALUES(10383,13,4.8,20,0);
INSERT INTO Order_Details2783 VALUES(10383,50,13,15,0);
INSERT INTO Order_Details2783 VALUES(10383,56,30.4,20,0);
INSERT INTO Order_Details2783 VALUES(10384,20,64.8,28,0);
INSERT INTO Order_Details2783 VALUES(10384,60,27.2,15,0);
INSERT INTO Order_Details2783 VALUES(10385,7,24,10,0.2);
INSERT INTO Order_Details2783 VALUES(10385,60,27.2,20,0.2);
INSERT INTO Order_Details2783 VALUES(10385,68,10,8,0.2);
INSERT INTO Order_Details2783 VALUES(10386,24,3.6,15,0);
INSERT INTO Order_Details2783 VALUES(10386,34,11.2,10,0);
INSERT INTO Order_Details2783 VALUES(10387,24,3.6,15,0);
INSERT INTO Order_Details2783 VALUES(10387,28,36.4,6,0);
INSERT INTO Order_Details2783 VALUES(10387,59,44,12,0);
INSERT INTO Order_Details2783 VALUES(10387,71,17.2,15,0);
INSERT INTO Order_Details2783 VALUES(10388,45,7.6,15,0.2);
INSERT INTO Order_Details2783 VALUES(10388,52,5.6,20,0.2);
INSERT INTO Order_Details2783 VALUES(10388,53,26.2,40,0);
INSERT INTO Order_Details2783 VALUES(10389,10,24.8,16,0);
INSERT INTO Order_Details2783 VALUES(10389,55,19.2,15,0);
INSERT INTO Order_Details2783 VALUES(10389,62,39.4,20,0);
INSERT INTO Order_Details2783 VALUES(10389,70,12,30,0);
INSERT INTO Order_Details2783 VALUES(10390,31,10,60,0.1);
INSERT INTO Order_Details2783 VALUES(10390,35,14.4,40,0.1);
INSERT INTO Order_Details2783 VALUES(10390,46,9.6,45,0);
INSERT INTO Order_Details2783 VALUES(10390,72,27.8,24,0.1);
INSERT INTO Order_Details2783 VALUES(10391,13,4.8,18,0);
INSERT INTO Order_Details2783 VALUES(10392,69,28.8,50,0);
INSERT INTO Order_Details2783 VALUES(10393,2,15.2,25,0.25);
INSERT INTO Order_Details2783 VALUES(10393,14,18.6,42,0.25);
INSERT INTO Order_Details2783 VALUES(10393,25,11.2,7,0.25);
INSERT INTO Order_Details2783 VALUES(10393,26,24.9,70,0.25);
INSERT INTO Order_Details2783 VALUES(10393,31,10,32,0);
INSERT INTO Order_Details2783 VALUES(10394,13,4.8,10,0);
INSERT INTO Order_Details2783 VALUES(10394,62,39.4,10,0);
INSERT INTO Order_Details2783 VALUES(10395,46,9.6,28,0.1);
INSERT INTO Order_Details2783 VALUES(10395,53,26.2,70,0.1);
INSERT INTO Order_Details2783 VALUES(10395,69,28.8,8,0);
INSERT INTO Order_Details2783 VALUES(10396,23,7.2,40,0);
INSERT INTO Order_Details2783 VALUES(10396,71,17.2,60,0);
INSERT INTO Order_Details2783 VALUES(10396,72,27.8,21,0);
INSERT INTO Order_Details2783 VALUES(10397,21,8,10,0.15);
INSERT INTO Order_Details2783 VALUES(10397,51,42.4,18,0.15);
INSERT INTO Order_Details2783 VALUES(10398,35,14.4,30,0);
INSERT INTO Order_Details2783 VALUES(10398,55,19.2,120,0.1);
INSERT INTO Order_Details2783 VALUES(10399,68,10,60,0);
INSERT INTO Order_Details2783 VALUES(10399,71,17.2,30,0);
INSERT INTO Order_Details2783 VALUES(10399,76,14.4,35,0);
INSERT INTO Order_Details2783 VALUES(10399,77,10.4,14,0);
INSERT INTO Order_Details2783 VALUES(10400,29,99,21,0);
INSERT INTO Order_Details2783 VALUES(10400,35,14.4,35,0);
INSERT INTO Order_Details2783 VALUES(10400,49,16,30,0);
INSERT INTO Order_Details2783 VALUES(10401,30,20.7,18,0);
INSERT INTO Order_Details2783 VALUES(10401,56,30.4,70,0);
INSERT INTO Order_Details2783 VALUES(10401,65,16.8,20,0);
INSERT INTO Order_Details2783 VALUES(10401,71,17.2,60,0);
INSERT INTO Order_Details2783 VALUES(10402,23,7.2,60,0);
INSERT INTO Order_Details2783 VALUES(10402,63,35.1,65,0);
INSERT INTO Order_Details2783 VALUES(10403,16,13.9,21,0.15);
INSERT INTO Order_Details2783 VALUES(10403,48,10.2,70,0.15);
INSERT INTO Order_Details2783 VALUES(10404,26,24.9,30,0.05);
INSERT INTO Order_Details2783 VALUES(10404,42,11.2,40,0.05);
INSERT INTO Order_Details2783 VALUES(10404,49,16,30,0.05);
INSERT INTO Order_Details2783 VALUES(10405,3,8,50,0);
INSERT INTO Order_Details2783 VALUES(10406,1,14.4,10,0);
INSERT INTO Order_Details2783 VALUES(10406,21,8,30,0.1);
INSERT INTO Order_Details2783 VALUES(10406,28,36.4,42,0.1);
INSERT INTO Order_Details2783 VALUES(10406,36,15.2,5,0.1);
INSERT INTO Order_Details2783 VALUES(10406,40,14.7,2,0.1);
INSERT INTO Order_Details2783 VALUES(10407,11,16.8,30,0);
INSERT INTO Order_Details2783 VALUES(10407,69,28.8,15,0);
INSERT INTO Order_Details2783 VALUES(10407,71,17.2,15,0);
INSERT INTO Order_Details2783 VALUES(10408,37,20.8,10,0);
INSERT INTO Order_Details2783 VALUES(10408,54,5.9,6,0);
INSERT INTO Order_Details2783 VALUES(10408,62,39.4,35,0);
INSERT INTO Order_Details2783 VALUES(10409,14,18.6,12,0);
INSERT INTO Order_Details2783 VALUES(10409,21,8,12,0);
INSERT INTO Order_Details2783 VALUES(10410,33,2,49,0);
INSERT INTO Order_Details2783 VALUES(10410,59,44,16,0);
INSERT INTO Order_Details2783 VALUES(10411,41,7.7,25,0.2);
INSERT INTO Order_Details2783 VALUES(10411,44,15.5,40,0.2);
INSERT INTO Order_Details2783 VALUES(10411,59,44,9,0.2);
INSERT INTO Order_Details2783 VALUES(10412,14,18.6,20,0.1);
INSERT INTO Order_Details2783 VALUES(10413,1,14.4,24,0);
INSERT INTO Order_Details2783 VALUES(10413,62,39.4,40,0);
INSERT INTO Order_Details2783 VALUES(10413,76,14.4,14,0);
INSERT INTO Order_Details2783 VALUES(10414,19,7.3,18,0.05);
INSERT INTO Order_Details2783 VALUES(10414,33,2,50,0);
INSERT INTO Order_Details2783 VALUES(10415,17,31.2,2,0);
INSERT INTO Order_Details2783 VALUES(10415,33,2,20,0);
INSERT INTO Order_Details2783 VALUES(10416,19,7.3,20,0);
INSERT INTO Order_Details2783 VALUES(10416,53,26.2,10,0);
INSERT INTO Order_Details2783 VALUES(10416,57,15.6,20,0);
INSERT INTO Order_Details2783 VALUES(10417,38,210.8,50,0);
INSERT INTO Order_Details2783 VALUES(10417,46,9.6,2,0.25);
INSERT INTO Order_Details2783 VALUES(10417,68,10,36,0.25);
INSERT INTO Order_Details2783 VALUES(10417,77,10.4,35,0);
INSERT INTO Order_Details2783 VALUES(10418,2,15.2,60,0);
INSERT INTO Order_Details2783 VALUES(10418,47,7.6,55,0);
INSERT INTO Order_Details2783 VALUES(10418,61,22.8,16,0);
INSERT INTO Order_Details2783 VALUES(10418,74,8,15,0);
INSERT INTO Order_Details2783 VALUES(10419,60,27.2,60,0.05);
INSERT INTO Order_Details2783 VALUES(10419,69,28.8,20,0.05);
INSERT INTO Order_Details2783 VALUES(10420,9,77.6,20,0.1);
INSERT INTO Order_Details2783 VALUES(10420,13,4.8,2,0.1);
INSERT INTO Order_Details2783 VALUES(10420,70,12,8,0.1);
INSERT INTO Order_Details2783 VALUES(10420,73,12,20,0.1);
INSERT INTO Order_Details2783 VALUES(10421,19,7.3,4,0.15);
INSERT INTO Order_Details2783 VALUES(10421,26,24.9,30,0);
INSERT INTO Order_Details2783 VALUES(10421,53,26.2,15,0.15);
INSERT INTO Order_Details2783 VALUES(10421,77,10.4,10,0.15);
INSERT INTO Order_Details2783 VALUES(10422,26,24.9,2,0);
INSERT INTO Order_Details2783 VALUES(10423,31,10,14,0);
INSERT INTO Order_Details2783 VALUES(10423,59,44,20,0);
INSERT INTO Order_Details2783 VALUES(10424,35,14.4,60,0.2);
INSERT INTO Order_Details2783 VALUES(10424,38,210.8,49,0.2);
INSERT INTO Order_Details2783 VALUES(10424,68,10,30,0.2);
INSERT INTO Order_Details2783 VALUES(10425,55,19.2,10,0.25);
INSERT INTO Order_Details2783 VALUES(10425,76,14.4,20,0.25);
INSERT INTO Order_Details2783 VALUES(10426,56,30.4,5,0);
INSERT INTO Order_Details2783 VALUES(10426,64,26.6,7,0);
INSERT INTO Order_Details2783 VALUES(10427,14,18.6,35,0);
INSERT INTO Order_Details2783 VALUES(10428,46,9.6,20,0);
INSERT INTO Order_Details2783 VALUES(10429,50,13,40,0);
INSERT INTO Order_Details2783 VALUES(10429,63,35.1,35,0.25);
INSERT INTO Order_Details2783 VALUES(10430,17,31.2,45,0.2);
INSERT INTO Order_Details2783 VALUES(10430,21,8,50,0);
INSERT INTO Order_Details2783 VALUES(10430,56,30.4,30,0);
INSERT INTO Order_Details2783 VALUES(10430,59,44,70,0.2);
INSERT INTO Order_Details2783 VALUES(10431,17,31.2,50,0.25);
INSERT INTO Order_Details2783 VALUES(10431,40,14.7,50,0.25);
INSERT INTO Order_Details2783 VALUES(10431,47,7.6,30,0.25);
INSERT INTO Order_Details2783 VALUES(10432,26,24.9,10,0);
INSERT INTO Order_Details2783 VALUES(10432,54,5.9,40,0);
INSERT INTO Order_Details2783 VALUES(10433,56,30.4,28,0);
INSERT INTO Order_Details2783 VALUES(10434,11,16.8,6,0);
INSERT INTO Order_Details2783 VALUES(10434,76,14.4,18,0.15);
INSERT INTO Order_Details2783 VALUES(10435,2,15.2,10,0);
INSERT INTO Order_Details2783 VALUES(10435,22,16.8,12,0);
INSERT INTO Order_Details2783 VALUES(10435,72,27.8,10,0);
INSERT INTO Order_Details2783 VALUES(10436,46,9.6,5,0);
INSERT INTO Order_Details2783 VALUES(10436,56,30.4,40,0.1);
INSERT INTO Order_Details2783 VALUES(10436,64,26.6,30,0.1);
INSERT INTO Order_Details2783 VALUES(10436,75,6.2,24,0.1);
INSERT INTO Order_Details2783 VALUES(10437,53,26.2,15,0);
INSERT INTO Order_Details2783 VALUES(10438,19,7.3,15,0.2);
INSERT INTO Order_Details2783 VALUES(10438,34,11.2,20,0.2);
INSERT INTO Order_Details2783 VALUES(10438,57,15.6,15,0.2);
INSERT INTO Order_Details2783 VALUES(10439,12,30.4,15,0);
INSERT INTO Order_Details2783 VALUES(10439,16,13.9,16,0);
INSERT INTO Order_Details2783 VALUES(10439,64,26.6,6,0);
INSERT INTO Order_Details2783 VALUES(10439,74,8,30,0);
INSERT INTO Order_Details2783 VALUES(10440,2,15.2,45,0.15);
INSERT INTO Order_Details2783 VALUES(10440,16,13.9,49,0.15);
INSERT INTO Order_Details2783 VALUES(10440,29,99,24,0.15);
INSERT INTO Order_Details2783 VALUES(10440,61,22.8,90,0.15);
INSERT INTO Order_Details2783 VALUES(10441,27,35.1,50,0);
INSERT INTO Order_Details2783 VALUES(10442,11,16.8,30,0);
INSERT INTO Order_Details2783 VALUES(10442,54,5.9,80,0);
INSERT INTO Order_Details2783 VALUES(10442,66,13.6,60,0);
INSERT INTO Order_Details2783 VALUES(10443,11,16.8,6,0.2);
INSERT INTO Order_Details2783 VALUES(10443,28,36.4,12,0);
INSERT INTO Order_Details2783 VALUES(10444,17,31.2,10,0);
INSERT INTO Order_Details2783 VALUES(10444,26,24.9,15,0);
INSERT INTO Order_Details2783 VALUES(10444,35,14.4,8,0);
INSERT INTO Order_Details2783 VALUES(10444,41,7.7,30,0);
INSERT INTO Order_Details2783 VALUES(10445,39,14.4,6,0);
INSERT INTO Order_Details2783 VALUES(10445,54,5.9,15,0);
INSERT INTO Order_Details2783 VALUES(10446,19,7.3,12,0.1);
INSERT INTO Order_Details2783 VALUES(10446,24,3.6,20,0.1);
INSERT INTO Order_Details2783 VALUES(10446,31,10,3,0.1);
INSERT INTO Order_Details2783 VALUES(10446,52,5.6,15,0.1);
INSERT INTO Order_Details2783 VALUES(10447,19,7.3,40,0);
INSERT INTO Order_Details2783 VALUES(10447,65,16.8,35,0);
INSERT INTO Order_Details2783 VALUES(10447,71,17.2,2,0);
INSERT INTO Order_Details2783 VALUES(10448,26,24.9,6,0);
INSERT INTO Order_Details2783 VALUES(10448,40,14.7,20,0);
INSERT INTO Order_Details2783 VALUES(10449,10,24.8,14,0);
INSERT INTO Order_Details2783 VALUES(10449,52,5.6,20,0);
INSERT INTO Order_Details2783 VALUES(10449,62,39.4,35,0);
INSERT INTO Order_Details2783 VALUES(10450,10,24.8,20,0.2);
INSERT INTO Order_Details2783 VALUES(10450,54,5.9,6,0.2);
INSERT INTO Order_Details2783 VALUES(10451,55,19.2,120,0.1);
INSERT INTO Order_Details2783 VALUES(10451,64,26.6,35,0.1);
INSERT INTO Order_Details2783 VALUES(10451,65,16.8,28,0.1);
INSERT INTO Order_Details2783 VALUES(10451,77,10.4,55,0.1);
INSERT INTO Order_Details2783 VALUES(10452,28,36.4,15,0);
INSERT INTO Order_Details2783 VALUES(10452,44,15.5,100,0.05);
INSERT INTO Order_Details2783 VALUES(10453,48,10.2,15,0.1);
INSERT INTO Order_Details2783 VALUES(10453,70,12,25,0.1);
INSERT INTO Order_Details2783 VALUES(10454,16,13.9,20,0.2);
INSERT INTO Order_Details2783 VALUES(10454,33,2,20,0.2);
INSERT INTO Order_Details2783 VALUES(10454,46,9.6,10,0.2);
INSERT INTO Order_Details2783 VALUES(10455,39,14.4,20,0);
INSERT INTO Order_Details2783 VALUES(10455,53,26.2,50,0);
INSERT INTO Order_Details2783 VALUES(10455,61,22.8,25,0);
INSERT INTO Order_Details2783 VALUES(10455,71,17.2,30,0);
INSERT INTO Order_Details2783 VALUES(10456,21,8,40,0.15);
INSERT INTO Order_Details2783 VALUES(10456,49,16,21,0.15);
INSERT INTO Order_Details2783 VALUES(10457,59,44,36,0);
INSERT INTO Order_Details2783 VALUES(10458,26,24.9,30,0);
INSERT INTO Order_Details2783 VALUES(10458,28,36.4,30,0);
INSERT INTO Order_Details2783 VALUES(10458,43,36.8,20,0);
INSERT INTO Order_Details2783 VALUES(10458,56,30.4,15,0);
INSERT INTO Order_Details2783 VALUES(10458,71,17.2,50,0);
INSERT INTO Order_Details2783 VALUES(10459,7,24,16,0.05);
INSERT INTO Order_Details2783 VALUES(10459,46,9.6,20,0.05);
INSERT INTO Order_Details2783 VALUES(10459,72,27.8,40,0);
INSERT INTO Order_Details2783 VALUES(10460,68,10,21,0.25);
INSERT INTO Order_Details2783 VALUES(10460,75,6.2,4,0.25);
INSERT INTO Order_Details2783 VALUES(10461,21,8,40,0.25);
INSERT INTO Order_Details2783 VALUES(10461,30,20.7,28,0.25);
INSERT INTO Order_Details2783 VALUES(10461,55,19.2,60,0.25);
INSERT INTO Order_Details2783 VALUES(10462,13,4.8,1,0);
INSERT INTO Order_Details2783 VALUES(10462,23,7.2,21,0);
INSERT INTO Order_Details2783 VALUES(10463,19,7.3,21,0);
INSERT INTO Order_Details2783 VALUES(10463,42,11.2,50,0);
INSERT INTO Order_Details2783 VALUES(10464,4,17.6,16,0.2);
INSERT INTO Order_Details2783 VALUES(10464,43,36.8,3,0);
INSERT INTO Order_Details2783 VALUES(10464,56,30.4,30,0.2);
INSERT INTO Order_Details2783 VALUES(10464,60,27.2,20,0);
INSERT INTO Order_Details2783 VALUES(10465,24,3.6,25,0);
INSERT INTO Order_Details2783 VALUES(10465,29,99,18,0.1);
INSERT INTO Order_Details2783 VALUES(10465,40,14.7,20,0);
INSERT INTO Order_Details2783 VALUES(10465,45,7.6,30,0.1);
INSERT INTO Order_Details2783 VALUES(10465,50,13,25,0);
INSERT INTO Order_Details2783 VALUES(10466,11,16.8,10,0);
INSERT INTO Order_Details2783 VALUES(10466,46,9.6,5,0);
INSERT INTO Order_Details2783 VALUES(10467,24,3.6,28,0);
INSERT INTO Order_Details2783 VALUES(10467,25,11.2,12,0);
INSERT INTO Order_Details2783 VALUES(10468,30,20.7,8,0);
INSERT INTO Order_Details2783 VALUES(10468,43,36.8,15,0);
INSERT INTO Order_Details2783 VALUES(10469,2,15.2,40,0.15);
INSERT INTO Order_Details2783 VALUES(10469,16,13.9,35,0.15);
INSERT INTO Order_Details2783 VALUES(10469,44,15.5,2,0.15);
INSERT INTO Order_Details2783 VALUES(10470,18,50,30,0);
INSERT INTO Order_Details2783 VALUES(10470,23,7.2,15,0);
INSERT INTO Order_Details2783 VALUES(10470,64,26.6,8,0);
INSERT INTO Order_Details2783 VALUES(10471,7,24,30,0);
INSERT INTO Order_Details2783 VALUES(10471,56,30.4,20,0);
INSERT INTO Order_Details2783 VALUES(10472,24,3.6,80,0.05);
INSERT INTO Order_Details2783 VALUES(10472,51,42.4,18,0);
INSERT INTO Order_Details2783 VALUES(10473,33,2,12,0);
INSERT INTO Order_Details2783 VALUES(10473,71,17.2,12,0);
INSERT INTO Order_Details2783 VALUES(10474,14,18.6,12,0);
INSERT INTO Order_Details2783 VALUES(10474,28,36.4,18,0);
INSERT INTO Order_Details2783 VALUES(10474,40,14.7,21,0);
INSERT INTO Order_Details2783 VALUES(10474,75,6.2,10,0);
INSERT INTO Order_Details2783 VALUES(10475,31,10,35,0.15);
INSERT INTO Order_Details2783 VALUES(10475,66,13.6,60,0.15);
INSERT INTO Order_Details2783 VALUES(10475,76,14.4,42,0.15);
INSERT INTO Order_Details2783 VALUES(10476,55,19.2,2,0.05);
INSERT INTO Order_Details2783 VALUES(10476,70,12,12,0);
INSERT INTO Order_Details2783 VALUES(10477,1,14.4,15,0);
INSERT INTO Order_Details2783 VALUES(10477,21,8,21,0.25);
INSERT INTO Order_Details2783 VALUES(10477,39,14.4,20,0.25);
INSERT INTO Order_Details2783 VALUES(10478,10,24.8,20,0.05);
INSERT INTO Order_Details2783 VALUES(10479,38,210.8,30,0);
INSERT INTO Order_Details2783 VALUES(10479,53,26.2,28,0);
INSERT INTO Order_Details2783 VALUES(10479,59,44,60,0);
INSERT INTO Order_Details2783 VALUES(10479,64,26.6,30,0);
INSERT INTO Order_Details2783 VALUES(10480,47,7.6,30,0);
INSERT INTO Order_Details2783 VALUES(10480,59,44,12,0);
INSERT INTO Order_Details2783 VALUES(10481,49,16,24,0);
INSERT INTO Order_Details2783 VALUES(10481,60,27.2,40,0);
INSERT INTO Order_Details2783 VALUES(10482,40,14.7,10,0);
INSERT INTO Order_Details2783 VALUES(10483,34,11.2,35,0.05);
INSERT INTO Order_Details2783 VALUES(10483,77,10.4,30,0.05);
INSERT INTO Order_Details2783 VALUES(10484,21,8,14,0);
INSERT INTO Order_Details2783 VALUES(10484,40,14.7,10,0);
INSERT INTO Order_Details2783 VALUES(10484,51,42.4,3,0);
INSERT INTO Order_Details2783 VALUES(10485,2,15.2,20,0.1);
INSERT INTO Order_Details2783 VALUES(10485,3,8,20,0.1);
INSERT INTO Order_Details2783 VALUES(10485,55,19.2,30,0.1);
INSERT INTO Order_Details2783 VALUES(10485,70,12,60,0.1);
INSERT INTO Order_Details2783 VALUES(10486,11,16.8,5,0);
INSERT INTO Order_Details2783 VALUES(10486,51,42.4,25,0);
INSERT INTO Order_Details2783 VALUES(10486,74,8,16,0);
INSERT INTO Order_Details2783 VALUES(10487,19,7.3,5,0);
INSERT INTO Order_Details2783 VALUES(10487,26,24.9,30,0);
INSERT INTO Order_Details2783 VALUES(10487,54,5.9,24,0.25);
INSERT INTO Order_Details2783 VALUES(10488,59,44,30,0);
INSERT INTO Order_Details2783 VALUES(10488,73,12,20,0.2);
INSERT INTO Order_Details2783 VALUES(10489,11,16.8,15,0.25);
INSERT INTO Order_Details2783 VALUES(10489,16,13.9,18,0);
INSERT INTO Order_Details2783 VALUES(10490,59,44,60,0);
INSERT INTO Order_Details2783 VALUES(10490,68,10,30,0);
INSERT INTO Order_Details2783 VALUES(10490,75,6.2,36,0);
INSERT INTO Order_Details2783 VALUES(10491,44,15.5,15,0.15);
INSERT INTO Order_Details2783 VALUES(10491,77,10.4,7,0.15);
INSERT INTO Order_Details2783 VALUES(10492,25,11.2,60,0.05);
INSERT INTO Order_Details2783 VALUES(10492,42,11.2,20,0.05);
INSERT INTO Order_Details2783 VALUES(10493,65,16.8,15,0.1);
INSERT INTO Order_Details2783 VALUES(10493,66,13.6,10,0.1);
INSERT INTO Order_Details2783 VALUES(10493,69,28.8,10,0.1);
INSERT INTO Order_Details2783 VALUES(10494,56,30.4,30,0);
INSERT INTO Order_Details2783 VALUES(10495,23,7.2,10,0);
INSERT INTO Order_Details2783 VALUES(10495,41,7.7,20,0);
INSERT INTO Order_Details2783 VALUES(10495,77,10.4,5,0);
INSERT INTO Order_Details2783 VALUES(10496,31,10,20,0.05);
INSERT INTO Order_Details2783 VALUES(10497,56,30.4,14,0);
INSERT INTO Order_Details2783 VALUES(10497,72,27.8,25,0);
INSERT INTO Order_Details2783 VALUES(10497,77,10.4,25,0);
INSERT INTO Order_Details2783 VALUES(10498,24,4.5,14,0);
INSERT INTO Order_Details2783 VALUES(10498,40,18.4,5,0);
INSERT INTO Order_Details2783 VALUES(10498,42,14,30,0);
INSERT INTO Order_Details2783 VALUES(10499,28,45.6,20,0);
INSERT INTO Order_Details2783 VALUES(10499,49,20,25,0);
INSERT INTO Order_Details2783 VALUES(10500,15,15.5,12,0.05);
INSERT INTO Order_Details2783 VALUES(10500,28,45.6,8,0.05);
INSERT INTO Order_Details2783 VALUES(10501,54,7.45,20,0);
INSERT INTO Order_Details2783 VALUES(10502,45,9.5,21,0);
INSERT INTO Order_Details2783 VALUES(10502,53,32.8,6,0);
INSERT INTO Order_Details2783 VALUES(10502,67,14,30,0);
INSERT INTO Order_Details2783 VALUES(10503,14,23.25,70,0);
INSERT INTO Order_Details2783 VALUES(10503,65,21.05,20,0);
INSERT INTO Order_Details2783 VALUES(10504,2,19,12,0);
INSERT INTO Order_Details2783 VALUES(10504,21,10,12,0);
INSERT INTO Order_Details2783 VALUES(10504,53,32.8,10,0);
INSERT INTO Order_Details2783 VALUES(10504,61,28.5,25,0);
INSERT INTO Order_Details2783 VALUES(10505,62,49.3,3,0);
INSERT INTO Order_Details2783 VALUES(10506,25,14,18,0.1);
INSERT INTO Order_Details2783 VALUES(10506,70,15,14,0.1);
INSERT INTO Order_Details2783 VALUES(10507,43,46,15,0.15);
INSERT INTO Order_Details2783 VALUES(10507,48,12.75,15,0.15);
INSERT INTO Order_Details2783 VALUES(10508,13,6,10,0);
INSERT INTO Order_Details2783 VALUES(10508,39,18,10,0);
INSERT INTO Order_Details2783 VALUES(10509,28,45.6,3,0);
INSERT INTO Order_Details2783 VALUES(10510,29,123.79,36,0);
INSERT INTO Order_Details2783 VALUES(10510,75,7.75,36,0.1);
INSERT INTO Order_Details2783 VALUES(10511,4,22,50,0.15);
INSERT INTO Order_Details2783 VALUES(10511,7,30,50,0.15);
INSERT INTO Order_Details2783 VALUES(10511,8,40,10,0.15);
INSERT INTO Order_Details2783 VALUES(10512,24,4.5,10,0.15);
INSERT INTO Order_Details2783 VALUES(10512,46,12,9,0.15);
INSERT INTO Order_Details2783 VALUES(10512,47,9.5,6,0.15);
INSERT INTO Order_Details2783 VALUES(10512,60,34,12,0.15);
INSERT INTO Order_Details2783 VALUES(10513,21,10,40,0.2);
INSERT INTO Order_Details2783 VALUES(10513,32,32,50,0.2);
INSERT INTO Order_Details2783 VALUES(10513,61,28.5,15,0.2);
INSERT INTO Order_Details2783 VALUES(10514,20,81,39,0);
INSERT INTO Order_Details2783 VALUES(10514,28,45.6,35,0);
INSERT INTO Order_Details2783 VALUES(10514,56,38,70,0);
INSERT INTO Order_Details2783 VALUES(10514,65,21.05,39,0);
INSERT INTO Order_Details2783 VALUES(10514,75,7.75,50,0);
INSERT INTO Order_Details2783 VALUES(10515,9,97,16,0.15);
INSERT INTO Order_Details2783 VALUES(10515,16,17.45,50,0);
INSERT INTO Order_Details2783 VALUES(10515,27,43.9,120,0);
INSERT INTO Order_Details2783 VALUES(10515,33,2.5,16,0.15);
INSERT INTO Order_Details2783 VALUES(10515,60,34,84,0.15);
INSERT INTO Order_Details2783 VALUES(10516,18,62.5,25,0.1);
INSERT INTO Order_Details2783 VALUES(10516,41,9.65,80,0.1);
INSERT INTO Order_Details2783 VALUES(10516,42,14,20,0);
INSERT INTO Order_Details2783 VALUES(10517,52,7,6,0);
INSERT INTO Order_Details2783 VALUES(10517,59,55,4,0);
INSERT INTO Order_Details2783 VALUES(10517,70,15,6,0);
INSERT INTO Order_Details2783 VALUES(10518,24,4.5,5,0);
INSERT INTO Order_Details2783 VALUES(10518,38,263.5,15,0);
INSERT INTO Order_Details2783 VALUES(10518,44,19.45,9,0);
INSERT INTO Order_Details2783 VALUES(10519,10,31,16,0.05);
INSERT INTO Order_Details2783 VALUES(10519,56,38,40,0);
INSERT INTO Order_Details2783 VALUES(10519,60,34,10,0.05);
INSERT INTO Order_Details2783 VALUES(10520,24,4.5,8,0);
INSERT INTO Order_Details2783 VALUES(10520,53,32.8,5,0);
INSERT INTO Order_Details2783 VALUES(10521,35,18,3,0);
INSERT INTO Order_Details2783 VALUES(10521,41,9.65,10,0);
INSERT INTO Order_Details2783 VALUES(10521,68,12.5,6,0);
INSERT INTO Order_Details2783 VALUES(10522,1,18,40,0.2);
INSERT INTO Order_Details2783 VALUES(10522,8,40,24,0);
INSERT INTO Order_Details2783 VALUES(10522,30,25.89,20,0.2);
INSERT INTO Order_Details2783 VALUES(10522,40,18.4,25,0.2);
INSERT INTO Order_Details2783 VALUES(10523,17,39,25,0.1);
INSERT INTO Order_Details2783 VALUES(10523,20,81,15,0.1);
INSERT INTO Order_Details2783 VALUES(10523,37,26,18,0.1);
INSERT INTO Order_Details2783 VALUES(10523,41,9.65,6,0.1);
INSERT INTO Order_Details2783 VALUES(10524,10,31,2,0);
INSERT INTO Order_Details2783 VALUES(10524,30,25.89,10,0);
INSERT INTO Order_Details2783 VALUES(10524,43,46,60,0);
INSERT INTO Order_Details2783 VALUES(10524,54,7.45,15,0);
INSERT INTO Order_Details2783 VALUES(10525,36,19,30,0);
INSERT INTO Order_Details2783 VALUES(10525,40,18.4,15,0.1);
INSERT INTO Order_Details2783 VALUES(10526,1,18,8,0.15);
INSERT INTO Order_Details2783 VALUES(10526,13,6,10,0);
INSERT INTO Order_Details2783 VALUES(10526,56,38,30,0.15);
INSERT INTO Order_Details2783 VALUES(10527,4,22,50,0.1);
INSERT INTO Order_Details2783 VALUES(10527,36,19,30,0.1);
INSERT INTO Order_Details2783 VALUES(10528,11,21,3,0);
INSERT INTO Order_Details2783 VALUES(10528,33,2.5,8,0.2);
INSERT INTO Order_Details2783 VALUES(10528,72,34.8,9,0);
INSERT INTO Order_Details2783 VALUES(10529,55,24,14,0);
INSERT INTO Order_Details2783 VALUES(10529,68,12.5,20,0);
INSERT INTO Order_Details2783 VALUES(10529,69,36,10,0);
INSERT INTO Order_Details2783 VALUES(10530,17,39,40,0);
INSERT INTO Order_Details2783 VALUES(10530,43,46,25,0);
INSERT INTO Order_Details2783 VALUES(10530,61,28.5,20,0);
INSERT INTO Order_Details2783 VALUES(10530,76,18,50,0);
INSERT INTO Order_Details2783 VALUES(10531,59,55,2,0);
INSERT INTO Order_Details2783 VALUES(10532,30,25.89,15,0);
INSERT INTO Order_Details2783 VALUES(10532,66,17,24,0);
INSERT INTO Order_Details2783 VALUES(10533,4,22,50,0.05);
INSERT INTO Order_Details2783 VALUES(10533,72,34.8,24,0);
INSERT INTO Order_Details2783 VALUES(10533,73,15,24,0.05);
INSERT INTO Order_Details2783 VALUES(10534,30,25.89,10,0);
INSERT INTO Order_Details2783 VALUES(10534,40,18.4,10,0.2);
INSERT INTO Order_Details2783 VALUES(10534,54,7.45,10,0.2);
INSERT INTO Order_Details2783 VALUES(10535,11,21,50,0.1);
INSERT INTO Order_Details2783 VALUES(10535,40,18.4,10,0.1);
INSERT INTO Order_Details2783 VALUES(10535,57,19.5,5,0.1);
INSERT INTO Order_Details2783 VALUES(10535,59,55,15,0.1);
INSERT INTO Order_Details2783 VALUES(10536,12,38,15,0.25);
INSERT INTO Order_Details2783 VALUES(10536,31,12.5,20,0);
INSERT INTO Order_Details2783 VALUES(10536,33,2.5,30,0);
INSERT INTO Order_Details2783 VALUES(10536,60,34,35,0.25);
INSERT INTO Order_Details2783 VALUES(10537,31,12.5,30,0);
INSERT INTO Order_Details2783 VALUES(10537,51,53,6,0);
INSERT INTO Order_Details2783 VALUES(10537,58,13.25,20,0);
INSERT INTO Order_Details2783 VALUES(10537,72,34.8,21,0);
INSERT INTO Order_Details2783 VALUES(10537,73,15,9,0);
INSERT INTO Order_Details2783 VALUES(10538,70,15,7,0);
INSERT INTO Order_Details2783 VALUES(10538,72,34.8,1,0);
INSERT INTO Order_Details2783 VALUES(10539,13,6,8,0);
INSERT INTO Order_Details2783 VALUES(10539,21,10,15,0);
INSERT INTO Order_Details2783 VALUES(10539,33,2.5,15,0);
INSERT INTO Order_Details2783 VALUES(10539,49,20,6,0);
INSERT INTO Order_Details2783 VALUES(10540,3,10,60,0);
INSERT INTO Order_Details2783 VALUES(10540,26,31.23,40,0);
INSERT INTO Order_Details2783 VALUES(10540,38,263.5,30,0);
INSERT INTO Order_Details2783 VALUES(10540,68,12.5,35,0);
INSERT INTO Order_Details2783 VALUES(10541,24,4.5,35,0.1);
INSERT INTO Order_Details2783 VALUES(10541,38,263.5,4,0.1);
INSERT INTO Order_Details2783 VALUES(10541,65,21.05,36,0.1);
INSERT INTO Order_Details2783 VALUES(10541,71,21.5,9,0.1);
INSERT INTO Order_Details2783 VALUES(10542,11,21,15,0.05);
INSERT INTO Order_Details2783 VALUES(10542,54,7.45,24,0.05);
INSERT INTO Order_Details2783 VALUES(10543,12,38,30,0.15);
INSERT INTO Order_Details2783 VALUES(10543,23,9,70,0.15);
INSERT INTO Order_Details2783 VALUES(10544,28,45.6,7,0);
INSERT INTO Order_Details2783 VALUES(10544,67,14,7,0);
INSERT INTO Order_Details2783 VALUES(10545,11,21,10,0);
INSERT INTO Order_Details2783 VALUES(10546,7,30,10,0);
INSERT INTO Order_Details2783 VALUES(10546,35,18,30,0);
INSERT INTO Order_Details2783 VALUES(10546,62,49.3,40,0);
INSERT INTO Order_Details2783 VALUES(10547,32,32,24,0.15);
INSERT INTO Order_Details2783 VALUES(10547,36,19,60,0);
INSERT INTO Order_Details2783 VALUES(10548,34,14,10,0.25);
INSERT INTO Order_Details2783 VALUES(10548,41,9.65,14,0);
INSERT INTO Order_Details2783 VALUES(10549,31,12.5,55,0.15);
INSERT INTO Order_Details2783 VALUES(10549,45,9.5,100,0.15);
INSERT INTO Order_Details2783 VALUES(10549,51,53,48,0.15);
INSERT INTO Order_Details2783 VALUES(10550,17,39,8,0.1);
INSERT INTO Order_Details2783 VALUES(10550,19,9.2,10,0);
INSERT INTO Order_Details2783 VALUES(10550,21,10,6,0.1);
INSERT INTO Order_Details2783 VALUES(10550,61,28.5,10,0.1);
INSERT INTO Order_Details2783 VALUES(10551,16,17.45,40,0.15);
INSERT INTO Order_Details2783 VALUES(10551,35,18,20,0.15);
INSERT INTO Order_Details2783 VALUES(10551,44,19.45,40,0);
INSERT INTO Order_Details2783 VALUES(10552,69,36,18,0);
INSERT INTO Order_Details2783 VALUES(10552,75,7.75,30,0);
INSERT INTO Order_Details2783 VALUES(10553,11,21,15,0);
INSERT INTO Order_Details2783 VALUES(10553,16,17.45,14,0);
INSERT INTO Order_Details2783 VALUES(10553,22,21,24,0);
INSERT INTO Order_Details2783 VALUES(10553,31,12.5,30,0);
INSERT INTO Order_Details2783 VALUES(10553,35,18,6,0);
INSERT INTO Order_Details2783 VALUES(10554,16,17.45,30,0.05);
INSERT INTO Order_Details2783 VALUES(10554,23,9,20,0.05);
INSERT INTO Order_Details2783 VALUES(10554,62,49.3,20,0.05);
INSERT INTO Order_Details2783 VALUES(10554,77,13,10,0.05);
INSERT INTO Order_Details2783 VALUES(10555,14,23.25,30,0.2);
INSERT INTO Order_Details2783 VALUES(10555,19,9.2,35,0.2);
INSERT INTO Order_Details2783 VALUES(10555,24,4.5,18,0.2);
INSERT INTO Order_Details2783 VALUES(10555,51,53,20,0.2);
INSERT INTO Order_Details2783 VALUES(10555,56,38,40,0.2);
INSERT INTO Order_Details2783 VALUES(10556,72,34.8,24,0);
INSERT INTO Order_Details2783 VALUES(10557,64,33.25,30,0);
INSERT INTO Order_Details2783 VALUES(10557,75,7.75,20,0);
INSERT INTO Order_Details2783 VALUES(10558,47,9.5,25,0);
INSERT INTO Order_Details2783 VALUES(10558,51,53,20,0);
INSERT INTO Order_Details2783 VALUES(10558,52,7,30,0);
INSERT INTO Order_Details2783 VALUES(10558,53,32.8,18,0);
INSERT INTO Order_Details2783 VALUES(10558,73,15,3,0);
INSERT INTO Order_Details2783 VALUES(10559,41,9.65,12,0.05);
INSERT INTO Order_Details2783 VALUES(10559,55,24,18,0.05);
INSERT INTO Order_Details2783 VALUES(10560,30,25.89,20,0);
INSERT INTO Order_Details2783 VALUES(10560,62,49.3,15,0.25);
INSERT INTO Order_Details2783 VALUES(10561,44,19.45,10,0);
INSERT INTO Order_Details2783 VALUES(10561,51,53,50,0);
INSERT INTO Order_Details2783 VALUES(10562,33,2.5,20,0.1);
INSERT INTO Order_Details2783 VALUES(10562,62,49.3,10,0.1);
INSERT INTO Order_Details2783 VALUES(10563,36,19,25,0);
INSERT INTO Order_Details2783 VALUES(10563,52,7,70,0);
INSERT INTO Order_Details2783 VALUES(10564,17,39,16,0.05);
INSERT INTO Order_Details2783 VALUES(10564,31,12.5,6,0.05);
INSERT INTO Order_Details2783 VALUES(10564,55,24,25,0.05);
INSERT INTO Order_Details2783 VALUES(10565,24,4.5,25,0.1);
INSERT INTO Order_Details2783 VALUES(10565,64,33.25,18,0.1);
INSERT INTO Order_Details2783 VALUES(10566,11,21,35,0.15);
INSERT INTO Order_Details2783 VALUES(10566,18,62.5,18,0.15);
INSERT INTO Order_Details2783 VALUES(10566,76,18,10,0);
INSERT INTO Order_Details2783 VALUES(10567,31,12.5,60,0.2);
INSERT INTO Order_Details2783 VALUES(10567,51,53,3,0);
INSERT INTO Order_Details2783 VALUES(10567,59,55,40,0.2);
INSERT INTO Order_Details2783 VALUES(10568,10,31,5,0);
INSERT INTO Order_Details2783 VALUES(10569,31,12.5,35,0.2);
INSERT INTO Order_Details2783 VALUES(10569,76,18,30,0);
INSERT INTO Order_Details2783 VALUES(10570,11,21,15,0.05);
INSERT INTO Order_Details2783 VALUES(10570,56,38,60,0.05);
INSERT INTO Order_Details2783 VALUES(10571,14,23.25,11,0.15);
INSERT INTO Order_Details2783 VALUES(10571,42,14,28,0.15);
INSERT INTO Order_Details2783 VALUES(10572,16,17.45,12,0.1);
INSERT INTO Order_Details2783 VALUES(10572,32,32,10,0.1);
INSERT INTO Order_Details2783 VALUES(10572,40,18.4,50,0);
INSERT INTO Order_Details2783 VALUES(10572,75,7.75,15,0.1);
INSERT INTO Order_Details2783 VALUES(10573,17,39,18,0);
INSERT INTO Order_Details2783 VALUES(10573,34,14,40,0);
INSERT INTO Order_Details2783 VALUES(10573,53,32.8,25,0);
INSERT INTO Order_Details2783 VALUES(10574,33,2.5,14,0);
INSERT INTO Order_Details2783 VALUES(10574,40,18.4,2,0);
INSERT INTO Order_Details2783 VALUES(10574,62,49.3,10,0);
INSERT INTO Order_Details2783 VALUES(10574,64,33.25,6,0);
INSERT INTO Order_Details2783 VALUES(10575,59,55,12,0);
INSERT INTO Order_Details2783 VALUES(10575,63,43.9,6,0);
INSERT INTO Order_Details2783 VALUES(10575,72,34.8,30,0);
INSERT INTO Order_Details2783 VALUES(10575,76,18,10,0);
INSERT INTO Order_Details2783 VALUES(10576,1,18,10,0);
INSERT INTO Order_Details2783 VALUES(10576,31,12.5,20,0);
INSERT INTO Order_Details2783 VALUES(10576,44,19.45,21,0);
INSERT INTO Order_Details2783 VALUES(10577,39,18,10,0);
INSERT INTO Order_Details2783 VALUES(10577,75,7.75,20,0);
INSERT INTO Order_Details2783 VALUES(10577,77,13,18,0);
INSERT INTO Order_Details2783 VALUES(10578,35,18,20,0);
INSERT INTO Order_Details2783 VALUES(10578,57,19.5,6,0);
INSERT INTO Order_Details2783 VALUES(10579,15,15.5,10,0);
INSERT INTO Order_Details2783 VALUES(10579,75,7.75,21,0);
INSERT INTO Order_Details2783 VALUES(10580,14,23.25,15,0.05);
INSERT INTO Order_Details2783 VALUES(10580,41,9.65,9,0.05);
INSERT INTO Order_Details2783 VALUES(10580,65,21.05,30,0.05);
INSERT INTO Order_Details2783 VALUES(10581,75,7.75,50,0.2);
INSERT INTO Order_Details2783 VALUES(10582,57,19.5,4,0);
INSERT INTO Order_Details2783 VALUES(10582,76,18,14,0);
INSERT INTO Order_Details2783 VALUES(10583,29,123.79,10,0);
INSERT INTO Order_Details2783 VALUES(10583,60,34,24,0.15);
INSERT INTO Order_Details2783 VALUES(10583,69,36,10,0.15);
INSERT INTO Order_Details2783 VALUES(10584,31,12.5,50,0.05);
INSERT INTO Order_Details2783 VALUES(10585,47,9.5,15,0);
INSERT INTO Order_Details2783 VALUES(10586,52,7,4,0.15);
INSERT INTO Order_Details2783 VALUES(10587,26,31.23,6,0);
INSERT INTO Order_Details2783 VALUES(10587,35,18,20,0);
INSERT INTO Order_Details2783 VALUES(10587,77,13,20,0);
INSERT INTO Order_Details2783 VALUES(10588,18,62.5,40,0.2);
INSERT INTO Order_Details2783 VALUES(10588,42,14,100,0.2);
INSERT INTO Order_Details2783 VALUES(10589,35,18,4,0);
INSERT INTO Order_Details2783 VALUES(10590,1,18,20,0);
INSERT INTO Order_Details2783 VALUES(10590,77,13,60,0.05);
INSERT INTO Order_Details2783 VALUES(10591,3,10,14,0);
INSERT INTO Order_Details2783 VALUES(10591,7,30,10,0);
INSERT INTO Order_Details2783 VALUES(10591,54,7.45,50,0);
INSERT INTO Order_Details2783 VALUES(10592,15,15.5,25,0.05);
INSERT INTO Order_Details2783 VALUES(10592,26,31.23,5,0.05);
INSERT INTO Order_Details2783 VALUES(10593,20,81,21,0.2);
INSERT INTO Order_Details2783 VALUES(10593,69,36,20,0.2);
INSERT INTO Order_Details2783 VALUES(10593,76,18,4,0.2);
INSERT INTO Order_Details2783 VALUES(10594,52,7,24,0);
INSERT INTO Order_Details2783 VALUES(10594,58,13.25,30,0);
INSERT INTO Order_Details2783 VALUES(10595,35,18,30,0.25);
INSERT INTO Order_Details2783 VALUES(10595,61,28.5,120,0.25);
INSERT INTO Order_Details2783 VALUES(10595,69,36,65,0.25);
INSERT INTO Order_Details2783 VALUES(10596,56,38,5,0.2);
INSERT INTO Order_Details2783 VALUES(10596,63,43.9,24,0.2);
INSERT INTO Order_Details2783 VALUES(10596,75,7.75,30,0.2);
INSERT INTO Order_Details2783 VALUES(10597,24,4.5,35,0.2);
INSERT INTO Order_Details2783 VALUES(10597,57,19.5,20,0);
INSERT INTO Order_Details2783 VALUES(10597,65,21.05,12,0.2);
INSERT INTO Order_Details2783 VALUES(10598,27,43.9,50,0);
INSERT INTO Order_Details2783 VALUES(10598,71,21.5,9,0);
INSERT INTO Order_Details2783 VALUES(10599,62,49.3,10,0);
INSERT INTO Order_Details2783 VALUES(10600,54,7.45,4,0);
INSERT INTO Order_Details2783 VALUES(10600,73,15,30,0);
INSERT INTO Order_Details2783 VALUES(10601,13,6,60,0);
INSERT INTO Order_Details2783 VALUES(10601,59,55,35,0);
INSERT INTO Order_Details2783 VALUES(10602,77,13,5,0.25);
INSERT INTO Order_Details2783 VALUES(10603,22,21,48,0);
INSERT INTO Order_Details2783 VALUES(10603,49,20,25,0.05);
INSERT INTO Order_Details2783 VALUES(10604,48,12.75,6,0.1);
INSERT INTO Order_Details2783 VALUES(10604,76,18,10,0.1);
INSERT INTO Order_Details2783 VALUES(10605,16,17.45,30,0.05);
INSERT INTO Order_Details2783 VALUES(10605,59,55,20,0.05);
INSERT INTO Order_Details2783 VALUES(10605,60,34,70,0.05);
INSERT INTO Order_Details2783 VALUES(10605,71,21.5,15,0.05);
INSERT INTO Order_Details2783 VALUES(10606,4,22,20,0.2);
INSERT INTO Order_Details2783 VALUES(10606,55,24,20,0.2);
INSERT INTO Order_Details2783 VALUES(10606,62,49.3,10,0.2);
INSERT INTO Order_Details2783 VALUES(10607,7,30,45,0);
INSERT INTO Order_Details2783 VALUES(10607,17,39,100,0);
INSERT INTO Order_Details2783 VALUES(10607,33,2.5,14,0);
INSERT INTO Order_Details2783 VALUES(10607,40,18.4,42,0);
INSERT INTO Order_Details2783 VALUES(10607,72,34.8,12,0);
INSERT INTO Order_Details2783 VALUES(10608,56,38,28,0);
INSERT INTO Order_Details2783 VALUES(10609,1,18,3,0);
INSERT INTO Order_Details2783 VALUES(10609,10,31,10,0);
INSERT INTO Order_Details2783 VALUES(10609,21,10,6,0);
INSERT INTO Order_Details2783 VALUES(10610,36,19,21,0.25);
INSERT INTO Order_Details2783 VALUES(10611,1,18,6,0);
INSERT INTO Order_Details2783 VALUES(10611,2,19,10,0);
INSERT INTO Order_Details2783 VALUES(10611,60,34,15,0);
INSERT INTO Order_Details2783 VALUES(10612,10,31,70,0);
INSERT INTO Order_Details2783 VALUES(10612,36,19,55,0);
INSERT INTO Order_Details2783 VALUES(10612,49,20,18,0);
INSERT INTO Order_Details2783 VALUES(10612,60,34,40,0);
INSERT INTO Order_Details2783 VALUES(10612,76,18,80,0);
INSERT INTO Order_Details2783 VALUES(10613,13,6,8,0.1);
INSERT INTO Order_Details2783 VALUES(10613,75,7.75,40,0);
INSERT INTO Order_Details2783 VALUES(10614,11,21,14,0);
INSERT INTO Order_Details2783 VALUES(10614,21,10,8,0);
INSERT INTO Order_Details2783 VALUES(10614,39,18,5,0);
INSERT INTO Order_Details2783 VALUES(10615,55,24,5,0);
INSERT INTO Order_Details2783 VALUES(10616,38,263.5,15,0.05);
INSERT INTO Order_Details2783 VALUES(10616,56,38,14,0);
INSERT INTO Order_Details2783 VALUES(10616,70,15,15,0.05);
INSERT INTO Order_Details2783 VALUES(10616,71,21.5,15,0.05);
INSERT INTO Order_Details2783 VALUES(10617,59,55,30,0.15);
INSERT INTO Order_Details2783 VALUES(10618,6,25,70,0);
INSERT INTO Order_Details2783 VALUES(10618,56,38,20,0);
INSERT INTO Order_Details2783 VALUES(10618,68,12.5,15,0);
INSERT INTO Order_Details2783 VALUES(10619,21,10,42,0);
INSERT INTO Order_Details2783 VALUES(10619,22,21,40,0);
INSERT INTO Order_Details2783 VALUES(10620,24,4.5,5,0);
INSERT INTO Order_Details2783 VALUES(10620,52,7,5,0);
INSERT INTO Order_Details2783 VALUES(10621,19,9.2,5,0);
INSERT INTO Order_Details2783 VALUES(10621,23,9,10,0);
INSERT INTO Order_Details2783 VALUES(10621,70,15,20,0);
INSERT INTO Order_Details2783 VALUES(10621,71,21.5,15,0);
INSERT INTO Order_Details2783 VALUES(10622,2,19,20,0);
INSERT INTO Order_Details2783 VALUES(10622,68,12.5,18,0.2);
INSERT INTO Order_Details2783 VALUES(10623,14,23.25,21,0);
INSERT INTO Order_Details2783 VALUES(10623,19,9.2,15,0.1);
INSERT INTO Order_Details2783 VALUES(10623,21,10,25,0.1);
INSERT INTO Order_Details2783 VALUES(10623,24,4.5,3,0);
INSERT INTO Order_Details2783 VALUES(10623,35,18,30,0.1);
INSERT INTO Order_Details2783 VALUES(10624,28,45.6,10,0);
INSERT INTO Order_Details2783 VALUES(10624,29,123.79,6,0);
INSERT INTO Order_Details2783 VALUES(10624,44,19.45,10,0);
INSERT INTO Order_Details2783 VALUES(10625,14,23.25,3,0);
INSERT INTO Order_Details2783 VALUES(10625,42,14,5,0);
INSERT INTO Order_Details2783 VALUES(10625,60,34,10,0);
INSERT INTO Order_Details2783 VALUES(10626,53,32.8,12,0);
INSERT INTO Order_Details2783 VALUES(10626,60,34,20,0);
INSERT INTO Order_Details2783 VALUES(10626,71,21.5,20,0);
INSERT INTO Order_Details2783 VALUES(10627,62,49.3,15,0);
INSERT INTO Order_Details2783 VALUES(10627,73,15,35,0.15);
INSERT INTO Order_Details2783 VALUES(10628,1,18,25,0);
INSERT INTO Order_Details2783 VALUES(10629,29,123.79,20,0);
INSERT INTO Order_Details2783 VALUES(10629,64,33.25,9,0);
INSERT INTO Order_Details2783 VALUES(10630,55,24,12,0.05);
INSERT INTO Order_Details2783 VALUES(10630,76,18,35,0);
INSERT INTO Order_Details2783 VALUES(10631,75,7.75,8,0.1);
INSERT INTO Order_Details2783 VALUES(10632,2,19,30,0.05);
INSERT INTO Order_Details2783 VALUES(10632,33,2.5,20,0.05);
INSERT INTO Order_Details2783 VALUES(10633,12,38,36,0.15);
INSERT INTO Order_Details2783 VALUES(10633,13,6,13,0.15);
INSERT INTO Order_Details2783 VALUES(10633,26,31.23,35,0.15);
INSERT INTO Order_Details2783 VALUES(10633,62,49.3,80,0.15);
INSERT INTO Order_Details2783 VALUES(10634,7,30,35,0);
INSERT INTO Order_Details2783 VALUES(10634,18,62.5,50,0);
INSERT INTO Order_Details2783 VALUES(10634,51,53,15,0);
INSERT INTO Order_Details2783 VALUES(10634,75,7.75,2,0);
INSERT INTO Order_Details2783 VALUES(10635,4,22,10,0.1);
INSERT INTO Order_Details2783 VALUES(10635,5,21.35,15,0.1);
INSERT INTO Order_Details2783 VALUES(10635,22,21,40,0);
INSERT INTO Order_Details2783 VALUES(10636,4,22,25,0);
INSERT INTO Order_Details2783 VALUES(10636,58,13.25,6,0);
INSERT INTO Order_Details2783 VALUES(10637,11,21,10,0);
INSERT INTO Order_Details2783 VALUES(10637,50,16.25,25,0.05);
INSERT INTO Order_Details2783 VALUES(10637,56,38,60,0.05);
INSERT INTO Order_Details2783 VALUES(10638,45,9.5,20,0);
INSERT INTO Order_Details2783 VALUES(10638,65,21.05,21,0);
INSERT INTO Order_Details2783 VALUES(10638,72,34.8,60,0);
INSERT INTO Order_Details2783 VALUES(10639,18,62.5,8,0);
INSERT INTO Order_Details2783 VALUES(10640,69,36,20,0.25);
INSERT INTO Order_Details2783 VALUES(10640,70,15,15,0.25);
INSERT INTO Order_Details2783 VALUES(10641,2,19,50,0);
INSERT INTO Order_Details2783 VALUES(10641,40,18.4,60,0);
INSERT INTO Order_Details2783 VALUES(10642,21,10,30,0.2);
INSERT INTO Order_Details2783 VALUES(10642,61,28.5,20,0.2);
INSERT INTO Order_Details2783 VALUES(10643,28,45.6,15,0.25);
INSERT INTO Order_Details2783 VALUES(10643,39,18,21,0.25);
INSERT INTO Order_Details2783 VALUES(10643,46,12,2,0.25);
INSERT INTO Order_Details2783 VALUES(10644,18,62.5,4,0.1);
INSERT INTO Order_Details2783 VALUES(10644,43,46,20,0);
INSERT INTO Order_Details2783 VALUES(10644,46,12,21,0.1);
INSERT INTO Order_Details2783 VALUES(10645,18,62.5,20,0);
INSERT INTO Order_Details2783 VALUES(10645,36,19,15,0);
INSERT INTO Order_Details2783 VALUES(10646,1,18,15,0.25);
INSERT INTO Order_Details2783 VALUES(10646,10,31,18,0.25);
INSERT INTO Order_Details2783 VALUES(10646,71,21.5,30,0.25);
INSERT INTO Order_Details2783 VALUES(10646,77,13,35,0.25);
INSERT INTO Order_Details2783 VALUES(10647,19,9.2,30,0);
INSERT INTO Order_Details2783 VALUES(10647,39,18,20,0);
INSERT INTO Order_Details2783 VALUES(10648,22,21,15,0);
INSERT INTO Order_Details2783 VALUES(10648,24,4.5,15,0.15);
INSERT INTO Order_Details2783 VALUES(10649,28,45.6,20,0);
INSERT INTO Order_Details2783 VALUES(10649,72,34.8,15,0);
INSERT INTO Order_Details2783 VALUES(10650,30,25.89,30,0);
INSERT INTO Order_Details2783 VALUES(10650,53,32.8,25,0.05);
INSERT INTO Order_Details2783 VALUES(10650,54,7.45,30,0);
INSERT INTO Order_Details2783 VALUES(10651,19,9.2,12,0.25);
INSERT INTO Order_Details2783 VALUES(10651,22,21,20,0.25);
INSERT INTO Order_Details2783 VALUES(10652,30,25.89,2,0.25);
INSERT INTO Order_Details2783 VALUES(10652,42,14,20,0);
INSERT INTO Order_Details2783 VALUES(10653,16,17.45,30,0.1);
INSERT INTO Order_Details2783 VALUES(10653,60,34,20,0.1);
INSERT INTO Order_Details2783 VALUES(10654,4,22,12,0.1);
INSERT INTO Order_Details2783 VALUES(10654,39,18,20,0.1);
INSERT INTO Order_Details2783 VALUES(10654,54,7.45,6,0.1);
INSERT INTO Order_Details2783 VALUES(10655,41,9.65,20,0.2);
INSERT INTO Order_Details2783 VALUES(10656,14,23.25,3,0.1);
INSERT INTO Order_Details2783 VALUES(10656,44,19.45,28,0.1);
INSERT INTO Order_Details2783 VALUES(10656,47,9.5,6,0.1);
INSERT INTO Order_Details2783 VALUES(10657,15,15.5,50,0);
INSERT INTO Order_Details2783 VALUES(10657,41,9.65,24,0);
INSERT INTO Order_Details2783 VALUES(10657,46,12,45,0);
INSERT INTO Order_Details2783 VALUES(10657,47,9.5,10,0);
INSERT INTO Order_Details2783 VALUES(10657,56,38,45,0);
INSERT INTO Order_Details2783 VALUES(10657,60,34,30,0);
INSERT INTO Order_Details2783 VALUES(10658,21,10,60,0);
INSERT INTO Order_Details2783 VALUES(10658,40,18.4,70,0.05);
INSERT INTO Order_Details2783 VALUES(10658,60,34,55,0.05);
INSERT INTO Order_Details2783 VALUES(10658,77,13,70,0.05);
INSERT INTO Order_Details2783 VALUES(10659,31,12.5,20,0.05);
INSERT INTO Order_Details2783 VALUES(10659,40,18.4,24,0.05);
INSERT INTO Order_Details2783 VALUES(10659,70,15,40,0.05);
INSERT INTO Order_Details2783 VALUES(10660,20,81,21,0);
INSERT INTO Order_Details2783 VALUES(10661,39,18,3,0.2);
INSERT INTO Order_Details2783 VALUES(10661,58,13.25,49,0.2);
INSERT INTO Order_Details2783 VALUES(10662,68,12.5,10,0);
INSERT INTO Order_Details2783 VALUES(10663,40,18.4,30,0.05);
INSERT INTO Order_Details2783 VALUES(10663,42,14,30,0.05);
INSERT INTO Order_Details2783 VALUES(10663,51,53,20,0.05);
INSERT INTO Order_Details2783 VALUES(10664,10,31,24,0.15);
INSERT INTO Order_Details2783 VALUES(10664,56,38,12,0.15);
INSERT INTO Order_Details2783 VALUES(10664,65,21.05,15,0.15);
INSERT INTO Order_Details2783 VALUES(10665,51,53,20,0);
INSERT INTO Order_Details2783 VALUES(10665,59,55,1,0);
INSERT INTO Order_Details2783 VALUES(10665,76,18,10,0);
INSERT INTO Order_Details2783 VALUES(10666,29,123.79,36,0);
INSERT INTO Order_Details2783 VALUES(10666,65,21.05,10,0);
INSERT INTO Order_Details2783 VALUES(10667,69,36,45,0.2);
INSERT INTO Order_Details2783 VALUES(10667,71,21.5,14,0.2);
INSERT INTO Order_Details2783 VALUES(10668,31,12.5,8,0.1);
INSERT INTO Order_Details2783 VALUES(10668,55,24,4,0.1);
INSERT INTO Order_Details2783 VALUES(10668,64,33.25,15,0.1);
INSERT INTO Order_Details2783 VALUES(10669,36,19,30,0);
INSERT INTO Order_Details2783 VALUES(10670,23,9,32,0);
INSERT INTO Order_Details2783 VALUES(10670,46,12,60,0);
INSERT INTO Order_Details2783 VALUES(10670,67,14,25,0);
INSERT INTO Order_Details2783 VALUES(10670,73,15,50,0);
INSERT INTO Order_Details2783 VALUES(10670,75,7.75,25,0);
INSERT INTO Order_Details2783 VALUES(10671,16,17.45,10,0);
INSERT INTO Order_Details2783 VALUES(10671,62,49.3,10,0);
INSERT INTO Order_Details2783 VALUES(10671,65,21.05,12,0);
INSERT INTO Order_Details2783 VALUES(10672,38,263.5,15,0.1);
INSERT INTO Order_Details2783 VALUES(10672,71,21.5,12,0);
INSERT INTO Order_Details2783 VALUES(10673,16,17.45,3,0);
INSERT INTO Order_Details2783 VALUES(10673,42,14,6,0);
INSERT INTO Order_Details2783 VALUES(10673,43,46,6,0);
INSERT INTO Order_Details2783 VALUES(10674,23,9,5,0);
INSERT INTO Order_Details2783 VALUES(10675,14,23.25,30,0);
INSERT INTO Order_Details2783 VALUES(10675,53,32.8,10,0);
INSERT INTO Order_Details2783 VALUES(10675,58,13.25,30,0);
INSERT INTO Order_Details2783 VALUES(10676,10,31,2,0);
INSERT INTO Order_Details2783 VALUES(10676,19,9.2,7,0);
INSERT INTO Order_Details2783 VALUES(10676,44,19.45,21,0);
INSERT INTO Order_Details2783 VALUES(10677,26,31.23,30,0.15);
INSERT INTO Order_Details2783 VALUES(10677,33,2.5,8,0.15);
INSERT INTO Order_Details2783 VALUES(10678,12,38,100,0);
INSERT INTO Order_Details2783 VALUES(10678,33,2.5,30,0);
INSERT INTO Order_Details2783 VALUES(10678,41,9.65,120,0);
INSERT INTO Order_Details2783 VALUES(10678,54,7.45,30,0);
INSERT INTO Order_Details2783 VALUES(10679,59,55,12,0);
INSERT INTO Order_Details2783 VALUES(10680,16,17.45,50,0.25);
INSERT INTO Order_Details2783 VALUES(10680,31,12.5,20,0.25);
INSERT INTO Order_Details2783 VALUES(10680,42,14,40,0.25);
INSERT INTO Order_Details2783 VALUES(10681,19,9.2,30,0.1);
INSERT INTO Order_Details2783 VALUES(10681,21,10,12,0.1);
INSERT INTO Order_Details2783 VALUES(10681,64,33.25,28,0);
INSERT INTO Order_Details2783 VALUES(10682,33,2.5,30,0);
INSERT INTO Order_Details2783 VALUES(10682,66,17,4,0);
INSERT INTO Order_Details2783 VALUES(10682,75,7.75,30,0);
INSERT INTO Order_Details2783 VALUES(10683,52,7,9,0);
INSERT INTO Order_Details2783 VALUES(10684,40,18.4,20,0);
INSERT INTO Order_Details2783 VALUES(10684,47,9.5,40,0);
INSERT INTO Order_Details2783 VALUES(10684,60,34,30,0);
INSERT INTO Order_Details2783 VALUES(10685,10,31,20,0);
INSERT INTO Order_Details2783 VALUES(10685,41,9.65,4,0);
INSERT INTO Order_Details2783 VALUES(10685,47,9.5,15,0);
INSERT INTO Order_Details2783 VALUES(10686,17,39,30,0.2);
INSERT INTO Order_Details2783 VALUES(10686,26,31.23,15,0);
INSERT INTO Order_Details2783 VALUES(10687,9,97,50,0.25);
INSERT INTO Order_Details2783 VALUES(10687,29,123.79,10,0);
INSERT INTO Order_Details2783 VALUES(10687,36,19,6,0.25);
INSERT INTO Order_Details2783 VALUES(10688,10,31,18,0.1);
INSERT INTO Order_Details2783 VALUES(10688,28,45.6,60,0.1);
INSERT INTO Order_Details2783 VALUES(10688,34,14,14,0);
INSERT INTO Order_Details2783 VALUES(10689,1,18,35,0.25);
INSERT INTO Order_Details2783 VALUES(10690,56,38,20,0.25);
INSERT INTO Order_Details2783 VALUES(10690,77,13,30,0.25);
INSERT INTO Order_Details2783 VALUES(10691,1,18,30,0);
INSERT INTO Order_Details2783 VALUES(10691,29,123.79,40,0);
INSERT INTO Order_Details2783 VALUES(10691,43,46,40,0);
INSERT INTO Order_Details2783 VALUES(10691,44,19.45,24,0);
INSERT INTO Order_Details2783 VALUES(10691,62,49.3,48,0);
INSERT INTO Order_Details2783 VALUES(10692,63,43.9,20,0);
INSERT INTO Order_Details2783 VALUES(10693,9,97,6,0);
INSERT INTO Order_Details2783 VALUES(10693,54,7.45,60,0.15);
INSERT INTO Order_Details2783 VALUES(10693,69,36,30,0.15);
INSERT INTO Order_Details2783 VALUES(10693,73,15,15,0.15);
INSERT INTO Order_Details2783 VALUES(10694,7,30,90,0);
INSERT INTO Order_Details2783 VALUES(10694,59,55,25,0);
INSERT INTO Order_Details2783 VALUES(10694,70,15,50,0);
INSERT INTO Order_Details2783 VALUES(10695,8,40,10,0);
INSERT INTO Order_Details2783 VALUES(10695,12,38,4,0);
INSERT INTO Order_Details2783 VALUES(10695,24,4.5,20,0);
INSERT INTO Order_Details2783 VALUES(10696,17,39,20,0);
INSERT INTO Order_Details2783 VALUES(10696,46,12,18,0);
INSERT INTO Order_Details2783 VALUES(10697,19,9.2,7,0.25);
INSERT INTO Order_Details2783 VALUES(10697,35,18,9,0.25);
INSERT INTO Order_Details2783 VALUES(10697,58,13.25,30,0.25);
INSERT INTO Order_Details2783 VALUES(10697,70,15,30,0.25);
INSERT INTO Order_Details2783 VALUES(10698,11,21,15,0);
INSERT INTO Order_Details2783 VALUES(10698,17,39,8,0.05);
INSERT INTO Order_Details2783 VALUES(10698,29,123.79,12,0.05);
INSERT INTO Order_Details2783 VALUES(10698,65,21.05,65,0.05);
INSERT INTO Order_Details2783 VALUES(10698,70,15,8,0.05);
INSERT INTO Order_Details2783 VALUES(10699,47,9.5,12,0);
INSERT INTO Order_Details2783 VALUES(10700,1,18,5,0.2);
INSERT INTO Order_Details2783 VALUES(10700,34,14,12,0.2);
INSERT INTO Order_Details2783 VALUES(10700,68,12.5,40,0.2);
INSERT INTO Order_Details2783 VALUES(10700,71,21.5,60,0.2);
INSERT INTO Order_Details2783 VALUES(10701,59,55,42,0.15);
INSERT INTO Order_Details2783 VALUES(10701,71,21.5,20,0.15);
INSERT INTO Order_Details2783 VALUES(10701,76,18,35,0.15);
INSERT INTO Order_Details2783 VALUES(10702,3,10,6,0);
INSERT INTO Order_Details2783 VALUES(10702,76,18,15,0);
INSERT INTO Order_Details2783 VALUES(10703,2,19,5,0);
INSERT INTO Order_Details2783 VALUES(10703,59,55,35,0);
INSERT INTO Order_Details2783 VALUES(10703,73,15,35,0);
INSERT INTO Order_Details2783 VALUES(10704,4,22,6,0);
INSERT INTO Order_Details2783 VALUES(10704,24,4.5,35,0);
INSERT INTO Order_Details2783 VALUES(10704,48,12.75,24,0);
INSERT INTO Order_Details2783 VALUES(10705,31,12.5,20,0);
INSERT INTO Order_Details2783 VALUES(10705,32,32,4,0);
INSERT INTO Order_Details2783 VALUES(10706,16,17.45,20,0);
INSERT INTO Order_Details2783 VALUES(10706,43,46,24,0);
INSERT INTO Order_Details2783 VALUES(10706,59,55,8,0);
INSERT INTO Order_Details2783 VALUES(10707,55,24,21,0);
INSERT INTO Order_Details2783 VALUES(10707,57,19.5,40,0);
INSERT INTO Order_Details2783 VALUES(10707,70,15,28,0.15);
INSERT INTO Order_Details2783 VALUES(10708,5,21.35,4,0);
INSERT INTO Order_Details2783 VALUES(10708,36,19,5,0);
INSERT INTO Order_Details2783 VALUES(10709,8,40,40,0);
INSERT INTO Order_Details2783 VALUES(10709,51,53,28,0);
INSERT INTO Order_Details2783 VALUES(10709,60,34,10,0);
INSERT INTO Order_Details2783 VALUES(10710,19,9.2,5,0);
INSERT INTO Order_Details2783 VALUES(10710,47,9.5,5,0);
INSERT INTO Order_Details2783 VALUES(10711,19,9.2,12,0);
INSERT INTO Order_Details2783 VALUES(10711,41,9.65,42,0);
INSERT INTO Order_Details2783 VALUES(10711,53,32.8,120,0);
INSERT INTO Order_Details2783 VALUES(10712,53,32.8,3,0.05);
INSERT INTO Order_Details2783 VALUES(10712,56,38,30,0);
INSERT INTO Order_Details2783 VALUES(10713,10,31,18,0);
INSERT INTO Order_Details2783 VALUES(10713,26,31.23,30,0);
INSERT INTO Order_Details2783 VALUES(10713,45,9.5,110,0);
INSERT INTO Order_Details2783 VALUES(10713,46,12,24,0);
INSERT INTO Order_Details2783 VALUES(10714,2,19,30,0.25);
INSERT INTO Order_Details2783 VALUES(10714,17,39,27,0.25);
INSERT INTO Order_Details2783 VALUES(10714,47,9.5,50,0.25);
INSERT INTO Order_Details2783 VALUES(10714,56,38,18,0.25);
INSERT INTO Order_Details2783 VALUES(10714,58,13.25,12,0.25);
INSERT INTO Order_Details2783 VALUES(10715,10,31,21,0);
INSERT INTO Order_Details2783 VALUES(10715,71,21.5,30,0);
INSERT INTO Order_Details2783 VALUES(10716,21,10,5,0);
INSERT INTO Order_Details2783 VALUES(10716,51,53,7,0);
INSERT INTO Order_Details2783 VALUES(10716,61,28.5,10,0);
INSERT INTO Order_Details2783 VALUES(10717,21,10,32,0.05);
INSERT INTO Order_Details2783 VALUES(10717,54,7.45,15,0);
INSERT INTO Order_Details2783 VALUES(10717,69,36,25,0.05);
INSERT INTO Order_Details2783 VALUES(10718,12,38,36,0);
INSERT INTO Order_Details2783 VALUES(10718,16,17.45,20,0);
INSERT INTO Order_Details2783 VALUES(10718,36,19,40,0);
INSERT INTO Order_Details2783 VALUES(10718,62,49.3,20,0);
INSERT INTO Order_Details2783 VALUES(10719,18,62.5,12,0.25);
INSERT INTO Order_Details2783 VALUES(10719,30,25.89,3,0.25);
INSERT INTO Order_Details2783 VALUES(10719,54,7.45,40,0.25);
INSERT INTO Order_Details2783 VALUES(10720,35,18,21,0);
INSERT INTO Order_Details2783 VALUES(10720,71,21.5,8,0);
INSERT INTO Order_Details2783 VALUES(10721,44,19.45,50,0.05);
INSERT INTO Order_Details2783 VALUES(10722,2,19,3,0);
INSERT INTO Order_Details2783 VALUES(10722,31,12.5,50,0);
INSERT INTO Order_Details2783 VALUES(10722,68,12.5,45,0);
INSERT INTO Order_Details2783 VALUES(10722,75,7.75,42,0);
INSERT INTO Order_Details2783 VALUES(10723,26,31.23,15,0);
INSERT INTO Order_Details2783 VALUES(10724,10,31,16,0);
INSERT INTO Order_Details2783 VALUES(10724,61,28.5,5,0);
INSERT INTO Order_Details2783 VALUES(10725,41,9.65,12,0);
INSERT INTO Order_Details2783 VALUES(10725,52,7,4,0);
INSERT INTO Order_Details2783 VALUES(10725,55,24,6,0);
INSERT INTO Order_Details2783 VALUES(10726,4,22,25,0);
INSERT INTO Order_Details2783 VALUES(10726,11,21,5,0);
INSERT INTO Order_Details2783 VALUES(10727,17,39,20,0.05);
INSERT INTO Order_Details2783 VALUES(10727,56,38,10,0.05);
INSERT INTO Order_Details2783 VALUES(10727,59,55,10,0.05);
INSERT INTO Order_Details2783 VALUES(10728,30,25.89,15,0);
INSERT INTO Order_Details2783 VALUES(10728,40,18.4,6,0);
INSERT INTO Order_Details2783 VALUES(10728,55,24,12,0);
INSERT INTO Order_Details2783 VALUES(10728,60,34,15,0);
INSERT INTO Order_Details2783 VALUES(10729,1,18,50,0);
INSERT INTO Order_Details2783 VALUES(10729,21,10,30,0);
INSERT INTO Order_Details2783 VALUES(10729,50,16.25,40,0);
INSERT INTO Order_Details2783 VALUES(10730,16,17.45,15,0.05);
INSERT INTO Order_Details2783 VALUES(10730,31,12.5,3,0.05);
INSERT INTO Order_Details2783 VALUES(10730,65,21.05,10,0.05);
INSERT INTO Order_Details2783 VALUES(10731,21,10,40,0.05);
INSERT INTO Order_Details2783 VALUES(10731,51,53,30,0.05);
INSERT INTO Order_Details2783 VALUES(10732,76,18,20,0);
INSERT INTO Order_Details2783 VALUES(10733,14,23.25,16,0);
INSERT INTO Order_Details2783 VALUES(10733,28,45.6,20,0);
INSERT INTO Order_Details2783 VALUES(10733,52,7,25,0);
INSERT INTO Order_Details2783 VALUES(10734,6,25,30,0);
INSERT INTO Order_Details2783 VALUES(10734,30,25.89,15,0);
INSERT INTO Order_Details2783 VALUES(10734,76,18,20,0);
INSERT INTO Order_Details2783 VALUES(10735,61,28.5,20,0.1);
INSERT INTO Order_Details2783 VALUES(10735,77,13,2,0.1);
INSERT INTO Order_Details2783 VALUES(10736,65,21.05,40,0);
INSERT INTO Order_Details2783 VALUES(10736,75,7.75,20,0);
INSERT INTO Order_Details2783 VALUES(10737,13,6,4,0);
INSERT INTO Order_Details2783 VALUES(10737,41,9.65,12,0);
INSERT INTO Order_Details2783 VALUES(10738,16,17.45,3,0);
INSERT INTO Order_Details2783 VALUES(10739,36,19,6,0);
INSERT INTO Order_Details2783 VALUES(10739,52,7,18,0);
INSERT INTO Order_Details2783 VALUES(10740,28,45.6,5,0.2);
INSERT INTO Order_Details2783 VALUES(10740,35,18,35,0.2);
INSERT INTO Order_Details2783 VALUES(10740,45,9.5,40,0.2);
INSERT INTO Order_Details2783 VALUES(10740,56,38,14,0.2);
INSERT INTO Order_Details2783 VALUES(10741,2,19,15,0.2);
INSERT INTO Order_Details2783 VALUES(10742,3,10,20,0);
INSERT INTO Order_Details2783 VALUES(10742,60,34,50,0);
INSERT INTO Order_Details2783 VALUES(10742,72,34.8,35,0);
INSERT INTO Order_Details2783 VALUES(10743,46,12,28,0.05);
INSERT INTO Order_Details2783 VALUES(10744,40,18.4,50,0.2);
INSERT INTO Order_Details2783 VALUES(10745,18,62.5,24,0);
INSERT INTO Order_Details2783 VALUES(10745,44,19.45,16,0);
INSERT INTO Order_Details2783 VALUES(10745,59,55,45,0);
INSERT INTO Order_Details2783 VALUES(10745,72,34.8,7,0);
INSERT INTO Order_Details2783 VALUES(10746,13,6,6,0);
INSERT INTO Order_Details2783 VALUES(10746,42,14,28,0);
INSERT INTO Order_Details2783 VALUES(10746,62,49.3,9,0);
INSERT INTO Order_Details2783 VALUES(10746,69,36,40,0);
INSERT INTO Order_Details2783 VALUES(10747,31,12.5,8,0);
INSERT INTO Order_Details2783 VALUES(10747,41,9.65,35,0);
INSERT INTO Order_Details2783 VALUES(10747,63,43.9,9,0);
INSERT INTO Order_Details2783 VALUES(10747,69,36,30,0);
INSERT INTO Order_Details2783 VALUES(10748,23,9,44,0);
INSERT INTO Order_Details2783 VALUES(10748,40,18.4,40,0);
INSERT INTO Order_Details2783 VALUES(10748,56,38,28,0);
INSERT INTO Order_Details2783 VALUES(10749,56,38,15,0);
INSERT INTO Order_Details2783 VALUES(10749,59,55,6,0);
INSERT INTO Order_Details2783 VALUES(10749,76,18,10,0);
INSERT INTO Order_Details2783 VALUES(10750,14,23.25,5,0.15);
INSERT INTO Order_Details2783 VALUES(10750,45,9.5,40,0.15);
INSERT INTO Order_Details2783 VALUES(10750,59,55,25,0.15);
INSERT INTO Order_Details2783 VALUES(10751,26,31.23,12,0.1);
INSERT INTO Order_Details2783 VALUES(10751,30,25.89,30,0);
INSERT INTO Order_Details2783 VALUES(10751,50,16.25,20,0.1);
INSERT INTO Order_Details2783 VALUES(10751,73,15,15,0);
INSERT INTO Order_Details2783 VALUES(10752,1,18,8,0);
INSERT INTO Order_Details2783 VALUES(10752,69,36,3,0);
INSERT INTO Order_Details2783 VALUES(10753,45,9.5,4,0);
INSERT INTO Order_Details2783 VALUES(10753,74,10,5,0);
INSERT INTO Order_Details2783 VALUES(10754,40,18.4,3,0);
INSERT INTO Order_Details2783 VALUES(10755,47,9.5,30,0.25);
INSERT INTO Order_Details2783 VALUES(10755,56,38,30,0.25);
INSERT INTO Order_Details2783 VALUES(10755,57,19.5,14,0.25);
INSERT INTO Order_Details2783 VALUES(10755,69,36,25,0.25);
INSERT INTO Order_Details2783 VALUES(10756,18,62.5,21,0.2);
INSERT INTO Order_Details2783 VALUES(10756,36,19,20,0.2);
INSERT INTO Order_Details2783 VALUES(10756,68,12.5,6,0.2);
INSERT INTO Order_Details2783 VALUES(10756,69,36,20,0.2);
INSERT INTO Order_Details2783 VALUES(10757,34,14,30,0);
INSERT INTO Order_Details2783 VALUES(10757,59,55,7,0);
INSERT INTO Order_Details2783 VALUES(10757,62,49.3,30,0);
INSERT INTO Order_Details2783 VALUES(10757,64,33.25,24,0);
INSERT INTO Order_Details2783 VALUES(10758,26,31.23,20,0);
INSERT INTO Order_Details2783 VALUES(10758,52,7,60,0);
INSERT INTO Order_Details2783 VALUES(10758,70,15,40,0);
INSERT INTO Order_Details2783 VALUES(10759,32,32,10,0);
INSERT INTO Order_Details2783 VALUES(10760,25,14,12,0.25);
INSERT INTO Order_Details2783 VALUES(10760,27,43.9,40,0);
INSERT INTO Order_Details2783 VALUES(10760,43,46,30,0.25);
INSERT INTO Order_Details2783 VALUES(10761,25,14,35,0.25);
INSERT INTO Order_Details2783 VALUES(10761,75,7.75,18,0);
INSERT INTO Order_Details2783 VALUES(10762,39,18,16,0);
INSERT INTO Order_Details2783 VALUES(10762,47,9.5,30,0);
INSERT INTO Order_Details2783 VALUES(10762,51,53,28,0);
INSERT INTO Order_Details2783 VALUES(10762,56,38,60,0);
INSERT INTO Order_Details2783 VALUES(10763,21,10,40,0);
INSERT INTO Order_Details2783 VALUES(10763,22,21,6,0);
INSERT INTO Order_Details2783 VALUES(10763,24,4.5,20,0);
INSERT INTO Order_Details2783 VALUES(10764,3,10,20,0.1);
INSERT INTO Order_Details2783 VALUES(10764,39,18,130,0.1);
INSERT INTO Order_Details2783 VALUES(10765,65,21.05,80,0.1);
INSERT INTO Order_Details2783 VALUES(10766,2,19,40,0);
INSERT INTO Order_Details2783 VALUES(10766,7,30,35,0);
INSERT INTO Order_Details2783 VALUES(10766,68,12.5,40,0);
INSERT INTO Order_Details2783 VALUES(10767,42,14,2,0);
INSERT INTO Order_Details2783 VALUES(10768,22,21,4,0);
INSERT INTO Order_Details2783 VALUES(10768,31,12.5,50,0);
INSERT INTO Order_Details2783 VALUES(10768,60,34,15,0);
INSERT INTO Order_Details2783 VALUES(10768,71,21.5,12,0);
INSERT INTO Order_Details2783 VALUES(10769,41,9.65,30,0.05);
INSERT INTO Order_Details2783 VALUES(10769,52,7,15,0.05);
INSERT INTO Order_Details2783 VALUES(10769,61,28.5,20,0);
INSERT INTO Order_Details2783 VALUES(10769,62,49.3,15,0);
INSERT INTO Order_Details2783 VALUES(10770,11,21,15,0.25);
INSERT INTO Order_Details2783 VALUES(10771,71,21.5,16,0);
INSERT INTO Order_Details2783 VALUES(10772,29,123.79,18,0);
INSERT INTO Order_Details2783 VALUES(10772,59,55,25,0);
INSERT INTO Order_Details2783 VALUES(10773,17,39,33,0);
INSERT INTO Order_Details2783 VALUES(10773,31,12.5,70,0.2);
INSERT INTO Order_Details2783 VALUES(10773,75,7.75,7,0.2);
INSERT INTO Order_Details2783 VALUES(10774,31,12.5,2,0.25);
INSERT INTO Order_Details2783 VALUES(10774,66,17,50,0);
INSERT INTO Order_Details2783 VALUES(10775,10,31,6,0);
INSERT INTO Order_Details2783 VALUES(10775,67,14,3,0);
INSERT INTO Order_Details2783 VALUES(10776,31,12.5,16,0.05);
INSERT INTO Order_Details2783 VALUES(10776,42,14,12,0.05);
INSERT INTO Order_Details2783 VALUES(10776,45,9.5,27,0.05);
INSERT INTO Order_Details2783 VALUES(10776,51,53,120,0.05);
INSERT INTO Order_Details2783 VALUES(10777,42,14,20,0.2);
INSERT INTO Order_Details2783 VALUES(10778,41,9.65,10,0);
INSERT INTO Order_Details2783 VALUES(10779,16,17.45,20,0);
INSERT INTO Order_Details2783 VALUES(10779,62,49.3,20,0);
INSERT INTO Order_Details2783 VALUES(10780,70,15,35,0);
INSERT INTO Order_Details2783 VALUES(10780,77,13,15,0);
INSERT INTO Order_Details2783 VALUES(10781,54,7.45,3,0.2);
INSERT INTO Order_Details2783 VALUES(10781,56,38,20,0.2);
INSERT INTO Order_Details2783 VALUES(10781,74,10,35,0);
INSERT INTO Order_Details2783 VALUES(10782,31,12.5,1,0);
INSERT INTO Order_Details2783 VALUES(10783,31,12.5,10,0);
INSERT INTO Order_Details2783 VALUES(10783,38,263.5,5,0);
INSERT INTO Order_Details2783 VALUES(10784,36,19,30,0);
INSERT INTO Order_Details2783 VALUES(10784,39,18,2,0.15);
INSERT INTO Order_Details2783 VALUES(10784,72,34.8,30,0.15);
INSERT INTO Order_Details2783 VALUES(10785,10,31,10,0);
INSERT INTO Order_Details2783 VALUES(10785,75,7.75,10,0);
INSERT INTO Order_Details2783 VALUES(10786,8,40,30,0.2);
INSERT INTO Order_Details2783 VALUES(10786,30,25.89,15,0.2);
INSERT INTO Order_Details2783 VALUES(10786,75,7.75,42,0.2);
INSERT INTO Order_Details2783 VALUES(10787,2,19,15,0.05);
INSERT INTO Order_Details2783 VALUES(10787,29,123.79,20,0.05);
INSERT INTO Order_Details2783 VALUES(10788,19,9.2,50,0.05);
INSERT INTO Order_Details2783 VALUES(10788,75,7.75,40,0.05);
INSERT INTO Order_Details2783 VALUES(10789,18,62.5,30,0);
INSERT INTO Order_Details2783 VALUES(10789,35,18,15,0);
INSERT INTO Order_Details2783 VALUES(10789,63,43.9,30,0);
INSERT INTO Order_Details2783 VALUES(10789,68,12.5,18,0);
INSERT INTO Order_Details2783 VALUES(10790,7,30,3,0.15);
INSERT INTO Order_Details2783 VALUES(10790,56,38,20,0.15);
INSERT INTO Order_Details2783 VALUES(10791,29,123.79,14,0.05);
INSERT INTO Order_Details2783 VALUES(10791,41,9.65,20,0.05);
INSERT INTO Order_Details2783 VALUES(10792,2,19,10,0);
INSERT INTO Order_Details2783 VALUES(10792,54,7.45,3,0);
INSERT INTO Order_Details2783 VALUES(10792,68,12.5,15,0);
INSERT INTO Order_Details2783 VALUES(10793,41,9.65,14,0);
INSERT INTO Order_Details2783 VALUES(10793,52,7,8,0);
INSERT INTO Order_Details2783 VALUES(10794,14,23.25,15,0.2);
INSERT INTO Order_Details2783 VALUES(10794,54,7.45,6,0.2);
INSERT INTO Order_Details2783 VALUES(10795,16,17.45,65,0);
INSERT INTO Order_Details2783 VALUES(10795,17,39,35,0.25);
INSERT INTO Order_Details2783 VALUES(10796,26,31.23,21,0.2);
INSERT INTO Order_Details2783 VALUES(10796,44,19.45,10,0);
INSERT INTO Order_Details2783 VALUES(10796,64,33.25,35,0.2);
INSERT INTO Order_Details2783 VALUES(10796,69,36,24,0.2);
INSERT INTO Order_Details2783 VALUES(10797,11,21,20,0);
INSERT INTO Order_Details2783 VALUES(10798,62,49.3,2,0);
INSERT INTO Order_Details2783 VALUES(10798,72,34.8,10,0);
INSERT INTO Order_Details2783 VALUES(10799,13,6,20,0.15);
INSERT INTO Order_Details2783 VALUES(10799,24,4.5,20,0.15);
INSERT INTO Order_Details2783 VALUES(10799,59,55,25,0);
INSERT INTO Order_Details2783 VALUES(10800,11,21,50,0.1);
INSERT INTO Order_Details2783 VALUES(10800,51,53,10,0.1);
INSERT INTO Order_Details2783 VALUES(10800,54,7.45,7,0.1);
INSERT INTO Order_Details2783 VALUES(10801,17,39,40,0.25);
INSERT INTO Order_Details2783 VALUES(10801,29,123.79,20,0.25);
INSERT INTO Order_Details2783 VALUES(10802,30,25.89,25,0.25);
INSERT INTO Order_Details2783 VALUES(10802,51,53,30,0.25);
INSERT INTO Order_Details2783 VALUES(10802,55,24,60,0.25);
INSERT INTO Order_Details2783 VALUES(10802,62,49.3,5,0.25);
INSERT INTO Order_Details2783 VALUES(10803,19,9.2,24,0.05);
INSERT INTO Order_Details2783 VALUES(10803,25,14,15,0.05);
INSERT INTO Order_Details2783 VALUES(10803,59,55,15,0.05);
INSERT INTO Order_Details2783 VALUES(10804,10,31,36,0);
INSERT INTO Order_Details2783 VALUES(10804,28,45.6,24,0);
INSERT INTO Order_Details2783 VALUES(10804,49,20,4,0.15);
INSERT INTO Order_Details2783 VALUES(10805,34,14,10,0);
INSERT INTO Order_Details2783 VALUES(10805,38,263.5,10,0);
INSERT INTO Order_Details2783 VALUES(10806,2,19,20,0.25);
INSERT INTO Order_Details2783 VALUES(10806,65,21.05,2,0);
INSERT INTO Order_Details2783 VALUES(10806,74,10,15,0.25);
INSERT INTO Order_Details2783 VALUES(10807,40,18.4,1,0);
INSERT INTO Order_Details2783 VALUES(10808,56,38,20,0.15);
INSERT INTO Order_Details2783 VALUES(10808,76,18,50,0.15);
INSERT INTO Order_Details2783 VALUES(10809,52,7,20,0);
INSERT INTO Order_Details2783 VALUES(10810,13,6,7,0);
INSERT INTO Order_Details2783 VALUES(10810,25,14,5,0);
INSERT INTO Order_Details2783 VALUES(10810,70,15,5,0);
INSERT INTO Order_Details2783 VALUES(10811,19,9.2,15,0);
INSERT INTO Order_Details2783 VALUES(10811,23,9,18,0);
INSERT INTO Order_Details2783 VALUES(10811,40,18.4,30,0);
INSERT INTO Order_Details2783 VALUES(10812,31,12.5,16,0.1);
INSERT INTO Order_Details2783 VALUES(10812,72,34.8,40,0.1);
INSERT INTO Order_Details2783 VALUES(10812,77,13,20,0);
INSERT INTO Order_Details2783 VALUES(10813,2,19,12,0.2);
INSERT INTO Order_Details2783 VALUES(10813,46,12,35,0);
INSERT INTO Order_Details2783 VALUES(10814,41,9.65,20,0);
INSERT INTO Order_Details2783 VALUES(10814,43,46,20,0.15);
INSERT INTO Order_Details2783 VALUES(10814,48,12.75,8,0.15);
INSERT INTO Order_Details2783 VALUES(10814,61,28.5,30,0.15);
INSERT INTO Order_Details2783 VALUES(10815,33,2.5,16,0);
INSERT INTO Order_Details2783 VALUES(10816,38,263.5,30,0.05);
INSERT INTO Order_Details2783 VALUES(10816,62,49.3,20,0.05);
INSERT INTO Order_Details2783 VALUES(10817,26,31.23,40,0.15);
INSERT INTO Order_Details2783 VALUES(10817,38,263.5,30,0);
INSERT INTO Order_Details2783 VALUES(10817,40,18.4,60,0.15);
INSERT INTO Order_Details2783 VALUES(10817,62,49.3,25,0.15);
INSERT INTO Order_Details2783 VALUES(10818,32,32,20,0);
INSERT INTO Order_Details2783 VALUES(10818,41,9.65,20,0);
INSERT INTO Order_Details2783 VALUES(10819,43,46,7,0);
INSERT INTO Order_Details2783 VALUES(10819,75,7.75,20,0);
INSERT INTO Order_Details2783 VALUES(10820,56,38,30,0);
INSERT INTO Order_Details2783 VALUES(10821,35,18,20,0);
INSERT INTO Order_Details2783 VALUES(10821,51,53,6,0);
INSERT INTO Order_Details2783 VALUES(10822,62,49.3,3,0);
INSERT INTO Order_Details2783 VALUES(10822,70,15,6,0);
INSERT INTO Order_Details2783 VALUES(10823,11,21,20,0.1);
INSERT INTO Order_Details2783 VALUES(10823,57,19.5,15,0);
INSERT INTO Order_Details2783 VALUES(10823,59,55,40,0.1);
INSERT INTO Order_Details2783 VALUES(10823,77,13,15,0.1);
INSERT INTO Order_Details2783 VALUES(10824,41,9.65,12,0);
INSERT INTO Order_Details2783 VALUES(10824,70,15,9,0);
INSERT INTO Order_Details2783 VALUES(10825,26,31.23,12,0);
INSERT INTO Order_Details2783 VALUES(10825,53,32.8,20,0);
INSERT INTO Order_Details2783 VALUES(10826,31,12.5,35,0);
INSERT INTO Order_Details2783 VALUES(10826,57,19.5,15,0);
INSERT INTO Order_Details2783 VALUES(10827,10,31,15,0);
INSERT INTO Order_Details2783 VALUES(10827,39,18,21,0);
INSERT INTO Order_Details2783 VALUES(10828,20,81,5,0);
INSERT INTO Order_Details2783 VALUES(10828,38,263.5,2,0);
INSERT INTO Order_Details2783 VALUES(10829,2,19,10,0);
INSERT INTO Order_Details2783 VALUES(10829,8,40,20,0);
INSERT INTO Order_Details2783 VALUES(10829,13,6,10,0);
INSERT INTO Order_Details2783 VALUES(10829,60,34,21,0);
INSERT INTO Order_Details2783 VALUES(10830,6,25,6,0);
INSERT INTO Order_Details2783 VALUES(10830,39,18,28,0);
INSERT INTO Order_Details2783 VALUES(10830,60,34,30,0);
INSERT INTO Order_Details2783 VALUES(10830,68,12.5,24,0);
INSERT INTO Order_Details2783 VALUES(10831,19,9.2,2,0);
INSERT INTO Order_Details2783 VALUES(10831,35,18,8,0);
INSERT INTO Order_Details2783 VALUES(10831,38,263.5,8,0);
INSERT INTO Order_Details2783 VALUES(10831,43,46,9,0);
INSERT INTO Order_Details2783 VALUES(10832,13,6,3,0.2);
INSERT INTO Order_Details2783 VALUES(10832,25,14,10,0.2);
INSERT INTO Order_Details2783 VALUES(10832,44,19.45,16,0.2);
INSERT INTO Order_Details2783 VALUES(10832,64,33.25,3,0);
INSERT INTO Order_Details2783 VALUES(10833,7,30,20,0.1);
INSERT INTO Order_Details2783 VALUES(10833,31,12.5,9,0.1);
INSERT INTO Order_Details2783 VALUES(10833,53,32.8,9,0.1);
INSERT INTO Order_Details2783 VALUES(10834,29,123.79,8,0.05);
INSERT INTO Order_Details2783 VALUES(10834,30,25.89,20,0.05);
INSERT INTO Order_Details2783 VALUES(10835,59,55,15,0);
INSERT INTO Order_Details2783 VALUES(10835,77,13,2,0.2);
INSERT INTO Order_Details2783 VALUES(10836,22,21,52,0);
INSERT INTO Order_Details2783 VALUES(10836,35,18,6,0);
INSERT INTO Order_Details2783 VALUES(10836,57,19.5,24,0);
INSERT INTO Order_Details2783 VALUES(10836,60,34,60,0);
INSERT INTO Order_Details2783 VALUES(10836,64,33.25,30,0);
INSERT INTO Order_Details2783 VALUES(10837,13,6,6,0);
INSERT INTO Order_Details2783 VALUES(10837,40,18.4,25,0);
INSERT INTO Order_Details2783 VALUES(10837,47,9.5,40,0.25);
INSERT INTO Order_Details2783 VALUES(10837,76,18,21,0.25);
INSERT INTO Order_Details2783 VALUES(10838,1,18,4,0.25);
INSERT INTO Order_Details2783 VALUES(10838,18,62.5,25,0.25);
INSERT INTO Order_Details2783 VALUES(10838,36,19,50,0.25);
INSERT INTO Order_Details2783 VALUES(10839,58,13.25,30,0.1);
INSERT INTO Order_Details2783 VALUES(10839,72,34.8,15,0.1);
INSERT INTO Order_Details2783 VALUES(10840,25,14,6,0.2);
INSERT INTO Order_Details2783 VALUES(10840,39,18,10,0.2);
INSERT INTO Order_Details2783 VALUES(10841,10,31,16,0);
INSERT INTO Order_Details2783 VALUES(10841,56,38,30,0);
INSERT INTO Order_Details2783 VALUES(10841,59,55,50,0);
INSERT INTO Order_Details2783 VALUES(10841,77,13,15,0);
INSERT INTO Order_Details2783 VALUES(10842,11,21,15,0);
INSERT INTO Order_Details2783 VALUES(10842,43,46,5,0);
INSERT INTO Order_Details2783 VALUES(10842,68,12.5,20,0);
INSERT INTO Order_Details2783 VALUES(10842,70,15,12,0);
INSERT INTO Order_Details2783 VALUES(10843,51,53,4,0.25);
INSERT INTO Order_Details2783 VALUES(10844,22,21,35,0);
INSERT INTO Order_Details2783 VALUES(10845,23,9,70,0.1);
INSERT INTO Order_Details2783 VALUES(10845,35,18,25,0.1);
INSERT INTO Order_Details2783 VALUES(10845,42,14,42,0.1);
INSERT INTO Order_Details2783 VALUES(10845,58,13.25,60,0.1);
INSERT INTO Order_Details2783 VALUES(10845,64,33.25,48,0);
INSERT INTO Order_Details2783 VALUES(10846,4,22,21,0);
INSERT INTO Order_Details2783 VALUES(10846,70,15,30,0);
INSERT INTO Order_Details2783 VALUES(10846,74,10,20,0);
INSERT INTO Order_Details2783 VALUES(10847,1,18,80,0.2);
INSERT INTO Order_Details2783 VALUES(10847,19,9.2,12,0.2);
INSERT INTO Order_Details2783 VALUES(10847,37,26,60,0.2);
INSERT INTO Order_Details2783 VALUES(10847,45,9.5,36,0.2);
INSERT INTO Order_Details2783 VALUES(10847,60,34,45,0.2);
INSERT INTO Order_Details2783 VALUES(10847,71,21.5,55,0.2);
INSERT INTO Order_Details2783 VALUES(10848,5,21.35,30,0);
INSERT INTO Order_Details2783 VALUES(10848,9,97,3,0);
INSERT INTO Order_Details2783 VALUES(10849,3,10,49,0);
INSERT INTO Order_Details2783 VALUES(10849,26,31.23,18,0.15);
INSERT INTO Order_Details2783 VALUES(10850,25,14,20,0.15);
INSERT INTO Order_Details2783 VALUES(10850,33,2.5,4,0.15);
INSERT INTO Order_Details2783 VALUES(10850,70,15,30,0.15);
INSERT INTO Order_Details2783 VALUES(10851,2,19,5,0.05);
INSERT INTO Order_Details2783 VALUES(10851,25,14,10,0.05);
INSERT INTO Order_Details2783 VALUES(10851,57,19.5,10,0.05);
INSERT INTO Order_Details2783 VALUES(10851,59,55,42,0.05);
INSERT INTO Order_Details2783 VALUES(10852,2,19,15,0);
INSERT INTO Order_Details2783 VALUES(10852,17,39,6,0);
INSERT INTO Order_Details2783 VALUES(10852,62,49.3,50,0);
INSERT INTO Order_Details2783 VALUES(10853,18,62.5,10,0);
INSERT INTO Order_Details2783 VALUES(10854,10,31,100,0.15);
INSERT INTO Order_Details2783 VALUES(10854,13,6,65,0.15);
INSERT INTO Order_Details2783 VALUES(10855,16,17.45,50,0);
INSERT INTO Order_Details2783 VALUES(10855,31,12.5,14,0);
INSERT INTO Order_Details2783 VALUES(10855,56,38,24,0);
INSERT INTO Order_Details2783 VALUES(10855,65,21.05,15,0.15);
INSERT INTO Order_Details2783 VALUES(10856,2,19,20,0);
INSERT INTO Order_Details2783 VALUES(10856,42,14,20,0);
INSERT INTO Order_Details2783 VALUES(10857,3,10,30,0);
INSERT INTO Order_Details2783 VALUES(10857,26,31.23,35,0.25);
INSERT INTO Order_Details2783 VALUES(10857,29,123.79,10,0.25);
INSERT INTO Order_Details2783 VALUES(10858,7,30,5,0);
INSERT INTO Order_Details2783 VALUES(10858,27,43.9,10,0);
INSERT INTO Order_Details2783 VALUES(10858,70,15,4,0);
INSERT INTO Order_Details2783 VALUES(10859,24,4.5,40,0.25);
INSERT INTO Order_Details2783 VALUES(10859,54,7.45,35,0.25);
INSERT INTO Order_Details2783 VALUES(10859,64,33.25,30,0.25);
INSERT INTO Order_Details2783 VALUES(10860,51,53,3,0);
INSERT INTO Order_Details2783 VALUES(10860,76,18,20,0);
INSERT INTO Order_Details2783 VALUES(10861,17,39,42,0);
INSERT INTO Order_Details2783 VALUES(10861,18,62.5,20,0);
INSERT INTO Order_Details2783 VALUES(10861,21,10,40,0);
INSERT INTO Order_Details2783 VALUES(10861,33,2.5,35,0);
INSERT INTO Order_Details2783 VALUES(10861,62,49.3,3,0);
INSERT INTO Order_Details2783 VALUES(10862,11,21,25,0);
INSERT INTO Order_Details2783 VALUES(10862,52,7,8,0);
INSERT INTO Order_Details2783 VALUES(10863,1,18,20,0.15);
INSERT INTO Order_Details2783 VALUES(10863,58,13.25,12,0.15);
INSERT INTO Order_Details2783 VALUES(10864,35,18,4,0);
INSERT INTO Order_Details2783 VALUES(10864,67,14,15,0);
INSERT INTO Order_Details2783 VALUES(10865,38,263.5,60,0.05);
INSERT INTO Order_Details2783 VALUES(10865,39,18,80,0.05);
INSERT INTO Order_Details2783 VALUES(10866,2,19,21,0.25);
INSERT INTO Order_Details2783 VALUES(10866,24,4.5,6,0.25);
INSERT INTO Order_Details2783 VALUES(10866,30,25.89,40,0.25);
INSERT INTO Order_Details2783 VALUES(10867,53,32.8,3,0);
INSERT INTO Order_Details2783 VALUES(10868,26,31.23,20,0);
INSERT INTO Order_Details2783 VALUES(10868,35,18,30,0);
INSERT INTO Order_Details2783 VALUES(10868,49,20,42,0.1);
INSERT INTO Order_Details2783 VALUES(10869,1,18,40,0);
INSERT INTO Order_Details2783 VALUES(10869,11,21,10,0);
INSERT INTO Order_Details2783 VALUES(10869,23,9,50,0);
INSERT INTO Order_Details2783 VALUES(10869,68,12.5,20,0);
INSERT INTO Order_Details2783 VALUES(10870,35,18,3,0);
INSERT INTO Order_Details2783 VALUES(10870,51,53,2,0);
INSERT INTO Order_Details2783 VALUES(10871,6,25,50,0.05);
INSERT INTO Order_Details2783 VALUES(10871,16,17.45,12,0.05);
INSERT INTO Order_Details2783 VALUES(10871,17,39,16,0.05);
INSERT INTO Order_Details2783 VALUES(10872,55,24,10,0.05);
INSERT INTO Order_Details2783 VALUES(10872,62,49.3,20,0.05);
INSERT INTO Order_Details2783 VALUES(10872,64,33.25,15,0.05);
INSERT INTO Order_Details2783 VALUES(10872,65,21.05,21,0.05);
INSERT INTO Order_Details2783 VALUES(10873,21,10,20,0);
INSERT INTO Order_Details2783 VALUES(10873,28,45.6,3,0);
INSERT INTO Order_Details2783 VALUES(10874,10,31,10,0);
INSERT INTO Order_Details2783 VALUES(10875,19,9.2,25,0);
INSERT INTO Order_Details2783 VALUES(10875,47,9.5,21,0.1);
INSERT INTO Order_Details2783 VALUES(10875,49,20,15,0);
INSERT INTO Order_Details2783 VALUES(10876,46,12,21,0);
INSERT INTO Order_Details2783 VALUES(10876,64,33.25,20,0);
INSERT INTO Order_Details2783 VALUES(10877,16,17.45,30,0.25);
INSERT INTO Order_Details2783 VALUES(10877,18,62.5,25,0);
INSERT INTO Order_Details2783 VALUES(10878,20,81,20,0.05);
INSERT INTO Order_Details2783 VALUES(10879,40,18.4,12,0);
INSERT INTO Order_Details2783 VALUES(10879,65,21.05,10,0);
INSERT INTO Order_Details2783 VALUES(10879,76,18,10,0);
INSERT INTO Order_Details2783 VALUES(10880,23,9,30,0.2);
INSERT INTO Order_Details2783 VALUES(10880,61,28.5,30,0.2);
INSERT INTO Order_Details2783 VALUES(10880,70,15,50,0.2);
INSERT INTO Order_Details2783 VALUES(10881,73,15,10,0);
INSERT INTO Order_Details2783 VALUES(10882,42,14,25,0);
INSERT INTO Order_Details2783 VALUES(10882,49,20,20,0.15);
INSERT INTO Order_Details2783 VALUES(10882,54,7.45,32,0.15);
INSERT INTO Order_Details2783 VALUES(10883,24,4.5,8,0);
INSERT INTO Order_Details2783 VALUES(10884,21,10,40,0.05);
INSERT INTO Order_Details2783 VALUES(10884,56,38,21,0.05);
INSERT INTO Order_Details2783 VALUES(10884,65,21.05,12,0.05);
INSERT INTO Order_Details2783 VALUES(10885,2,19,20,0);
INSERT INTO Order_Details2783 VALUES(10885,24,4.5,12,0);
INSERT INTO Order_Details2783 VALUES(10885,70,15,30,0);
INSERT INTO Order_Details2783 VALUES(10885,77,13,25,0);
INSERT INTO Order_Details2783 VALUES(10886,10,31,70,0);
INSERT INTO Order_Details2783 VALUES(10886,31,12.5,35,0);
INSERT INTO Order_Details2783 VALUES(10886,77,13,40,0);
INSERT INTO Order_Details2783 VALUES(10887,25,14,5,0);
INSERT INTO Order_Details2783 VALUES(10888,2,19,20,0);
INSERT INTO Order_Details2783 VALUES(10888,68,12.5,18,0);
INSERT INTO Order_Details2783 VALUES(10889,11,21,40,0);
INSERT INTO Order_Details2783 VALUES(10889,38,263.5,40,0);
INSERT INTO Order_Details2783 VALUES(10890,17,39,15,0);
INSERT INTO Order_Details2783 VALUES(10890,34,14,10,0);
INSERT INTO Order_Details2783 VALUES(10890,41,9.65,14,0);
INSERT INTO Order_Details2783 VALUES(10891,30,25.89,15,0.05);
INSERT INTO Order_Details2783 VALUES(10892,59,55,40,0.05);
INSERT INTO Order_Details2783 VALUES(10893,8,40,30,0);
INSERT INTO Order_Details2783 VALUES(10893,24,4.5,10,0);
INSERT INTO Order_Details2783 VALUES(10893,29,123.79,24,0);
INSERT INTO Order_Details2783 VALUES(10893,30,25.89,35,0);
INSERT INTO Order_Details2783 VALUES(10893,36,19,20,0);
INSERT INTO Order_Details2783 VALUES(10894,13,6,28,0.05);
INSERT INTO Order_Details2783 VALUES(10894,69,36,50,0.05);
INSERT INTO Order_Details2783 VALUES(10894,75,7.75,120,0.05);
INSERT INTO Order_Details2783 VALUES(10895,24,4.5,110,0);
INSERT INTO Order_Details2783 VALUES(10895,39,18,45,0);
INSERT INTO Order_Details2783 VALUES(10895,40,18.4,91,0);
INSERT INTO Order_Details2783 VALUES(10895,60,34,100,0);
INSERT INTO Order_Details2783 VALUES(10896,45,9.5,15,0);
INSERT INTO Order_Details2783 VALUES(10896,56,38,16,0);
INSERT INTO Order_Details2783 VALUES(10897,29,123.79,80,0);
INSERT INTO Order_Details2783 VALUES(10897,30,25.89,36,0);
INSERT INTO Order_Details2783 VALUES(10898,13,6,5,0);
INSERT INTO Order_Details2783 VALUES(10899,39,18,8,0.15);
INSERT INTO Order_Details2783 VALUES(10900,70,15,3,0.25);
INSERT INTO Order_Details2783 VALUES(10901,41,9.65,30,0);
INSERT INTO Order_Details2783 VALUES(10901,71,21.5,30,0);
INSERT INTO Order_Details2783 VALUES(10902,55,24,30,0.15);
INSERT INTO Order_Details2783 VALUES(10902,62,49.3,6,0.15);
INSERT INTO Order_Details2783 VALUES(10903,13,6,40,0);
INSERT INTO Order_Details2783 VALUES(10903,65,21.05,21,0);
INSERT INTO Order_Details2783 VALUES(10903,68,12.5,20,0);
INSERT INTO Order_Details2783 VALUES(10904,58,13.25,15,0);
INSERT INTO Order_Details2783 VALUES(10904,62,49.3,35,0);
INSERT INTO Order_Details2783 VALUES(10905,1,18,20,0.05);
INSERT INTO Order_Details2783 VALUES(10906,61,28.5,15,0);
INSERT INTO Order_Details2783 VALUES(10907,75,7.75,14,0);
INSERT INTO Order_Details2783 VALUES(10908,7,30,20,0.05);
INSERT INTO Order_Details2783 VALUES(10908,52,7,14,0.05);
INSERT INTO Order_Details2783 VALUES(10909,7,30,12,0);
INSERT INTO Order_Details2783 VALUES(10909,16,17.45,15,0);
INSERT INTO Order_Details2783 VALUES(10909,41,9.65,5,0);
INSERT INTO Order_Details2783 VALUES(10910,19,9.2,12,0);
INSERT INTO Order_Details2783 VALUES(10910,49,20,10,0);
INSERT INTO Order_Details2783 VALUES(10910,61,28.5,5,0);
INSERT INTO Order_Details2783 VALUES(10911,1,18,10,0);
INSERT INTO Order_Details2783 VALUES(10911,17,39,12,0);
INSERT INTO Order_Details2783 VALUES(10911,67,14,15,0);
INSERT INTO Order_Details2783 VALUES(10912,11,21,40,0.25);
INSERT INTO Order_Details2783 VALUES(10912,29,123.79,60,0.25);
INSERT INTO Order_Details2783 VALUES(10913,4,22,30,0.25);
INSERT INTO Order_Details2783 VALUES(10913,33,2.5,40,0.25);
INSERT INTO Order_Details2783 VALUES(10913,58,13.25,15,0);
INSERT INTO Order_Details2783 VALUES(10914,71,21.5,25,0);
INSERT INTO Order_Details2783 VALUES(10915,17,39,10,0);
INSERT INTO Order_Details2783 VALUES(10915,33,2.5,30,0);
INSERT INTO Order_Details2783 VALUES(10915,54,7.45,10,0);
INSERT INTO Order_Details2783 VALUES(10916,16,17.45,6,0);
INSERT INTO Order_Details2783 VALUES(10916,32,32,6,0);
INSERT INTO Order_Details2783 VALUES(10916,57,19.5,20,0);
INSERT INTO Order_Details2783 VALUES(10917,30,25.89,1,0);
INSERT INTO Order_Details2783 VALUES(10917,60,34,10,0);
INSERT INTO Order_Details2783 VALUES(10918,1,18,60,0.25);
INSERT INTO Order_Details2783 VALUES(10918,60,34,25,0.25);
INSERT INTO Order_Details2783 VALUES(10919,16,17.45,24,0);
INSERT INTO Order_Details2783 VALUES(10919,25,14,24,0);
INSERT INTO Order_Details2783 VALUES(10919,40,18.4,20,0);
INSERT INTO Order_Details2783 VALUES(10920,50,16.25,24,0);
INSERT INTO Order_Details2783 VALUES(10921,35,18,10,0);
INSERT INTO Order_Details2783 VALUES(10921,63,43.9,40,0);
INSERT INTO Order_Details2783 VALUES(10922,17,39,15,0);
INSERT INTO Order_Details2783 VALUES(10922,24,4.5,35,0);
INSERT INTO Order_Details2783 VALUES(10923,42,14,10,0.2);
INSERT INTO Order_Details2783 VALUES(10923,43,46,10,0.2);
INSERT INTO Order_Details2783 VALUES(10923,67,14,24,0.2);
INSERT INTO Order_Details2783 VALUES(10924,10,31,20,0.1);
INSERT INTO Order_Details2783 VALUES(10924,28,45.6,30,0.1);
INSERT INTO Order_Details2783 VALUES(10924,75,7.75,6,0);
INSERT INTO Order_Details2783 VALUES(10925,36,19,25,0.15);
INSERT INTO Order_Details2783 VALUES(10925,52,7,12,0.15);
INSERT INTO Order_Details2783 VALUES(10926,11,21,2,0);
INSERT INTO Order_Details2783 VALUES(10926,13,6,10,0);
INSERT INTO Order_Details2783 VALUES(10926,19,9.2,7,0);
INSERT INTO Order_Details2783 VALUES(10926,72,34.8,10,0);
INSERT INTO Order_Details2783 VALUES(10927,20,81,5,0);
INSERT INTO Order_Details2783 VALUES(10927,52,7,5,0);
INSERT INTO Order_Details2783 VALUES(10927,76,18,20,0);
INSERT INTO Order_Details2783 VALUES(10928,47,9.5,5,0);
INSERT INTO Order_Details2783 VALUES(10928,76,18,5,0);
INSERT INTO Order_Details2783 VALUES(10929,21,10,60,0);
INSERT INTO Order_Details2783 VALUES(10929,75,7.75,49,0);
INSERT INTO Order_Details2783 VALUES(10929,77,13,15,0);
INSERT INTO Order_Details2783 VALUES(10930,21,10,36,0);
INSERT INTO Order_Details2783 VALUES(10930,27,43.9,25,0);
INSERT INTO Order_Details2783 VALUES(10930,55,24,25,0.2);
INSERT INTO Order_Details2783 VALUES(10930,58,13.25,30,0.2);
INSERT INTO Order_Details2783 VALUES(10931,13,6,42,0.15);
INSERT INTO Order_Details2783 VALUES(10931,57,19.5,30,0);
INSERT INTO Order_Details2783 VALUES(10932,16,17.45,30,0.1);
INSERT INTO Order_Details2783 VALUES(10932,62,49.3,14,0.1);
INSERT INTO Order_Details2783 VALUES(10932,72,34.8,16,0);
INSERT INTO Order_Details2783 VALUES(10932,75,7.75,20,0.1);
INSERT INTO Order_Details2783 VALUES(10933,53,32.8,2,0);
INSERT INTO Order_Details2783 VALUES(10933,61,28.5,30,0);
INSERT INTO Order_Details2783 VALUES(10934,6,25,20,0);
INSERT INTO Order_Details2783 VALUES(10935,1,18,21,0);
INSERT INTO Order_Details2783 VALUES(10935,18,62.5,4,0.25);
INSERT INTO Order_Details2783 VALUES(10935,23,9,8,0.25);
INSERT INTO Order_Details2783 VALUES(10936,36,19,30,0.2);
INSERT INTO Order_Details2783 VALUES(10937,28,45.6,8,0);
INSERT INTO Order_Details2783 VALUES(10937,34,14,20,0);
INSERT INTO Order_Details2783 VALUES(10938,13,6,20,0.25);
INSERT INTO Order_Details2783 VALUES(10938,43,46,24,0.25);
INSERT INTO Order_Details2783 VALUES(10938,60,34,49,0.25);
INSERT INTO Order_Details2783 VALUES(10938,71,21.5,35,0.25);
INSERT INTO Order_Details2783 VALUES(10939,2,19,10,0.15);
INSERT INTO Order_Details2783 VALUES(10939,67,14,40,0.15);
INSERT INTO Order_Details2783 VALUES(10940,7,30,8,0);
INSERT INTO Order_Details2783 VALUES(10940,13,6,20,0);
INSERT INTO Order_Details2783 VALUES(10941,31,12.5,44,0.25);
INSERT INTO Order_Details2783 VALUES(10941,62,49.3,30,0.25);
INSERT INTO Order_Details2783 VALUES(10941,68,12.5,80,0.25);
INSERT INTO Order_Details2783 VALUES(10941,72,34.8,50,0);
INSERT INTO Order_Details2783 VALUES(10942,49,20,28,0);
INSERT INTO Order_Details2783 VALUES(10943,13,6,15,0);
INSERT INTO Order_Details2783 VALUES(10943,22,21,21,0);
INSERT INTO Order_Details2783 VALUES(10943,46,12,15,0);
INSERT INTO Order_Details2783 VALUES(10944,11,21,5,0.25);
INSERT INTO Order_Details2783 VALUES(10944,44,19.45,18,0.25);
INSERT INTO Order_Details2783 VALUES(10944,56,38,18,0);
INSERT INTO Order_Details2783 VALUES(10945,13,6,20,0);
INSERT INTO Order_Details2783 VALUES(10945,31,12.5,10,0);
INSERT INTO Order_Details2783 VALUES(10946,10,31,25,0);
INSERT INTO Order_Details2783 VALUES(10946,24,4.5,25,0);
INSERT INTO Order_Details2783 VALUES(10946,77,13,40,0);
INSERT INTO Order_Details2783 VALUES(10947,59,55,4,0);
INSERT INTO Order_Details2783 VALUES(10948,50,16.25,9,0);
INSERT INTO Order_Details2783 VALUES(10948,51,53,40,0);
INSERT INTO Order_Details2783 VALUES(10948,55,24,4,0);
INSERT INTO Order_Details2783 VALUES(10949,6,25,12,0);
INSERT INTO Order_Details2783 VALUES(10949,10,31,30,0);
INSERT INTO Order_Details2783 VALUES(10949,17,39,6,0);
INSERT INTO Order_Details2783 VALUES(10949,62,49.3,60,0);
INSERT INTO Order_Details2783 VALUES(10950,4,22,5,0);
INSERT INTO Order_Details2783 VALUES(10951,33,2.5,15,0.05);
INSERT INTO Order_Details2783 VALUES(10951,41,9.65,6,0.05);
INSERT INTO Order_Details2783 VALUES(10951,75,7.75,50,0.05);
INSERT INTO Order_Details2783 VALUES(10952,6,25,16,0.05);
INSERT INTO Order_Details2783 VALUES(10952,28,45.6,2,0);
INSERT INTO Order_Details2783 VALUES(10953,20,81,50,0.05);
INSERT INTO Order_Details2783 VALUES(10953,31,12.5,50,0.05);
INSERT INTO Order_Details2783 VALUES(10954,16,17.45,28,0.15);
INSERT INTO Order_Details2783 VALUES(10954,31,12.5,25,0.15);
INSERT INTO Order_Details2783 VALUES(10954,45,9.5,30,0);
INSERT INTO Order_Details2783 VALUES(10954,60,34,24,0.15);
INSERT INTO Order_Details2783 VALUES(10955,75,7.75,12,0.2);
INSERT INTO Order_Details2783 VALUES(10956,21,10,12,0);
INSERT INTO Order_Details2783 VALUES(10956,47,9.5,14,0);
INSERT INTO Order_Details2783 VALUES(10956,51,53,8,0);
INSERT INTO Order_Details2783 VALUES(10957,30,25.89,30,0);
INSERT INTO Order_Details2783 VALUES(10957,35,18,40,0);
INSERT INTO Order_Details2783 VALUES(10957,64,33.25,8,0);
INSERT INTO Order_Details2783 VALUES(10958,5,21.35,20,0);
INSERT INTO Order_Details2783 VALUES(10958,7,30,6,0);
INSERT INTO Order_Details2783 VALUES(10958,72,34.8,5,0);
INSERT INTO Order_Details2783 VALUES(10959,75,7.75,20,0.15);
INSERT INTO Order_Details2783 VALUES(10960,24,4.5,10,0.25);
INSERT INTO Order_Details2783 VALUES(10960,41,9.65,24,0);
INSERT INTO Order_Details2783 VALUES(10961,52,7,6,0.05);
INSERT INTO Order_Details2783 VALUES(10961,76,18,60,0);
INSERT INTO Order_Details2783 VALUES(10962,7,30,45,0);
INSERT INTO Order_Details2783 VALUES(10962,13,6,77,0);
INSERT INTO Order_Details2783 VALUES(10962,53,32.8,20,0);
INSERT INTO Order_Details2783 VALUES(10962,69,36,9,0);
INSERT INTO Order_Details2783 VALUES(10962,76,18,44,0);
INSERT INTO Order_Details2783 VALUES(10963,60,34,2,0.15);
INSERT INTO Order_Details2783 VALUES(10964,18,62.5,6,0);
INSERT INTO Order_Details2783 VALUES(10964,38,263.5,5,0);
INSERT INTO Order_Details2783 VALUES(10964,69,36,10,0);
INSERT INTO Order_Details2783 VALUES(10965,51,53,16,0);
INSERT INTO Order_Details2783 VALUES(10966,37,26,8,0);
INSERT INTO Order_Details2783 VALUES(10966,56,38,12,0.15);
INSERT INTO Order_Details2783 VALUES(10966,62,49.3,12,0.15);
INSERT INTO Order_Details2783 VALUES(10967,19,9.2,12,0);
INSERT INTO Order_Details2783 VALUES(10967,49,20,40,0);
INSERT INTO Order_Details2783 VALUES(10968,12,38,30,0);
INSERT INTO Order_Details2783 VALUES(10968,24,4.5,30,0);
INSERT INTO Order_Details2783 VALUES(10968,64,33.25,4,0);
INSERT INTO Order_Details2783 VALUES(10969,46,12,9,0);
INSERT INTO Order_Details2783 VALUES(10970,52,7,40,0.2);
INSERT INTO Order_Details2783 VALUES(10971,29,123.79,14,0);
INSERT INTO Order_Details2783 VALUES(10972,17,39,6,0);
INSERT INTO Order_Details2783 VALUES(10972,33,2.5,7,0);
INSERT INTO Order_Details2783 VALUES(10973,26,31.23,5,0);
INSERT INTO Order_Details2783 VALUES(10973,41,9.65,6,0);
INSERT INTO Order_Details2783 VALUES(10973,75,7.75,10,0);
INSERT INTO Order_Details2783 VALUES(10974,63,43.9,10,0);
INSERT INTO Order_Details2783 VALUES(10975,8,40,16,0);
INSERT INTO Order_Details2783 VALUES(10975,75,7.75,10,0);
INSERT INTO Order_Details2783 VALUES(10976,28,45.6,20,0);
INSERT INTO Order_Details2783 VALUES(10977,39,18,30,0);
INSERT INTO Order_Details2783 VALUES(10977,47,9.5,30,0);
INSERT INTO Order_Details2783 VALUES(10977,51,53,10,0);
INSERT INTO Order_Details2783 VALUES(10977,63,43.9,20,0);
INSERT INTO Order_Details2783 VALUES(10978,8,40,20,0.15);
INSERT INTO Order_Details2783 VALUES(10978,21,10,40,0.15);
INSERT INTO Order_Details2783 VALUES(10978,40,18.4,10,0);
INSERT INTO Order_Details2783 VALUES(10978,44,19.45,6,0.15);
INSERT INTO Order_Details2783 VALUES(10979,7,30,18,0);
INSERT INTO Order_Details2783 VALUES(10979,12,38,20,0);
INSERT INTO Order_Details2783 VALUES(10979,24,4.5,80,0);
INSERT INTO Order_Details2783 VALUES(10979,27,43.9,30,0);
INSERT INTO Order_Details2783 VALUES(10979,31,12.5,24,0);
INSERT INTO Order_Details2783 VALUES(10979,63,43.9,35,0);
INSERT INTO Order_Details2783 VALUES(10980,75,7.75,40,0.2);
INSERT INTO Order_Details2783 VALUES(10981,38,263.5,60,0);
INSERT INTO Order_Details2783 VALUES(10982,7,30,20,0);
INSERT INTO Order_Details2783 VALUES(10982,43,46,9,0);
INSERT INTO Order_Details2783 VALUES(10983,13,6,84,0.15);
INSERT INTO Order_Details2783 VALUES(10983,57,19.5,15,0);
INSERT INTO Order_Details2783 VALUES(10984,16,17.45,55,0);
INSERT INTO Order_Details2783 VALUES(10984,24,4.5,20,0);
INSERT INTO Order_Details2783 VALUES(10984,36,19,40,0);
INSERT INTO Order_Details2783 VALUES(10985,16,17.45,36,0.1);
INSERT INTO Order_Details2783 VALUES(10985,18,62.5,8,0.1);
INSERT INTO Order_Details2783 VALUES(10985,32,32,35,0.1);
INSERT INTO Order_Details2783 VALUES(10986,11,21,30,0);
INSERT INTO Order_Details2783 VALUES(10986,20,81,15,0);
INSERT INTO Order_Details2783 VALUES(10986,76,18,10,0);
INSERT INTO Order_Details2783 VALUES(10986,77,13,15,0);
INSERT INTO Order_Details2783 VALUES(10987,7,30,60,0);
INSERT INTO Order_Details2783 VALUES(10987,43,46,6,0);
INSERT INTO Order_Details2783 VALUES(10987,72,34.8,20,0);
INSERT INTO Order_Details2783 VALUES(10988,7,30,60,0);
INSERT INTO Order_Details2783 VALUES(10988,62,49.3,40,0.1);
INSERT INTO Order_Details2783 VALUES(10989,6,25,40,0);
INSERT INTO Order_Details2783 VALUES(10989,11,21,15,0);
INSERT INTO Order_Details2783 VALUES(10989,41,9.65,4,0);
INSERT INTO Order_Details2783 VALUES(10990,21,10,65,0);
INSERT INTO Order_Details2783 VALUES(10990,34,14,60,0.15);
INSERT INTO Order_Details2783 VALUES(10990,55,24,65,0.15);
INSERT INTO Order_Details2783 VALUES(10990,61,28.5,66,0.15);
INSERT INTO Order_Details2783 VALUES(10991,2,19,50,0.2);
INSERT INTO Order_Details2783 VALUES(10991,70,15,20,0.2);
INSERT INTO Order_Details2783 VALUES(10991,76,18,90,0.2);
INSERT INTO Order_Details2783 VALUES(10992,72,34.8,2,0);
INSERT INTO Order_Details2783 VALUES(10993,29,123.79,50,0.25);
INSERT INTO Order_Details2783 VALUES(10993,41,9.65,35,0.25);
INSERT INTO Order_Details2783 VALUES(10994,59,55,18,0.05);
INSERT INTO Order_Details2783 VALUES(10995,51,53,20,0);
INSERT INTO Order_Details2783 VALUES(10995,60,34,4,0);
INSERT INTO Order_Details2783 VALUES(10996,42,14,40,0);
INSERT INTO Order_Details2783 VALUES(10997,32,32,50,0);
INSERT INTO Order_Details2783 VALUES(10997,46,12,20,0.25);
INSERT INTO Order_Details2783 VALUES(10997,52,7,20,0.25);
INSERT INTO Order_Details2783 VALUES(10998,24,4.5,12,0);
INSERT INTO Order_Details2783 VALUES(10998,61,28.5,7,0);
INSERT INTO Order_Details2783 VALUES(10998,74,10,20,0);
INSERT INTO Order_Details2783 VALUES(10998,75,7.75,30,0);
INSERT INTO Order_Details2783 VALUES(10999,41,9.65,20,0.05);
INSERT INTO Order_Details2783 VALUES(10999,51,53,15,0.05);
INSERT INTO Order_Details2783 VALUES(10999,77,13,21,0.05);
INSERT INTO Order_Details2783 VALUES(11000,4,22,25,0.25);
INSERT INTO Order_Details2783 VALUES(11000,24,4.5,30,0.25);
INSERT INTO Order_Details2783 VALUES(11000,77,13,30,0);
INSERT INTO Order_Details2783 VALUES(11001,7,30,60,0);
INSERT INTO Order_Details2783 VALUES(11001,22,21,25,0);
INSERT INTO Order_Details2783 VALUES(11001,46,12,25,0);
INSERT INTO Order_Details2783 VALUES(11001,55,24,6,0);
INSERT INTO Order_Details2783 VALUES(11002,13,6,56,0);
INSERT INTO Order_Details2783 VALUES(11002,35,18,15,0.15);
INSERT INTO Order_Details2783 VALUES(11002,42,14,24,0.15);
INSERT INTO Order_Details2783 VALUES(11002,55,24,40,0);
INSERT INTO Order_Details2783 VALUES(11003,1,18,4,0);
INSERT INTO Order_Details2783 VALUES(11003,40,18.4,10,0);
INSERT INTO Order_Details2783 VALUES(11003,52,7,10,0);
INSERT INTO Order_Details2783 VALUES(11004,26,31.23,6,0);
INSERT INTO Order_Details2783 VALUES(11004,76,18,6,0);
INSERT INTO Order_Details2783 VALUES(11005,1,18,2,0);
INSERT INTO Order_Details2783 VALUES(11005,59,55,10,0);
INSERT INTO Order_Details2783 VALUES(11006,1,18,8,0);
INSERT INTO Order_Details2783 VALUES(11006,29,123.79,2,0.25);
INSERT INTO Order_Details2783 VALUES(11007,8,40,30,0);
INSERT INTO Order_Details2783 VALUES(11007,29,123.79,10,0);
INSERT INTO Order_Details2783 VALUES(11007,42,14,14,0);
INSERT INTO Order_Details2783 VALUES(11008,28,45.6,70,0.05);
INSERT INTO Order_Details2783 VALUES(11008,34,14,90,0.05);
INSERT INTO Order_Details2783 VALUES(11008,71,21.5,21,0);
INSERT INTO Order_Details2783 VALUES(11009,24,4.5,12,0);
INSERT INTO Order_Details2783 VALUES(11009,36,19,18,0.25);
INSERT INTO Order_Details2783 VALUES(11009,60,34,9,0);
INSERT INTO Order_Details2783 VALUES(11010,7,30,20,0);
INSERT INTO Order_Details2783 VALUES(11010,24,4.5,10,0);
INSERT INTO Order_Details2783 VALUES(11011,58,13.25,40,0.05);
INSERT INTO Order_Details2783 VALUES(11011,71,21.5,20,0);
INSERT INTO Order_Details2783 VALUES(11012,19,9.2,50,0.05);
INSERT INTO Order_Details2783 VALUES(11012,60,34,36,0.05);
INSERT INTO Order_Details2783 VALUES(11012,71,21.5,60,0.05);
INSERT INTO Order_Details2783 VALUES(11013,23,9,10,0);
INSERT INTO Order_Details2783 VALUES(11013,42,14,4,0);
INSERT INTO Order_Details2783 VALUES(11013,45,9.5,20,0);
INSERT INTO Order_Details2783 VALUES(11013,68,12.5,2,0);
INSERT INTO Order_Details2783 VALUES(11014,41,9.65,28,0.1);
INSERT INTO Order_Details2783 VALUES(11015,30,25.89,15,0);
INSERT INTO Order_Details2783 VALUES(11015,77,13,18,0);
INSERT INTO Order_Details2783 VALUES(11016,31,12.5,15,0);
INSERT INTO Order_Details2783 VALUES(11016,36,19,16,0);
INSERT INTO Order_Details2783 VALUES(11017,3,10,25,0);
INSERT INTO Order_Details2783 VALUES(11017,59,55,110,0);
INSERT INTO Order_Details2783 VALUES(11017,70,15,30,0);
INSERT INTO Order_Details2783 VALUES(11018,12,38,20,0);
INSERT INTO Order_Details2783 VALUES(11018,18,62.5,10,0);
INSERT INTO Order_Details2783 VALUES(11018,56,38,5,0);
INSERT INTO Order_Details2783 VALUES(11019,46,12,3,0);
INSERT INTO Order_Details2783 VALUES(11019,49,20,2,0);
INSERT INTO Order_Details2783 VALUES(11020,10,31,24,0.15);
INSERT INTO Order_Details2783 VALUES(11021,2,19,11,0.25);
INSERT INTO Order_Details2783 VALUES(11021,20,81,15,0);
INSERT INTO Order_Details2783 VALUES(11021,26,31.23,63,0);
INSERT INTO Order_Details2783 VALUES(11021,51,53,44,0.25);
INSERT INTO Order_Details2783 VALUES(11021,72,34.8,35,0);
INSERT INTO Order_Details2783 VALUES(11022,19,9.2,35,0);
INSERT INTO Order_Details2783 VALUES(11022,69,36,30,0);
INSERT INTO Order_Details2783 VALUES(11023,7,30,4,0);
INSERT INTO Order_Details2783 VALUES(11023,43,46,30,0);
INSERT INTO Order_Details2783 VALUES(11024,26,31.23,12,0);
INSERT INTO Order_Details2783 VALUES(11024,33,2.5,30,0);
INSERT INTO Order_Details2783 VALUES(11024,65,21.05,21,0);
INSERT INTO Order_Details2783 VALUES(11024,71,21.5,50,0);
INSERT INTO Order_Details2783 VALUES(11025,1,18,10,0.1);
INSERT INTO Order_Details2783 VALUES(11025,13,6,20,0.1);
INSERT INTO Order_Details2783 VALUES(11026,18,62.5,8,0);
INSERT INTO Order_Details2783 VALUES(11026,51,53,10,0);
INSERT INTO Order_Details2783 VALUES(11027,24,4.5,30,0.25);
INSERT INTO Order_Details2783 VALUES(11027,62,49.3,21,0.25);
INSERT INTO Order_Details2783 VALUES(11028,55,24,35,0);
INSERT INTO Order_Details2783 VALUES(11028,59,55,24,0);
INSERT INTO Order_Details2783 VALUES(11029,56,38,20,0);
INSERT INTO Order_Details2783 VALUES(11029,63,43.9,12,0);
INSERT INTO Order_Details2783 VALUES(11030,2,19,100,0.25);
INSERT INTO Order_Details2783 VALUES(11030,5,21.35,70,0);
INSERT INTO Order_Details2783 VALUES(11030,29,123.79,60,0.25);
INSERT INTO Order_Details2783 VALUES(11030,59,55,100,0.25);
INSERT INTO Order_Details2783 VALUES(11031,1,18,45,0);
INSERT INTO Order_Details2783 VALUES(11031,13,6,80,0);
INSERT INTO Order_Details2783 VALUES(11031,24,4.5,21,0);
INSERT INTO Order_Details2783 VALUES(11031,64,33.25,20,0);
INSERT INTO Order_Details2783 VALUES(11031,71,21.5,16,0);
INSERT INTO Order_Details2783 VALUES(11032,36,19,35,0);
INSERT INTO Order_Details2783 VALUES(11032,38,263.5,25,0);
INSERT INTO Order_Details2783 VALUES(11032,59,55,30,0);
INSERT INTO Order_Details2783 VALUES(11033,53,32.8,70,0.1);
INSERT INTO Order_Details2783 VALUES(11033,69,36,36,0.1);
INSERT INTO Order_Details2783 VALUES(11034,21,10,15,0.1);
INSERT INTO Order_Details2783 VALUES(11034,44,19.45,12,0);
INSERT INTO Order_Details2783 VALUES(11034,61,28.5,6,0);
INSERT INTO Order_Details2783 VALUES(11035,1,18,10,0);
INSERT INTO Order_Details2783 VALUES(11035,35,18,60,0);
INSERT INTO Order_Details2783 VALUES(11035,42,14,30,0);
INSERT INTO Order_Details2783 VALUES(11035,54,7.45,10,0);
INSERT INTO Order_Details2783 VALUES(11036,13,6,7,0);
INSERT INTO Order_Details2783 VALUES(11036,59,55,30,0);
INSERT INTO Order_Details2783 VALUES(11037,70,15,4,0);
INSERT INTO Order_Details2783 VALUES(11038,40,18.4,5,0.2);
INSERT INTO Order_Details2783 VALUES(11038,52,7,2,0);
INSERT INTO Order_Details2783 VALUES(11038,71,21.5,30,0);
INSERT INTO Order_Details2783 VALUES(11039,28,45.6,20,0);
INSERT INTO Order_Details2783 VALUES(11039,35,18,24,0);
INSERT INTO Order_Details2783 VALUES(11039,49,20,60,0);
INSERT INTO Order_Details2783 VALUES(11039,57,19.5,28,0);
INSERT INTO Order_Details2783 VALUES(11040,21,10,20,0);
INSERT INTO Order_Details2783 VALUES(11041,2,19,30,0.2);
INSERT INTO Order_Details2783 VALUES(11041,63,43.9,30,0);
INSERT INTO Order_Details2783 VALUES(11042,44,19.45,15,0);
INSERT INTO Order_Details2783 VALUES(11042,61,28.5,4,0);
INSERT INTO Order_Details2783 VALUES(11043,11,21,10,0);
INSERT INTO Order_Details2783 VALUES(11044,62,49.3,12,0);
INSERT INTO Order_Details2783 VALUES(11045,33,2.5,15,0);
INSERT INTO Order_Details2783 VALUES(11045,51,53,24,0);
INSERT INTO Order_Details2783 VALUES(11046,12,38,20,0.05);
INSERT INTO Order_Details2783 VALUES(11046,32,32,15,0.05);
INSERT INTO Order_Details2783 VALUES(11046,35,18,18,0.05);
INSERT INTO Order_Details2783 VALUES(11047,1,18,25,0.25);
INSERT INTO Order_Details2783 VALUES(11047,5,21.35,30,0.25);
INSERT INTO Order_Details2783 VALUES(11048,68,12.5,42,0);
INSERT INTO Order_Details2783 VALUES(11049,2,19,10,0.2);
INSERT INTO Order_Details2783 VALUES(11049,12,38,4,0.2);
INSERT INTO Order_Details2783 VALUES(11050,76,18,50,0.1);
INSERT INTO Order_Details2783 VALUES(11051,24,4.5,10,0.2);
INSERT INTO Order_Details2783 VALUES(11052,43,46,30,0.2);
INSERT INTO Order_Details2783 VALUES(11052,61,28.5,10,0.2);
INSERT INTO Order_Details2783 VALUES(11053,18,62.5,35,0.2);
INSERT INTO Order_Details2783 VALUES(11053,32,32,20,0);
INSERT INTO Order_Details2783 VALUES(11053,64,33.25,25,0.2);
INSERT INTO Order_Details2783 VALUES(11054,33,2.5,10,0);
INSERT INTO Order_Details2783 VALUES(11054,67,14,20,0);
INSERT INTO Order_Details2783 VALUES(11055,24,4.5,15,0);
INSERT INTO Order_Details2783 VALUES(11055,25,14,15,0);
INSERT INTO Order_Details2783 VALUES(11055,51,53,20,0);
INSERT INTO Order_Details2783 VALUES(11055,57,19.5,20,0);
INSERT INTO Order_Details2783 VALUES(11056,7,30,40,0);
INSERT INTO Order_Details2783 VALUES(11056,55,24,35,0);
INSERT INTO Order_Details2783 VALUES(11056,60,34,50,0);
INSERT INTO Order_Details2783 VALUES(11057,70,15,3,0);
INSERT INTO Order_Details2783 VALUES(11058,21,10,3,0);
INSERT INTO Order_Details2783 VALUES(11058,60,34,21,0);
INSERT INTO Order_Details2783 VALUES(11058,61,28.5,4,0);
INSERT INTO Order_Details2783 VALUES(11059,13,6,30,0);
INSERT INTO Order_Details2783 VALUES(11059,17,39,12,0);
INSERT INTO Order_Details2783 VALUES(11059,60,34,35,0);
INSERT INTO Order_Details2783 VALUES(11060,60,34,4,0);
INSERT INTO Order_Details2783 VALUES(11060,77,13,10,0);
INSERT INTO Order_Details2783 VALUES(11061,60,34,15,0);
INSERT INTO Order_Details2783 VALUES(11062,53,32.8,10,0.2);
INSERT INTO Order_Details2783 VALUES(11062,70,15,12,0.2);
INSERT INTO Order_Details2783 VALUES(11063,34,14,30,0);
INSERT INTO Order_Details2783 VALUES(11063,40,18.4,40,0.1);
INSERT INTO Order_Details2783 VALUES(11063,41,9.65,30,0.1);
INSERT INTO Order_Details2783 VALUES(11064,17,39,77,0.1);
INSERT INTO Order_Details2783 VALUES(11064,41,9.65,12,0);
INSERT INTO Order_Details2783 VALUES(11064,53,32.8,25,0.1);
INSERT INTO Order_Details2783 VALUES(11064,55,24,4,0.1);
INSERT INTO Order_Details2783 VALUES(11064,68,12.5,55,0);
INSERT INTO Order_Details2783 VALUES(11065,30,25.89,4,0.25);
INSERT INTO Order_Details2783 VALUES(11065,54,7.45,20,0.25);
INSERT INTO Order_Details2783 VALUES(11066,16,17.45,3,0);
INSERT INTO Order_Details2783 VALUES(11066,19,9.2,42,0);
INSERT INTO Order_Details2783 VALUES(11066,34,14,35,0);
INSERT INTO Order_Details2783 VALUES(11067,41,9.65,9,0);
INSERT INTO Order_Details2783 VALUES(11068,28,45.6,8,0.15);
INSERT INTO Order_Details2783 VALUES(11068,43,46,36,0.15);
INSERT INTO Order_Details2783 VALUES(11068,77,13,28,0.15);
INSERT INTO Order_Details2783 VALUES(11069,39,18,20,0);
INSERT INTO Order_Details2783 VALUES(11070,1,18,40,0.15);
INSERT INTO Order_Details2783 VALUES(11070,2,19,20,0.15);
INSERT INTO Order_Details2783 VALUES(11070,16,17.45,30,0.15);
INSERT INTO Order_Details2783 VALUES(11070,31,12.5,20,0);
INSERT INTO Order_Details2783 VALUES(11071,7,30,15,0.05);
INSERT INTO Order_Details2783 VALUES(11071,13,6,10,0.05);
INSERT INTO Order_Details2783 VALUES(11072,2,19,8,0);
INSERT INTO Order_Details2783 VALUES(11072,41,9.65,40,0);
INSERT INTO Order_Details2783 VALUES(11072,50,16.25,22,0);
INSERT INTO Order_Details2783 VALUES(11072,64,33.25,130,0);
INSERT INTO Order_Details2783 VALUES(11073,11,21,10,0);
INSERT INTO Order_Details2783 VALUES(11073,24,4.5,20,0);
INSERT INTO Order_Details2783 VALUES(11074,16,17.45,14,0.05);
INSERT INTO Order_Details2783 VALUES(11075,2,19,10,0.15);
INSERT INTO Order_Details2783 VALUES(11075,46,12,30,0.15);
INSERT INTO Order_Details2783 VALUES(11075,76,18,2,0.15);
INSERT INTO Order_Details2783 VALUES(11076,6,25,20,0.25);
INSERT INTO Order_Details2783 VALUES(11076,14,23.25,20,0.25);
INSERT INTO Order_Details2783 VALUES(11076,19,9.2,10,0.25);
INSERT INTO Order_Details2783 VALUES(11077,2,19,24,0.2);
INSERT INTO Order_Details2783 VALUES(11077,3,10,4,0);
INSERT INTO Order_Details2783 VALUES(11077,4,22,1,0);
INSERT INTO Order_Details2783 VALUES(11077,6,25,1,0.02);
INSERT INTO Order_Details2783 VALUES(11077,7,30,1,0.05);
INSERT INTO Order_Details2783 VALUES(11077,8,40,2,0.1);
INSERT INTO Order_Details2783 VALUES(11077,10,31,1,0);
INSERT INTO Order_Details2783 VALUES(11077,12,38,2,0.05);
INSERT INTO Order_Details2783 VALUES(11077,13,6,4,0);
INSERT INTO Order_Details2783 VALUES(11077,14,23.25,1,0.03);
INSERT INTO Order_Details2783 VALUES(11077,16,17.45,2,0.03);
INSERT INTO Order_Details2783 VALUES(11077,20,81,1,0.04);
INSERT INTO Order_Details2783 VALUES(11077,23,9,2,0);
INSERT INTO Order_Details2783 VALUES(11077,32,32,1,0);
INSERT INTO Order_Details2783 VALUES(11077,39,18,2,0.05);
INSERT INTO Order_Details2783 VALUES(11077,41,9.65,3,0);
INSERT INTO Order_Details2783 VALUES(11077,46,12,3,0.02);
INSERT INTO Order_Details2783 VALUES(11077,52,7,2,0);
INSERT INTO Order_Details2783 VALUES(11077,55,24,2,0);
INSERT INTO Order_Details2783 VALUES(11077,60,34,2,0.06);
INSERT INTO Order_Details2783 VALUES(11077,64,33.25,2,0.03);
INSERT INTO Order_Details2783 VALUES(11077,66,17,1,0);
INSERT INTO Order_Details2783 VALUES(11077,73,15,2,0.01);
INSERT INTO Order_Details2783 VALUES(11077,75,7.75,4,0);
INSERT INTO Order_Details2783 VALUES(11077,77,13,2,0);

/* count num of rows from all tables */
SELECT COUNT(*) FROM CATEGORIES2783;
SELECT COUNT(*) FROM CUSTOMERS2783;
SELECT COUNT(*) FROM SHIPPERS2783;
SELECT COUNT(*) FROM SUPPLIERS2783;
SELECT COUNT(*) FROM EMPLOYEES2783;
SELECT COUNT(*) FROM PRODUCTS2783;
SELECT COUNT(*) FROM ORDERS2783;
SELECT COUNT(*) FROM ORDER_DETAILS2783;

/*Question 1*/
select p.productname
from order_details2783 od
inner join orders2783 o
on od.orderid = o.orderid
right outer join products2783 p
on od.productid = p.productid
where customerid is null;

/* Question 2 */
select od.orderid as "Order ID", o.orderdate as "Order Date",p.productname as "Ordered Products"
from order_details2783 od
inner join orders2783 o
on od.orderid = o.orderid
inner join products2783 p
on od.productid = p.productid
where o.shippeddate is null
order by od.orderid asc;

/* Question 3 */
select o.shipcountry as "Country" , count(o.orderid) as "Number of recorded Orders"
from orders2783 o
group by o.shipcountry
order by "Number of recorded Orders" desc;


/* Question 4 */
select o.shipcountry as "Country" , count(o.orderid) as "Number of recorded Orders", count(o.shippeddate) as " Number of Shipped Orders"
from orders2783 o
group by o.shipcountry
order by "Number of recorded Orders" desc;

/* Question 5 */
select o.shipcountry as "Country" , count(o.orderid) as "Number of recorded Orders", count(o.shippeddate) as " Number of Shipped Orders",
case 
    when count(o.shippeddate) != count(o.orderid) then 'Not all Orders have been shipped'
    else 'All orders have been shipped'
    end as Status
from orders2783 o
group by o.shipcountry
order by "Number of recorded Orders" desc;

/* Question 6 */
select p.productname, sum(od.quantity * od.unitprice * (1-od.discount)) as "Total Sales"
from order_details2783 od
inner join products2783 p
on od.productid = p.productid
group by p.productname
order by "Total Sales" desc;

/* Question 7 */
/* ask mr.hamada */
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


/*Question 8 */
/* used concantenation here */
/* ask mr.hamada*/
select s.companyname, s.city, s.country,s.contacttitle ||' - '|| s.contactname as "Contact Person", 'Suppliers' as "User Type"
from suppliers2783 s
union
select c.companyname, c.city, c.country,c.contacttitle ||' - '|| c.contactname as "Contact Person", 'Customers' as "User Type"
from customers2783 c
order by country,"User Type" asc;

/*question 9 */
select e.titleofcourtesy ||' '|| e.firstname ||' '|| e.lastname as "Manager Name",emp.titleofcourtesy ||' '|| emp.firstname ||' '|| emp.lastname as "Employee Name"
from employees2783 e
inner join employees2783 emp
on e.employeeid = emp.reportsto
order by e.titleofcourtesy asc;

/*question 10*/
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

/*Question 11*/

insert into order_details2783 values (12629, 169, 69,69,0);
delete from products2783 where productid = 11;

/*Question 12*/

DROP TABLE DW_ORDERS2783 CASCADE CONSTRAINTS;
DROP TABLE DW_PRODUCTS2783 CASCADE CONSTRAINTS;
DROP TABLE DW_DATE2783 CASCADE CONSTRAINTS;
DROP TABLE DW_CUSTOMERS2783 CASCADE CONSTRAINTS;
DROP TABLE DW_EMPLOYEES2783 CASCADE CONSTRAINTS;


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

/* create date*/
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

select count(*) from DW_customers2783;
select count(*) from DW_Employees2783;
select count(*) from DW_products2783;
select count(*) from DW_orders2783;
select count(*) from DW_date2783;

/* QUestion 13 */
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
add constraint PK_DW_CUSTOMERS2783
primary key (customerid);

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
alter table dw_employees2783
add constraint PK_DW_EMPLOYEES2783
primary key (employeeid);

/* alter DW_PRODUCTS2783 */
alter table dw_products2783
add constraint PK_DW_PRODUCTS2783
primary key (productid);

/* alter DW_ORDERS2783 */
alter table dw_orders2783
drop column OID;

alter table dw_orders2783  
add OID number (10) not null;

alter table dw_orders2783 
add constraint PK_DW_ORDERS2783
primary key (OID);

alter table dw_orders2783 
drop constraint fk_dw_orders2783_customerid;
alter table dw_orders2783
add constraint FK_DW_ORDERS2783_CUSTOMERID
foreign key(customerid) references dw_customers2783(customerid);

alter table dw_orders2783
drop constraint FK_DW_ORDERS2783_EMPLOYEEID;
alter table dw_orders2783
add constraint FK_DW_ORDERS2783_EMPLOYEEID
foreign key(employeeid) references dw_employees2783(employeeid);

alter table dw_orders2783
drop constraint FK_DW_ORDERS2783_PRODUCTID;
alter table dw_orders2783
add constraint FK_DW_ORDERS2783_PRODUCTID
foreign key(productid) references dw_products2783(productid);

alter table dw_orders2783
drop constraint FK_DW_ORDERS2783_ORDERDATE;
alter table dw_orders2783
add constraint FK_DW_ORDERS2783_ORDERDATE
foreign key(orderdate) references dw_date2783(full_date);


/* Question 14 */
/* insert into dw_customers2783 table*/
insert into DW_CUSTOMERS2783
select  c.customerid, c.companyname, c.address, c.city, c.region, c.postalcode, c.country
from customers2783 c;

select count(*) from dw_customers2783;

insert into dw_employees2783
select emp.employeeid, emp.lastname, emp.firstname, emp.address, emp.city, emp.region, emp.postalcode, emp.country, emp.reportsto
from employees2783 emp;

select * from dw_employees2783;

insert into dw_products2783
select p.productid,p.productname,s.supplierid,s.companyname,c.categoryid,c.categoryname,p.quantityperunit,p.unitprice,p.unitsinstock,p.unitsonorder,p.reorderlevel,p.discontinued
from products2783 p
inner join suppliers2783 s
on p.supplierid = s.supplierid
inner join categories2783 c
on p.categoryid = c.categoryid;

select count(*) from products2783;
select count(*) from dw_products2783;

/* question 15*/
drop sequence oid_sequence;

create sequence oid_sequence
minvalue 0
start with 1
increment by 1;

insert into dw_orders2783
select o.customerid, o.employeeid, od.productid, o.orderdate, od.orderid,o.requireddate,o.shippeddate,o.shipvia,o.freight,od.unitprice,od.quantity,od.discount,oid_sequence.nextval
from orders2783 o
inner join order_details2783 od
on o.orderid = od.orderid
where o.shippeddate is not null;

/*question 16*/
/*ask mr.hamada */
select dwd.year, sum(dwo.quantity * dwo.unitprice * (1-dwo.discount)) as "Total Revenues", dwd.quarter
from dw_orders2783 dwo
right outer join dw_date2783 dwd
on dwo.orderdate = dwd.full_date
where dwd.quarter = 1 and (dwd.year = 2015 or dwd.year = 2016)
group by (dwd.year,dwd.quarter);

/*question 17*/
select dwc.companyname as "Company Name",dwc.country,round(sum(dwo.quantity * dwo.unitprice * (1-dwo.discount)),0) as "Total Purchase"
from dw_orders2783 dwo
inner join dw_customers2783 dwc
on dwo.customerid = dwc.customerid
group by (dwc.companyname,dwc.country)
order by dwc.country asc,"Total Purchase" desc;

/*question 18*/
/* ask mr hamada */
/*select dwc.companyname as "Company Name",dwc.country,round(sum(dwo.quantity * dwo.unitprice * (1-dwo.discount)),0) as "Total Purchase",dwd.quarter
from dw_orders2783 dwo
inner join dw_customers2783 dwc
on dwo.customerid = dwc.customerid
inner join dw_date2783 dwd
on dwo.orderdate = dwd.full_date
where (select(sum(dwo.quantity * dwo.unitprice * (1-dwo.discount)))from dw_orders2783 dwo)>10000 and dwd.year = 2017
group by (dwc.companyname,dwc.country,dwd.quarter)
order by dwd.quarter asc,"Total Purchase" desc;

select sum(dwo.quantity * dwo.unitprice * (1-dwo.discount))from dw_orders2783 dwo;*/

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


/* question 19 */
select dwp.productname as "Product name",round(sum(dwo.quantity * dwo.unitprice * (1-dwo.discount)),0) as "Total Sales", rank() over(order by(sum(dwo.quantity * dwo.unitprice * (1-dwo.discount)))desc) as "rank"
from dw_orders2783 dwo
inner join dw_products2783 dwp
on dwo.productid = dwp.productid
group by (dwp.productname);


/* question 20 */
select dwc.companyname as "Company Name",dwc.country,round(sum(dwo.quantity * dwo.unitprice * (1-dwo.discount)),0) as "Total Purchase"
from dw_orders2783 dwo
inner join dw_customers2783 dwc
on dwo.customerid = dwc.customerid
group by rollup(dwc.companyname,dwc.country);

select dwc.companyname as "Company Name",dwc.country,round(sum(dwo.quantity * dwo.unitprice * (1-dwo.discount)),0) as "Total Purchase"
from dw_orders2783 dwo
inner join dw_customers2783 dwc
on dwo.customerid = dwc.customerid
group by cube(dwc.companyname,dwc.country);


























