USE goit_rdb_hw_03;

SELECT cat.name AS category_name, COUNT(*) AS row_count,
       AVG(od.quantity) AS average_quantity
FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.id
INNER JOIN customers AS c ON o.customer_id = c.id
INNER JOIN products AS p ON od.product_id = p.id
INNER JOIN categories AS cat ON p.category_id = cat.id
INNER JOIN employees AS e ON o.employee_id = e.employee_id
INNER JOIN shippers AS sh ON o.shipper_id = sh.id
INNER JOIN suppliers AS s ON p.supplier_id = s.id
WHERE e.employee_id > 3 AND e.employee_id <= 10
GROUP BY cat.name;
