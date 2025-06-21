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