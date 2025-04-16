-- 1. Фильтрация «хороших» валют и подсчёт суммы по каждой
-- Считаем суммарную сумму транзакций по популярным валютам: USD, EUR, RUB.
SELECT 
    currency,
    SUM(amount) AS total_amount
FROM transactions_v2
WHERE currency IN ('USD', 'EUR', 'RUB')
GROUP BY currency;

-- 2. Подсчёт мошеннических и обычных транзакций:
--   - сколько всего транзакций с фродом (is_fraud = 1) и без (is_fraud = 0),
--   - суммарную сумму по каждой категории,
--   - средний чек.
SELECT 
    is_fraud,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount,
    AVG(amount) AS avg_amount
FROM transactions_v2
GROUP BY is_fraud;

-- 3. Ежедневная статистика:
-- Для каждой даты — количество транзакций, общая сумма и средний размер транзакции.
SELECT 
    SUBSTRING(transaction_date, 1, 10) AS transaction_day,
    COUNT(*) AS daily_count,
    SUM(amount) AS daily_total,
    AVG(amount) AS daily_avg
FROM transactions_v2
GROUP BY SUBSTRING(transaction_date, 1, 10)
ORDER BY transaction_day;

-- 4. Разбор по дню и месяцу — анализ временной активности:
SELECT 
    YEAR(TO_DATE(transaction_date)) AS year,
    MONTH(TO_DATE(transaction_date)) AS month,
    DAY(TO_DATE(transaction_date)) AS day,
    COUNT(*) AS tx_count,
    SUM(amount) AS total
FROM transactions_v2
GROUP BY 
    YEAR(TO_DATE(transaction_date)),
    MONTH(TO_DATE(transaction_date)),
    DAY(TO_DATE(transaction_date))
ORDER BY year, month, day;

-- 5. JOIN с logs_v2: количество логов на транзакцию
SELECT 
    t.transaction_id,
    COUNT(l.log_id) AS log_count
FROM transactions_v2 t
LEFT JOIN logs_v2 l ON t.transaction_id = l.transaction_id
GROUP BY t.transaction_id
ORDER BY log_count DESC;

-- 6. JOIN: самые частые категории логов по транзакциям
-- Считаем, сколько раз встречалась каждая категория лога (например, Electronics, System).
SELECT 
    l.category,
    COUNT(*) AS count
FROM transactions_v2 t
JOIN logs_v2 l ON t.transaction_id = l.transaction_id
GROUP BY l.category
ORDER BY count DESC;

-- 7. JOIN: среднее количество логов на транзакцию
    AVG(log_count) AS avg_logs_per_transaction
FROM (
    SELECT 
        t.transaction_id,
        COUNT(l.log_id) AS log_count
    FROM transactions_v2 t
    LEFT JOIN logs_v2 l ON t.transaction_id = l.transaction_id
    GROUP BY t.transaction_id
) sub;
