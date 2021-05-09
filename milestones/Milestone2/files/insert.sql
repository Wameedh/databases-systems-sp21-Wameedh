-- Script name: inserts.sql
-- Author:      Wameedh Mohammed Ali
-- Purpose:     insert sample data to test the integrity of this database system

-- the database used to insert the data into.   
USE WholesaleDB ;

-- User table inserts
INSERT INTO User (user_email, first_name, last_name) VALUES ("wameedh.wf@gmail.com", "wameedh", "Mohammed Ali");
INSERT INTO User (user_email, first_name, last_name) VALUES ("Sara@gmail.com", "Sara", "Smith");
INSERT INTO User (user_email, first_name, last_name) VALUES ("alex@gmail.com", "Alex", "Williams");


-- --------------------------------------------
-- the inserts are commented out in the following tables: Account, RegisterUser, Role and PaymentMethod
--  because I have triggers would  insert data in them when an insert occur on USER.
-- -------------------------------------------

-- Account table inserts, 
-- INSERT INTO Account (user_id, date_created) VALUES (1, NOW());
-- INSERT INTO Account (user_id, date_created) VALUES (2, NOW());
-- INSERT INTO Account (user_id, date_created) VALUES (3, NOW());

-- RegisterUser table inserts
-- INSERT INTO RegisterUser (user_id, role_id) VALUES ( 1, 1);
-- INSERT INTO RegisterUser (user_id, role_id) VALUES ( 2, 2);
-- INSERT INTO RegisterUser (user_id, role_id) VALUES ( 3, 3);

-- Role table inserts
-- INSERT INTO Role (role_id) VALUES ( 1);
-- INSERT INTO Role (role_id) VALUES ( 2);
-- INSERT INTO Role (role_id) VALUES ( 3);

-- PaymentMethod table inserts
-- INSERT INTO PaymentMethod (user_id) VALUES ( 1);
-- INSERT INTO PaymentMethod (user_id) VALUES ( 2);
-- INSERT INTO PaymentMethod (user_id) VALUES ( 3);

-- Actions table inserts
INSERT INTO Actions (description) VALUES ("Action 1 description 1");
INSERT INTO Actions (description) VALUES ("Action 2 description 2");
INSERT INTO Actions (description) VALUES ("Action 3 description 3");

-- Addresses table inserts
INSERT INTO Addresses (number, street, city, state, country, zip_code) VALUES (123, "Dellwood way", "San Jose", "CA", "USA", 95118);
INSERT INTO Addresses (number, street, city, state, country, zip_code) VALUES (5384, "Dellwood way", "San Jose", "CA", "USA", 95118);
INSERT INTO Addresses (number, street, city, state, country, zip_code) VALUES (100, "Oak Rim Way", "Los Gatos", "CA", "USA", 95032);

-- Admin table inserts
INSERT INTO Admin (creation_date, description, role_id) VALUES ( NOW(), "Admin 1 description 1", 1);
INSERT INTO Admin (creation_date, description, role_id) VALUES ( NOW(), "Admin 2 description 2", 2);
INSERT INTO Admin (creation_date, description, role_id) VALUES ( NOW(), "Admin 3 description 3", 3);

-- BankAccount table inserts
INSERT INTO BankAccount (account_number, routing_number, paymentMethod_id) VALUES ( 188725267, 123456789, 1);
INSERT INTO BankAccount (account_number, routing_number, paymentMethod_id) VALUES ( 123456789, 175428962, 2);
INSERT INTO BankAccount (account_number, routing_number, paymentMethod_id) VALUES ( 138688421, 124000643, 3);

-- Category table inserts
INSERT INTO Category (name) VALUES ( "Category name 1");
INSERT INTO Category (name) VALUES ( "Category name 2");
INSERT INTO Category (name) VALUES ( "Category name 3");

-- BeautyProducts table inserts
INSERT INTO BeautyProducts (type, category_id) VALUES ( "type 1", 1);
INSERT INTO BeautyProducts (type, category_id) VALUES ( "type 2", 2);
INSERT INTO BeautyProducts (type, category_id) VALUES ( "type 3", 3);

-- CDN table inserts
INSERT INTO CDN (name) VALUES ( "CDN name 1");
INSERT INTO CDN (name) VALUES ( "CDN name 2");
INSERT INTO CDN (name) VALUES ( "CDN name 3");

-- Clothes table inserts
INSERT INTO Clothes (category_id, gender, description) VALUES (1, "male", "Clothes 1 description 1");
INSERT INTO Clothes (category_id, gender, description) VALUES (2, "female", "Clothes 2 description 2");
INSERT INTO Clothes (category_id, gender, description) VALUES (3, "male", "Clothes 3 description 3");
-- Color table inserts
INSERT INTO Color (hex_value, color_name) VALUES ( "FFFFFF", "White");
INSERT INTO Color (hex_value, color_name) VALUES ( "000000", "Black");
INSERT INTO Color (hex_value, color_name) VALUES ( "ff0101", "Red");

-- Credentials table inserts
INSERT INTO Credentials (account_id, password, user_email) VALUES (1, "123456", "wameedh.wf@gmail.com");
INSERT INTO Credentials (account_id, password, user_email) VALUES (2, "123456", "sara@gmail.com");
INSERT INTO Credentials (account_id, password, user_email) VALUES (3, "123456", "alex@gmail.com");
-- CreditCard table inserts
INSERT INTO CreditCard (card_number, cvv, expiration_date, first_name, last_name, paymentMethod_id) VALUES ("123456789012", 543, '2025-7-04', "Wameedh", "Mohammed Ali", 1);
INSERT INTO CreditCard (card_number, cvv, expiration_date, first_name, last_name, paymentMethod_id) VALUES ("234864268931", 876, '2026-12-05', "Sarar", "Smith", 2);
INSERT INTO CreditCard (card_number, cvv, expiration_date, first_name, last_name, paymentMethod_id) VALUES ("15789424568", 712, '2023-4-15', "Alex", "Williams", 3);

