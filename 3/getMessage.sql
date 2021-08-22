USE dbproject;

DELIMITER $$

DROP PROCEDURE getMessage;
CREATE PROCEDURE getMessage(senderID varchar(20))`scope`:
BEGIN
	DECLARE setCurrentUser varchar(20);
    SET setCurrentUser = getCurrentUser();
    
    IF setCurrentUser IS NULL THEN
			SELECT 'There is no user logined!' AS `status`;
            LEAVE scope;
    END IF;
    
    IF senderID NOT IN (
		SELECT ID
        FROM user
    ) THEN
			SELECT 'There is no user with this ID!' AS `status`;
            LEAVE scope;
    END IF;
    
	SELECT messageText, voice_content
	FROM message M, voice V
	WHERE (m.sender_ID = senderID AND m.resiver_ID = setCurrentUser AND type_of_message = 0 AND M.sender_ID NOT IN (SELECT blocker_ID FROM blocking WHERE blocked_ID = setCurrentUser) AND V.voice_ID = 36) OR 
	(m.sender_ID = senderID AND m.resiver_ID = setCurrentUser AND M.voice_ID = V.voice_ID AND type_of_message = 1 AND M.sender_ID NOT IN (SELECT blocker_ID FROM blocking WHERE blocked_ID = setCurrentUser)
    AND V.sender_ID NOT IN (SELECT blocker_ID FROM blocking WHERE blocked_ID = setCurrentUser));
END$$