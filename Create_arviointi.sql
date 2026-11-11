-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema arviointi
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema arviointi
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `arviointi` DEFAULT CHARACTER SET utf8 ;
USE `arviointi` ;

-- -----------------------------------------------------
-- Table `arviointi`.`Luokkatunnus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `arviointi`.`Luokkatunnus` ;

CREATE TABLE IF NOT EXISTS `arviointi`.`Luokkatunnus` (
  `idLuokkatunnus` INT NOT NULL AUTO_INCREMENT,
  `Tunnus` VARCHAR(45) NULL,
  PRIMARY KEY (`idLuokkatunnus`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `arviointi`.`Opiskelija`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `arviointi`.`Opiskelija` ;

CREATE TABLE IF NOT EXISTS `arviointi`.`Opiskelija` (
  `idOpiskelija` INT NOT NULL AUTO_INCREMENT,
  `Etunimi` VARCHAR(255) NULL,
  `Sukunimi` VARCHAR(255) NULL,
  `Osoite` VARCHAR(45) NULL,
  `Luokkatunnus_idLuokkatunnus` INT NOT NULL,
  PRIMARY KEY (`idOpiskelija`),
  INDEX `fk_Opiskelija_Luokkatunnus1_idx` (`Luokkatunnus_idLuokkatunnus` ASC) VISIBLE,
  CONSTRAINT `fk_Opiskelija_Luokkatunnus1`
    FOREIGN KEY (`Luokkatunnus_idLuokkatunnus`)
    REFERENCES `arviointi`.`Luokkatunnus` (`idLuokkatunnus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `arviointi`.`Opintojakso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `arviointi`.`Opintojakso` ;

CREATE TABLE IF NOT EXISTS `arviointi`.`Opintojakso` (
  `idOpintojakso` INT NOT NULL AUTO_INCREMENT,
  `Nimi` VARCHAR(45) NULL,
  `Laajuus` INT NOT NULL,
  `Koodi` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idOpintojakso`),
  UNIQUE INDEX `Koodi_UNIQUE` (`Koodi` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `arviointi`.`Arviointi`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `arviointi`.`Arviointi` ;

CREATE TABLE IF NOT EXISTS `arviointi`.`Arviointi` (
  `idArviointi` INT NOT NULL AUTO_INCREMENT,
  `Päivämäärä` DATE NOT NULL,
  `Arvosana` INT NOT NULL,
  `idOpiskelija` INT NOT NULL,
  `idOpintojakso` INT NOT NULL,
  PRIMARY KEY (`idArviointi`),
  INDEX `fk_Arviointi_Opiskelija_idx` (`idOpiskelija` ASC) VISIBLE,
  INDEX `fk_Arviointi_Opintojakso1_idx` (`idOpintojakso` ASC) VISIBLE,
  CONSTRAINT `fk_Arviointi_Opiskelija`
    FOREIGN KEY (`idOpiskelija`)
    REFERENCES `arviointi`.`Opiskelija` (`idOpiskelija`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Arviointi_Opintojakso1`
    FOREIGN KEY (`idOpintojakso`)
    REFERENCES `arviointi`.`Opintojakso` (`idOpintojakso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
