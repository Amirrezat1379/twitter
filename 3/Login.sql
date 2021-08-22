USE dbproject;

DELIMITER $$

DROP PROCEDURE userlogin;
CREATE PROCEDURE userlogin (userID VARCHAR(20), pass VARCHAR(20))`scope`:
BEGIN
	IF userID NOT IN (SELECT ID
			  FROM user) THEN
			SELECT 'There is not user with that ID.' AS `status`;
            LEAVE scope;
    END IF;
    
    IF NOT EXISTS (SELECT *
				   FROM user
                   WHERE pasword = sha2(pass, 512)) THEN
                   SELECT 'Password is incorrect' AS `status`;
            LEAVE scope;
	END IF;
		
	INSERT INTO login(user_ID,login_time)
	SELECT userID, now()
	WHERE EXISTS (SELECT ID, pasword 
				FROM user 
                WHERE ID = userID AND pasword = sha2(pass, 512));
	SELECT * FROM login;
END $$