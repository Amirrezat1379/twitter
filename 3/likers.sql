USE dbproject;

DELIMITER $$

DROP PROCEDURE likers;
CREATE PROCEDURE likers(voiceID int)`scope`:
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
    
    IF setCurrentUser IN (
		SELECT blocked_ID
		FROM blocking
		WHERE blocker_ID = (
			SELECT sender_ID
            FROM voice
            WHERE voice_ID = voiceID
		)
    ) THEN
			SELECT 'Sorry! You were banned by sender of this tweet!' AS `status`;
            LEAVE scope;
    END IF;
    
	SELECT user_ID
	FROM voices_liked VL, voice V
	WHERE VL.voice_ID = V.voice_ID AND V.voice_ID = voiceID AND sender_ID NOT IN (SELECT blocker_ID
																				   FROM blocking
																				   WHERE blocked_ID = setCurrentUser);
END$$