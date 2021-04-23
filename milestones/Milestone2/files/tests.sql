-- Script name: tests.sql
-- Author:      Wameedh Mohammed Ali
-- Purpose:     test the integrity of this database system

-- the database used to insert the data into.
USE WholesaleDB; 

-- Testing User table
-- 1. Error in User DELETE
-- DELETE FROM User WHERE first_name = 'Alex';
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
-- To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
-- 2. Error in User UPDATE
-- UPDATE User SET user_id = 4 WHERE first_name = 'Wameedh';
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
-- To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.

-- Testing User table
DELETE FROM Account WHERE user_id = 1;
UPDATE Account SET user_id = 4 WHERE user_id = 2;

-- Testing AccountHasAddresses table
DELETE FROM AccountHasAddresses WHERE account_id = 1;
UPDATE AccountHasAddresses SET account_id = 4 WHERE address_id = 2;

-- Testing Actions table
DELETE FROM Actions WHERE action_id = 1;
UPDATE Actions SET description = "new description" WHERE action_id = 2;

-- Testing Addresses table

-- 3. Error in Addresses DELETE
-- DELETE FROM Addresses WHERE number = 123;
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
-- To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
UPDATE Addresses SET zip_code = 12345 WHERE Address_id = 3;

-- Testing Admin table
DELETE FROM Admin WHERE role_id = 1;
UPDATE Admin SET description = "new description" WHERE role_id = 2;

-- Testing BankAccount table
DELETE FROM BankAccount WHERE bank_account_id = 1;
UPDATE BankAccount SET account_number = 121445363 WHERE paymentMethod_id = 2;

-- Testing BeautyProducts table
DELETE FROM BeautyProducts WHERE beauty_products_id = 1;
UPDATE BeautyProducts SET type = "new type" WHERE category_id = 2;

-- Testing Category table
DELETE FROM Category WHERE category_id = 1;
UPDATE Category SET name = "new name" WHERE category_id = 3;

-- Testing CDN table
DELETE FROM CDN WHERE cdn_id = 1;
UPDATE CDN SET name = "new name" WHERE cdn_id = 3;

-- Testing Clothes table
DELETE FROM Clothes WHERE clothes_id = 1;
UPDATE Clothes SET description = "new description" WHERE category_id = 3;

-- Testing Color table
DELETE FROM Color WHERE color_id = 1;
-- 4. Error in Color UPDATE
-- UPDATE Color SET hex_value = "ffff6d" WHERE color_name = "Red";
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
-- To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.

-- Testing Credentials table
DELETE FROM Credentials WHERE account_id = 1;
UPDATE Credentials SET password = "new password" WHERE user_email = "alex@gmail.com";

-- Testing CreditCard table

-- 5. Error in CreditCard DELETE
-- DELETE FROM CreditCard WHERE last_name = "Mohammed Ali";
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
-- To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
-- 6. Error in CreditCard UPDATE
-- UPDATE CreditCard SET cvv = 476 WHERE first_name = "Sara";
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
-- To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.

-- Testing Customer table

DELETE FROM Customer WHERE customer_id = 1;
UPDATE Customer SET role_id = 7 WHERE role_id = 2;

-- Testing Devices table

-- 7. Error in Devices DELETE
-- DELETE FROM Devices WHERE name = "Iphone X";
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
-- To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
-- 8. Error in Devices UPDATE
-- UPDATE Devices SET name = "Iphone XS" WHERE type = "Apple";
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
-- To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.

-- Testing Electronics table

-- 9. Error in Electronics DELETE
-- DELETE FROM Electronics WHERE model_year = 2020;
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
-- To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
UPDATE Electronics SET brand = "Sony" WHERE category_id = 1;

-- Testing Food table
DELETE FROM Food WHERE food_id = 1;
UPDATE Food SET food_type = "New food type" WHERE food_id = 3;

-- Testing HealthProducts table
DELETE FROM HealthProducts WHERE category_id = 1;
UPDATE HealthProducts SET type = "new type" WHERE category_id = 2;

