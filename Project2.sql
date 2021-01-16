/*Create customer table*/
CREATE TABLE Customer(
CustomerID INT,
CustomerName CHAR(25), 
CustomerAddress CHAR(30), 
CustomerCity CHAR(25), 
CustomerState CHAR(2), 
CustomerPostalCode CHAR(10), 
CustomerEmail CHAR(40), 
CustomerUserName CHAR(25),
CustomerPassword CHAR(25),
PRIMARY KEY(CustomerID));

/*create table territory*/
CREATE TABLE Territory(
TerritoryID INT, 
TerritoryName CHAR(9),
PRIMARY KEY(TerritoryID));



/*create table SalesPerson*/
CREATE TABLE Salesperson(
SalespersonID INT, 
SalespersonName CHAR(25), 
SalespersonPhone CHAR(15), 
SalespersonEmail CHAR(40), 
SalespersonUserName CHAR(25), 
SalespersonPassword CHAR(25),
TerritoryID INT, 
PRIMARY KEY (SalespersonID),
FOREIGN KEY (TerritoryID) REFERENCES Territory);


/*create table DoesBusinessIn*/
CREATE TABLE DoesBusinessIn (
CustomerID INT, 
TerritoryID INT,
PRIMARY KEY (CustomerID, TerritoryID),
FOREIGN KEY(CustomerID) REFERENCES Customer,
FOREIGN KEY (TerritoryID) REFERENCES Territory);




/*create table ProductLune*/
CREATE TABLE ProductLine(
ProductLineID INT,
ProductLineName VARCHAR(20), 
PRIMARY KEY (ProductLineID));




/*create product table*/
CREATE TABLE Product(
ProductID INT, 
ProductName CHAR(20), 
ProductFinish CHAR(15), 
ProductStandardPrice INT, 
ProductLineID INT, 
Photo CHAR(10),
PRIMARY KEY (ProductID),
FOREIGN KEY (ProductLineID)REFERENCES ProductLine
);



/*create table Orders*/
CREATE TABLE Orders(
OrderID INT, 
OrderDate DATE, 
CustomerID INT,
PRIMARY KEY(OrderID),
FOREIGN KEY(CustomerID) REFERENCES Customer);


/*create table orderLine*/
CREATE TABLE OrderLine(
OrderID INT,
ProductID INT,
OrderedQuantity INT, 
SalePrice INT,
PRIMARY KEY(OrderID,ProductID),
FOREIGN KEY(OrderID) REFERENCES Orders,
FOREIGN KEY(ProductID) REFERENCES Product);


/*create table PriceUpdates */
CREATE TABLE PriceUpdate(
PriceUpdateID INT, 
DateChanged DATE, 
OldPrice INT, 
NewPrice INT,
PRIMARY KEY(PriceUpdateID));


/*create ProductLineSales view*/
CREATE VIEW ProductLineSales(ProductID, ProductSales) 
    AS SELECT P.ProductID, OL.OrderedQuantity * OL.SalePrice 
    FROM Product P, OrderLine OL 
    WHERE P.ProductID = OL.ProductID;
    







/*create TotalValue view*/
CREATE VIEW TotalValue(ProductID,TotalSales)
    AS SELECT P.ProductID, P.ProductStandardPrice * OL.OrderedQuantity 
    FROM Product P, OrderLine OL
    WHERE P.ProductID = OL.ProductID;
    
    
    
/*create DataCustomer view*/
CREATE VIEW DataCustomer(CustomerID, ProductID, StandardPrice)
    AS SELECT C.CustomerID, P.ProductID, P.ProductStandardPrice
    FROM Customer C, Product P,  DoesBusinessIn DB,  Salesperson SP, OrderLine OL, Orders O
    WHERE DB.TerritoryID = SP.TerritoryID 
    AND C.CustomerID = DB.CustomerID 
    AND OL.ProductID = P.ProductID 
    AND O.OrderID = OL.OrderID
    AND O.CustomerID = C.CustomerID;



/*create CustomerByState view*/
CREATE VIEW CustomerByState (States, NumberOfCustomers)
    AS SELECT C.CustomerState, COUNT(*)
    FROM Customer C Group By C.CustomerState;

