DROP PROCEDURE IF EXISTS update_time;

DELIMITER //

CREATE PROCEDURE update_time()
BEGIN
    INSERT INTO wait_times(user_id, store_id, wait_time)
    VALUES(...);
END//

DELIMITER ;


DROP PROCEDURE IF EXISTS show_stores_city;

DELIMITER //
CREATE PROCEDURE show_stores_city(IN city VARCHAR(255))
BEGIN
    SELECT * FROM stores
    WHERE store_city LIKE city; 
END//
DELIMITER ;


DROP PROCEDURE IF EXISTS shopw_senior_times;
DELIMITER //

CREATE PROCEDURE show_senior_times()
BEGIN
    SELECT store_name, store_address, senior_time_start, senior_time_end FROM stores
    WHERE senior_time_start IS NOT NULL
    AND senior_time_end IS NOT NULL;
END//

DELIMITER ;