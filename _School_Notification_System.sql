-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema parentteacher
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Parent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Parent` (
  `id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Mobile` VARCHAR(45) NOT NULL,
  `E-mail` VARCHAR(45) NULL,
  `Login_Pwd` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Standard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Standard` (
  `id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Syllabus` VARCHAR(1000) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Student` (
  `id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Parent_Id` INT NOT NULL,
  `Standard_Id` INT NOT NULL,
  `Section` VARCHAR(3) NOT NULL,
  `Comments` VARCHAR(1000) NULL,
  `Special Fees` INT NULL,
  `Tutor` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `Stud_Parent_idx` (`Parent_Id` ASC),
  INDEX `Stud_Std_idx` (`Standard_Id` ASC),
  CONSTRAINT `Stud_Parent`
    FOREIGN KEY (`Parent_Id`)
    REFERENCES `mydb`.`Parent` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Stud_Std`
    FOREIGN KEY (`Standard_Id`)
    REFERENCES `mydb`.`Standard` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Teacher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Teacher` (
  `id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Designation` VARCHAR(45) NOT NULL,
  `Mobile` VARCHAR(45) NOT NULL,
  `E-maill` VARCHAR(45) NULL,
  `Login_Pwd` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TeacherStandardRel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TeacherStandardRel` (
  `Teacher_Id` INT NOT NULL,
  `Standard_Id` INT NOT NULL,
  `Section` VARCHAR(5) NOT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LeaveRecord`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LeaveRecord` (
  `Student_Id` INT NOT NULL,
  `From_Date` DATE NOT NULL,
  `To_Date` DATE NOT NULL,
  `Requested_Date` DATE NOT NULL,
  `Is_Approved` BIT NOT NULL,
  `Remarks` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`Student_Id`),
  CONSTRAINT `Stud_Leave`
    FOREIGN KEY (`Student_Id`)
    REFERENCES `mydb`.`Student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`FeesStructure`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`FeesStructure` (
  `Standard_Id` INT NOT NULL,
  `Term_Fees` INT NOT NULL,
  PRIMARY KEY (`Standard_Id`),
  CONSTRAINT `Std_Fees-PK`
    FOREIGN KEY (`Standard_Id`)
    REFERENCES `mydb`.`Standard` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Subject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Subject` (
  `id` INT NOT NULL,
  `Name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ExamName`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ExamName` (
  `id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`StandardSubjectRel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`StandardSubjectRel` (
  `Standard_id` INT NOT NULL,
  `Subject_Id` INT NOT NULL,
  INDEX `Std_PK_idx` (`Standard_id` ASC),
  INDEX `Sub_PK_idx` (`Subject_Id` ASC),
  CONSTRAINT `Std_PK`
    FOREIGN KEY (`Standard_id`)
    REFERENCES `mydb`.`Standard` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Sub_PK`
    FOREIGN KEY (`Subject_Id`)
    REFERENCES `mydb`.`Subject` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MarkSheet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MarkSheet` (
  `Student_Id` INT NOT NULL,
  `Exam_Id` INT NOT NULL,
  `Subject_Name` VARCHAR(30) NOT NULL,
  `Marks` INT NOT NULL,
  INDEX `Stud_Mark_PK_idx` (`Student_Id` ASC),
  INDEX `Exam_Mark_PK_idx` (`Exam_Id` ASC),
  CONSTRAINT `Stud_Mark_PK`
    FOREIGN KEY (`Student_Id`)
    REFERENCES `mydb`.`Student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Exam_Mark_PK`
    FOREIGN KEY (`Exam_Id`)
    REFERENCES `mydb`.`ExamName` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`UserPosition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`UserPosition` (
  `id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Position` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
