INSERT INTO store_info(store_name, senior_hour_note)
VALUES
("Superstore", "Everyday, 7AM to 8AM"),
("Costco", "Monday to Friday, 8AM to 9AM"),
("Walmart", "Everyday, 7AM to 8AM"),
("Safeway", "Everyday, 8AM to 9AM"),
("Save-On-Foods", "Everyday, 7AM to 8AM"),
("IGA", "Everyday, 7AM to 8AM"),
("London Drugs", "Everyday, 8AM to 9AM"),
("No Frills", "Mondays and Fridays, 8AM to 9AM"),
("Urban Fare", "Everyday, 7AM to 8AM"),
("Super Grocer", NULL),
("Thrifty Foods", "Everyday, 8AM to 9AM"),
("Loblaws", "Everyday, 7AM to 8AM"),
("Whole Foods", "Everyday, 8AM to 9AM");

INSERT INTO stores (store_info_id, phone, store_address, store_post_code, store_city)
VALUES
(3, "7783281120", "4545 Central Blvd", "V5H4J5", "Burnaby"),
(6, "6046845714", "489 Robson St", "V6B6L9", "Vancouver"), 
(9, "6046695831", "305 Bute St", "V6C3T6", "Vancouver"), 
(8, "8669876453", "1030 Denman St", "V6G2M6", "Vancouver"), 
(1, "6043223702", "350 SE Marine Dr", "V5X2S5", "Vancouver"),
(4, "6045894774", "8860 152 St", "V3R4E4", "Surrey"),
(1, "6044366407", "3185 Grandview Hwy", "V5M2E9", "Vancouver"), 
(10, "6042712722", "12051 No 1 Rd", "V7E1T5", "Richmond"), 
(8, "8669876453", "1460 E Hastings St", "V5L1S3", "Vancouver"), 
(3, "6044356905", "3585 Grandview Hwy", "V5M2G7", "Vancouver"), 
(2, "6046225050", "605 Expo Blvd", "V6B1V4", "Vancouver"), 
(11, "2503822751", "3475 Quadra St", "V8X1G8", "Victoria"), 
(1, "6042332438", "4651 Number 3 Rd", "V6X2C4", "Richmond"),
(2, "6045398901", "20499 64 Ave", "V2Y1N5", "Langley"), 
(1, "6044686718", "3000 Lougheed Hwy", "V3B1C5", "Coquitlam"),
(2, "6044356695", "4500 Still Creek RD", "V5C0B5", "Burnaby"),
(4, "6042056922", "4440 Hastings St", "V5C2K2", "Burnaby"),
(3, "6045241291", "805 Boyd St", "V3M5X2", "New Westminister"),
(5, "6044391382", "8550 River District Crossing", "V9B6A2", "Vancouver"), 
(12, "6049221902", "845 Park Royal N #861", "V7T1H9", "West Vancouver"), 
(13, "6042055032", "4420 Lougheed Hwy", "V5C3Z3", "Burnaby"), 
(1, "6049045537", "333 Seymour Blvd", "V7J2J4", "Vancouver"),
(7, "6044484828", "3328 Kingsway", "V5R5L1", "Vancouver");


INSERT INTO users(username, pswrd, email)
VALUES ('admin', 'admin', 'admin@onetrip.now.sh');

INSERT INTO wait_times (user_id, store_id, wait_time, created)
VALUES
(1, 1, 25, '2020-04-20 12:00:00'),
(1, 1, 5, '2020-04-10 12:00:00'),
(1, 1, 25, '2020-04-15 10:00:00'),
(1, 1, 5, '2020-04-18 18:00:00'),
(1, 2, 20, '2020-04-16 12:00:00'),
(1, 3, 5, '2020-04-26 18:00:00'),
(1, 4, 15, '2020-04-08 12:00:00'),
(1, 5, 5, '2020-04-18 18:00:00'),
(1, 6, 5, '2020-04-28 12:00:00'),
(1, 7, 10, '2020-04-27 12:00:00'),
(1, 7, 5, '2020-03-28 18:00:00'),
(1, 8, 45, '2020-04-13 10:00:00'),
(1, 9, 25, '2020-04-18 10:00:00'),
(1, 10, 15, '2020-04-20 10:00:00'),
(1, 10, 10, '2020-04-21 10:00:00'),
(1, 11, 5, '2020-04-14 12:00:00'),
(1, 12, 5, '2020-03-31 10:00:00'),
(1, 13, 15, '2020-04-26 12:00:00'),
(1, 14, 5, '2020-04-28 12:00:00'),
(1, 15, 5, '2020-04-18 18:00:00'),
(1, 16, 5, '2020-04-26 12:00:00'),
(1, 17, 45, '2020-04-25 12:00:00'),
(1, 18, 15, '2020-04-20 12:00:00'),
(1, 19, 25, '2020-04-15 10:00:00'),
(1, 20, 5, '2020-04-28 10:00:00'),
(1, 21, 5, '2020-04-23 10:00:00'),
(1, 22, 25, '2020-04-23 12:00:00'),
(1, 23, 10, '2020-04-25 12:00:00');




