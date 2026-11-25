-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema kirjasto
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema kirjasto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `kirjasto` DEFAULT CHARACTER SET utf8 ;
USE `kirjasto` ;

-- -----------------------------------------------------
-- Table `kirjasto`.`asiakas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kirjasto`.`asiakas` (
  `asiakasId` INT NOT NULL AUTO_INCREMENT,
  `Etunimi` VARCHAR(45) NOT NULL,
  `Sukunimi` VARCHAR(45) NOT NULL,
  `Osoite` VARCHAR(45) NULL,
  `Puhnro` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `hetu` VARCHAR(45) NULL,
  PRIMARY KEY (`asiakasId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kirjasto`.`Tekijä`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kirjasto`.`Tekijä` (
  `tekijäId` INT NOT NULL AUTO_INCREMENT,
  `Etunimi` VARCHAR(45) NOT NULL,
  `Sukunimi` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tekijäId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kirjasto`.`Roolit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kirjasto`.`Roolit` (
  `RooliId` INT NOT NULL AUTO_INCREMENT,
  `RooliNimi` VARCHAR(45) NULL,
  PRIMARY KEY (`RooliId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kirjasto`.`Teos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kirjasto`.`Teos` (
  `TeosId` INT NOT NULL AUTO_INCREMENT,
  `TeosNimi` VARCHAR(200) NULL,
  `AlkupJulkaisuvuosi` INT NULL,
  `AlkupKieli` VARCHAR(200) NULL,
  PRIMARY KEY (`TeosId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kirjasto`.`Sijainti`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kirjasto`.`Sijainti` (
  `sijaintiId` INT NOT NULL,
  `sijaintiNimi` VARCHAR(45) NULL,
  PRIMARY KEY (`sijaintiId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kirjasto`.`Kirja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kirjasto`.`Kirja` (
  `idKirja` INT NOT NULL AUTO_INCREMENT,
  `sijaintiId` INT NOT NULL,
  `TeosId` INT NOT NULL,
  PRIMARY KEY (`idKirja`),
  INDEX `fk_Kirja_Sijainti1_idx` (`sijaintiId` ASC) VISIBLE,
  INDEX `fk_Kirja_Teos1_idx` (`TeosId` ASC) VISIBLE,
  CONSTRAINT `fk_Kirja_Sijainti1`
    FOREIGN KEY (`sijaintiId`)
    REFERENCES `kirjasto`.`Sijainti` (`sijaintiId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Kirja_Teos1`
    FOREIGN KEY (`TeosId`)
    REFERENCES `kirjasto`.`Teos` (`TeosId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kirjasto`.`TeosTekijä`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kirjasto`.`TeosTekijä` (
  `TeosId` INT NOT NULL,
  `tekijäId` INT NOT NULL,
  `RooliId` INT NOT NULL,
  INDEX `fk_TeosTekijä_Teos_idx` (`TeosId` ASC) VISIBLE,
  PRIMARY KEY (`TeosId`, `RooliId`, `tekijäId`),
  INDEX `fk_TeosTekijä_Tekijä1_idx` (`tekijäId` ASC) VISIBLE,
  INDEX `fk_TeosTekijä_Roolit1_idx` (`RooliId` ASC) VISIBLE,
  CONSTRAINT `fk_TeosTekijä_Teos`
    FOREIGN KEY (`TeosId`)
    REFERENCES `kirjasto`.`Teos` (`TeosId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TeosTekijä_Tekijä1`
    FOREIGN KEY (`tekijäId`)
    REFERENCES `kirjasto`.`Tekijä` (`tekijäId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TeosTekijä_Roolit1`
    FOREIGN KEY (`RooliId`)
    REFERENCES `kirjasto`.`Roolit` (`RooliId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kirjasto`.`Lainaus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `kirjasto`.`Lainaus` (
  `lainausId` INT NOT NULL AUTO_INCREMENT,
  `lainauspvm` DATE NOT NULL,
  `eräpäivä` DATE NOT NULL,
  `palautuspäivä` DATE NULL,
  `asiakas_asiakasId` INT NOT NULL,
  `Kirja_idKirja` INT NOT NULL,
  PRIMARY KEY (`lainausId`),
  INDEX `fk_Lainaus_asiakas1_idx` (`asiakas_asiakasId` ASC) VISIBLE,
  INDEX `fk_Lainaus_Kirja1_idx` (`Kirja_idKirja` ASC) VISIBLE,
  CONSTRAINT `fk_Lainaus_asiakas1`
    FOREIGN KEY (`asiakas_asiakasId`)
    REFERENCES `kirjasto`.`asiakas` (`asiakasId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Lainaus_Kirja1`
    FOREIGN KEY (`Kirja_idKirja`)
    REFERENCES `kirjasto`.`Kirja` (`idKirja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
