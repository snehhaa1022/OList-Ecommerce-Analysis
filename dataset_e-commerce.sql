create database ecommerce_analysis;
use ecommerce_analysis;

select* from olist_complete_dataset;

CREATE TABLE olist_complete_dataset (
    customer_id VARCHAR(32),
    customer_city VARCHAR(100),
    customer_state CHAR(2),
    geolocation_city VARCHAR(100),
    geolocation_state CHAR(2),
    order_id VARCHAR(32),
    product_category_name_english VARCHAR(100),
    product_id VARCHAR(32),
    seller_id VARCHAR(32),
    seller_city VARCHAR(100),
    price DECIMAL(10, 2),
    freight_value DECIMAL(10, 2),
    payment_type VARCHAR(50),
    payment_installments TINYINT,
    payment_value DECIMAL(10, 2),
    product_category_name VARCHAR(100),
    product_description_length INT,
    avg_delivery_days DECIMAL(15, 10) NULL,
    order_delivery_customer_date DATETIME NULL,
    order_purchase_timestamp DATETIME NULL,
    order_estimated_delivery_date DATETIME NULL,
    review_score TINYINT,
    order_status VARCHAR(50)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_analysis.csv'
INTO TABLE olist_complete_dataset
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 ROWS
(
    @v_customer_id, @v_customer_city, @v_customer_state, @v_geolocation_city, @v_geolocation_state, 
    @v_order_id, @v_product_category_name_english, @v_product_id, @v_seller_id, @v_seller_city, 
    @v_price, @v_freight_value, @v_payment_type, @v_payment_installments, @v_payment_value, 
    @v_product_category_name, @v_product_description_length, @v_avg_delivery_days, 
    @v_order_delivery_customer_date, @v_order_purchase_timestamp, @v_order_estimated_delivery_date, 
    @v_review_score, @v_order_status
)
SET 
    customer_id = NULLIF(NULLIF(@v_customer_id, 'NULL'), ''),
    customer_city = NULLIF(NULLIF(@v_customer_city, 'NULL'), ''),
    customer_state = NULLIF(NULLIF(@v_customer_state, 'NULL'), ''),
    geolocation_city = NULLIF(NULLIF(@v_geolocation_city, 'NULL'), ''),
    geolocation_state = NULLIF(NULLIF(@v_geolocation_state, 'NULL'), ''),
    order_id = NULLIF(NULLIF(@v_order_id, 'NULL'), ''),
    product_category_name_english = NULLIF(NULLIF(@v_product_category_name_english, 'NULL'), ''),
    product_id = NULLIF(NULLIF(@v_product_id, 'NULL'), ''),
    seller_id = NULLIF(NULLIF(@v_seller_id, 'NULL'), ''),
    seller_city = NULLIF(NULLIF(@v_seller_city, 'NULL'), ''),
    price = NULLIF(NULLIF(@v_price, 'NULL'), ''),
    freight_value = NULLIF(NULLIF(@v_freight_value, 'NULL'), ''),
    payment_type = NULLIF(NULLIF(@v_payment_type, 'NULL'), ''),
    payment_installments = NULLIF(NULLIF(@v_payment_installments, 'NULL'), ''),
    payment_value = NULLIF(NULLIF(@v_payment_value, 'NULL'), ''),
    product_category_name = NULLIF(NULLIF(@v_product_category_name, 'NULL'), ''),
    product_description_length = NULLIF(NULLIF(@v_product_description_length, 'NULL'), ''),
    
    -- Special handling for numeric/date columns to avoid import crashes
    avg_delivery_days = IF(@v_avg_delivery_days IN ('NULL', '', '#VALUE!'), NULL, @v_avg_delivery_days),
    
    order_delivery_customer_date = IF(@v_order_delivery_customer_date IN ('NULL', '') OR @v_order_delivery_customer_date < '1901-01-01', NULL, @v_order_delivery_customer_date),
    order_purchase_timestamp = IF(@v_order_purchase_timestamp IN ('NULL', '') OR @v_order_purchase_timestamp < '1901-01-01', NULL, @v_order_purchase_timestamp),
    order_estimated_delivery_date = IF(@v_order_estimated_delivery_date IN ('NULL', '') OR @v_order_estimated_delivery_date < '1901-01-01', NULL, @v_order_estimated_delivery_date),
    
    review_score = NULLIF(NULLIF(@v_review_score, 'NULL'), ''),
    order_status = NULLIF(NULLIF(@v_order_status, 'NULL'), '');