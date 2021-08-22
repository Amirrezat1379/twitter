USE dbproject;

DELIMITER $$

DROP PROCEDURE MyVoices;
CREATE PROCEDURE MyVoices()`scope`:
BEGIN
	DECLARE setCurrentUser varchar(20);
    SET setCurrentUser = getCurrentUser();
    
    IF setCurrentUser IS NULL THEN
			SELECT 'There is no logined user!' AS `status`;
            LEAVE scope;
    END IF;
    
	SELECT  voice_content, send_date
	FROM voice
	WHERE sender_ID = setCurrentUser
	ORDER BY send_date DESC; 
END$$