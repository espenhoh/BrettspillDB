-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bosetterne
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS brettspill;

-- -----------------------------------------------------
-- Schema bosetterne
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS brettspill DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE brettspill;

-- -----------------------------------------------------
-- Table brettspill.SPILLER
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS brettspill.SPILLER (
  spiller_id INT NOT NULL AUTO_INCREMENT,
  kallenavn VARCHAR(45) NOT NULL,
  epost VARCHAR(45) NOT NULL,
  passord VARCHAR(45) NOT NULL,
  dato_registrert DATE NOT NULL,
  innlogget BIT(1) NOT NULL DEFAULT b'0',
  i_spill BIT(1) NOT NULL DEFAULT b'0',
  dato_sist_innlogget TIMESTAMP NULL,
  PRIMARY KEY (spiller_id))
ENGINE = InnoDB;

CREATE UNIQUE INDEX navn_UNIQUE ON brettspill.SPILLER (brukernavn ASC);

CREATE UNIQUE INDEX epost_UNIQUE ON brettspill.SPILLER (epost ASC);


-- -----------------------------------------------------
-- Table brettspill.SPILL
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS brettspill.SPILL (
  spill_id INT NOT NULL AUTO_INCREMENT,
  navn VARCHAR(45) NULL,
  fk_leder int NOT NULL,
  type_spill ENUM('Bosetterne','Byer og riddere','Sjøfarer','Sjøfarer med byer og riddere','Traders and barbarians ikke planlagt implementert','Explorers and Pirates ikke planlagt implementert') NOT NULL,
  dato_fom TIMESTAMP NULL,
  dato_tom TIMESTAMP NULL,
  maks_poeng TINYINT(1) UNSIGNED NOT NULL DEFAULT 13,
  PRIMARY KEY (spill_id),
  CONSTRAINT fk_SPILL_LEDER
    FOREIGN KEY (fk_leder)
    REFERENCES brettspill.SPILLER (spiller_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
  CONSTRAINT fk_TYPE_SPILL1
    FOREIGN KEY (fk_type_spill)
    REFERENCES brettspill.TYPE_SPILL (pk_type_spill)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_dato USING BTREE ON brettspill.SPILL (dato_fom ASC, dato_tom ASC);


-- -----------------------------------------------------
-- Table brettspill.SPILLER_I_SPILL
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS brettspill.SPILLER_I_SPILL (
  spiller_i_spill_id INT NOT NULL AUTO_INCREMENT,
  brukernavn VARCHAR(15) NOT NULL,
  spill_id INT NOT NULL,
  farge CHAR(7) NOT NULL,
  plassering TINYINT NULL,
  PRIMARY KEY (spiller_i_spill_id),
  CONSTRAINT fk_SPILLER_i_SPILL
    FOREIGN KEY (brukernavn)
    REFERENCES brettspill.SPILLER (brukernavn)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_SPILL_med_SPILLER
    FOREIGN KEY (spill_id)
    REFERENCES brettspill.SPILL (spill_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX fk_SPILL_med_SPILLER_idx USING BTREE ON brettspill.SPILLER_I_SPILL (spill_id ASC);

CREATE INDEX fk_SPILLER_i_SPILL_idx ON brettspill.SPILLER_I_SPILL (brukernavn ASC);

CREATE UNIQUE INDEX game_id_UNIQUE USING BTREE ON brettspill.SPILLER_I_SPILL (spill_id ASC, brukernavn ASC);


-- -----------------------------------------------------
-- Table brettspill.TUR
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS brettspill.TUR (
  tur_id INT NOT NULL AUTO_INCREMENT,
  fk_spiller_i_spill_id INT NOT NULL,
  PRIMARY KEY (tur_id),
  CONSTRAINT fk_table1_SPILL1
    FOREIGN KEY (fk_spiller_i_spill_id)
    REFERENCES brettspill.SPILLER_I_SPILL (spiller_i_spill_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table brettspill.HANDLING
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS brettspill.HANDLING (
  handling_id INT NOT NULL,
  k_handling VARCHAR(20) NOT NULL,
  tur_id INT NOT NULL,
  spill_id INT NOT NULL,
  PRIMARY KEY (handling_id),
  CONSTRAINT fk_HANDLING_TUR1
    FOREIGN KEY (tur_id , spill_id)
    REFERENCES brettspill.TUR (tur_id , spill_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_HANDLING_K_HANDLING1
    FOREIGN KEY (k_handling)
    REFERENCES brettspill.K_HANDLING (k_handling)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX fk_HANDLING_TUR1_idx ON brettspill.HANDLING (tur_id ASC, spill_id ASC);

CREATE INDEX fk_HANDLING_K_HANDLING1_idx ON brettspill.HANDLING (k_handling ASC);




SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
