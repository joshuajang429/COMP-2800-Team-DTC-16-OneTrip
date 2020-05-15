CREATE DATABASE onetrip;

DROP TABLE IF EXISTS store_info;
DROP TABLE IF EXISTS stores;
DROP TABLE IF EXISTS wait_times;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS store_hours;


CREATE TABLE store_info (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    store_name VARCHAR(50) NOT NULL,
    senior_hour_note TEXT DEFAULT NULL
);

CREATE TABLE stores (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    store_info_id INTEGER NOT NULL,
    phone VARCHAR(10) NOT NULL,
    store_address VARCHAR(255) NOT NULL,
    store_post_code VARCHAR(6) NOT NULL,
    store_city VARCHAR(50) NOT NULL,
    FOREIGN KEY (store_info_id) REFERENCES store_info (id)
);



CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTO_INCREMENT, 
    username VARCHAR(30) NOT NULL,
    pswrd VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL
);

CREATE TABLE wait_times (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    user_id INTEGER NOT NULL,
    store_id INTEGER NOT NULL,
    created TIMESTAMP NOT NULL DEFAULT NOW(),
    wait_time INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (store_id) REFERENCES stores (id)
);






CREATE TABLE store_hours (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    store_id INTEGER NOT NULL,
    dayOfTheWeek INTEGER NOT NULL,
    senior_time_start time,
    senior_time_end time,
    FOREIGN KEY (store_id) REFERENCES stores (id)
);