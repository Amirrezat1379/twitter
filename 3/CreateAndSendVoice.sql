USE dbproject;

DELIMITER $$

drop procedure sendVoice;
CREATE PROCEDURE sendVoice(content varchar(256))`scope`:
BEGIN
	DECLARE setCurrentUser varchar(20);
    SET setCurrentUser = getCurrentUser();
    
    IF setCurrentUser IS NULL THEN
			SELECT 'There is no logined user!' AS `status`;
            LEAVE scope;
    END IF;
    
	INSERT INTO voice(sender_ID,voice_content,send_date) VALUES (setCurrentUser, content, now());
    
    SELECT * FROM voice;
END$$