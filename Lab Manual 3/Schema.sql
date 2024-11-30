CREATE TABLE Users (
    userid SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    phonenum VARCHAR(15) NOT NULL,
    city VARCHAR(20) NOT NULL
);

CREATE TABLE CardType (
    cardTypeID SERIAL PRIMARY KEY,
    name VARCHAR(15),
    description VARCHAR(40)
);

CREATE TABLE Card (
    cardNum VARCHAR(20) PRIMARY KEY,
    cardTypeID INT REFERENCES CardType(cardTypeID),
    PIN VARCHAR(4) NOT NULL,
    expireDate DATE NOT NULL,
    balance FLOAT NOT NULL
);

CREATE TABLE UserCard (
    userID INT REFERENCES USERS(USERID),
    cardNum VARCHAR(20) REFERENCES Card(cardNum),
    PRIMARY KEY (cardNum)
);

CREATE TABLE Transactions (
    transId SERIAL PRIMARY KEY,
    transDate DATE NOT NULL,
    cardNum VARCHAR(20) REFERENCES Card(cardNum),
    amount INT NOT NULL
);

INSERT INTO USERS (USERID, NAME, PHONENUM, CITY) VALUES 
(1, 'Ali', '03036067000', 'Narowal'),
(2, 'Ahmed', '03036047000', 'Lahore'),
(3, 'Aqeel', '03036063000', 'Karachi'),
(4, 'Usman', '03036062000', 'Sialkot'),
(5, 'Hafeez', '03036061000', 'Lahore');

INSERT INTO CardType (cardTypeID, name, description) VALUES 
(1, 'Debit', 'Spend Now, Pay Now'),
(2, 'Credit', 'Spend Now, Pay Later');

INSERT INTO Card (cardNum, cardTypeID, PIN, expireDate, balance) VALUES 
('1234', 1, '1770', '2022-07-01', 43025.31),
('1235', 1, '9234', '2020-03-02', 14425.62),
('1236', 1, '1234', '2019-02-06', 34325.52),
('1237', 2, '1200', '2021-02-05', 24325.3),
('1238', 2, '9004', '2020-09-02', 34025.12);

INSERT INTO UserCard (userID, cardNum) VALUES 
(1, '1234'),
(1, '1235'),
(2, '1236'),
(3, '1238'),
(4, '1237');

INSERT INTO Transactions (transId, transDate, cardNum, amount) VALUES 
(1, '2017-02-02', '1234', 500),
(2, '2018-02-03', '1235', 3000),
(3, '2020-01-06', '1236', 2500),
(4, '2016-09-09', '1238', 2000),
(5, '2020-02-10', '1234', 6000);
