USE dbproject;

DELIMITER $$

DROP PROCEDURE sendReply;
CREATE PROCEDURE sendReply(voiceID int, content varchar(256))`scope`:
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
			SELECT 'Sorry! You were banned by sender of this voice!' AS `status`;
            LEAVE scope;
    END IF;
    
	INSERT INTO voice(sender_ID,voice_content,send_date) VALUES (setCurrentUser, content, now());

	INSERT INTO reply(voice_ID, replied_ID)
	select voice_ID, voiceID FROM voice ORDER BY voice_ID DESC LIMIT 1;
    
    SELECT * FROM reply;

END$$