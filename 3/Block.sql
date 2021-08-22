USE dbproject;

DELIMITER $$

DROP PROCEDURE blocked;
CREATE PROCEDURE blocked(bannedUser varchar(20))`scope`:
BEGIN
	DECLARE setCurrentUser varchar(20);
    SET setCurrentUser = getCurrentUser();
    
    IF setCurrentUser IS NULL THEN
			SELECT 'There is no logined user!' AS `status`;
            LEAVE scope;
    END IF;
    
    IF bannedUser NOT IN (
		SELECT ID
        FROM user
    ) THEN
			SELECT 'There is no user with this username!' AS `status`;
            LEAVE scope;
    END IF;
    
    IF bannedUser IN (
		SELECT blocked_ID
        FROM blocking
        WHERE blocker_ID = setCurrentUser
    ) THEN
			SELECT 'You have blocked user!' AS `status`;
            LEAVE scope;
    END IF;
    
    IF setCurrentUser = bannedUser THEN
			SELECT 'Sorry! You connot ban yourself!' AS `status`;
            LEAVE scope;
    END IF;
    
	INSERT INTO blocking
	SELECT setCurrentUser, bannedUser
	WHERE NOT EXISTS(
	SELECT *
	FROM blocking
	WHERE blocker_ID = setCurrentUser AND blocked_ID = bannedUser)
    AND setCurrentUser <> bannedUser;
    
    SELECT * FROM blocking;
END$$