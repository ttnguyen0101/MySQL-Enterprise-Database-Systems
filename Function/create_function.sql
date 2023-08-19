-- Create a function that calculates the order total using order id
DROP FUNCTION IF EXISTS order_total;
DELIMITER //
CREATE FUNCTION order_total(order_id_input INT)
    RETURNS DECIMAL(10, 2)
    DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE order_total_output DECIMAL (10, 2);

    SELECT (sale_price * qty) INTO order_total_output
    FROM order_items
    WHERE order_id = order_id_input;

    RETURN (order_total_output);
END //
DELIMITER ;

-- Call the function
SELECT order_id, sale_price, qty, order_total(order_id) FROM order_items;