/*create PurchaseHistory view*/
CREATE VIEW PurchaseHistory(OrderDate, Quantity, Price, ProductName)
    AS SELECT O.OrderDate, OL.OrderedQuantity, OL.SalePrice, OL.ProductID
    FROM Orders O, OrderLine OL, Customer C
    WHERE C.CustomerID = O.CustomerID AND O.OrderID = OL.OrderID;
    
    
    
/*Insert into customer*/
INSERT ALL
  INTO Customer (CustomerID, CustomerName, CustomerAddress, CustomerCity,CustomerState, CustomerPostalCode, CustomerEmail, CustomerUserName, CustomerPassword) VALUES (1, 'Contemporary Casuals', 
  '1355 S Hines Blvd', 'Gainesville', 'FL', '32601-2871', NULL, NULL, NULL)
  INTO Customer (CustomerID, CustomerName, CustomerAddress, CustomerCity,CustomerState, CustomerPostalCode, CustomerEmail, CustomerUserName, CustomerPassword) VALUES (2, 'Value Furnitures',
  '15145 S.W. 17th St.', 'Plano', 'TX', '75094-7734', NULL, NULL, NULL)
  INTO Customer (CustomerID, CustomerName, CustomerAddress, CustomerCity,CustomerState, CustomerPostalCode, CustomerEmail, CustomerUserName, CustomerPassword) VALUES (3, 'Home Furnishings', 
  '1900 Allard Ave', 'Albany', 'NY', '12209-1125','homefurnishings?@gmail.com', 'CUSTOMER1', 'CUSTOMER1#')
  INTO Customer (CustomerID, CustomerName, CustomerAddress, CustomerCity,CustomerState, CustomerPostalCode, CustomerEmail, CustomerUserName, CustomerPassword) VALUES (4, 'Eastern Furniture', 
  '1925 Beltline Rd.', 'Carteret', 'NJ', '07008-3188', NULL, NULL, NULL)
  INTO Customer (CustomerID, CustomerName, CustomerAddress, CustomerCity,CustomerState, CustomerPostalCode, CustomerEmail, CustomerUserName, CustomerPassword) VALUES (5, 'Impressions', 
  '5585 Westcott Ct.', 'Sacramento', 'CA', '94206-4056', NULL, NULL, NULL)
  INTO Customer (CustomerID, CustomerName, CustomerAddress, CustomerCity,CustomerState, CustomerPostalCode, CustomerEmail, CustomerUserName, CustomerPassword) VALUES (6, 'Furniture Gallery', 
  '325 Flatiron Dr.', 'Boulder', 'CO', '80514-4432', NULL, NULL, NULL)
  INTO Customer (CustomerID, CustomerName, CustomerAddress, CustomerCity,CustomerState, CustomerPostalCode, CustomerEmail, CustomerUserName, CustomerPassword) VALUES (7, 'New Furniture', 'Palace Ave', 'Farmington', 'NM', '', NULL, NULL, NULL)
  INTO Customer (CustomerID, CustomerName, CustomerAddress, CustomerCity,CustomerState, CustomerPostalCode, CustomerEmail, CustomerUserName, CustomerPassword) VALUES (8, 'Dunkins Furniture', '7700 Main St', 'Syracuse', 'NY', '31590', NULL, NULL, NULL)
  INTO Customer (CustomerID, CustomerName, CustomerAddress, CustomerCity,CustomerState, CustomerPostalCode, CustomerEmail, CustomerUserName, CustomerPassword) VALUES (9, 'A Carpet', '434 Abe Dr', 'Rome', 'NY', '13440', NULL, NULL, NULL)
  INTO Customer (CustomerID, CustomerName, CustomerAddress, CustomerCity,CustomerState, CustomerPostalCode, CustomerEmail, CustomerUserName, CustomerPassword) VALUES (12, 'Flanigan Furniture', 'Snow Flake Rd', 'Ft Walton Beach', 'FL', '32548', NULL, NULL, NULL)
  INTO Customer (CustomerID, CustomerName, CustomerAddress, CustomerCity,CustomerState, CustomerPostalCode, CustomerEmail, CustomerUserName, CustomerPassword) VALUES (13, 'Ikards', '1011 S. Main St', 'Las Cruces', 'NM', '88001', NULL, NULL, NULL)
  INTO Customer (CustomerID, CustomerName, CustomerAddress, CustomerCity,CustomerState, CustomerPostalCode, CustomerEmail, CustomerUserName, CustomerPassword) VALUES (14, 'Wild Bills', 'Four Horse Rd', 'Oak Brook', 'Il', '60522', NULL, NULL, NULL)
  INTO Customer (CustomerID, CustomerName, CustomerAddress, CustomerCity,CustomerState, CustomerPostalCode, CustomerEmail, CustomerUserName, CustomerPassword) VALUES (15, 'Janet''s Collection', 'Janet Lane', 'Virginia Beach', 'VA', '10012', NULL, NULL, NULL)
  INTO Customer (CustomerID, CustomerName, CustomerAddress, CustomerCity,CustomerState, CustomerPostalCode, CustomerEmail, CustomerUserName, CustomerPassword) VALUES (16, 'ABC Furniture Co.', '152 Geramino Drive', 'Rome', 'NY', '13440', NULL, NULL, NULL)
