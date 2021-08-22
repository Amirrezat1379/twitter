USE dbproject;

DELIMITER $$

DROP PROCEDURE addTag;
CREATE PROCEDURE addTag(voiceID int, myTag varchar(6))`scope`:
BEGIN
	INSERT INTO hashtag
		SELECT myTag, voiceID
		WHERE myTag LIKE '#_____' AND myTag NOT IN (select tag from hashtag) AND voiceID IN (select voice_ID from voice);
END$$