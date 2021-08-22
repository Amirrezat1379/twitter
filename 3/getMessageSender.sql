USE dbproject;

DELIMITER $$

DROP PROCEDURE getMessageSender;
CREATE PROCEDURE getMessageSender()`scope`:
BEGIN
	DECLARE setCurrentUser varchar(20);
    SET setCurrentUser = getCurrentUser();
    
    IF setCurrentUser IS NULL THEN
			SELECT 'There is no user logined!' AS `status`;
            LEAVE scope;
    END IF;

	SELECT DISTINCT M.sender_ID, message_ID
	FROM message M, voice V
	WHERE resiver_ID = setCurrentUser AND ((type_of_message = 0) OR (type_of_message = 1 AND M.voice_ID = V.voice_ID))
	ORDER BY M.send_date;
END$$