USE dbproject;

CREATE TABLE IF NOT EXISTS sendVoiceLog (
	sender_ID varchar(20),
    voice_ID int,
    send_date datetime,
    primary key(sender_ID, voice_ID)
);

DELIMITER $$

DROP TRIGGER sendVoiceLogger;
CREATE TRIGGER sendVoiceLogger
	AFTER INSERT
    ON voice FOR EACH ROW
BEGIN
	INSERT INTO sendVoiceLog VALUES (NEW.sender_ID, NEW.voice_ID, now());
END$$