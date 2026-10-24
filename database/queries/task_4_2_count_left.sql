USE goit_rdb_hw_03;

SELECT COUNT(*) AS row_count
FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.id
INNER JOIN customers AS c ON o.customer_id = c.id
INNER JOIN products AS p ON od.product_id = p.id
INNER JOIN categories AS cat ON p.category_id = cat.id
INNER JOIN employees AS e ON o.employee_id = e.employee_id
LEFT JOIN shippers AS sh ON o.shipper_id = sh.id
LEFT JOIN suppliers AS s ON p.supplier_id = s.id;
