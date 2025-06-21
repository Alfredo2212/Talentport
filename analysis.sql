-- RFM ANALYSIS WITH 6 SEGMENTATION --
-- Recency
WITH reference_date AS (
SELECT MAX(order_date) AS ref_date FROM e_commerce_transactions 
),
customer_recency AS (
SELECT
customer_id,
(SELECT ref_date FROM reference_date) - MAX(order_date) AS recency_day
FROM e_commerce_transactions
GROUP BY customer_id
)
SELECT *,
NTILE(6) OVER (ORDER BY recency_day ASC) AS recency_segment
FROM customer_recency
ORDER BY recency_day;

-- Frequency
WITH customer_frequency AS (
SELECT
customer_id,
COUNT(order_id) AS frequency
FROM e_commerce_transactions
GROUP BY customer_id
),
scored_frequency AS (
SELECT *,
NTILE(6) OVER (ORDER BY frequency) AS frequency_segment
FROM customer_frequency
)
SELECT * FROM scored_frequency;

-- Monetary
With customer_monetary AS (
SELECT
customer_id,
SUM(payment_value) AS monetary_value
FROM e_commerce_transactions
GROUP BY customer_id
),
monetary_segmented AS (
SELECT 
customer_id,
monetary_value,
NTILE(6) OVER (ORDER BY monetary_value) AS monetary_segment
FROM customer_monetary 
)
SELECT * FROM monetary_segmented
ORDER BY monetary_segment;

-- ANOMALY DETECTION ( decoy_noise ) --
-- Mark lower 2.5% and upper 2.5% as anomaly
WITH anomali_thresholds AS (
SELECT
PERCENTILE_CONT(0.025) WITHIN GROUP (ORDER BY decoy_noise) AS p2_5,
PERCENTILE_CONT(0.975) WITHIN GROUP (ORDER BY decoy_noise) AS p97_5
FROM e_commerce_transactions
)
SELECT 
t.*,
CASE
WHEN t.decoy_noise <= p.p2_5 THEN '<=2.5% Anomaly' 
WHEN t.decoy_noise >= p.p97_5 THEN '>=97.5% Anomaly' 
ELSE 'WITHIN 95%'
END AS anomaly_flag
FROM e_commerce_transactions t
CROSS JOIN anomali_thresholds p --;
-- Query only Anomalies
WHERE
t.decoy_noise <= p.p2_5 OR t.decoy_noise >= p.p97_5;

-- MONTHLY REPEAT PURCHASE --
WITH monthly_orders AS(
SELECT
customer_id,
DATE_TRUNC('month', order_date) AS order_month,
COUNT(order_id) AS monthly_order_count
FROM e_commerce_transactions
GROUP BY customer_id, order_month
),
repeat_purchases AS (
SELECT *
FROM monthly_orders
WHERE monthly_order_count > 1
)
-- Individual repeat purchase |TOGGLE ONLY 1|
SELECT * FROM repeat_purchases
ORDER BY order_month, customer_id;
-- Monthly summary |TOGGLE ONLY 1|
--SELECT order_month,
--COUNT(DISTINCT customer_id) AS repeat_customers,
--SUM(monthly_order_count) AS total_repeat_orders
--FROM repeat_purchases
--GROUP BY order_month
--ORDER BY order_month;
