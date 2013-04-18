SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `mydb` ;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Company`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Company` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Company` (
  `CompanyId` INT NOT NULL AUTO_INCREMENT ,
  `CompanyName` VARCHAR(50) NOT NULL ,
  `LogoUrl` VARCHAR(45) NOT NULL ,
  `ManagerId` INT NOT NULL ,
  PRIMARY KEY (`CompanyId`, `ManagerId`) ,
  UNIQUE INDEX `CompanyId_UNIQUE` (`CompanyId` ASC) ,
  INDEX `fk_Company_User1_idx` (`ManagerId` ASC) ,
  CONSTRAINT `fk_Company_User1`
    FOREIGN KEY (`ManagerId` )
    REFERENCES `mydb`.`User` (`UserId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Roles` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Roles` (
  `RoleId` INT NOT NULL AUTO_INCREMENT ,
  `RoleName` VARCHAR(45) NOT NULL ,
  `ManageCompany` TINYINT(1) NOT NULL ,
  `AddContent` TINYINT(1) NOT NULL ,
  PRIMARY KEY (`RoleId`) ,
  UNIQUE INDEX `RoleId_UNIQUE` (`RoleId` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`User` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`User` (
  `UserId` INT NOT NULL AUTO_INCREMENT ,
  `UserName` VARCHAR(45) NOT NULL ,
  `Password` VARCHAR(20) NOT NULL ,
  `Company_CompanyId` INT NULL ,
  `Roles_RoleId` INT NOT NULL ,
  PRIMARY KEY (`UserId`, `Company_CompanyId`, `Roles_RoleId`) ,
  UNIQUE INDEX `UserId_UNIQUE` (`UserId` ASC) ,
  UNIQUE INDEX `UserName_UNIQUE` (`UserName` ASC) ,
  INDEX `fk_User_Company1_idx` (`Company_CompanyId` ASC) ,
  INDEX `fk_User_Roles1_idx` (`Roles_RoleId` ASC) ,
  CONSTRAINT `fk_User_Company1`
    FOREIGN KEY (`Company_CompanyId` )
    REFERENCES `mydb`.`Company` (`CompanyId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_Roles1`
    FOREIGN KEY (`Roles_RoleId` )
    REFERENCES `mydb`.`Roles` (`RoleId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Variety`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Variety` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Variety` (
  `VarietyId` INT NOT NULL AUTO_INCREMENT ,
  `VarietyName` VARCHAR(45) NOT NULL ,
  `Description` VARCHAR(200) NOT NULL ,
  `ImageUrl` VARCHAR(150) NOT NULL ,
  PRIMARY KEY (`VarietyId`) ,
  UNIQUE INDEX `VarietyId_UNIQUE` (`VarietyId` ASC) ,
  UNIQUE INDEX `VarietyName_UNIQUE` (`VarietyName` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Source`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Source` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Source` (
  `SourceId` INT NOT NULL AUTO_INCREMENT ,
  `SourceName` VARCHAR(50) NOT NULL ,
  `SourceDescription` VARCHAR(200) NOT NULL ,
  PRIMARY KEY (`SourceId`) ,
  UNIQUE INDEX `SourceId_UNIQUE` (`SourceId` ASC) ,
  UNIQUE INDEX `SourceName_UNIQUE` (`SourceName` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OrderHeader`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`OrderHeader` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`OrderHeader` (
  `OrderHeaderId` INT NOT NULL AUTO_INCREMENT ,
  `DateCreated` DATETIME NOT NULL ,
  `TotalPrice` DECIMAL NOT NULL ,
  `Status` TINYINT(1) NOT NULL DEFAULT False ,
  `User_UserId` INT NOT NULL ,
  PRIMARY KEY (`OrderHeaderId`, `User_UserId`) ,
  UNIQUE INDEX `OrderHeaderId_UNIQUE` (`OrderHeaderId` ASC) ,
  INDEX `fk_OrderHeader_User1_idx` (`User_UserId` ASC) ,
  CONSTRAINT `fk_OrderHeader_User1`
    FOREIGN KEY (`User_UserId` )
    REFERENCES `mydb`.`User` (`UserId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OrderLineItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`OrderLineItem` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`OrderLineItem` (
  `OrderHeaderId` INT NOT NULL ,
  `ProductId` INT NOT NULL ,
  `Quantity` INT NOT NULL ,
  PRIMARY KEY (`OrderHeaderId`, `ProductId`) ,
  INDEX `fk_OrderLineItem_OrderHeader1_idx` (`OrderHeaderId` ASC) ,
  CONSTRAINT `fk_OrderLineItem_OrderHeader1`
    FOREIGN KEY (`OrderHeaderId` )
    REFERENCES `mydb`.`OrderHeader` (`OrderHeaderId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Product` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Product` (
  `ProductId` INT NOT NULL AUTO_INCREMENT ,
  `VarietyId` INT NOT NULL ,
  `SourceId` INT NOT NULL ,
  `Price` DECIMAL NOT NULL ,
  PRIMARY KEY (`ProductId`, `VarietyId`, `SourceId`, `Price`) ,
  UNIQUE INDEX `ProductId_UNIQUE` (`ProductId` ASC) ,
  INDEX `fk_Product_Variety_idx` (`VarietyId` ASC) ,
  INDEX `fk_Product_Source1_idx` (`SourceId` ASC) ,
  CONSTRAINT `fk_Product_Variety`
    FOREIGN KEY (`VarietyId` )
    REFERENCES `mydb`.`Variety` (`VarietyId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_Source1`
    FOREIGN KEY (`SourceId` )
    REFERENCES `mydb`.`Source` (`SourceId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_OrderLineItem1`
    FOREIGN KEY (`ProductId` )
    REFERENCES `mydb`.`OrderLineItem` (`ProductId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Profile` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Profile` (
  `Email` VARCHAR(100) NOT NULL ,
  `Phone` VARCHAR(45) NOT NULL ,
  `User_UserId` INT NOT NULL ,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) ,
  PRIMARY KEY (`User_UserId`) ,
  CONSTRAINT `fk_Profile_User1`
    FOREIGN KEY (`User_UserId` )
    REFERENCES `mydb`.`User` (`UserId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
