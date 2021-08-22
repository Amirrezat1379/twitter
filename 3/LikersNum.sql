USE dbproject;

DELIMITER $$

DROP PROCEDURE likersNumber;
CREATE PROCEDURE likersNumber(voiceID int)`scope`:
BEGIN
	DECLARE setCurrentUser varchar(20);
    SET setCurrentUser = getCurrentUser();
    
    IF setCurrentUser IS NULL THEN
			SELECT 'There is no logined user!' AS `status`;
            LEAVE scope;
    END IF;
    
	IF voiceID NOT IN (
		SELECT voice_ID
        FROM voice
    ) THEN
			SELECT 'Selected voice wasn`t found!' AS `status`;
            LEAVE scope;
    END IF;
    
	SELECT COUNT(*) as 'Number of likes'
	FROM voices_liked VL, voice V
	WHERE V.voice_ID = voiceID AND VL.voice_ID = V.voice_ID AND V.sender_ID NOT IN (SELECT blocker_ID
												FROM blocking
												WHERE blocked_ID = setCurrentUser);
END$$