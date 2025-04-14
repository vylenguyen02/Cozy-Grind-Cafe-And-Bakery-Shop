/*
Vy Nguyen, Ananya Tiwari
CNIT 272 - Spring 2025
Lab time: 11:30 AM - 1:20 PM
Duration: 2 hours
*/
-- COZY GRIND CAFE & BAKERY SHOP PROJECT --
/*****************************************************
                        DDL
*****************************************************/

-- drop cascade tables before creation!!
DROP TABLE CUSTOMER CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEES CASCADE CONSTRAINTS;
DROP TABLE JOB CASCADE CONSTRAINTS;
DROP TABLE MEMBERSHIP CASCADE CONSTRAINTS;
DROP TABLE ORDERS CASCADE CONSTRAINTS;
DROP TABLE ORDERDETAILS CASCADE CONSTRAINTS;
DROP TABLE PRODUCT CASCADE CONSTRAINTS;
DROP TABLE SUPPLIER CASCADE CONSTRAINTS;

-- CREATE TABLE, ASSIGNING PRIMARY KEY --
CREATE TABLE CUSTOMER (
    CustomerID              CHAR(5) NOT NULL,
    CustomerFirstName       VARCHAR2(20) NOT NULL,
    MembershipID            CHAR(5) 
);

ALTER TABLE CUSTOMER ADD CONSTRAINT CUSTOMER_PK PRIMARY KEY ( CustomerID );

CREATE TABLE EMPLOYEES (
    EmployeeID          CHAR(5) NOT NULL,
    EmployeeFirstName   VARCHAR2(20),
    EmployeeLastName    VARCHAR2(30),
    EmployeeEmail       VARCHAR2(50),
    EmployeePhoneNumber VARCHAR2(10),
    Salary              NUMBER(2, 5),
    JobID               CHAR(5) 
);


ALTER TABLE EMPLOYEES ADD CONSTRAINT EMPLOYEES_PK PRIMARY KEY ( EmployeeID );

CREATE TABLE JOB (
    JobID          CHAR(5) NOT NULL,
    JobName        VARCHAR2(20),
    JobDescription VARCHAR2(100)
);

ALTER TABLE JOB ADD CONSTRAINT JOB_PK PRIMARY KEY ( JobID );

CREATE TABLE MEMBERSHIP (
    MembershipID      CHAR(5) NOT NULL,
    MembershipType    VARCHAR2(30)
        CONSTRAINT MEMBERSHIPTYPE_CK CHECK (MembershipType in ('New Member','Bronze','Silver','Gold','Platinum')),
    CustomerBenefits  VARCHAR2(100),
    MemberLastName    VARCHAR2(30),
    MemberFirstName   VARCHAR2(20),
    MemberEmail       VARCHAR2(50),
    MemberPhoneNumber CHAR(10),
    MemberAddress     VARCHAR2(100),
    LoyaltyPoints     NUMBER(3)
);

ALTER TABLE MEMBERSHIP ADD CONSTRAINT MEMBERSHIP_PK PRIMARY KEY ( MembershipID );

-- We changed the ORDER table to ORDERS because the word is reserved --
CREATE TABLE ORDERS (
    OrderID              CHAR(5) NOT NULL,
    OrderDate            DATE NOT NULL,
    TotalAmount          NUMBER(2, 3), -- discounted price --
    PaymentMethod        VARCHAR2(20),
    Status               VARCHAR2(20) NOT NULL
        CONSTRAINT ORDER_CK CHECK (Status in ('Placed', 'Preparing', 'Ready', 'Served', 'Cancelled')),
    EmployeeID           CHAR(5) NOT NULL,
    CustomerID           CHAR(5) NOT NULL,
    Discount             NUMBER(2,2)
);

ALTER TABLE ORDERS ADD CONSTRAINT ORDER_PK PRIMARY KEY ( OrderID );

CREATE TABLE ORDERDETAILS (
    OrderDetailsID     CHAR(10) NOT NULL,
    Quantity           NUMBER NOT NULL,
    OrderID            CHAR(5) NOT NULL,
    ProductID          CHAR(5) NOT NULL,
    SupplierID         CHAR(5) NOT NULL,
    Price              NUMBER(2,3) -- the total price of each product based on the price listed in the product table --
);

ALTER TABLE ORDERDETAILS ADD CONSTRAINT ORDERDETAILS_PK PRIMARY KEY ( OrderDetailsID,
                                                                      OrderID );

CREATE TABLE PRODUCT (
    ProductID           CHAR(5) NOT NULL,
    ProductName         VARCHAR2(50) NOT NULL,
    ProductCategory     VARCHAR2(50),
    ProductPrice        NUMBER(2, 3), -- the price we will sell at --
    StockQuantity       NUMBER,
    SupplierID CHAR(5) NOT NULL
);

ALTER TABLE PRODUCT ADD CONSTRAINT PRODUCT_PK PRIMARY KEY ( ProductID,
                                                            SupplierID );

CREATE TABLE SUPPLIER (
    SupplierID            CHAR(5) NOT NULL,
    SupplierName          VARCHAR2(50),
    SupplierContactNumber VARCHAR2(10),
    SupplierEmail         VARCHAR2(50),
    CompanyAddress        VARCHAR2(100)
);

ALTER TABLE SUPPLIER ADD CONSTRAINT SUPPLIER_PK PRIMARY KEY ( SupplierID );

-- FORIGN KEY --
ALTER TABLE CUSTOMER
    ADD CONSTRAINT CUSTOMER_MEMBERSHIP_FK FOREIGN KEY ( MembershipID )
        REFERENCES MEMBERSHIP ( MembershipID );

ALTER TABLE EMPLOYEES
    ADD CONSTRAINT EMPLOYEES_JOB_FK FOREIGN KEY ( JobID )
        REFERENCES JOB ( JobID );
-- We changed the ORDER table to ORDERS because the word is reserved --
ALTER TABLE ORDERS
    ADD CONSTRAINT ORDERS_CUSTOMER_FK FOREIGN KEY ( CustomerID )
        REFERENCES CUSTOMER ( CustomerID );

ALTER TABLE ORDERS
    ADD CONSTRAINT ORDERS_EMPLOYEES_FK FOREIGN KEY ( EmployeeID )
        REFERENCES EMPLOYEES ( EmployeeID );

ALTER TABLE ORDERDETAILS
    ADD CONSTRAINT ORDERDETAILS_ORDER_FK FOREIGN KEY ( OrderID )
        REFERENCES ORDERS ( OrderID );

ALTER TABLE ORDERDETAILS
    ADD CONSTRAINT ORDERDETAILS_PRODUCT_FK
        FOREIGN KEY ( ProductID,
                      SupplierID )
            REFERENCES PRODUCT ( ProductID,
                                 SupplierID );

ALTER TABLE PRODUCT
    ADD CONSTRAINT PRODUCT_SUPPLIER_FK FOREIGN KEY ( SupplierID )
        REFERENCES SUPPLIER ( SupplierID );

DESC CUSTOMER;
DESC EMPLOYEES;
DESC JOB;
DESC MEMBERSHIP;
DESC ORDERS;
DESC ORDERDETAILS;
DESC PRODUCT;
DESC SUPPLIER;
