CREATE TABLE product_level_dataset AS
SELECT
    p.product_id,
    p.product_category_name,
    p.product_photos_qty,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm,
    COALESCE(t.product_category_name_english, p.product_category_name) AS product_category,
    COUNT(oi.order_id) AS total_orders,
    SUM(oi.price) AS total_revenue,
    AVG(r.review_score) AS avg_review_score
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN product_category_name_translation t
       ON p.product_category_name = t.product_category_name
LEFT JOIN order_reviews r ON oi.order_id = r.order_id
GROUP BY 
    p.product_id, p.product_category_name, p.product_photos_qty,
    p.product_weight_g, p.product_length_cm, p.product_height_cm, p.product_width_cm,
    COALESCE(t.product_category_name_english, p.product_category_name);