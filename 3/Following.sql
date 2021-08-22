USE dbproject;

DELIMITER $$

DROP PROCEDURE FollowingUser;
CREATE PROCEDURE FollowingUser(followedUser varchar(20))`scope`:
BEGIN
	DECLARE setCurrentUser varchar(20);
    SET setCurrentUser = getCurrentUser();
    
    IF setCurrentUser IS NULL THEN
			SELECT 'There is no user logined!' AS `status`;
            LEAVE scope;
    END IF;
    
    IF followedUser NOT IN (
		SELECT ID
        FROM user
    ) THEN
			SELECT 'There is no user with this ID!' AS `status`;
            LEAVE scope;
    END IF;
    
    IF followedUser IN (
		SELECT followed_ID
        FROM follow
        WHERE follower_ID = setCurrentUser
    ) THEN
			SELECT 'You have followed this user!' AS `status`;
            LEAVE scope;
    END IF;
    
    IF setCurrentUser = followedUser THEN
			SELECT 'You cannot follow yourself!' AS `status`;
            LEAVE scope;
    END IF;
    
	INSERT INTO follow VALUES (setCurrentUser,followedUser);
    SELECT * FROM follow;
    
END$$