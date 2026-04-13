CREATE TABLE product_category_dataset AS
SELECT 
    COALESCE(t.product_category_name_english, p.product_category_name) AS product_category,
    COUNT(oi.order_id) AS total_orders,
    SUM(oi.price) AS total_revenue,
    AVG(r.review_score) AS avg_review_score
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation t 
       ON p.product_category_name = t.product_category_name
LEFT JOIN order_reviews r ON oi.order_id = r.order_id
GROUP BY p.product_category_name,t.product_category_name_english;