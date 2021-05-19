-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
SET SQL_SAFE_UPDATES =0;
-- -----------------------------------------------------
-- Schema WholesaleDB
-- -----------------------------------------------------
-- DROP SCHEMA IF EXISTS `WholesaleDB` ;

-- -----------------------------------------------------
-- Schema WholesaleDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `WholesaleDB` DEFAULT CHARACTER SET utf8 ;
USE `WholesaleDB` ;

-- -----------------------------------------------------
-- Table `WholesaleDB`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`User` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`User` (
  `user_id` TINYINT NOT NULL AUTO_INCREMENT,
  `user_email` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `full_name` VARCHAR(100) GENERATED ALWAYS AS (CONCAT(first_name, " ", last_name)),
  `first_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`, `user_email`),
  UNIQUE INDEX `user_email_UNIQUE` (`user_email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Account`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `WholesaleDB`.`Account` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Account` (
  `account_id` TINYINT NOT NULL AUTO_INCREMENT,
  `user_id` TINYINT NOT NULL,
  `date_created` TIMESTAMP NOT NULL,
  PRIMARY KEY (`account_id`),
  INDEX `FK_USER_ACCOUNT_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `FK_USER_ACCOUNT`
    FOREIGN KEY (`user_id`)
    REFERENCES `WholesaleDB`.`User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Role` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Role` (
  `role_id` TINYINT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`RegisterUser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`RegisterUser` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`RegisterUser` (
  `register_user_id` TINYINT NOT NULL AUTO_INCREMENT,
  `user_id` TINYINT NOT NULL,
  `role_id` TINYINT NULL,
  PRIMARY KEY (`register_user_id`, `user_id`),
  INDEX `FK_PK_USER_REGUSER_idx` (`user_id` ASC) VISIBLE,
  INDEX `FK_ROLE_REGUSER_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `FK_PK_USER_REGUSER`
    FOREIGN KEY (`user_id`)
    REFERENCES `WholesaleDB`.`User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_ROLE_REGUSER`
    FOREIGN KEY (`role_id`)
    REFERENCES `WholesaleDB`.`Role` (`role_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Devices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Devices` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Devices` (
  `device_id` TINYINT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`device_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`UserDevices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`UserDevices` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`UserDevices` (
  `user_device_id` TINYINT NOT NULL AUTO_INCREMENT,
  `device` TINYINT NOT NULL,
  `user` TINYINT NOT NULL,
  `accessed` TIMESTAMP NOT NULL,
  PRIMARY KEY (`user_device_id`),
  INDEX `FK_DEVICE_USERDEVICES_idx` (`device` ASC) VISIBLE,
  INDEX `FK_REGUSER_USERDEVICES_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `FK_DEVICE_USERDEVICES`
    FOREIGN KEY (`device`)
    REFERENCES `WholesaleDB`.`Devices` (`device_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_REGUSER_USERDEVICES`
    FOREIGN KEY (`user`)
    REFERENCES `WholesaleDB`.`RegisterUser` (`register_user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Credentials`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Credentials` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Credentials` (
  `credential_id` TINYINT NOT NULL AUTO_INCREMENT,
  `account_id` TINYINT NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `user_email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`credential_id`, `account_id`),
  INDEX `PK_FK_ACCOUNT_CREDENTIALS_idx` (`account_id` ASC) VISIBLE,
  INDEX `PK_FK_USER_CREDENTIALS_idx` (`user_email` ASC) VISIBLE,
  CONSTRAINT `PK_FK_ACCOUNT_CREDENTIALS`
    FOREIGN KEY (`account_id`)
    REFERENCES `WholesaleDB`.`Account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PK_FK_USER_CREDENTIALS`
    FOREIGN KEY (`user_email`)
    REFERENCES `WholesaleDB`.`User` (`user_email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Membership`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Membership` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Membership` (
  `membership_id` TINYINT NOT NULL AUTO_INCREMENT,
  `rewards_points` INT NOT NULL DEFAULT 0,
  `creation_date` TIMESTAMP NOT NULL,
  `renewal_date` TIMESTAMP NOT NULL,
  `account_id` TINYINT NOT NULL,
  PRIMARY KEY (`membership_id`),
  INDEX `FK_ACOUNT_MEMBERSHIP_idx` (`account_id` ASC) VISIBLE,
  CONSTRAINT `FK_ACOUNT_MEMBERSHIP`
    FOREIGN KEY (`account_id`)
    REFERENCES `WholesaleDB`.`Account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Profile` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Profile` (
  `profile_id` TINYINT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(45) NOT NULL,
  `date_of_birth` DATE NULL,
  `avatar_link` VARCHAR(2045) NULL,
  `account_id` TINYINT NOT NULL,
  PRIMARY KEY (`profile_id`),
  INDEX `FK_ACOUNT_PROFILE_idx` (`account_id` ASC) VISIBLE,
  CONSTRAINT `FK_ACOUNT_PROFILE`
    FOREIGN KEY (`account_id`)
    REFERENCES `WholesaleDB`.`Account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`LogedinDevices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`LogedinDevices` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`LogedinDevices` (
  `device_id` TINYINT NOT NULL,
  `LogedinDevice_id` TINYINT NOT NULL AUTO_INCREMENT,
  `acount_id` TINYINT NOT NULL,
  `accessed` TIMESTAMP NOT NULL,
  PRIMARY KEY (`LogedinDevice_id`),
  INDEX `FK_ACCOUNT_DEVICES_idx` (`acount_id` ASC) VISIBLE,
  INDEX `FK_DEVICES_LOGEDINDEVICES_idx` (`device_id` ASC) VISIBLE,
  CONSTRAINT `FK_ACCOUNT_LOGEDINDEVICES`
    FOREIGN KEY (`acount_id`)
    REFERENCES `WholesaleDB`.`Account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_DEVICES_LOGEDINDEVICES`
    FOREIGN KEY (`device_id`)
    REFERENCES `WholesaleDB`.`Devices` (`device_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`ShoppingCart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`ShoppingCart` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`ShoppingCart` (
  `Shopping_cart_id` TINYINT NOT NULL AUTO_INCREMENT,
  `product_id` TINYINT NOT NULL,
  `date_added` TIMESTAMP NOT NULL,
  `reg_user_id` TINYINT NOT NULL,
  PRIMARY KEY (`Shopping_cart_id`),
  INDEX `FK_REGUSER_CART_idx` (`reg_user_id` ASC) VISIBLE,
  CONSTRAINT `FK_REGUSER_CART`
    FOREIGN KEY (`reg_user_id`)
    REFERENCES `WholesaleDB`.`RegisterUser` (`register_user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Customer` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `creation_date` TIMESTAMP NOT NULL,
  `role_id` TINYINT NOT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `FK_ROLE_CUSTOMER_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `FK_ROLE_CUSTOMER`
    FOREIGN KEY (`role_id`)
    REFERENCES `WholesaleDB`.`Role` (`role_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Admin` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Admin` (
  `admin_id` TINYINT NOT NULL AUTO_INCREMENT,
  `creation_date` TIMESTAMP NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `role_id` TINYINT NOT NULL,
  PRIMARY KEY (`admin_id`),
  INDEX `FK_ROLE_ADMIN_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `FK_ROLE_ADMIN`
    FOREIGN KEY (`role_id`)
    REFERENCES `WholesaleDB`.`Role` (`role_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`PaymentMethod`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`PaymentMethod` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`PaymentMethod` (
  `paymentMethod_id` TINYINT NOT NULL AUTO_INCREMENT,
  `user_id` TINYINT NULL,
  PRIMARY KEY (`paymentMethod_id`),
  INDEX `FK_REGUSER_PAYMETHOD_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `FK_REGUSER_PAYMETHOD`
    FOREIGN KEY (`user_id`)
    REFERENCES `WholesaleDB`.`RegisterUser` (`register_user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`BankAccount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`BankAccount` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`BankAccount` (
  `bank_account_id` TINYINT NOT NULL AUTO_INCREMENT,
  `account_number` INT NOT NULL,
  `routing_number` INT NOT NULL,
  `paymentMethod_id` TINYINT NOT NULL,
  PRIMARY KEY (`bank_account_id`),
  INDEX `FK_PAYMETHOD_BANKACC_idx` (`paymentMethod_id` ASC) VISIBLE,
  CONSTRAINT `FK_PAYMETHOD_BANKACC`
    FOREIGN KEY (`paymentMethod_id`)
    REFERENCES `WholesaleDB`.`PaymentMethod` (`paymentMethod_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`CreditCard`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`CreditCard` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`CreditCard` (
  `credit_card_id` TINYINT NOT NULL AUTO_INCREMENT,
  `card_number` VARCHAR(20) NOT NULL,
  `cvv` INT NOT NULL,
  `expiration_date` DATE NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `full_name` VARCHAR(100) GENERATED ALWAYS AS (CONCAT(first_name, " ", last_name)),
  `paymentMethod_id` TINYINT NOT NULL,
  PRIMARY KEY (`credit_card_id`),
  INDEX `FK_PAYMETHOD_CREDITCARD_idx` (`paymentMethod_id` ASC) VISIBLE,
  CONSTRAINT `FK_PAYMETHOD_CREDITCARD`
    FOREIGN KEY (`paymentMethod_id`)
    REFERENCES `WholesaleDB`.`PaymentMethod` (`paymentMethod_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Addresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Addresses` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Addresses` (
  `Address_id` TINYINT NOT NULL AUTO_INCREMENT,
  `number` INT NOT NULL DEFAULT 0,
  `street` VARCHAR(45) NOT NULL DEFAULT "",
  `state` VARCHAR(45) NOT NULL DEFAULT "",
  `city` VARCHAR(45) NOT NULL DEFAULT "",
  `country` VARCHAR(45) NOT NULL DEFAULT "",
  `zip_code` INT NOT NULL DEFAULT 00000,
  PRIMARY KEY (`Address_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Rule`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Rule` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Rule` (
  `rule_id` TINYINT NOT NULL AUTO_INCREMENT,
  `rule` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`rule_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Inventory` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Inventory` (
  `inventory_id` TINYINT NOT NULL AUTO_INCREMENT,
  `rule_id` TINYINT NULL,
  `description` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`inventory_id`),
  INDEX `FK_RULE_INVENTORY_idx` (`rule_id` ASC) VISIBLE,
  CONSTRAINT `FK_RULE_INVENTORY`
    FOREIGN KEY (`rule_id`)
    REFERENCES `WholesaleDB`.`Rule` (`rule_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Order` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Order` (
  `order_id` TINYINT NOT NULL AUTO_INCREMENT,
  `customer_id` TINYINT NOT NULL,
  `inventory_id` TINYINT NOT NULL,
  `order_date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `FK_CUSTOMER_ORDER_idx` (`customer_id` ASC) VISIBLE,
  INDEX `FK_INVENTORY_ORDER_idx` (`inventory_id` ASC) VISIBLE,
  CONSTRAINT `FK_CUSTOMER_ORDER`
    FOREIGN KEY (`customer_id`)
    REFERENCES `WholesaleDB`.`Customer` (`role_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_INVENTORY_ORDER`
    FOREIGN KEY (`inventory_id`)
    REFERENCES `WholesaleDB`.`Inventory` (`inventory_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Manage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Manage` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Manage` (
  `Manage_id` TINYINT NOT NULL AUTO_INCREMENT,
  `admin_id` TINYINT NOT NULL,
  `inventory_id` TINYINT NOT NULL,
  `managed_date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`Manage_id`),
  INDEX `FK_ADMIN_MANAGE_idx` (`admin_id` ASC) VISIBLE,
  INDEX `FK_INVENTORY_MANAGE_idx` (`inventory_id` ASC) VISIBLE,
  CONSTRAINT `FK_ADMIN_MANAGE`
    FOREIGN KEY (`admin_id`)
    REFERENCES `WholesaleDB`.`Admin` (`admin_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_INVENTORY_MANAGE`
    FOREIGN KEY (`inventory_id`)
    REFERENCES `WholesaleDB`.`Inventory` (`inventory_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Actions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Actions` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Actions` (
  `action_id` TINYINT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`action_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`RuleAction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`RuleAction` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`RuleAction` (
  `rule_id` TINYINT NOT NULL,
  `action_id` TINYINT NULL,
  PRIMARY KEY (`rule_id`),
  INDEX `PK_FK_ACTION_RULEACTION_idx` (`action_id` ASC) VISIBLE,
  UNIQUE INDEX `action_id_UNIQUE` (`action_id` ASC) VISIBLE,
  CONSTRAINT `PK_FK_RULE_RULEACTION`
    FOREIGN KEY (`rule_id`)
    REFERENCES `WholesaleDB`.`Rule` (`rule_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PK_FK_ACTION_RULEACTION`
    FOREIGN KEY (`action_id`)
    REFERENCES `WholesaleDB`.`Actions` (`action_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Permissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Permissions` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Permissions` (
  `permissions_id` TINYINT NOT NULL AUTO_INCREMENT,
  `rule_id` TINYINT NOT NULL,
  `account_id` TINYINT NOT NULL,
  `table_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`permissions_id`),
  INDEX `PK_FK_ACCOUNT_PERMISSIONS_idx` (`account_id` ASC) VISIBLE,
  CONSTRAINT `PK_FK_RULE_PERMISSIONS`
    FOREIGN KEY (`rule_id`)
    REFERENCES `WholesaleDB`.`Rule` (`rule_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PK_FK_ACCOUNT_PERMISSIONS`
    FOREIGN KEY (`account_id`)
    REFERENCES `WholesaleDB`.`Account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Color`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Color` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Color` (
  `color_id` TINYINT NOT NULL AUTO_INCREMENT,
  `hex_value` VARCHAR(45) NOT NULL,
  `color_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`color_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Size`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Size` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Size` (
  `size_id` TINYINT NOT NULL AUTO_INCREMENT,
  `size_name` VARCHAR(45) NOT NULL,
  `size_desc` VARCHAR(250) NOT NULL,
  `size_value` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`size_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Category` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Category` (
  `category_id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Product` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Product` (
  `product_id` TINYINT NOT NULL AUTO_INCREMENT,
  `price` DECIMAL(9,2) NOT NULL DEFAULT 0.00,
  `wight` DECIMAL(4,2) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(250) NOT NULL,
  `quantity` INT NOT NULL DEFAULT 0,
  `color_id` TINYINT NULL,
  `size_id` TINYINT NULL,
  `inventory_id` TINYINT NULL,
  `category_id` TINYINT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `FK_COLOR_PRODUCT_idx` (`color_id` ASC) VISIBLE,
  INDEX `FK_INVENTORY_PRODUCT_idx` (`inventory_id` ASC) VISIBLE,
  INDEX `FK_SIZE_PRODUCT_idx` (`size_id` ASC) VISIBLE,
  INDEX `FK_CATEGORY_PRODUCT_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `FK_COLOR_PRODUCT`
    FOREIGN KEY (`color_id`)
    REFERENCES `WholesaleDB`.`Color` (`color_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `FK_SIZE_PRODUCT`
    FOREIGN KEY (`size_id`)
    REFERENCES `WholesaleDB`.`Size` (`size_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `FK_INVENTORY_PRODUCT`
    FOREIGN KEY (`inventory_id`)
    REFERENCES `WholesaleDB`.`Inventory` (`inventory_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `FK_CATEGORY_PRODUCT`
    FOREIGN KEY (`category_id`)
    REFERENCES `WholesaleDB`.`Category` (`category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Images`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Images` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Images` (
  `image_id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `hight` INT NOT NULL,
  `width` INT NOT NULL,
  `product_id` TINYINT NULL,
  PRIMARY KEY (`image_id`),
  INDEX `FK_PRODUCT_IMAGES_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `FK_PRODUCT_IMAGES`
    FOREIGN KEY (`product_id`)
    REFERENCES `WholesaleDB`.`Product` (`product_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`CDN`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`CDN` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`CDN` (
  `cdn_id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cdn_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Storaged`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Storaged` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Storaged` (
  `image_id` TINYINT NOT NULL,
  `cdn_id` TINYINT NOT NULL,
  PRIMARY KEY (`image_id`, `cdn_id`),
  INDEX `PK_FK_CDN_STORAGED_idx` (`cdn_id` ASC) VISIBLE,
  CONSTRAINT `PK_FK_IMAGES_STORAGED`
    FOREIGN KEY (`image_id`)
    REFERENCES `WholesaleDB`.`Images` (`image_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PK_FK_CDN_STORAGED`
    FOREIGN KEY (`cdn_id`)
    REFERENCES `WholesaleDB`.`CDN` (`cdn_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Clothes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Clothes` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Clothes` (
  `clothes_id` TINYINT NOT NULL AUTO_INCREMENT,
  `category_id` TINYINT NOT NULL,
  `gender` VARCHAR(45) NOT NULL,
  `description` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`clothes_id`),
  INDEX `FK_CATEGORY_CLOTHES_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `FK_CATEGORY_CLOTHES`
    FOREIGN KEY (`category_id`)
    REFERENCES `WholesaleDB`.`Category` (`category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`HealthProducts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`HealthProducts` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`HealthProducts` (
  `health_products_id` TINYINT NOT NULL AUTO_INCREMENT,
  `category_id` TINYINT NOT NULL,
  `expiration_date` DATE NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`health_products_id`),
  INDEX `FK_CATEGORY_HEALTHPRODUCTS_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `FK_CATEGORY_HEALTHPRODUCTS`
    FOREIGN KEY (`category_id`)
    REFERENCES `WholesaleDB`.`Category` (`category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Electronics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Electronics` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Electronics` (
  `electronics_id` TINYINT NOT NULL AUTO_INCREMENT,
  `model_year` YEAR NOT NULL,
  `brand` VARCHAR(45) NOT NULL,
  `serial_number` INT NOT NULL,
  `category_id` TINYINT NOT NULL,
  PRIMARY KEY (`electronics_id`),
  INDEX `FK_CATEGORY_ELECTRONICS_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `FK_CATEGORY_ELECTRONICS`
    FOREIGN KEY (`category_id`)
    REFERENCES `WholesaleDB`.`Category` (`category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`Food`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`Food` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`Food` (
  `food_id` TINYINT NOT NULL AUTO_INCREMENT,
  `expiration_date` DATE NOT NULL,
  `food_type` VARCHAR(45) NOT NULL,
  `category_id` TINYINT NOT NULL,
  PRIMARY KEY (`food_id`),
  INDEX `FK_CATEGORY_FOOD_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `FK_CATEGORY_FOOD`
    FOREIGN KEY (`category_id`)
    REFERENCES `WholesaleDB`.`Category` (`category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`BeautyProducts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`BeautyProducts` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`BeautyProducts` (
  `beauty_products_id` TINYINT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  `category_id` TINYINT NOT NULL,
  PRIMARY KEY (`beauty_products_id`),
  INDEX `FK_CATEGORY_BEAUTYPRODUCTS_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `FK_CATEGORY_BEAUTYPRODUCTS`
    FOREIGN KEY (`category_id`)
    REFERENCES `WholesaleDB`.`Category` (`category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`PaymentHasAddresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`PaymentHasAddresses` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`PaymentHasAddresses` (
  `address_id` TINYINT NOT NULL,
  `payment_method_id` TINYINT NOT NULL,
  PRIMARY KEY (`address_id`, `payment_method_id`),
  INDEX `PK_FK_PAYMETHOD_PAYMENTADDRESSES_idx` (`payment_method_id` ASC) VISIBLE,
  CONSTRAINT `PK_FK_ADDRESSES_PAYMENTADDRESSES`
    FOREIGN KEY (`address_id`)
    REFERENCES `WholesaleDB`.`Addresses` (`Address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PK_FK_PAYMETHOD_PAYMENTADDRESSES`
    FOREIGN KEY (`payment_method_id`)
    REFERENCES `WholesaleDB`.`PaymentMethod` (`paymentMethod_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WholesaleDB`.`AccountHasAddresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WholesaleDB`.`AccountHasAddresses` ;

CREATE TABLE IF NOT EXISTS `WholesaleDB`.`AccountHasAddresses` (
  `address_id` TINYINT NOT NULL,
  `account_id` TINYINT NOT NULL,
  PRIMARY KEY (`address_id`, `account_id`),
  INDEX `PK_FK_ACCOUNT_ACC_HAS_ADDRESSES_idx` (`account_id` ASC) VISIBLE,
  CONSTRAINT `PK_FK_ACCOUNT_ACC_HAS_ADDRESSES`
    FOREIGN KEY (`account_id`)
    REFERENCES `WholesaleDB`.`Account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PK_FK_ADDR__ACC_HAS_ADDRESSES`
    FOREIGN KEY (`address_id`)
    REFERENCES `WholesaleDB`.`Addresses` (`Address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

