-- Create user and grant privilege to this user
CREATE USER 'Thu' IDENTIFIED BY 'password123';

GRANT SELECT ON thunguyen_guitar_shop.* TO 'Thu';
GRANT INSERT, UPDATE, DELETE ON customers TO 'Thu';

SHOW GRANTS FOR 'Thu';