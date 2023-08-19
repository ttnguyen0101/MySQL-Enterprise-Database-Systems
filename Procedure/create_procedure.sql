-- Create a procedure with error handler when adding new employee
DROP PROCEDURE IF EXISTS new_employee;
DELIMITER //
CREATE PROCEDURE new_employee (
	new_employee_id INT,
    new_employee_name VARCHAR(100),
    new_shift VARCHAR(45),
    new_salary DECIMAL(10,2),
    new_position VARCHAR(45),
    new_email VARCHAR(45),
    new_phone VARCHAR(45)
)
BEGIN
	-- error handler for duplicate rows
	DECLARE duplicate_key TINYINT DEFAULT FALSE;
	DECLARE CONTINUE HANDLER FOR 1062
		SET duplicate_key = TRUE;
    
    -- insert new employee
	INSERT INTO employees VALUE
    (new_employee_id, new_employee_name, new_shift, new_salary, new_position, new_email, new_phone);
    
    IF duplicate_key = TRUE THEN
		SELECT 'Row was not inserted - duplicate entry' AS 'Message';
	ELSE 
		SELECT '1 row was inserted' AS 'Message';
    END IF; 
END //
DELIMITER ;