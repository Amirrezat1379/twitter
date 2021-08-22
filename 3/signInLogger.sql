USE dbproject;

CREATE TABLE IF NOT EXISTS signInLog (
	ID varchar(20),
	time_joined datetime,
	primary key(ID, time_joined)
);

DELIMITER $$

CREATE TRIGGER signInLogger
	AFTER INSERT
    ON user FOR EACH ROW
BEGIN
    INSERT INTO signInLogger(ID, time_joined) VALUES (NEW.ID, now());
END$$