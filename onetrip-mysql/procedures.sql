DROP PROCEDURE IF EXISTS update_time_test;
DELIMITER //

CREATE PROCEDURE update_time_test(IN storeid INTEGER, IN waittime INTEGER)
BEGIN
    INSERT INTO wait_times(user_id, store_id, wait_time)
    VALUES(1, storeid, waittime);
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


-- DROP PROCEDURE IF EXISTS show_wait_times;
-- DELIMITER //

-- CREATE PROCEDURE show_wait_times(IN id INTEGER)
-- BEGIN
--     SELECT  FROM stores
--     WHERE senior_time_start IS NOT NULL
--     AND senior_time_end IS NOT NULL;
-- END//

-- DELIMITER ;



DROP PROCEDURE IF EXISTS show_senior_times;
DELIMITER //
CREATE PROCEDURE show_senior_times()
BEGIN
    SELECT store_name, store_address, senior_time_start, senior_time_end FROM stores
    WHERE senior_time_start IS NOT NULL
    AND senior_time_end IS NOT NULL;
END//
DELIMITER ;



DROP FUNCTION IF EXISTS latest_wait_time;
DELIMITER //
CREATE FUNCTION latest_wait_time(id INT) 
RETURNS INT READS SQL DATA
BEGIN
    RETURN (
      SELECT wait_time
      FROM wait_times
      WHERE wait_times.store_id = id
      ORDER BY wait_times.created DESC LIMIT 1
    );
END //
DELIMITER ;