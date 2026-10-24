USE goit_rdb_hw_03;

SELECT od.id AS order_detail_id, o.id AS order_id, o.date AS order_date,
       c.name AS customer_name, p.name AS product_name, cat.name AS category_name,
       e.employee_id, e.first_name, e.last_name,
       sh.name AS shipper_name, s.name AS supplier_name, od.quantity
FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.id
INNER JOIN customers AS c ON o.customer_id = c.id
INNER JOIN products AS p ON od.product_id = p.id
INNER JOIN categories AS cat ON p.category_id = cat.id
INNER JOIN employees AS e ON o.employee_id = e.employee_id
INNER JOIN shippers AS sh ON o.shipper_id = sh.id
INNER JOIN suppliers AS s ON p.supplier_id = s.id;
