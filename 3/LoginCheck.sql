USE dbproject;

DELIMITER $$

drop procedure UserLoginHistory;
CREATE PROCEDURE UserLoginHistory (userID varchar(20))`scope`:
BEGIN
	IF userID NOT IN (
		SELECT ID
        FROM user
    ) THEN
			SELECT 'User not found! Please sign up first!' AS `status`;
            LEAVE scope;
    END IF;
    
    IF userID NOT IN (
		SELECT user_ID
        FROM login
	) THEN
		SELECT 'User not login!' AS `status`;
        LEAVE scope;
	END IF;
	SELECT login_time
	FROM login 
	WHERE user_ID = userID
	ORDER BY login_time DESC;
END$$