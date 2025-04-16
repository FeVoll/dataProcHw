CREATE TABLE orders (
    order_id UInt32,
    user_id UInt32,
    order_date DateTime,
    total_amount Float64,
    payment_status String
) ENGINE = MergeTree
ORDER BY order_id;

INSERT INTO orders
SELECT *
FROM s3('https://storage.yandexcloud.net/dataprocwh/orders/orders.csv', 'CSVWithNames');




CREATE TABLE order_items (
    item_id UInt32,
    order_id UInt32,
    product_name String,
    product_price Float64,
    quantity UInt32
) ENGINE = MergeTree
ORDER BY item_id;

INSERT INTO order_items
SELECT 
    toUInt32(item_id),
    toUInt32(order_id),
    product_name,
    toFloat64(product_price),
    toUInt32(quantity)
FROM s3(
    'https://storage.yandexcloud.net/dataprocwh/order_items/order_items.txt',
    'CSVWithNames',
    'item_id UInt32, order_id UInt32, product_name String, product_price Float64, quantity UInt32'
) SETTINGS format_csv_delimiter=';';


