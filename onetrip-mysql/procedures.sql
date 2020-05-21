/* 
Updates a store's wait times as the admin user (user_id = 1). 
*/
DROP PROCEDURE IF EXISTS update_time_test;
DELIMITER //

CREATE PROCEDURE update_time_test(IN storeid INTEGER, IN waittime INTEGER)
BEGIN
    INSERT INTO wait_times(user_id, store_id, wait_time)
    VALUES(1, storeid, waittime);
END//
DELIMITER ;

/* 
Updates a store's wait times as the admin user (user_id = 1). 
*/
DROP PROCEDURE IF EXISTS update_time_test;
DELIMITER //

CREATE PROCEDURE update_time_test(IN storeid INTEGER, IN waittime INTEGER)
BEGIN
    INSERT INTO wait_times(user_id, store_id, wait_time)
    VALUES(1, storeid, waittime);
END//
DELIMITER ;


/*
Shows the stores within a given city.
*/
DROP PROCEDURE IF EXISTS show_stores_city;
DELIMITER //
CREATE PROCEDURE show_stores_city(IN city VARCHAR(255))
BEGIN
    SELECT * FROM stores
    WHERE store_city LIKE city; 
END//
DELIMITER ;


/* 
Shows the store waiting time and store id WITHOUT checking if the store exists in the database.
*/
DROP PROCEDURE IF EXISTS store_info_test;
DELIMITER //
CREATE PROCEDURE store_info_test(IN postcode TEXT, IN phonenum TEXT, IN storename TEXT, IN storecity TEXT)
BEGIN
    IF (SELECT store_exists(postcode, phonenum)) = 1
    BEGIN
        SELECT latest_wait_time_post_code(postcode) as wait_time, 
        get_store_id_with_post_code(postcode) as store_id;
    END
END//
DELIMITER ;


/*
Shows the store waiting time and store id and adds the store to the database if it didn't exist before.
Test:  CALL store_info_create_if_doesnt_exist('V2Y1N5', '(604) 539-8901', 'Costco', 'Langley');
Returns: store_id: 14, wait_time: 5

Test:  CALL store_info_create_if_doesnt_exist('V3Z9N6', '(604) 541-9015', 'Walmart', 'Surrey');
Returns: store_id: INT, wait_time: NULL

Test:  CALL store_info_create_if_doesnt_exist('ABCDEF', '(123) 456-7890', 'Neverland', 'Vancouver');
Returns: store_id: INT, wait_time: NULL
*/
DROP PROCEDURE IF EXISTS store_info_create_if_doesnt_exist;
DELIMITER //
CREATE PROCEDURE store_info_create_if_doesnt_exist(IN postcode TEXT, IN phonenum TEXT, IN storename TEXT, IN storecity TEXT)
BEGIN
    IF (SELECT store_exists(postcode, phonenum)) = 1 THEN
        SELECT latest_wait_time_post_code_phone(postcode, phonenum) as wait_time, 
        last_updated((SELECT get_store_id_post_code_phone_num(postcode, phonenum))) as last_updated,
        get_average_time((SELECT get_store_id_post_code_phone_num(postcode, phonenum))) as average_time,
        get_store_id_post_code_phone_num(postcode, phonenum) as store_id;
    ELSE
        IF (SELECT get_store_id(storename)) IS NULL THEN
            INSERT INTO store_info (store_name) VALUES (storename);
        END IF;
        INSERT INTO stores (store_info_id, phone, store_post_code, store_city)
        VALUES ((SELECT get_store_id(storename)), phonenum, postcode, storecity);
        SELECT latest_wait_time_post_code_phone(postcode, phonenum) as wait_time, 
        get_average_time((SELECT get_store_id_post_code_phone_num(postcode, phonenum))) as average_time,
        last_updated((SELECT get_store_id_post_code_phone_num(postcode, phonenum))) as last_updated,

        get_store_id_post_code_phone_num(postcode, phonenum) as store_id;
    END IF;
END//
DELIMITER ;


/*
Returns the store_info_id of a store name and adds the store to the database if it didn't exist before.
*/
DROP PROCEDURE IF EXISTS create_store_if_doesnt_exist;
DELIMITER //
CREATE PROCEDURE create_store_if_doesnt_exist(IN storename TEXT)
BEGIN
    IF (SELECT get_store_id(storename)) <> NULL
    BEGIN
        RETURN get_store_id(storename);
    END
    ELSE
    BEGIN
        INSERT INTO store_info (store_name)
        VALUES (storename)
        RETURN (
            SELECT id FROM store_info WHERE store_name LIKE storename
        );
    END
