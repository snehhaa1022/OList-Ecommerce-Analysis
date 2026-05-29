-- Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM olist_complete_dataset;


-- Total Revenue
SELECT ROUND(SUM(payment_value),2) AS total_revenue
FROM olist_complete_dataset;


-- Average Order Value (AOV)
SELECT ROUND(
SUM(payment_value) /
COUNT(DISTINCT order_id),2
) AS avg_order_value
FROM olist_complete_dataset;


-- Top 10 Product Categories by Revenue
SELECT
    product_category_name_english,
    ROUND(SUM(price),2) AS revenue
FROM olist_complete_dataset
GROUP BY product_category_name_english
ORDER BY revenue DESC
LIMIT 10;


-- Most Used Payment Type
SELECT
    payment_type,
    COUNT(*) AS total_transactions
FROM olist_complete_dataset
GROUP BY payment_type
ORDER BY total_transactions DESC;

-- Average Delivery Days
SELECT ROUND(
AVG(avg_delivery_days),2
) AS avg_delivery_days
FROM olist_complete_dataset;


-- Late vs On-Time Delivery
SELECT
CASE
WHEN order_delivery_customer_date >
     order_estimated_delivery_date
THEN 'Late'
WHEN order_delivery_customer_date <
     order_estimated_delivery_date
THEN 'Early'
ELSE 'On Time'
END AS delivery_status,
COUNT(*) AS total_orders
FROM olist_complete_dataset
GROUP BY delivery_status;

-- Average Review Score
SELECT ROUND(
AVG(review_score),2
) AS average_review_score
FROM olist_complete_dataset;


-- Top Customer States by Orders
SELECT
    customer_state,
    COUNT(DISTINCT order_id)
    AS total_orders
FROM olist_complete_dataset
GROUP BY customer_state
ORDER BY total_orders DESC;


-- Weekday Vs Weekend (order_purchase_timestamp) Payment Statistics
SELECT
CASE
WHEN DAYOFWEEK(order_purchase_timestamp)
IN (1,7)
THEN 'Weekend'
ELSE 'Weekday'
END AS day_type,
ROUND(SUM(payment_value),2)
AS revenue
FROM olist_complete_dataset
GROUP BY day_type;


-- Number of Orders with Review Score 5 and Payment Type = Credit Card
SELECT
COUNT(DISTINCT order_id)
AS total_orders
FROM olist_complete_dataset
WHERE review_score = 5
AND payment_type = 'credit_card';


-- Average Number of Days Taken for pet_shop
SELECT
product_category_name_english,
ROUND(
AVG(avg_delivery_days),2
) AS avg_delivery_days
FROM olist_complete_dataset
WHERE product_category_name_english = 'pet_shop'
GROUP BY product_category_name_english;


-- Average Price and Payment Values from Customers of São Paulo City
SELECT
customer_city,
ROUND(AVG(price),2)
AS avg_price,
ROUND(AVG(payment_value),2)
AS avg_payment_value
FROM olist_complete_dataset
WHERE customer_city = 'sao paulo'
GROUP BY customer_city;


-- Relationship Between Shipping Days vs Review Scores
SELECT
review_score,
ROUND(
AVG(avg_delivery_days),2
) AS avg_shipping_days,
COUNT(*) AS total_orders
FROM olist_complete_dataset
GROUP BY review_score
ORDER BY review_score;