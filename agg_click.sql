-- 1. Группировка по payment_status:
-- Считает количество заказов, общую сумму заказов и среднюю стоимость заказа
-- для каждого статуса оплаты (например, paid, pending, cancelled).
SELECT 
    payment_status,
    COUNT(*) AS order_count,
    SUM(total_amount) AS total_sum,
    AVG(total_amount) AS avg_order_amount
FROM orders
GROUP BY payment_status
ORDER BY total_sum DESC;

-- 2. JOIN с order_items:
-- Выводит по каждому товару:
--   - общее количество строк (заказов, где этот товар встречался),
--   - суммарную выручку (цена * количество),
--   - среднюю цену за единицу товара (без учёта quantity).
SELECT 
    oi.product_name,
    COUNT(*) AS items_count,
    SUM(oi.product_price * oi.quantity) AS total_revenue,
    AVG(oi.product_price) AS avg_price
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY oi.product_name
ORDER BY total_revenue DESC;

-- 3. Статистика по датам:
SELECT 
    toDate(order_date) AS order_day,
    COUNT(*) AS daily_orders,
    SUM(total_amount) AS daily_total
FROM orders
GROUP BY order_day
ORDER BY order_day;

-- 4. Топ пользователей по сумме заказов:
SELECT 
    user_id,
    COUNT(*) AS orders_count,
    SUM(total_amount) AS total_spent
FROM orders
GROUP BY user_id
ORDER BY total_spent DESC
LIMIT 10;

-- 5. Топ пользователей по количеству заказов:
SELECT 
    user_id,
    COUNT(*) AS orders_count
FROM orders
GROUP BY user_id
ORDER BY orders_count DESC
LIMIT 10;
