CREATE EXTERNAL TABLE transactions_v2 (
    transaction_id INT,
    user_id INT,
    amount DOUBLE,
    currency STRING,
    transaction_date STRING,
    is_fraud INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 's3a://dataprocwh/transactions_v2/'
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM transactions_v2;



CREATE EXTERNAL TABLE logs_v2 (
    log_id INT,
    transaction_id INT,
    category STRING,
    comment STRING,
    log_timestamp STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION 's3a://dataprocwh/logs/'
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM logs_v2




-- Сделал случайно, но пусть уже будет

CREATE EXTERNAL TABLE order_items (
    item_id INT,
    order_id INT,
    product_name STRING,
    product_price DOUBLE,
    quantity INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION 's3a://dataprocwh/order_items/'
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM order_items;



CREATE EXTERNAL TABLE orders (
    order_id INT,
    user_id INT,
    order_date STRING,
    total_amount DOUBLE,
    payment_status STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 's3a://dataprocwh/orders/'
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT * FROM orders;