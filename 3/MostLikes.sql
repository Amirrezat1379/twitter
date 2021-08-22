USE dbproject;

DELIMITER $$

DROP PROCEDURE PopularVoices;
CREATE PROCEDURE PopularVoices()`scope`:
BEGIN
	DECLARE setCurrentUser varchar(20);
    SET setCurrentUser = getCurrentUser();
    
    IF setCurrentUser IS NULL THEN
			SELECT 'There is no logined user!' AS `status`;
            LEAVE scope;
    END IF;
    
	SELECT voice_content
	FROM voice v
	WHERE sender_ID NOT IN (SELECT blocker_ID
						FROM blocking
						WHERE blocked_ID = setCurrentUser)
	ORDER BY (SELECT COUNT(*)
			FROM voices_liked VL
			WHERE V.voice_ID = VL.voice_ID) DESC;
END$$