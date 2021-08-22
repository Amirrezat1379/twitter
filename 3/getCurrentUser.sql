USE dbproject;
SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER $$

DROP FUNCTION getCurrentUser;
CREATE FUNCTION getCurrentUser()
RETURNS VARCHAR(20)
NOT deterministic
BEGIN
    RETURN (SELECT user_ID
			FROM login
			ORDER BY login_time DESC
			LIMIT 1);
END$$