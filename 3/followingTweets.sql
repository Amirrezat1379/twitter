USE dbproject;

DELIMITER $$

DROP PROCEDURE followingVoices;
CREATE PROCEDURE followingvoices()`scope`:
BEGIN
	DECLARE setCurrentUser varchar(20);
    SET setCurrentUser = getCurrentUser();
    
    IF setCurrentUser IS NULL THEN
			SELECT 'There is no logined user!' AS `status`;
            LEAVE scope;
    END IF;
    
	SELECT voice_content
	FROM follow, voice
	WHERE follower_ID = setCurrentUser AND followed_ID = sender_ID AND sender_ID NOT IN (SELECT blocker_ID
																						 FROM blocking
																						 WHERE blocked_ID = setCurrentUser)
	ORDER BY send_date DESC;
END$$