END//
DELIMITER ;


/*
Determines if a store exists within the database using the postal code and phone number.
*/
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


/*
Returns the store_info id with a given store name.
*/
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


/*
Returns the store id with a given postal code and phone number.

Test: SELECT get_store_id_post_code_phone_num('V2Y1N5', '(604) 539-8901');
Returns: id: 14
*/
DROP FUNCTION IF EXISTS get_store_id_post_code_phone_num;
DELIMITER //
CREATE FUNCTION get_store_id_post_code_phone_num(postcode TEXT, phoneNum TEXT) 
RETURNS INT READS SQL DATA
BEGIN
    RETURN (
      SELECT id
      FROM stores
      WHERE store_post_code LIKE postcode
      AND phone LIKE phoneNum
    );
END //
DELIMITER ;


/*
Returns the store_info_id with a given postal code and phone number.
*/
DROP FUNCTION IF EXISTS store_info_id_with_post_code_phone_num;
DELIMITER //
CREATE FUNCTION store_info_id_with_post_code_phone_num(postcode TEXT, phoneNum TEXT) 
RETURNS INT READS SQL DATA
BEGIN
    RETURN (
      SELECT store_info_id
      FROM stores
      WHERE store_post_code LIKE postcode
      AND phone LIKE phoneNum
    );
END //
DELIMITER ;


/*
Returns the store id with a given postal code.
*/
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


/*
Shows store info with a given store id.
*/
DROP PROCEDURE IF EXISTS get_store_info_with_id;
DELIMITER //
CREATE PROCEDURE get_store_info_with_id(IN storeid INT)
BEGIN
    SELECT *, (SELECT store_name FROM store_info WHERE store_info.id = store_info_id) as store_name, latest_wait_time(stores.id) as wait_time 
    FROM stores WHERE id = storeid;
END//
DELIMITER ;


/*
Shows store info including the senior information with what.
*/
DROP PROCEDURE IF EXISTS get_store_info_with_id_senior;
DELIMITER //
CREATE PROCEDURE get_store_info_with_id_senior(IN storeid INT)
BEGIN
    SELECT stores.id, store_city, store_name, senior_hour_note, 
    latest_wait_time(stores.id) as wait_time,
    get_average_time(stores.id) as average_time,
    last_updated(stores.id) as last_updated
    FROM stores JOIN store_info ON store_info_id = store_info.id 
    WHERE stores.id = storeid;
END//
DELIMITER ;

/*
Calculates the time difference of the latest wait time for a store with a given store id.

Test: SELECT last_updated(1) as last_updated, latest_wait_time(1) as wait_time;
Returns: last updated: HHH:MM:SS, wait_time: n
*/
DROP FUNCTION IF EXISTS last_updated;
DELIMITER //
CREATE FUNCTION last_updated(id INT) 
RETURNS TIME READS SQL DATA
BEGIN
    RETURN (
      SELECT TIMEDIFF(CURRENT_TIMESTAMP, created)
      FROM wait_times
      WHERE wait_times.store_id = id
      ORDER BY wait_times.created DESC LIMIT 1
    );
END //
DELIMITER ;

/*
Shows stores info with a given store name.
*/
DROP PROCEDURE IF EXISTS get_store_info;
DELIMITER //
CREATE PROCEDURE get_store_info(IN storename VARCHAR(255))
BEGIN
    SELECT *, (SELECT store_name FROM store_info WHERE store_info.id = store_info_id) as store_name, latest_wait_time(stores.id) as wait_time 
    FROM stores WHERE store_info_id = get_store_id(storename);
END//
DELIMITER ;


/*
Returns the latest wait time for a given store.
*/
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


/*
Returns the latest wait time for a given store with a postal code and phone number.
*/
DROP FUNCTION IF EXISTS latest_wait_time_post_code_phone;
DELIMITER //
CREATE FUNCTION latest_wait_time_post_code_phone(postCode TEXT, phoneNum TEXT) 
RETURNS INT READS SQL DATA
BEGIN
    RETURN (
      SELECT wait_time
      FROM wait_times
      WHERE wait_times.store_id = (SELECT id FROM stores WHERE store_post_code LIKE postCode AND phone LIKE phoneNum)
      ORDER BY wait_times.created DESC LIMIT 1
    );
END //
DELIMITER ;

/*
Calculates the average wait time for a store.
*/
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