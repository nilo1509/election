-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema election
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema election
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `election` DEFAULT CHARACTER SET utf8 ;
USE `election` ;

-- -----------------------------------------------------
-- Table `election`.`adm`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `election`.`adm` (
  `adm_id` INT NOT NULL AUTO_INCREMENT,
  `google_id` VARCHAR(45) NULL,
  `name` VARCHAR(60) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(60) NULL,
  `admin_role` VARCHAR(45) NULL,
  `permition_list` TEXT NULL,
  `last_login` DATE NOT NULL,
  PRIMARY KEY (`adm_id`),
  UNIQUE INDEX `google_id_UNIQUE` (`google_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `election`.`election`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `election`.`election` (
  `election_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `adm_adm_id` INT NOT NULL,
  PRIMARY KEY (`election_id`, `adm_adm_id`),
  INDEX `fk_election_adm1_idx` (`adm_adm_id` ASC) VISIBLE,
  CONSTRAINT `fk_election_adm1`
    FOREIGN KEY (`adm_adm_id`)
    REFERENCES `election`.`adm` (`adm_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `election`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `election`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `google_id` VARCHAR(45) NULL,
  `name` VARCHAR(60) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(60) NULL,
  `is_logged` TINYINT(1) NOT NULL,
  `election_election_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `election_election_id`),
  INDEX `fk_user_election1_idx` (`election_election_id` ASC) VISIBLE,
  UNIQUE INDEX `google_id_UNIQUE` (`google_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_election1`
    FOREIGN KEY (`election_election_id`)
    REFERENCES `election`.`election` (`election_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `election`.`political_party`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `election`.`political_party` (
  `political_party_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `profile_picture` VARCHAR(350) NOT NULL,
  `election_election_id` INT NOT NULL,
  PRIMARY KEY (`political_party_id`, `election_election_id`),
  INDEX `fk_political_party_election1_idx` (`election_election_id` ASC) VISIBLE,
  CONSTRAINT `fk_political_party_election1`
    FOREIGN KEY (`election_election_id`)
    REFERENCES `election`.`election` (`election_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `election`.`political_position`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `election`.`political_position` (
  `political_position_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `vacancies` INT NOT NULL,
  `election_election_id` INT NOT NULL,
  PRIMARY KEY (`political_position_id`, `election_election_id`),
  INDEX `fk_political_position_election1_idx` (`election_election_id` ASC) VISIBLE,
  CONSTRAINT `fk_political_position_election1`
    FOREIGN KEY (`election_election_id`)
    REFERENCES `election`.`election` (`election_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `election`.`candidate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `election`.`candidate` (
  `candidate_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `card_number` VARCHAR(45) NOT NULL,
  `candidate_number` INT NOT NULL,
  `amount_votes` INT NOT NULL,
  `profile_picture` VARCHAR(350) NULL,
  `political_party_political_party_id` INT NOT NULL,
  `political_position_political_position_id` INT NOT NULL,
  `election_election_id` INT NOT NULL,
  PRIMARY KEY (`candidate_id`, `political_party_political_party_id`, `political_position_political_position_id`, `election_election_id`),
  INDEX `fk_candidate_political_party_idx` (`political_party_political_party_id` ASC) VISIBLE,
  INDEX `fk_candidate_election1_idx` (`election_election_id` ASC) VISIBLE,
  INDEX `fk_candidate_political_position1_idx` (`political_position_political_position_id` ASC) VISIBLE,
  CONSTRAINT `fk_candidate_political_party`
    FOREIGN KEY (`political_party_political_party_id`)
    REFERENCES `election`.`political_party` (`political_party_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_candidate_election1`
    FOREIGN KEY (`election_election_id`)
    REFERENCES `election`.`election` (`election_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_candidate_political_position1`
    FOREIGN KEY (`political_position_political_position_id`)
    REFERENCES `election`.`political_position` (`political_position_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `election`.`permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `election`.`permissions` (
  `permissions_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(250) NOT NULL,
  `access_levels` TEXT NOT NULL,
  `is_active` TINYINT(1) NOT NULL,
  PRIMARY KEY (`permissions_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `election`.`permissions_has_adm`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `election`.`permissions_has_adm` (
  `permissions_permissions_id` INT NOT NULL,
  `adm_adm_id` INT NOT NULL,
  PRIMARY KEY (`permissions_permissions_id`, `adm_adm_id`),
  INDEX `fk_permissions_has_adm_adm1_idx` (`adm_adm_id` ASC) VISIBLE,
  INDEX `fk_permissions_has_adm_permissions1_idx` (`permissions_permissions_id` ASC) VISIBLE,
  CONSTRAINT `fk_permissions_has_adm_permissions1`
    FOREIGN KEY (`permissions_permissions_id`)
    REFERENCES `election`.`permissions` (`permissions_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_permissions_has_adm_adm1`
    FOREIGN KEY (`adm_adm_id`)
    REFERENCES `election`.`adm` (`adm_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;