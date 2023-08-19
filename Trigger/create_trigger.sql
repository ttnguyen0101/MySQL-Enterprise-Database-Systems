-- Create triggers to populate the customers_audit table whenever there is an update to the customers table. Both old and new values are included.
DROP TRIGGER IF EXISTS customers_after_insert;
DROP TRIGGER IF EXISTS customers_after_delete;
DROP TRIGGER IF EXISTS customers_after_update;
DELIMITER //

CREATE TRIGGER customers_after_insert
    AFTER INSERT ON customers
    FOR EACH ROW
BEGIN
    INSERT INTO customers_audit
    VALUES (NEW.customer_id, NEW.customer_name, NEW.email, NEW.phone, NEW.reward_points, 'INSERTED', NOW());
END//

CREATE TRIGGER customers_after_delete
    AFTER DELETE ON customers
    FOR EACH ROW
BEGIN
    INSERT INTO customers_audit
    VALUES (OLD.customer_id, OLD.customer_name, OLD.email, OLD.phone, OLD.reward_points, 'DELETED', NOW());
END//

CREATE TRIGGER customers_after_update
    AFTER UPDATE ON customers
    FOR EACH ROW
BEGIN
    INSERT INTO customers_audit
    VALUES 
    (OLD.customer_id, OLD.customer_name, OLD.email, OLD.phone, OLD.reward_points, 'OLD', NOW()),
    (NEW.customer_id, NEW.customer_name, NEW.email, NEW.phone, NEW.reward_points, 'NEW', NOW());
END//

DELIMITER ;