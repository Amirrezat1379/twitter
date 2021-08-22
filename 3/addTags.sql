USE dbproject;

delimiter $$

DROP PROCEDURE addHashtag;
CREATE PROCEDURE addHashtag(text_in varchar(256), voiceID int)
BEGIN 
	DECLARE x int;
	DECLARE subs varchar(6);
    
    SET x = 1;
    
	loop_label : LOOP
		SET subs = REGEXP_SUBSTR(text_in, '#.....', 1, x);
        IF subs is NULL THEN
			LEAVE loop_label;
        END IF;
        
        SET x = x + 1;
        IF TRIM(subs) LIKE '#_____' THEN 
			call addTag(voiceID, subs);
		END IF;
        
	END LOOP loop_label;
END$$

DROP TRIGGER addTags;
CREATE TRIGGER addTags
	AFTER INSERT
    ON voice FOR EACH ROW
BEGIN
	call addHashtag(NEW.voice_content, NEW.voice_ID);
END$$

delimiter ;
