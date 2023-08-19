-- Create a view of total sales in last month

CREATE OR REPLACE VIEW last_month_revenue AS
SELECT product_name AS 'Product Name', SUM(qty) AS 'Quantity Sold Last Month', (sale_price * qty) AS 'Total Sale Last Month'
FROM  order_items oi
INNER JOIN products p ON p.product_id = oi.product_id
INNER JOIN orders o ON o.order_id = oi.order_id
WHERE MONTH(date) = MONTH(NOW() - INTERVAL 1 MONTH)
GROUP BY oi.product_id
ORDER BY (sale_price * qty) DESC;

SELECT * FROM last_month_revenue;