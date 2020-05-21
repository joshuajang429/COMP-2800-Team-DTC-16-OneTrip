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

DROP PROCEDURE IF EXISTS show_senior_times;
DELIMITER //
CREATE PROCEDURE show_senior_times()
BEGIN
    SELECT store_name, store_address, senior_time_start, senior_time_end FROM stores
    WHERE senior_time_start IS NOT NULL
    AND senior_time_end IS NOT NULL;
END//
DELIMITER ;


DROP PROCEDURE IF EXISTS store_info_create_if_doesnt_exist;
DELIMITER //
CREATE PROCEDURE store_info_create_if_doesnt_exist(IN postcode TEXT, IN phonenum TEXT, IN storename TEXT, IN storecity TEXT)
BEGIN
    IF (SELECT store_exists(postcode, phonenum)) = 0 THEN
        INSERT INTO stores (store_info_id, phone, store_post_code, store_city)
        VALUES ((SELECT get_store_id(storename)), phonenum, postcode, storecity)
    END IF;

    SELECT latest_wait_time_post_code(postcode) as wait_time, 
        get_store_id_with_post_code(postcode) as store_id;
END//
DELIMITER ;

DROP FUNCTION IF EXISTS store_exists;
DELIMITER //
CREATE FUNCTION store_exists(post_code TEXT, phone_num TEXT) 
RETURNS INT READS SQL DATA
BEGIN
    RETURN (
      SELECT 1
      FROM stores
      WHERE phone LIKE phone_num AND store_post_code LIKE post_code
    );
END //
DELIMITER ;

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

DROP FUNCTION IF EXISTS get_store_id_with_post_code;
DELIMITER //
CREATE FUNCTION get_store_id_with_post_code(postcode TEXT) 
RETURNS INT READS SQL DATA
BEGIN
    RETURN (
      SELECT id
      FROM stores
      WHERE store_post_code LIKE postcode
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

DROP FUNCTION IF EXISTS get_average_time;
DELIMITER //
CREATE FUNCTION get_average_time(id INT)
RETURNS INT READS SQL DATA
BEGIN
    RETURN (
        SELECT avg(wait_time)
        FROM wait_times
        WHERE wait_times.store_id = id
    );
END //
DELIMITER ;