-- Testing Images table
DELETE FROM Images WHERE product_id = 1;
-- 10. Error in Images UPDATE
-- UPDATE Images SET product_id = 3 WHERE name = "iphone X";
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
-- To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.

-- Testing Inventory table
DELETE FROM Inventory WHERE rule_id = 1;
UPDATE Inventory SET description = "new description" WHERE rule_id = 2;

-- Testing LogedinDevices table
DELETE FROM LogedinDevices WHERE LogedinDevice_id = 1;
UPDATE LogedinDevices SET accessed = NOW() WHERE acount_id = 2;

-- Testing Manage table
DELETE FROM Manage WHERE inventory_id = 1;
UPDATE Manage SET managed_date = NOW() WHERE admin_id=2;
-- Testing Membership table
DELETE FROM Membership WHERE membership_id = 1;
UPDATE Membership SET rewards_points = 1000 WHERE account_id=2;

-- Testing Order table
DELETE FROM `Order` WHERE customer_id = 1;
UPDATE `Order` SET customer_id = 2 WHERE order_id=2;

-- Testing PaymentHasAddresses table
DELETE FROM PaymentHasAddresses WHERE address_id = 1;
UPDATE PaymentHasAddresses SET address_id = 2 WHERE payment_method_id=3;

-- Testing PaymentMethod table
DELETE FROM PaymentMethod WHERE paymentMethod_id = 1;
UPDATE PaymentMethod SET user_id = 2 WHERE paymentMethod_id=3;

-- Testing Permissions table
DELETE FROM Permissions WHERE rule_id = 1;
UPDATE Permissions SET rule_id = 2 WHERE account_id=3;

-- Testing Product table
-- 11. Error in Product DELETE
-- DELETE FROM Product WHERE name = "tv";
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
-- To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
UPDATE Product SET price = 700.00 WHERE inventory_id=2;

-- Testing Profile table
-- 12. Error in Profile DELETE
-- DELETE FROM Profile WHERE user_name = "wameedh";
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
-- To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
UPDATE Profile SET user_name = "Omid" WHERE account_id=3;

-- Testing RegisterUser table
DELETE FROM RegisterUser WHERE role_id = 1;
UPDATE RegisterUser SET role_id = 2 WHERE user_id=3;

-- Testing Role table
DELETE FROM Role WHERE role_id = 1;
UPDATE Role SET description = "new description" WHERE role_id=3;

-- Testing Rule table
DELETE FROM Rule WHERE rule_id = 1;
UPDATE Rule SET rule_id = 4 WHERE rule_id=2;


-- Testing RuleAction table
DELETE FROM RuleAction WHERE rule_id = 1;
-- 13. Error in RuleAction UPDATE
-- UPDATE RuleAction SET action_id = 3 WHERE rul_id=2;
-- Error Code: 1054. Unknown column 'rul_id' in 'where clause'

-- Testing ShoppingCart table
DELETE FROM ShoppingCart WHERE reg_user_id = 1;
UPDATE ShoppingCart SET date_added = NOW() WHERE reg_user_id=2;

-- Testing Size table

-- 14. Error in Size DELETE
-- DELETE FROM Size WHERE size_name = "small";
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.
-- To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
-- 15. Error in Size UPDATE
-- UPDATE Size SET size_value = "New size value" WHERE size_id=2;
-- Error Code: 1366. Incorrect integer value: 'New size value' for column 'size_value' at row 1

-- Testing Storaged table
DELETE FROM Storaged WHERE image_id = 1;
UPDATE Storaged SET cdn_id = 4 WHERE image_id =2;

-- Testing UserDevices table
DELETE FROM UserDevices WHERE user = 1;
UPDATE UserDevices SET device = 2 WHERE user=3;


-- -------------------------------------
-- Testing  2 procedures & 1 function
-- -------------------------------------
CALL update_product_price(1, 2.99);
CALL getTotalOfCart(2, @totalPrice);
SELECT @totalPrice as totalOfCart;

SELECT getInventoryTotal(1);


