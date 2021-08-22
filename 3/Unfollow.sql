USE dbproject;

DELIMITER $$

DROP PROCEDURE Unfollow;
CREATE PROCEDURE Unfollow(followedUser varchar(20))`scope`:
BEGIN
	DECLARE setCurrentUser varchar(20);
    SET setCurrentUser = getCurrentUser();
    
    IF setCurrentUser IS NULL THEN
			SELECT 'There is no logined user!' AS `status`;
            LEAVE scope;
    END IF;
    
    IF followedUser NOT IN (
		SELECT ID
        FROM user
    ) THEN
			SELECT 'There is no user with this username!' AS `status`;
            LEAVE scope;
    END IF;
    
    IF NOT EXISTS (
		SELECT *
        from follow
        WHERE follower_ID = setCurrentUser AND followed_ID = followedUser
    ) THEN
			SELECT 'This user hasn`t been followed by you!' AS `status`;
            LEAVE scope;
    END IF;
    
	DELETE FROM follow WHERE follower_ID = setCurrentUser AND followed_ID = followedUser;
    SELECT * FROM follow;
END$$