SELECT * FROM dual;

/*INSERT INTO TERRITORY*/
INSERT ALL 
    INTO Territory(TerritoryID, TerritoryName) VALUES(1, 'SouthEast')
    INTO Territory(TerritoryID, TerritoryName) VALUES(2, 'SouthWest')
    INTO Territory(TerritoryID, TerritoryName) VALUES(3, 'NorthEast')
    INTO Territory(TerritoryID, TerritoryName) VALUES(4, 'NorthWest')
    INTO Territory(TerritoryID, TerritoryName) VALUES(5, 'Central')
SELECT * FROM dual;



/*Insert into SalesPerson*/
INSERT ALL
    INTO Salesperson(SalespersonID, SalespersonName, SalespersonPhone, SalespersonEmail, SalespersonUserName, SalespersonPassword,TerritoryID) 
    VALUES(1,'Doug Henny', '8134445555', 'salesperson?@gmail.com', 'SALESPERSON', 'SALESPERSON#',1)
    INTO Salesperson(SalespersonID, SalespersonName, SalespersonPhone, SalespersonEmail, SalespersonUserName, SalespersonPassword,TerritoryID) 
    VALUES(2, 'Robert Lewis', '8139264006', '', '', '', 2)
    INTO Salesperson(SalespersonID, SalespersonName, SalespersonPhone, SalespersonEmail, SalespersonUserName, SalespersonPassword,TerritoryID) 
    VALUES(3, 'William Strong', '5053821212', '', '', '', 3)
    INTO Salesperson(SalespersonID, SalespersonName, SalespersonPhone, SalespersonEmail, SalespersonUserName, SalespersonPassword,TerritoryID) 
    VALUES(4, 'Julie Dawson', '4355346677', '', '', '', 4)
    INTO Salesperson(SalespersonID, SalespersonName, SalespersonPhone, SalespersonEmail, SalespersonUserName, SalespersonPassword,TerritoryID) 
    VALUES(5, 'Jacob Winslow', '2238973498', '', '', '', 5)
SELECT * FROM dual;



/*Insert into DoesBusinessIn*/
INSERT ALL 
    INTO DoesBusinessIn(CustomerID, TerritoryID) VALUES(1, 1)
    INTO DoesBusinessIn(CustomerID, TerritoryID) VALUES(2, 2)
    INTO DoesBusinessIn(CustomerID, TerritoryID) VALUES(3, 3)
    INTO DoesBusinessIn(CustomerID, TerritoryID) VALUES(4, 4)
    INTO DoesBusinessIn(CustomerID, TerritoryID) VALUES(5, 5)
    INTO DoesBusinessIn(CustomerID, TerritoryID) VALUES(6, 1)
    INTO DoesBusinessIn(CustomerID, TerritoryID) VALUES(7, 2)
SELECT * FROM dual;
  
/*iNSERT INTO PRODUCTLINE*/  
INSERT ALL 
    INTO ProductLine(ProductLineID, ProductLineName) VALUES(1, 'Cherry Tree')
    INTO ProductLine(ProductLineID, ProductLineName) VALUES(2, 'Scandinavia')
    INTO ProductLine(ProductLineID, ProductLineName) VALUES(3, 'Country Look')
