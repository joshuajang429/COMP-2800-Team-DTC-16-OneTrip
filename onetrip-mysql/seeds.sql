INSERT INTO store_info(store_name, offers_senior_store_hours, senior_hour_note)
VALUES
("Superstore", TRUE, ""),
("Costco", TRUE, ""),
("Walmart", TRUE, ""),
("Safeway", TRUE, ""),
("Save-On-Foods", TRUE, ""),
("IGA", TRUE, ""),
("No Frills", TRUE, ""),
("Urban Fare", TRUE, ""),
("Super Grocer", TRUE, ""),
("Thrifty Foods", TRUE, ""),
("Loblaws", TRUE, ""),
("Whole Foods", TRUE, "");

INSERT INTO stores (store_info_id, phone, store_address, store_post_code, store_city)
VALUES 
("Walmart", "7783281120", "4545 Central Blvd", "V5H4J5", "Burnaby"),
("IGA", "6046845714", "489 Robson St", "V6B6L9", "Vancouver"), 
("Urban Fare", "6046695831", "305 Bute St", "V6C3T6", "Vancouver"), 
("No Frills", "8669876453", "1030 Denman St", "V6G2M6", "Vancouver"), 
("Superstore", "6043223702", "350 SE Marine Dr", "V5X2S5", "Vancouver"),
("Safeway", "6045894774", "8860 152 St", "V3R4E4", "Surrey"),
("Superstore", "6044366407", "3185 Grandview Hwy", "V5M2E9", "Vancouver"), 
("Super Grocer", "6042712722", "12051 No 1 Rd", "V7E1T5", "Richmond"), 
("No Frills", "8669876453", "1460 E Hastings St", "V5L1S3", "Vancouver"), 
("Walmart", "6044356905", "3585 Grandview Hwy", "V5M2G7", "Vancouver"), 
("Costco", "6046225050", "605 Expo Blvd", "V6B1V4", "Vancouver"), 
("Thrifty Foods", "2503822751", "3475 Quadra St", "V8X1G8", "Victoria"), 
("Superstore", "6042332438", "4651 Number 3 Rd", "V6X2C4", "Richmond"),
("Costco", "6045398901", "20499 64 Ave", "V2Y1N5", "Langley"), 
("Superstore", "6044686718", "3000 Lougheed Hwy", "V3B1C5", "Coquitlam"),
("Costco", "6044356695", "4500 Still Creek RD", "V5C0B5", "Burnaby"),
("Safeway", "6042056922", "4440 Hastings St", "V5C2K2", "Burnaby"),
("Walmart", "6045241291", "805 Boyd St", "V3M5X2", "New Westminister"),
("Save-On-Foods", "6044391382", "8550 River District Crossing", "V9B6A2", "Vancouver"), 
("Loblaws", "6049221902", "845 Park Royal N #861", "V7T1H9", "West Vancouver"), 
("Whole Foods", "6042055032", "4420 Lougheed Hwy", "V5C3Z3", "Burnaby"), 
("Superstore", "6049045537", "333 Seymour Blvd,", "V7J2J4", "Vancouver");


INSERT INTO wait_times (user_id, store_id, wait_times, created)
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
(1, 23, 5, '2020-04-23 10:00:00'),
(1, 22, 25, '2020-04-23 12:00:00');





