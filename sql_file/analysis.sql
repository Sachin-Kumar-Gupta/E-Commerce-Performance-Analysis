create table customers(
customer_id varchar(50),
customer_unique_id varchar(50),
customer_zip_code_prefix varchar(10),
customer_city varchar(50),
customer_state varchar(50)
);

select * from customers;

create table geolocation_dataset(
geolocation_zip_code_prefix varchar(10),
geolocation_lat DOUBLE PRECISION,
geolocation_lng DOUBLE PRECISION,
geolocation_city varchar(100),
geolocation_state varchar(100)
);

select * from geolocation_dataset;

create table order_items(
order_id varchar(100),
order_item_id int,
product_id varchar(100),
seller_id varchar(100),
shipping_limit_date timestamp,
price NUMERIC(10,2),
freight_value NUMERIC(10,2)
);

select * from order_items;

create table order_payments(
order_id varchar(100),
payment_sequential int,
payment_type varchar(50),
payment_installments int,
payment_value NUMERIC(10,2)
);

select * from order_payments;

create table order_reviews(
review_id varchar(100),
order_id varchar(100),
review_score int,
review_comment_title varchar(100),
review_comment_message varchar(500),
review_creation_date timestamp,
review_answer_timestamp timestamp
);

select * from order_reviews;

create table orders(
order_id varchar(100),
customer_id varchar(100),
order_status varchar(50),
order_purchase_timestamp timestamp,
order_approved_at timestamp,
order_delivered_carrier_date timestamp,
order_delivered_customer_date timestamp,
order_estimated_delivery_date timestamp
);

select * from orders;

create table product_category_name_translation(
product_category_name varchar(200),
product_category_name_english varchar(200)
);

select * from product_category_name_translation;

create table products(
product_id varchar(100),
product_category_name varchar(100),
product_name_length bigint,
product_description_lenght bigint,
product_photos_qty bigint,
product_weight_g bigint,
product_length_cm bigint,
product_height_cm bigint,
product_width_cm bigint
);

select * from products;

create table sellers(
seller_id varchar(100),
seller_zip_code_prefix varchar(10),
seller_city varchar(50),
seller_state varchar(50)
);

select * from sellers;

CREATE OR REPLACE VIEW ecommerce_dashboard AS
SELECT 
    o.order_id,
    o.order_purchase_timestamp AS order_date,
    c.customer_city,
    c.customer_state,
    t.product_category_name_english AS product_category,
    oi.price,
    pay.payment_value,
    EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_purchase_timestamp))/86400 AS delivery_days,
    r.review_score,
    s.seller_city,
    s.seller_state
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation t 
       ON p.product_category_name = t.product_category_name
LEFT JOIN order_payments pay ON o.order_id = pay.order_id
LEFT JOIN order_reviews r ON o.order_id = r.order_id
JOIN sellers s ON oi.seller_id = s.seller_id;

select * from ecommerce_dashboard

select * from customers

select customer_id, count(*)
from customers
group by customer_id
having count(*) > 1;

-- Creating final dataset one by one 
create table final_orders_dataset as
with order_item_agg as(
select order_id,sum(price) as total_price, sum(freight_value) as total_freight, 
count(*) as total_items
from order_items
group by order_id
),
payment_agg as(
select order_id, sum(payment_value) as total_payment_value
from order_payments
group by order_id
),
review_agg as(
select order_id, avg(review_score) as avg_review_score
from order_reviews
group by order_id
)
select
o.order_id,
o.customer_id,
c.customer_unique_id,
o.order_status,
o.order_purchase_timestamp AS order_date,
o.order_approved_at,
o.order_delivered_carrier_date,
o.order_delivered_customer_date,
o.order_estimated_delivery_date,
c.customer_city,
c.customer_state,
oi.total_price,
oi.total_freight,
oi.total_items,
p.total_payment_value,
r.avg_review_score,
EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_purchase_timestamp))/86400 AS delivery_days
from orders o
join customers c on o.customer_id = c.customer_id
left join order_item_agg oi on o.order_id = oi.order_id
left join payment_agg p on o.order_id = p.order_id
left join review_agg r on o.order_id = r.order_id;

select distinct(count(order_id)) from final_orders_dataset
