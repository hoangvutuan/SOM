SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `user_role`;
DROP TABLE IF EXISTS `entry`;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `block`;
DROP TABLE IF EXISTS `section`;
DROP TABLE IF EXISTS `student_section`;
DROP TABLE IF exists `student`;
DROP TABLE IF exists `course`;
DROP TABLE IF exists `schedule`;
DROP TABLE IF exists `section_entry`;
DROP TABLE IF exists `faculty`;
DROP TABLE IF exists `faculty_course`;
DROP TABLE IF exists `entry_block`;
DROP TABLE IF exists `course_prerequisite`;

CREATE TABLE `mumsched`.`user` (
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `enabled` tinyint(4) NOT NULL DEFAULT '1',  
  PRIMARY KEY (`username`));
  
CREATE TABLE `mumsched`.`student` (
  `id` INT NOT NULL auto_increment,
  `entry_id` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `dob` date DEFAULT NULL,
   `email` varchar(45) DEFAULT NULL,
   `kind` INT NOT NULL,
  PRIMARY KEY (`id`),
  constraint fk_EntryStudent foreign key (entry_id) references entry(id),
  constraint fk_UserStudent foreign key (username) references user(username));

CREATE TABLE `user_role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `role` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_username_role` (`role`,`username`),
  KEY `fk_username_idx` (`username`),
  CONSTRAINT `fk_username` FOREIGN KEY (`username`) REFERENCES `user` (`username`)
);

CREATE TABLE `mumsched`.`entry` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,  
  `total_fpp` int(11) NOT NULL,
  `total_mpp` int(11) NOT NULL,
  `percent_opt` int(11) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`));
  
CREATE TABLE `mumsched`.`block` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,  
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  PRIMARY KEY (`id`));
  
CREATE TABLE `mumsched`.`section` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,  
  `block_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `faculty_id` INT NULL,
  `capacity` INT NOT NULL,
  PRIMARY KEY (`id`),
   constraint fk_BlockSection foreign key (block_id) references block(id),
   constraint fk_CourseSection foreign key (course_id) references course(id),
   constraint fk_FacultySection foreign key (faculty_id) references faculty(id));
   
CREATE TABLE `course` ( 
  `id` INT NOT NULL AUTO_INCREMENT,
  `course_code` varchar(255) NOT NULL,
  `course_name` varchar(255) NOT NULL,
  `target_block` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_name_UNIQUE` (`course_name`),
  UNIQUE KEY `course_code_UNIQUE` (`course_code`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
  
CREATE TABLE IF NOT EXISTS `mumsched`.`course_prerequisite` (
  `course_id` INT NOT NULL,
  `prerequisite_id` INT NOT NULL,
  PRIMARY KEY (`course_id`, `prerequisite_id`),
  INDEX `fk_prerequisite_course_idx` (`prerequisite_id` ASC),
  CONSTRAINT `fk_course_prerequisite` FOREIGN KEY (`course_id`) REFERENCES `mumsched`.`course` (`id`),
  CONSTRAINT `fk_prerequisite_course` FOREIGN KEY (`prerequisite_id`) REFERENCES `mumsched`.`course` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `mumsched`.`student_section` (
  `id` INT NOT NULL auto_increment,
  `section_id` INT NOT NULL,
  `student_id` INT NOT NULL,  
  `approved` boolean,
  `grade` INT DEFAULT -1,
  PRIMARY KEY (`id`),
  Unique (section_id,student_id),
  constraint fk_Student_id foreign key (student_id) references student(id) on delete cascade,
  constraint fk_Section_id foreign key (section_id) references section(id) on delete cascade);
  
CREATE TABLE IF NOT EXISTS `faculty` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `target_block` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  constraint fk_username_faculty foreign key (username) references user(username)
);

CREATE TABLE IF NOT EXISTS `faculty_course` (
  `faculty_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  PRIMARY KEY (`faculty_id`,`course_id`),
  CONSTRAINT `fk_specialization_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_specialization_faculty` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `schedule` (
  `id` INT NOT NULL auto_increment,
  `entry_id` INT NOT NULL,
  `status` varchar(45) DEFAULT 'DRAFT',
  PRIMARY KEY (`id`),
  KEY `entryFK_idx` (`entry_id`),
  CONSTRAINT `entryFK` FOREIGN KEY (`entry_id`) REFERENCES `entry` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `mumsched`.`section_entry` (
  `entry_id` INT NOT NULL,
  `section_id` INT NOT NULL,
  PRIMARY KEY (entry_id, section_id),
  CONSTRAINT `entryIdFK` FOREIGN KEY (`entry_id`) REFERENCES `entry` (`id`),
  CONSTRAINT `sectionIdFK` FOREIGN KEY (`section_id`) REFERENCES `section` (`id`));
  
CREATE TABLE `mumsched`.`entry_block` (
  `entry_id` INT NOT NULL,
  `block_id` INT NOT NULL,
  PRIMARY KEY (entry_id, block_id),
  CONSTRAINT `entryblockFK` FOREIGN KEY (`entry_id`) REFERENCES `entry` (`id`),
  CONSTRAINT `blockentryFK` FOREIGN KEY (`block_id`) REFERENCES `block` (`id`));

SET FOREIGN_KEY_CHECKS = 1;