-- Customer table inserts
INSERT INTO Customer (creation_date, role_id) VALUES ( NOW(), 1);
INSERT INTO Customer (creation_date, role_id) VALUES ( NOW(), 2);
INSERT INTO Customer (creation_date, role_id) VALUES ( NOW(), 3);
-- Devices table inserts

INSERT INTO Devices (type, name) VALUES ( "Apple","Iphone X");
INSERT INTO Devices (type, name) VALUES ( "Samsung","Galaxy");
INSERT INTO Devices (type, name) VALUES ( "Apple","Iphone 12 pro");
-- Electronics table inserts
INSERT INTO Electronics (model_year, brand, serial_number, category_id) VALUES ( '2020', "Samsung", 123456789, 1);
INSERT INTO Electronics (model_year, brand, serial_number, category_id) VALUES ( '2021', "Toshiba", 543564215, 2);
INSERT INTO Electronics (model_year, brand, serial_number, category_id) VALUES ( '2019', "LG", 645451545, 3);
-- Food table inserts
INSERT INTO Food (expiration_date, food_type, category_id) VALUES ( '2021-12-15', "Caned food", 1);
INSERT INTO Food (expiration_date, food_type, category_id) VALUES ( '2022-11-24', "dry food", 2);
INSERT INTO Food (expiration_date, food_type, category_id) VALUES ( '2021-5-01', "fresh food", 3);
-- HealthProducts table inserts
INSERT INTO HealthProducts (expiration_date, type, category_id) VALUES ( '2021-8-01', "type 1", 1);
INSERT INTO HealthProducts (expiration_date, type, category_id) VALUES ( '2023-3-23', "type 2", 2);
INSERT INTO HealthProducts (expiration_date, type, category_id) VALUES ( '2026-1-22', "type 3", 3);

-- Rule table inserts
INSERT INTO Rule (rule_id) VALUES ( 1);
INSERT INTO Rule (rule_id) VALUES ( 2);
INSERT INTO Rule (rule_id) VALUES ( 3);

-- Inventory table inserts
INSERT INTO Inventory (rule_id, description) VALUES ( 1, "Inventory 1 description 1");
INSERT INTO Inventory (rule_id, description) VALUES ( 2, "Inventory 2 description 2");
INSERT INTO Inventory (rule_id, description) VALUES ( 3, "Inventory 3 description 3");

-- Size table inserts
INSERT INTO Size (size_name, size_desc, size_value) VALUES ("Small", "American size", 10);
INSERT INTO Size (size_name, size_desc, size_value) VALUES ("Medium", "American size", 32);
INSERT INTO Size (size_name, size_desc, size_value) VALUES ("Larg", "American size", 36);

-- Product table inserts
INSERT INTO Product (price, wight, name, description, quantity, color_id, size_id, inventory_id, category_id) VALUES ( 3.99, 0.1,"apple", "Product 1 description 1", 500, 1,1,1,1);
INSERT INTO Product (price, wight, name, description, quantity, color_id, size_id, inventory_id, category_id) VALUES ( 10.99, 1.0,"cup", "Product 1 description 1", 500, 2,2,2,2);
INSERT INTO Product (price, wight, name, description, quantity, color_id, size_id, inventory_id, category_id) VALUES ( 100.00, 20.0,"tv", "Product 1 description 1", 50, 2,3,2,3);

-- Images table inserts
INSERT INTO Images (name, hight, width, product_id) VALUES ( "LG TV", 480, 480, 1);
INSERT INTO Images (name, hight, width, product_id) VALUES ( "iphone X", 480, 480, 2);
INSERT INTO Images (name, hight, width, product_id) VALUES ( "Orange", 480, 480, 3);

-- Membership table inserts
INSERT INTO Membership (rewards_points, creation_date, renewal_date, account_id) VALUES ( 1, NOW(), (NOW() + INTERVAL 1 YEAR), 1);
INSERT INTO Membership (rewards_points, creation_date, renewal_date, account_id) VALUES ( 100, NOW(), (NOW() + INTERVAL 1 YEAR), 2);
INSERT INTO Membership (rewards_points, creation_date, renewal_date, account_id) VALUES ( 23, NOW(), (NOW() + INTERVAL 1 YEAR), 3);

-- Profile table inserts
INSERT INTO Profile (user_name, date_of_birth, avatar_link, account_id) VALUES ("wameedh",'1989-12-05',"https://www.mysite.com/avatar/205e4", 1);
INSERT INTO Profile (user_name, date_of_birth, avatar_link, account_id) VALUES ("Sarar",'1990-03-26',"https://www.mysite.com/avatar/205e4ft32", 2);
INSERT INTO Profile (user_name, date_of_birth, avatar_link, account_id) VALUES ("Alex",'1995-07-15',"https://www.mysite.com/avatar/20523fe41", 3);

-- ShoppingCart table inserts
INSERT INTO ShoppingCart (product_id, date_added, reg_user_id) VALUES (1, NOW(), 1);
INSERT INTO ShoppingCart (product_id, date_added, reg_user_id) VALUES (2, NOW(), 2);
INSERT INTO ShoppingCart (product_id, date_added, reg_user_id) VALUES (3, NOW(), 2);















