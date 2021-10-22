CREATE TABLE buyers(
    id INTEGER UNIQUE,
    name TEXT,
    address TEXT,

    localTs DATETIME DEFAULT CURRENT_TIMESTAMP,
    localId INTEGER PRIMARY KEY
);
CREATE TABLE orders(
    id INTEGER UNIQUE,
    buyerId INTEGER,
    ord INTEGER,
    ndoc TEXT,
    info TEXT,
    inc INTEGER,
    goodsCnt INTEGER,
    mc NUMERIC,
    delivered INTEGER,

    localTs DATETIME DEFAULT CURRENT_TIMESTAMP,
    localId INTEGER PRIMARY KEY
);
CREATE TABLE debts(
    id INTEGER UNIQUE,
    buyerId INTEGER,
    orderId INTEGER,
    ndoc TEXT,
    orderNdoc TEXT,
    ddate DATETIME,
    orderDdate DATETIME,
    isCheck INTEGER,
    debtSum NUMERIC,
    orderSum NUMERIC,
    paidSum NUMERIC,
    paymentSum NUMERIC,

    localTs DATETIME DEFAULT CURRENT_TIMESTAMP,
    localId INTEGER PRIMARY KEY
);
CREATE TABLE cashPayments(
    id INTEGER UNIQUE,
    buyerId INTEGER,
    orderId INTEGER,
    summ NUMERIC,
    ddate DATETIME,
    kkmprinted INTEGER,

    localTs DATETIME DEFAULT CURRENT_TIMESTAMP,
    localId INTEGER PRIMARY KEY
);
CREATE TABLE cardPayments(
    id INTEGER UNIQUE,
    buyerId INTEGER,
    orderId INTEGER,
    summ NUMERIC,
    ddate DATETIME,
    transactionId TEXT,
    canceled INTEGER,

    localTs DATETIME DEFAULT CURRENT_TIMESTAMP,
    localId INTEGER PRIMARY KEY
);
CREATE TABLE incomes(
    id INTEGER UNIQUE,
    summ NUMERIC,
    ddate DATETIME,

    localTs DATETIME DEFAULT CURRENT_TIMESTAMP,
    localId INTEGER PRIMARY KEY
);
CREATE TABLE recepts(
    id INTEGER UNIQUE,
    summ NUMERIC,
    ddate DATETIME,

    localTs DATETIME DEFAULT CURRENT_TIMESTAMP,
    localId INTEGER PRIMARY KEY
);
