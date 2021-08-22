USE dbproject;

DELIMITER $$

DROP PROCEDURE getHashtag;
CREATE PROCEDURE getHashtag(tags varchar(6))`scope`:
BEGIN
	DECLARE setCurrentUser varchar(20);
    SET setCurrentUser = getCurrentUser();
    
    IF setCurrentUser IS NULL THEN
			SELECT 'There is no logined user!' AS `status`;
            LEAVE scope;
    END IF;
    
	SELECT voice_content
	FROM hashtag H, voice V
	WHERE tag = tags AND H.voice_ID = V.voice_ID AND sender_ID NOT IN (SELECT blocker_ID
																	FROM blocking
																	WHERE blocked_ID = setCurrentUser);
END$$