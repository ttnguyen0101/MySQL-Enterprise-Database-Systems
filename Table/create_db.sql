-- MySQL Script generated by MySQL Workbench
-- Thu Dec 15 17:50:33 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema thunguyen_final_project
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema thunguyen_final_project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `thunguyen_final_project` DEFAULT CHARACTER SET utf8 ;
USE `thunguyen_final_project` ;

-- -----------------------------------------------------
-- Table `thunguyen_final_project`.`customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `thunguyen_final_project`.`customers` ;

CREATE TABLE IF NOT EXISTS `thunguyen_final_project`.`customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `reward_points` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `customer_id_UNIQUE` (`customer_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `thunguyen_final_project`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `thunguyen_final_project`.`orders` ;

CREATE TABLE IF NOT EXISTS `thunguyen_final_project`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE,
  INDEX `fkorders_customer_id_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `thunguyen_final_project`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `thunguyen_final_project`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `thunguyen_final_project`.`categories` ;

CREATE TABLE IF NOT EXISTS `thunguyen_final_project`.`categories` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NOT NULL,
  `aisle` VARCHAR(45) NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE INDEX `category_id_UNIQUE` (`category_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `thunguyen_final_project`.`products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `thunguyen_final_project`.`products` ;

CREATE TABLE IF NOT EXISTS `thunguyen_final_project`.`products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(45) NOT NULL,
  `category_id` INT NOT NULL,
  `inventory` INT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE INDEX `product_id_UNIQUE` (`product_id` ASC) VISIBLE,
  UNIQUE INDEX `product_name_UNIQUE` (`product_name` ASC) VISIBLE,
  INDEX `fk_products_category_id_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `thunguyen_final_project`.`categories` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `thunguyen_final_project`.`order_items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `thunguyen_final_project`.`order_items` ;

CREATE TABLE IF NOT EXISTS `thunguyen_final_project`.`order_items` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `sale_price` DECIMAL(10,2) NOT NULL,
  `qty` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE,
  INDEX `fk_orderitems_product_id_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_orderitems_product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `thunguyen_final_project`.`products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orderitems_order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `thunguyen_final_project`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `thunguyen_final_project`.`employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `thunguyen_final_project`.`employees` ;

CREATE TABLE IF NOT EXISTS `thunguyen_final_project`.`employees` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `employee_name` VARCHAR(100) NOT NULL,
  `shift` VARCHAR(45) NULL,
  `salary` DECIMAL(10,2) NOT NULL,
  `position` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE INDEX `employee_id_UNIQUE` (`employee_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `thunguyen_final_project`.`work_assignments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `thunguyen_final_project`.`work_assignments` ;

CREATE TABLE IF NOT EXISTS `thunguyen_final_project`.`work_assignments` (
  `category_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  `hours` DECIMAL NULL,
  INDEX `fk_workassignments_category_id_idx` (`category_id` ASC) VISIBLE,
  INDEX `fk_workassignments_employee_id_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_workassignments_category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `thunguyen_final_project`.`categories` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_workassignments_employee_id`
    FOREIGN KEY (`employee_id`)
    REFERENCES `thunguyen_final_project`.`employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `thunguyen_final_project`.`customers_audit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `thunguyen_final_project`.`customers_audit` ;

CREATE TABLE IF NOT EXISTS `thunguyen_final_project`.`customers_audit` (
  `customer_id` INT NOT NULL,
  `customer_name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `reward_points` INT NOT NULL,
  INDEX `fk_customersaudit_customer_id_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_customersaudit_customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `thunguyen_final_project`.`customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
