-- Reference Date
WITH reference_date AS (
SELECT MAX(order_date) AS ref_date FROM e_commerce_transactions 
),

-- Recency
customer_recency AS (
SELECT
customer_id,
(SELECT ref_date FROM reference_date) - MAX(order_date) AS recency_day
FROM e_commerce_transactions
GROUP BY customer_id
)
-- Recency Segment
SELECT *,
NTILE(6) OVER (ORDER BY recency_day ASC) AS recency_segment
FROM customer_recency
ORDER BY recency_day;

-- Frequency
