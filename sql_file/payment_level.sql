CREATE TABLE payment_analysis_dataset AS
SELECT 
    o.order_id,
    c.customer_unique_id,
    p.payment_type,
    p.payment_installments,
    p.payment_value,
    o.order_purchase_timestamp AS order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_payments p ON o.order_id = p.order_id;