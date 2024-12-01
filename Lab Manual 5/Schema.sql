CREATE TABLE Items (
    ItemNo INTEGER NOT NULL,
    Name VARCHAR(10),
    Price INTEGER,
    Quantity_in_Store INTEGER,
    PRIMARY KEY (ItemNo)
);

INSERT INTO Items (ItemNo, Name, Price, Quantity_in_Store) VALUES (100, 'A', 1000, 100);
INSERT INTO Items (ItemNo, Name, Price, Quantity_in_Store) VALUES (200, 'B', 2000, 50);
INSERT INTO Items (ItemNo, Name, Price, Quantity_in_Store) VALUES (300, 'C', 3000, 60);
INSERT INTO Items (ItemNo, Name, Price, Quantity_in_Store) VALUES (400, 'D', 6000, 400);

CREATE TABLE Customers (
    CustomerNo VARCHAR(2) NOT NULL,
    Name VARCHAR(30),
    City VARCHAR(3),
    Phone VARCHAR(11),
    PRIMARY KEY (CustomerNo)
);

INSERT INTO Customers (CustomerNo, Name, City, Phone) VALUES ('C1', 'AHMED ALI', 'LHR', '111111');
INSERT INTO Customers (CustomerNo, Name, City, Phone) VALUES ('C2', 'ALI', 'LHR', '222222');
INSERT INTO Customers (CustomerNo, Name, City, Phone) VALUES ('C3', 'AYESHA', 'LHR', '333333');
INSERT INTO Customers (CustomerNo, Name, City, Phone) VALUES ('C4', 'BILAL', 'KHI', '444444');
INSERT INTO Customers (CustomerNo, Name, City, Phone) VALUES ('C5', 'SADAF', 'KHI', '555555');
INSERT INTO Customers (CustomerNo, Name, City, Phone) VALUES ('C6', 'FARAH', 'ISL', NULL);

CREATE TABLE Orders (
    OrderNo INTEGER NOT NULL,
    CustomerNo VARCHAR(2),
    Date DATE,
    Total_Items_Ordered INTEGER,
    PRIMARY KEY (OrderNo)
);

INSERT INTO Orders (OrderNo, CustomerNo, Date, Total_Items_Ordered) VALUES (1, 'C1', '2016-07-23', 30);
INSERT INTO Orders (OrderNo, CustomerNo, Date, Total_Items_Ordered) VALUES (2, 'C3', '2016-10-23', 5);
INSERT INTO Orders (OrderNo, CustomerNo, Date, Total_Items_Ordered) VALUES (3, 'C3', '2016-11-23', 20);
INSERT INTO Orders (OrderNo, CustomerNo, Date, Total_Items_Ordered) VALUES (4, 'C4', '2016-11-23', 15);

CREATE TABLE OrderDetails (
    OrderNo INTEGER NOT NULL,
    ItemNo INTEGER NOT NULL,
    Quantity INTEGER,
    PRIMARY KEY (OrderNo, ItemNo),
    FOREIGN KEY (ItemNo) REFERENCES Items (ItemNo),
    FOREIGN KEY (OrderNo) REFERENCES Orders (OrderNo)
);

INSERT INTO OrderDetails (OrderNo, ItemNo, Quantity) VALUES (1, 200, 20);
INSERT INTO OrderDetails (OrderNo, ItemNo, Quantity) VALUES (1, 400, 10);
INSERT INTO OrderDetails (OrderNo, ItemNo, Quantity) VALUES (2, 200, 5);
INSERT INTO OrderDetails (OrderNo, ItemNo, Quantity) VALUES (3, 200, 60);
