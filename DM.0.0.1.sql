
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

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
  dato_registrert TIMESTAMP NOT NULL,
  innlogget BIT(1) NOT NULL DEFAULT b'0',
  i_spill BIT(1) NOT NULL DEFAULT b'0',
  dato_sist_innlogget TIMESTAMP NULL,
  PRIMARY KEY (spiller_id))
ENGINE = InnoDB;

CREATE UNIQUE INDEX navn_UNIQUE ON brettspill.SPILLER (kallenavn ASC);

CREATE UNIQUE INDEX epost_UNIQUE ON brettspill.SPILLER (epost ASC);


-- -----------------------------------------------------
-- Table brettspill.TYPE_SPILL
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS brettspill.TYPE_SPILL (
	type_spill_id INT NOT NULL,
	type_spill VARCHAR(100) NOT NULL,
	PRIMARY KEY (type_spill_id)
)
ENGINE = InnoDB;

CREATE UNIQUE INDEX type_spill_UNIQUE ON brettspill.TYPE_SPILL (type_spill ASC);

-- -----------------------------------------------------
-- Table brettspill.SPILL
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS brettspill.SPILL (
  spill_id INT NOT NULL AUTO_INCREMENT,
  spillnavn VARCHAR(45) NULL,
  fk_leder int NULL,
  fk_type_spill_id int NULL,
  dato_fom TIMESTAMP NULL,
  dato_tom TIMESTAMP NULL,
  maks_poeng TINYINT(1) UNSIGNED NOT NULL DEFAULT 13,
  PRIMARY KEY (spill_id),
  CONSTRAINT fk_SPILL_LEDER
    FOREIGN KEY (fk_leder)
    REFERENCES brettspill.SPILLER_I_SPILL (spiller_i_spill_id)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT fk_SPILL_TYPE_SPILL
    FOREIGN KEY (fk_type_spill_id)
    REFERENCES brettspill.TYPE_SPILL (type_spill_id)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB;

CREATE INDEX idx_dato USING BTREE ON brettspill.SPILL (dato_fom ASC, dato_tom ASC);


-- -----------------------------------------------------
-- Table brettspill.SPILLER_I_SPILL
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS brettspill.SPILLER_I_SPILL (
  spiller_i_spill_id INT NOT NULL AUTO_INCREMENT,
  fk_spiller_id INT NOT NULL,
  fk_spill_id INT NOT NULL,
  farge CHAR(7) NOT NULL,
  plassering TINYINT NULL,
  PRIMARY KEY (spiller_i_spill_id),
  CONSTRAINT fk_SPILLER_i_SPILL
    FOREIGN KEY (fk_spiller_id)
    REFERENCES brettspill.SPILLER (spiller_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_SPILL_med_SPILLER
    FOREIGN KEY (fk_spill_id)
    REFERENCES brettspill.SPILL (spill_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX fk_SPILL_med_SPILLER_idx USING BTREE ON brettspill.SPILLER_I_SPILL (fk_spill_id ASC);

CREATE UNIQUE INDEX game_id_UNIQUE USING BTREE ON brettspill.SPILLER_I_SPILL (fk_spill_id ASC, fk_spiller_id ASC);


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
  handling_id INT NOT NULL AUTO_INCREMENT,
  handling_type ENUM('Legge ut kart', 'Legge ut number token') NOT NULL,
  tur_id INT NOT NULL,
  PRIMARY KEY (handling_id),
  CONSTRAINT fk_HANDLING_TUR1
    FOREIGN KEY (tur_id)
    REFERENCES brettspill.TUR (tur_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX fk_HANDLING_TUR1_idx ON brettspill.HANDLING (tur_id ASC);

-- -----------------------------------------------------
-- Table brettspill.HEXDEL
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS brettspill.HEXDEL (
  hexdel_id INT NOT NULL AUTO_INCREMENT,
  fk_spill INT NOT NULL,
  hextype VARCHAR(25) NOT NULL,
  q INT NOT NULL,
  r INT NOT NULL,
  PRIMARY KEY (hexdel_id),
  CONSTRAINT fk_BRETTDEL_SPILL1
    FOREIGN KEY (fk_spill)
    REFERENCES brettspill.SPILL (spill_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX fk_HANDLING_TUR1_idx ON brettspill.HEXDEL (fk_spill ASC);


SET SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION'; # 
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
