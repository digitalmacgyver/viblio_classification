create database test;

use test;

CREATE TABLE `test`.`video` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NULL DEFAULT NULL,
  `s3video_url` VARCHAR(2000) NULL DEFAULT NULL,
  `s3images_url` VARCHAR(2000) NULL DEFAULT NULL,
  `source_url` VARCHAR(2000) NULL DEFAULT NULL,
  `encoding` VARCHAR(60) NULL DEFAULT NULL,
  `width` INT NULL DEFAULT NULL,
  `height` INT NULL DEFAULT NULL,
  `length` DECIMAL(14,6) NULL DEFAULT NULL,
  `created_date` DATETIME NULL DEFAULT NULL,
  `last_updated` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'image'
-- 
-- ---

CREATE TABLE `test`.`image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `video_id` INT NOT NULL,
  `time_stamp` DECIMAL(14,6) NULL DEFAULT NULL,
  `s3image_url` VARCHAR(2000) NULL DEFAULT NULL,
  `format` VARCHAR(60) NULL DEFAULT NULL,
  `width` INT NULL DEFAULT NULL,
  `height` INT NULL DEFAULT NULL,
  `created_date` DATETIME NULL DEFAULT NULL,
  `last_updated` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY (`id`, `video_id`)
);

-- ---
-- Table 'image_label'
-- 
-- ---

CREATE TABLE `test`.`image_label` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image_id` INT NOT NULL,
  `image_video_id` INT NOT NULL,
  `label` VARCHAR(200) NULL DEFAULT NULL,
  `detector_name` VARCHAR(60) NULL DEFAULT NULL,
  `type` VARCHAR(60) NULL DEFAULT NULL,
  `confidence` DECIMAL(14,6) NULL DEFAULT NULL,
  `x1` DECIMAL(14,6) NULL DEFAULT NULL,
  `y1` DECIMAL(14,6) NULL DEFAULT NULL,
  `x2` DECIMAL(14,6) NULL DEFAULT NULL,
  `y2` DECIMAL(14,6) NULL DEFAULT NULL,
  `created_date` DATETIME NULL DEFAULT NULL,
  `last_updated` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'video_label'
-- 
-- ---

CREATE TABLE `test`.`video_label` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `video_id` INT NOT NULL,
  `label` VARCHAR(200) NULL DEFAULT NULL,
  `detector_name` VARCHAR(60) NULL DEFAULT NULL,
  `type` VARCHAR(60) NULL DEFAULT NULL,
  `confidence` DECIMAL(14,6) NULL DEFAULT NULL,
  `created_date` DATETIME NULL DEFAULT NULL,
  `last_updated` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);



-- ---
-- Table 'detector'
-- 
-- ---

CREATE TABLE `test`.`detector` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `run_status` VARCHAR(60) NULL DEFAULT NULL,
  `description` VARCHAR(200) NULL DEFAULT NULL,
  `created_date` DATETIME NULL DEFAULT NULL,
  `last_updated` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY (`name`)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `test`.`image` ADD FOREIGN KEY (video_id) REFERENCES `video` (`id`);
ALTER TABLE `test`.`image_label` ADD FOREIGN KEY (image_id, image_video_id) REFERENCES `image` (`id`, `video_id`);
ALTER TABLE `test`.`image_label` ADD FOREIGN KEY (detector_name) REFERENCES `detector` (`name`) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE `test`.`video_label` ADD FOREIGN KEY (video_id) REFERENCES `video` (`id`);
ALTER TABLE `test`.`video_label` ADD FOREIGN KEY (detector_name) REFERENCES `detector` (`name`) ON DELETE SET NULL ON UPDATE CASCADE;
