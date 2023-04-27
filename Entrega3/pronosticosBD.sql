
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


DROP SCHEMA IF EXISTS `pronosticosBD` ;

CREATE SCHEMA IF NOT EXISTS `pronosticosBD` DEFAULT CHARACTER SET utf8 ;
USE `pronosticosBD` ;

-- -----------------------------------------------------
-- Table `pronosticosBD`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pronosticosBD`.`usuario` ;

CREATE TABLE IF NOT EXISTS `pronosticosBD`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nombre_usuario` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pronosticosBD`.`resultado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pronosticosBD`.`resultado` ;

CREATE TABLE IF NOT EXISTS `pronosticosBD`.`resultado` (
  `idresultado` INT NOT NULL AUTO_INCREMENT,
  `resultado` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idresultado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pronosticosBD`.`ronda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pronosticosBD`.`ronda` ;

CREATE TABLE IF NOT EXISTS `pronosticosBD`.`ronda` (
  `idronda` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idronda`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pronosticosBD`.`partido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pronosticosBD`.`partido` ;

CREATE TABLE IF NOT EXISTS `pronosticosBD`.`partido` (
  `idpartido` INT NOT NULL AUTO_INCREMENT,
  `nombre_eq1` VARCHAR(30) NOT NULL,
  `nombre_eq2` VARCHAR(30) NOT NULL,
  `goles_eq1` INT NOT NULL,
  `goles_eq2` INT NOT NULL,
  `ronda_idronda` INT NOT NULL,
  PRIMARY KEY (`idpartido`, `ronda_idronda`),
  CONSTRAINT `fk_partido_ronda1`
    FOREIGN KEY (`ronda_idronda`)
    REFERENCES `pronosticosBD`.`ronda` (`idronda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_partido_ronda1_idx` ON `pronosticosBD`.`partido` (`ronda_idronda` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `pronosticosBD`.`pronostico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pronosticosBD`.`pronostico` ;

CREATE TABLE IF NOT EXISTS `pronosticosBD`.`pronostico` (
  `idpron` INT NOT NULL AUTO_INCREMENT,
  `usuario_idusuario` INT NOT NULL,
  `resultado_idresultado` INT NOT NULL,
  `partido_idpartido` INT NOT NULL,
  `partido_ronda_idronda` INT NOT NULL,
  PRIMARY KEY (`idpron`, `usuario_idusuario`, `resultado_idresultado`, `partido_idpartido`, `partido_ronda_idronda`),
  CONSTRAINT `fk_pronostico_usuario`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `pronosticosBD`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pronostico_resultado1`
    FOREIGN KEY (`resultado_idresultado`)
    REFERENCES `pronosticosBD`.`resultado` (`idresultado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pronostico_partido1`
    FOREIGN KEY (`partido_idpartido` , `partido_ronda_idronda`)
    REFERENCES `pronosticosBD`.`partido` (`idpartido` , `ronda_idronda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_pronostico_usuario_idx` ON `pronosticosBD`.`pronostico` (`usuario_idusuario` ASC) VISIBLE;

CREATE INDEX `fk_pronostico_resultado1_idx` ON `pronosticosBD`.`pronostico` (`resultado_idresultado` ASC) VISIBLE;

CREATE INDEX `fk_pronostico_partido1_idx` ON `pronosticosBD`.`pronostico` (`partido_idpartido` ASC, `partido_ronda_idronda` ASC) VISIBLE;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- DATA PARTIDO
INSERT INTO `pronosticosbd`.`partido` (`idpartido`, `nombre_eq1`, `nombre_eq2`, `goles_eq1`, `goles_eq2`, `ronda_idronda`) VALUES ('1', 'Argentina', 'Arabia Saudita', '1', '2', '1');
INSERT INTO `pronosticosbd`.`partido` (`idpartido`, `nombre_eq1`, `nombre_eq2`, `goles_eq1`, `goles_eq2`, `ronda_idronda`) VALUES ('2', 'Polonia', 'Mexico', '0', '0', '1');
INSERT INTO `pronosticosbd`.`partido` (`idpartido`, `nombre_eq1`, `nombre_eq2`, `goles_eq1`, `goles_eq2`, `ronda_idronda`) VALUES ('3', 'Argentina', 'Mexico', '2', '0', '2');
INSERT INTO `pronosticosbd`.`partido` (`idpartido`, `nombre_eq1`, `nombre_eq2`, `goles_eq1`, `goles_eq2`, `ronda_idronda`) VALUES ('4', 'Polonia', 'Arabia Saudita', '2', '0', '2');
INSERT INTO `pronosticosbd`.`partido` (`idpartido`, `nombre_eq1`, `nombre_eq2`, `goles_eq1`, `goles_eq2`, `ronda_idronda`) VALUES ('5', 'Argentina', 'Polonia', '2', '0', '3');
INSERT INTO `pronosticosbd`.`partido` (`idpartido`, `nombre_eq1`, `nombre_eq2`, `goles_eq1`, `goles_eq2`, `ronda_idronda`) VALUES ('6', 'Arabia Saudita', 'Mexico', '1', '2', '3');

-- DATA RESULTADO
INSERT INTO `pronosticosbd`.`resultado` (`idresultado`, `resultado`) VALUES ('1', 'GANADOR');
INSERT INTO `pronosticosbd`.`resultado` (`idresultado`, `resultado`) VALUES ('2', 'PERDEDOR');
INSERT INTO `pronosticosbd`.`resultado` (`idresultado`, `resultado`) VALUES ('3', 'EMPATE');

-- DATA RONDA
INSERT INTO `pronosticosbd`.`ronda` (`idronda`) VALUES ('1');
INSERT INTO `pronosticosbd`.`ronda` (`idronda`) VALUES ('2');
INSERT INTO `pronosticosbd`.`ronda` (`idronda`) VALUES ('3');

-- DATA USUARIO
INSERT INTO `pronosticosbd`.`usuario` (`idusuario`, `nombre_usuario`) VALUES ('1','Mariana');
INSERT INTO `pronosticosbd`.`usuario` (`idusuario`, `nombre_usuario`) VALUES ('1','Pedro');

-- DATA PRONOSTICO
INSERT INTO `pronosticosbd`.`pronostico` (`idpron`, `usuario_idusuario`, `resultado_idresultado`, `partido_idpartido`, `partido_ronda_idronda`) VALUES ('1','1', '1', '1', '1');
INSERT INTO `pronosticosbd`.`pronostico` (`idpron`, `usuario_idusuario`, `resultado_idresultado`, `partido_idpartido`, `partido_ronda_idronda`) VALUES ('2','1', '2', '2', '1');
INSERT INTO `pronosticosbd`.`pronostico` (`idpron`, `usuario_idusuario`, `resultado_idresultado`, `partido_idpartido`, `partido_ronda_idronda`) VALUES ('3','1', '3', '3', '2');
INSERT INTO `pronosticosbd`.`pronostico` (`idpron`, `usuario_idusuario`, `resultado_idresultado`, `partido_idpartido`, `partido_ronda_idronda`) VALUES ('4','1', '2', '4', '2');
INSERT INTO `pronosticosbd`.`pronostico` (`idpron`, `usuario_idusuario`, `resultado_idresultado`, `partido_idpartido`, `partido_ronda_idronda`) VALUES ('5','1', '1', '5', '3');
INSERT INTO `pronosticosbd`.`pronostico` (`idpron`, `usuario_idusuario`, `resultado_idresultado`, `partido_idpartido`, `partido_ronda_idronda`) VALUES ('6','1', '3', '6', '3');
INSERT INTO `pronosticosbd`.`pronostico` (`idpron`, `usuario_idusuario`, `resultado_idresultado`, `partido_idpartido`, `partido_ronda_idronda`) VALUES ('7','2', '2', '1', '1');
INSERT INTO `pronosticosbd`.`pronostico` (`idpron`, `usuario_idusuario`, `resultado_idresultado`, `partido_idpartido`, `partido_ronda_idronda`) VALUES ('8','2', '2', '2', '1');
INSERT INTO `pronosticosbd`.`pronostico` (`idpron`, `usuario_idusuario`, `resultado_idresultado`, `partido_idpartido`, `partido_ronda_idronda`) VALUES ('9','2', '3', '3', '2');
INSERT INTO `pronosticosbd`.`pronostico` (`idpron`, `usuario_idusuario`, `resultado_idresultado`, `partido_idpartido`, `partido_ronda_idronda`) VALUES ('10','2', '2', '4', '2');
INSERT INTO `pronosticosbd`.`pronostico` (`idpron`, `usuario_idusuario`, `resultado_idresultado`, `partido_idpartido`, `partido_ronda_idronda`) VALUES ('11','2', '1', '5', '3');
INSERT INTO `pronosticosbd`.`pronostico` (`idpron`, `usuario_idusuario`, `resultado_idresultado`, `partido_idpartido`, `partido_ronda_idronda`) VALUES ('12','2', '1', '6', '3');


SELECT * from pronostico;