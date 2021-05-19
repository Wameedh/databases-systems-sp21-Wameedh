-- -----------------------------------------------------
-- Triggers: When an insert on a user happen
-- then this trigger would create an account role and register user
-- -----------------------------------------------------
-- DELIMITER $$
DROP TRIGGER IF EXISTS createAccountAndRegUser $$
CREATE TRIGGER createAccountAndRegUser AFTER INSERT ON User
FOR EACH ROW
	BEGIN
	  -- code here
	  DECLARE userid TINYINT;
	  DECLARE useremail VARCHAR(45);
	  DECLARE username VARCHAR(45);
	  SET userid = (SELECT NEW.user_id);
	  SET useremail = (SELECT NEW.user_email);
	  SET username = (SELECT NEW.first_name);
	  INSERT INTO Account (user_id, date_created) VALUES (userid, SYSDATE());
	  INSERT INTO Role (role_id, description) VALUES (userid,"user");
	  INSERT INTO RegisterUser (user_id, role_id) VALUES (userid, userid);
	  INSERT INTO Credentials (account_id,password, user_email) VALUES (userid,"1234", useremail);
      INSERT INTO Profile (user_name, account_id, avatar_link) VALUES (username, userid, "https://www.mysite.com/avatar/205e4ft32");
      INSERT INTO Addresses (Address_id) VALUES (userid);
      INSERT INTO AccountHasAddresses (address_id, account_id) VALUES (userid, userid);

	  INSERT INTO Permissions (rule_id, account_id, `table_name`) VALUES (1, userid, "Account");
	  INSERT INTO Permissions (rule_id, account_id, `table_name`) VALUES (1, userid, "Profile");
	  INSERT INTO Permissions (rule_id, account_id, `table_name`) VALUES (1, userid, "Addresses");
	  INSERT INTO Permissions (rule_id, account_id, `table_name`) VALUES (1, userid, "BankAccount");
	  INSERT INTO Permissions (rule_id, account_id, `table_name`) VALUES (1, userid, "CreditCard");
	  INSERT INTO Permissions (rule_id, account_id, `table_name`) VALUES (1, userid, "ShoppingCart");
	END; $$

-- -----------------------------------------------------
-- Triggers: When a new RegisterUser get inserted in the DB
-- a PaymentMethod associated with that register usr is created
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS createPaymentMethod $$
CREATE TRIGGER createPaymentMethod AFTER INSERT ON RegisterUser
FOR EACH ROW
	BEGIN
	  -- code here
		INSERT INTO PaymentMethod (user_id) VALUES (New.register_user_id);
	END; $$

-- -----------------------------------------------------
-- Procedure: takes register user ID and out the total of the cart that belongs to that user
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS getTotalOfCart $$
CREATE PROCEDURE getTotalOfCart(IN regUser_id TINYINT, OUT totalPrice DECIMAL(9,2))
BEGIN
	-- get regUser_id return total price of items in cart belong to that user
    -- first get the product ids from cart
    -- then get the price of each item
    -- add the prices togather
	DECLARE n INT DEFAULT 0;
	DECLARE i INT DEFAULT 0;
	DECLARE tempPrice DECIMAL(9,2) DEFAULT 0.0;
	DECLARE productId TINYINT;
	SET totalPrice = 0.0;
	SELECT COUNT(*) FROM ShoppingCart INTO n; -- get the size of ShoppingCart table
	SET i=0;
	WHILE i<=n DO
		SELECT product_id  FROM ShoppingCart WHERE reg_user_id=regUser_id AND Shopping_cart_id=i INTO productId;
		SELECT price FROM Product WHERE product_id=productId INTO tempPrice;
		SET totalPrice = totalPrice + tempPrice;
		SET i = i + 1;
	END WHILE;
END $$
-- -----------------------------------------------------
-- Procedure: Gets two input the product id and the new price to be set for that product then it would update the new price
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS update_product_price $$
CREATE PROCEDURE update_product_price(IN productId TINYINT, IN new_price DECIMAL(8,2))
BEGIN
    UPDATE Product SET price = new_price WHERE product_id = productId;
END $$


-- -----------------------------------------------------
-- Function: Takes an inventory ID and return the total prices of items that belong to that inventory
-- -----------------------------------------------------
DROP FUNCTION IF EXISTS getInventoryTotal $$
CREATE FUNCTION getInventoryTotal (inventoryId TINYINT)
RETURNS DECIMAL(9,2)
DETERMINISTIC
-- input inventory id and the output is the total cost of that inventory
BEGIN
	DECLARE tempQuantity INT DEFAULT 0;
	DECLARE totalPrice DECIMAL(9,2) DEFAULT 0.0;
	DECLARE tempPrice DECIMAL(9,2) DEFAULT 0.0;
	DECLARE tempproduct_id TINYINT DEFAULT 0;
	DECLARE n INT DEFAULT 0;
	DECLARE i INT DEFAULT 0;
	DECLARE done INT DEFAULT FALSE;
	DECLARE cursor_i CURSOR FOR SELECT product_id FROM Product WHERE inventory_id=inventoryId;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	OPEN cursor_i;
	read_loop: LOOP
		FETCH cursor_i INTO tempproduct_id;
         IF done THEN
			LEAVE read_loop;
		END IF;
        SELECT price FROM Product WHERE inventory_id=inventoryId AND product_id=tempproduct_id INTO tempPrice;
        SELECT quantity FROM Product WHERE inventory_id=inventoryId AND product_id=tempproduct_id INTO tempQuantity;
		SET totalPrice = totalPrice + (tempPrice*tempQuantity);
	END LOOP;
	CLOSE cursor_i;
    RETURN totalPrice;
END $$

-- DELIMITER ;