SELECT * FROM dual;
    
    
/*INSERT INTO PRODUCT*/
INSERT ALL
    INTO Product(ProductID, ProductName, ProductFinish, ProductStandardPrice, ProductLineID, Photo) VALUES(1, 'End Table', 'Cherry', 175, 1, 'table.jpg')
    INTO Product(ProductID, ProductName, ProductFinish, ProductStandardPrice, ProductLineID, Photo) VALUES(2, 'Coffee Table', 'Natural Ash', 200, 2, NULL)
    INTO Product(ProductID, ProductName, ProductFinish, ProductStandardPrice, ProductLineID, Photo) VALUES(3, 'Computer Desk', 'Natural Ash', 375, 2, NULL)
    INTO Product(ProductID, ProductName, ProductFinish, ProductStandardPrice, ProductLineID, Photo) VALUES(4, 'Entertainment Center', 'Natural Maple', 650, 3, NULL)
    INTO Product(ProductID, ProductName, ProductFinish, ProductStandardPrice, ProductLineID, Photo) VALUES(5, 'Writers Desk', 'Cherry', 325, 1, NULL)
    INTO Product(ProductID, ProductName, ProductFinish, ProductStandardPrice, ProductLineID, Photo) VALUES(6, '8-Drawer Desk', 'White Ash', 750, 2, NULL)
    INTO Product(ProductID, ProductName, ProductFinish, ProductStandardPrice, ProductLineID, Photo) VALUES(7, 'Dining Table', 'Natural Ash', 800, 2, NULL)
    INTO Product(ProductID, ProductName, ProductFinish, ProductStandardPrice, ProductLineID, Photo) VALUES(8, 'Computer Desk', 'Walnut', 250, 3,NULL)
SELECT * FROM dual;


/*INSERT INTO ORDER*/
INSERT ALL
    INTO Orders(OrderID, OrderDate, CustomerID) VALUES(1001, TO_DATE('21/Aug/16','DD/MON/YY'), 1)
    INTO Orders(OrderID, OrderDate, CustomerID) VALUES(1002, TO_DATE('21/Jul/16','DD/MON/YY'), 8)
    INTO Orders(OrderID, OrderDate, CustomerID) VALUES(1003, TO_DATE('22/Aug/16','DD/MON/YY'), 15)
    INTO Orders(OrderID, OrderDate, CustomerID) VALUES(1004, TO_DATE('22/Oct/16','DD/MON/YY'), 5)
    INTO Orders(OrderID, OrderDate, CustomerID) VALUES(1005, TO_DATE('24/Jul/16','DD/MON/YY'), 3)
    INTO Orders(OrderID, OrderDate, CustomerID) VALUES(1006, TO_DATE('24/Oct/16','DD/MON/YY'), 2)
    INTO Orders(OrderID, OrderDate, CustomerID) VALUES(1007, TO_DATE('27/Aug/16','DD/MON/YY'), 5)
    INTO Orders(OrderID, OrderDate, CustomerID) VALUES(1008, TO_DATE('30/Oct/16','DD/MON/YY'), 12)
    INTO Orders(OrderID, OrderDate, CustomerID) VALUES(1009, TO_DATE('05/Nov/16','DD/MON/YY'), 4)
    INTO Orders(OrderID, OrderDate, CustomerID) VALUES(1010, TO_DATE('05/Nov/16','DD/MON/YY'), 1)
SELECT * FROM dual;
    
/*iNSERT INTO ORDERLINE*/
INSERT ALL
    INTO OrderLine(OrderID, ProductID, OrderedQuantity, SalePrice) VALUES(1001, 1, 2, NULL)
    INTO OrderLine(OrderID, ProductID, OrderedQuantity, SalePrice) VALUES(1001, 2, 2, NULL)
    INTO OrderLine(OrderID, ProductID, OrderedQuantity, SalePrice) VALUES(1001, 4, 1, NULL)
    INTO OrderLine(OrderID, ProductID, OrderedQuantity, SalePrice) VALUES(1002, 3, 5, NULL)
    INTO OrderLine(OrderID, ProductID, OrderedQuantity, SalePrice) VALUES(1003, 3, 3, NULL)
    INTO OrderLine(OrderID, ProductID, OrderedQuantity, SalePrice) VALUES(1004, 6, 2, NULL)
    INTO OrderLine(OrderID, ProductID, OrderedQuantity, SalePrice) VALUES(1004, 8, 2, NULL)
    INTO OrderLine(OrderID, ProductID, OrderedQuantity, SalePrice) VALUES(1005, 4, 4, NULL)
    INTO OrderLine(OrderID, ProductID, OrderedQuantity, SalePrice) VALUES(1006, 4, 1, NULL)
    INTO OrderLine(OrderID, ProductID, OrderedQuantity, SalePrice) VALUES(1006, 5, 2, NULL)
    INTO OrderLine(OrderID, ProductID, OrderedQuantity, SalePrice) VALUES(1006, 7, 2, NULL)
    INTO OrderLine(OrderID, ProductID, OrderedQuantity, SalePrice) VALUES(1007, 1, 3, NULL)
    INTO OrderLine(OrderID, ProductID, OrderedQuantity, SalePrice) VALUES(1007, 2, 2, NULL)
    INTO OrderLine(OrderID, ProductID, OrderedQuantity, SalePrice) VALUES(1008, 3, 3, NULL)
    INTO OrderLine(OrderID, ProductID, OrderedQuantity, SalePrice) VALUES(1008, 8, 3, NULL)
    INTO OrderLine(OrderID, ProductID, OrderedQuantity, SalePrice) VALUES(1009, 4, 2, NULL)
    INTO OrderLine(OrderID, ProductID, OrderedQuantity, SalePrice) VALUES(1009, 7, 3, NULL)
    INTO OrderLine(OrderID, ProductID, OrderedQuantity, SalePrice) VALUES(1010, 8, 10, NULL)
