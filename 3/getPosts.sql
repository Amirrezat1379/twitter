USE dbproject;

DELIMITER $$

DROP PROCEDURE getPost;
CREATE PROCEDURE getPost(senderID varchar(20))`scope`:
BEGIN
	DECLARE setCurrentUser varchar(20);
    SET setCurrentUser = getCurrentUser();
    
    IF setCurrentUser IS NULL THEN
			SELECT 'There is no logined user!' AS `status`;
            LEAVE scope;
    END IF;
    
    IF senderID NOT IN (
		SELECT ID
        FROM user
    ) THEN
			SELECT 'There is no user with this username!' AS `status`;
            LEAVE scope;
    END IF;
    
    IF setCurrentUser IN (
		SELECT blocked_ID
        FROM blocking
        WHERE blocker_ID = senderID
    ) THEN
			SELECT 'Sorry! You were banned by this user!' AS `status`;
            LEAVE scope;
    END IF;
    
	SELECT *
	FROM voice
	WHERE sender_ID = senderID AND sender_ID NOT IN (SELECT blocker_ID
											FROM blocking
											WHERE blocked_ID = setCurrentUser);
END$$