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

DROP FUNCTION IF EXISTS get_store_id;
DELIMITER //
CREATE FUNCTION get_store_id(storename VARCHAR(255)) 
RETURNS INT READS SQL DATA
BEGIN
    RETURN (
      SELECT id
      FROM store_info
      WHERE store_name LIKE storename
    );
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS get_store_info_with_id;
DELIMITER //
CREATE PROCEDURE get_store_info_with_id(IN storeid INT)
BEGIN
    SELECT *, (SELECT store_name FROM store_info WHERE store_info.id = store_info_id) as store_name, latest_wait_time(stores.id) as wait_time 
    FROM stores WHERE id = storeid;
END//
DELIMITER ;


DROP PROCEDURE IF EXISTS get_store_info_with_id_senior;
DELIMITER //
CREATE PROCEDURE get_store_info_with_id_senior(IN storeid INT)
BEGIN
    SELECT stores.id, phone, store_address, store_post_code, store_city, store_name, senior_hour_note, latest_wait_time(stores.id) as wait_time 
    FROM stores JOIN store_info ON store_info_id = store_info.id 
    WHERE stores.id = storeid;
END//
DELIMITER ;


DROP PROCEDURE IF EXISTS get_store_info;
DELIMITER //
CREATE PROCEDURE get_store_info(IN storename VARCHAR(255))
BEGIN
    SELECT *, (SELECT store_name FROM store_info WHERE store_info.id = store_info_id) as store_name, latest_wait_time(stores.id) as wait_time 
    FROM stores WHERE store_info_id = get_store_id(storename);
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