CREATE TABLE buyers(
    id INTEGER UNIQUE,
    name TEXT,
    address TEXT,

    local_ts DATETIME DEFAULT CURRENT_TIMESTAMP,
    local_id INTEGER PRIMARY KEY,
    local_inserted INTEGER DEFAULT 0,
    local_updated INTEGER DEFAULT 0,
    local_deleted INTEGER DEFAULT 0
);
CREATE TABLE orders(
    id INTEGER UNIQUE,
    buyer_id INTEGER,
    ord INTEGER,
    recept_ndoc TEXT,
    ndoc TEXT,
    info TEXT,
    inc INTEGER,
    goods_cnt INTEGER,
    mc NUMERIC,

    local_ts DATETIME DEFAULT CURRENT_TIMESTAMP,
    local_id INTEGER PRIMARY KEY,
    local_inserted INTEGER DEFAULT 0,
    local_updated INTEGER DEFAULT 0,
    local_deleted INTEGER DEFAULT 0
);
CREATE TABLE debts(
    id INTEGER UNIQUE,
    buyer_id INTEGER,
    order_id INTEGER,
    ndoc TEXT,
    ddate DATETIME,
    is_check INTEGER,
    debt_sum NUMERIC,
    order_sum NUMERIC,

    local_ts DATETIME DEFAULT CURRENT_TIMESTAMP,
    local_id INTEGER PRIMARY KEY,
    local_inserted INTEGER DEFAULT 0,
    local_updated INTEGER DEFAULT 0,
    local_deleted INTEGER DEFAULT 0
);
CREATE TABLE repayments(
    id INTEGER UNIQUE,
    buyer_id INTEGER,
    order_id INTEGER,
    summ NUMERIC,
    ddate DATETIME,
    kkmprinted INTEGER,

    local_ts DATETIME DEFAULT CURRENT_TIMESTAMP,
    local_id INTEGER PRIMARY KEY,
    local_inserted INTEGER DEFAULT 0,
    local_updated INTEGER DEFAULT 0,
    local_deleted INTEGER DEFAULT 0
);
