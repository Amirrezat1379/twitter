USE dbproject;

DELIMITER $$

DROP PROCEDURE SendMessage;
CREATE PROCEDURE SendMessage(resiver varchar(20), mtype int, voiceID int, mtext varchar(256))`scope`:
BEGIN
	DECLARE setCurrentUser varchar(20);
    SET setCurrentUser = getCurrentUser();
    
    IF setCurrentUser IS NULL THEN
			SELECT 'There is no logined user!' AS `status`;
            LEAVE scope;
    END IF;
    
    IF setCurrentUser IN (
		SELECT blocked_ID
        FROM blocking
        WHERE blocker_ID = resiver
    ) THEN
			SELECT 'Sorry! You were banned by receiver of this message!' AS `status`;
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
    
	INSERT INTO message (sender_ID, resiver_ID, messagetext, voice_ID, send_date, type_of_message)
	SELECT setCurrentUser, resiver, mtext, voiceID, now(), mtype
	WHERE EXISTS (
	SELECT *
	FROM voice
	WHERE ((mtype = 0 AND resiver NOT IN (SELECT blocker_ID FROM blocking WHERE blocked_ID = setCurrentUser)) 
	OR (voice_ID = voiceID AND mtype = 1 AND sender_ID NOT IN (SELECT blocker_ID FROM blocking WHERE blocked_ID = setCurrentUser)
    AND resiver NOT IN (SELECT blocker_ID FROM blocking WHERE blocked_ID = setCurrentUser))));
    
    select * from message;
END$$