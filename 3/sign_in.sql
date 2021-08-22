USE dbproject;

DELIMITER $$

DROP PROCEDURE sign_in;
CREATE PROCEDURE sign_in(
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	ID VARCHAR(20),
	pasword VARCHAR(128),
	birth_date DATE,
	Bio VARCHAR(64)
) `scope`:
BEGIN
	IF EXISTS (SELECT ID
			  FROM user U
              WHERE U.ID = ID) THEN
			SELECT 'There is user with that ID!' as `status`;
            LEAVE scope;
    END IF;
		
	INSERT INTO user VALUES (first_name, last_name, ID, sha2(pasword, 512), birth_date, curdate(), Bio);
select *
from user;
END $$
select *
from user;