SELECT * FROM dual;
    
    




/* Q1 Which products have a standard price of less than $ 275? */
SELECT * 
FROM Product P
WHERE P.ProductStandardPrice < 275;

/* Q2 List the unit price, product name, and product ID for all products in the Product table. */

SELECT P.ProductStandardPrice, P.ProductName, P.ProductID
FROM Product P;


/*Q3 What is the average standard price for all products in inventory? */

SELECT AVG(P.ProductStandardPrice)
FROM Product P;

/* Q4 How many different items were ordered on order number 1004? */
SELECT DISTINCT COUNT(OL.ProductID)
FROM OrderLine OL
WHERE OL.OrderID = 1004;

/*Q5 Which orders have been placed since 10/ 24/ 2010? */

SELECT OrderID,OrderDate
FROM ORDERS O
WHERE O.OrderDate > '24/OCT/10';


/*Q6 What furniture does COSC3380 carry that isn’t made of cherry?*/

SELECT P.ProductName
FROM Product P
WHERE P.ProductFinish != 'Cherry';


/* Q7 List product name, finish, and standard price for 
all desks and all tables that cost more than $ 300 in the Product table. */

SELECT P.ProductName, P.ProductFinish, P.ProductStandardPrice
FROM Product P
WHERE P.ProductName NOT LIKE 'E%' AND P.ProductStandardPrice > 300;

/* Q8 Which products in the Product table have a standard price between $ 200 and $ 300? */

SELECT *
FROM Product P
WHERE P.ProductStandardPrice BETWEEN 200 AND 300;

/* Q9 List customer, city, and state for all customers in the Customer table whose address is Florida, Texas, California, or Hawaii. 
List the customers alphabetically by state and alphabetically by customer within each state. */

SELECT C.CustomerName, C.CustomerCity, C.CustomerState 
FROM CUSTOMER C 
WHERE C.CustomerState IN ('FL','TX', 'CA', 'HI') ORDER BY C.CustomerState, C.CustomerName;



/*Q10 Count the number of customers with addresses in each state to which we ship. */

SELECT C.CustomerState, count(*)
FROM Customer C GROUP BY C.CustomerState;



/*Q11 Count the number of customers with addresses in each city to which we ship. List the cities by state. */

SELECT C.CustomerCity, count(C.CustomerCity)
FROM Customer C GROUP BY C.CustomerCity, C.CustomerState;






/*Q12 Find only states with more than one customer.*/
SELECT C.CustomerState, COUNT(*)
FROM Customer C
GROUP BY C.CustomerState
HAVING COUNT(*)>1;





/*Q13 List, in alphabetical order, 
the product finish and the average standard price for each finish for selected finishes having an average standard price less than 750. */
SELECT P.ProductFinish, AVG(P.ProductStandardPrice)
from Product P Group by P.ProductFinish 
HAVING AVG(P.ProductStandardPrice)< 750 ORDER BY(P.ProductFinish);





/*Q14 What is the total value of orders placed for each furniture product? */
SELECT P.ProductName, sum(OL.OrderedQuantity * P.ProductStandardPrice) as TotalValueOfOrders
from Product P, OrderLine OL 
WHERE P.ProductID = OL.ProductID group by P.ProductName;
 
 






























































