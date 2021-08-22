USE dbproject;

DELIMITER $$

DROP PROCEDURE unblock;
CREATE PROCEDURE unblock(bannedUser varchar(20))`scope`:
BEGIN
	DECLARE setCurrentUser varchar(20);
    SET setCurrentUser = getCurrentUser();
    
    IF setCurrentUser IS NULL THEN
			SELECT 'There is no logined user!' AS `status`;
            LEAVE scope;
    END IF;
    
    IF NOT EXISTS (
		SELECT *
        FROM blocking
        WHERE blocker_ID = setCurrentUser AND blocked_ID = bannedUser
    ) THEN
			SELECT 'This user was not banned!' AS `status`;
            LEAVE scope;
    END IF;
    
	DELETE 
	FROM blocking
	WHERE blocker_ID = setCurrentUser AND bannedUser = blocked_ID;
    
    SELECT * FROM blocking;
END$$