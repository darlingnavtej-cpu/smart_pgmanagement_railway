-- SmartPGManagementSystem Database Schema
-- Database: smart_pg

CREATE DATABASE IF NOT EXISTS `smart_pg`;
USE `smart_pg`;

-- ----------------------------
-- Table: activity
-- ----------------------------
CREATE TABLE IF NOT EXISTS `activity` (
  `activity_id` int NOT NULL AUTO_INCREMENT,
  `activity_text` varchar(255) DEFAULT NULL,
  `activity_time` datetime DEFAULT NULL,
  PRIMARY KEY (`activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table: complaint
-- ----------------------------
CREATE TABLE IF NOT EXISTS `complaint` (
  `complaint_id` int NOT NULL AUTO_INCREMENT,
  `tenant_id` int NOT NULL,
  `problem` varchar(500) NOT NULL,
  `complaint_date` date NOT NULL,
  `status` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`complaint_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table: employee
-- ----------------------------
CREATE TABLE IF NOT EXISTS `employee` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `employee_name` varchar(50) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `role` varchar(30) DEFAULT NULL,
  `salary` int DEFAULT NULL,
  `joining_date` date DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table: employee_salary_history
-- ----------------------------
CREATE TABLE IF NOT EXISTS `employee_salary_history` (
  `salary_id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int DEFAULT NULL,
  `employee_name` varchar(100) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `month_name` varchar(30) DEFAULT NULL,
  `salary_amount` int DEFAULT NULL,
  `paid_date` date DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`salary_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table: expense
-- ----------------------------
CREATE TABLE IF NOT EXISTS `expense` (
  `expense_id` int NOT NULL,
  `expense_name` varchar(100) DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `expense_date` date DEFAULT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`expense_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table: fee
-- ----------------------------
CREATE TABLE IF NOT EXISTS `fee` (
  `fee_id` int NOT NULL AUTO_INCREMENT,
  `tenant_id` int NOT NULL,
  `month_name` varchar(20) NOT NULL,
  `amount` double NOT NULL,
  `paid_date` date NOT NULL,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`fee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table: newreg (Admin Registration)
-- ----------------------------
CREATE TABLE IF NOT EXISTS `newreg` (
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Seed admin user
INSERT INTO `newreg` VALUES ('admin','admin123','smartpgmanage@gmail.com')
ON DUPLICATE KEY UPDATE `username`=`username`;

-- ----------------------------
-- Table: notice
-- ----------------------------
CREATE TABLE IF NOT EXISTS `notice` (
  `notice_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `notice_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table: payment_details
-- ----------------------------
CREATE TABLE IF NOT EXISTS `payment_details` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `owner_name` varchar(100) NOT NULL,
  `bank_name` varchar(100) NOT NULL,
  `account_number` varchar(30) NOT NULL,
  `ifsc_code` varchar(20) NOT NULL,
  `upi_id` varchar(100) DEFAULT NULL,
  `qr_image` varchar(255) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table: payment_request
-- ----------------------------
CREATE TABLE IF NOT EXISTS `payment_request` (
  `request_id` int NOT NULL AUTO_INCREMENT,
  `tenant_id` int DEFAULT NULL,
  `tenant_name` varchar(100) DEFAULT NULL,
  `room_no` int DEFAULT NULL,
  `month_name` varchar(20) DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `utr_number` varchar(50) DEFAULT NULL,
  `submitted_on` datetime DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table: pg_info
-- ----------------------------
CREATE TABLE IF NOT EXISTS `pg_info` (
  `id` int NOT NULL,
  `pg_name` varchar(100) DEFAULT NULL,
  `owner_name` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `wifi` varchar(20) DEFAULT NULL,
  `cctv` varchar(20) DEFAULT NULL,
  `parking` varchar(20) DEFAULT NULL,
  `laundry` varchar(20) DEFAULT NULL,
  `hot_water` varchar(20) DEFAULT NULL,
  `visitor_time` varchar(100) DEFAULT NULL,
  `rent_due_date` varchar(30) DEFAULT NULL,
  `google_map_link` varchar(1000) DEFAULT NULL,
  `rating` double DEFAULT NULL,
  `image1` varchar(200) DEFAULT NULL,
  `image2` varchar(200) DEFAULT NULL,
  `image3` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Seed PG info
INSERT INTO `pg_info` VALUES (1,'Smart PG Management','Navateja','9346120557','admin@smartpg.com','old madivala','Available','Available','Available','Available','Available','9:00 AM - 8:00 PM','Every Month Before 5th','https://maps.app.goo.gl/wigVoBnW9dq8jid79',4.8,'images/pg1.jpg','images/pg2.jpg','images/pg3.jpg')
ON DUPLICATE KEY UPDATE `id`=`id`;

-- ----------------------------
-- Table: reminder_history
-- ----------------------------
CREATE TABLE IF NOT EXISTS `reminder_history` (
  `reminder_id` int NOT NULL AUTO_INCREMENT,
  `month_name` varchar(20) DEFAULT NULL,
  `total_sent` int DEFAULT NULL,
  `sent_on` datetime DEFAULT NULL,
  PRIMARY KEY (`reminder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table: rent_reminder_settings
-- ----------------------------
CREATE TABLE IF NOT EXISTS `rent_reminder_settings` (
  `setting_id` int NOT NULL,
  `due_day` int NOT NULL,
  `reminder_before_days` int NOT NULL,
  PRIMARY KEY (`setting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table: room
-- ----------------------------
CREATE TABLE IF NOT EXISTS `room` (
  `room_no` int NOT NULL,
  `capacity` int DEFAULT NULL,
  `occupied` int DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `rent` int DEFAULT NULL,
  PRIMARY KEY (`room_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table: tenant
-- ----------------------------
CREATE TABLE IF NOT EXISTS `tenant` (
  `tenant_id` varchar(20) NOT NULL,
  `tenant_name` varchar(20) NOT NULL,
  `age` int NOT NULL,
  `gender` varchar(20) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `occupation` varchar(20) NOT NULL,
  `institute` varchar(20) NOT NULL,
  `joining_date` date NOT NULL,
  `room_no` int NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table: tenant_checkout
-- ----------------------------
CREATE TABLE IF NOT EXISTS `tenant_checkout` (
  `checkout_id` int NOT NULL AUTO_INCREMENT,
  `tenant_id` int DEFAULT NULL,
  `tenant_name` varchar(100) DEFAULT NULL,
  `room_no` int DEFAULT NULL,
  `exit_date` date DEFAULT NULL,
  `refund_amount` int DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`checkout_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table: visitor
-- ----------------------------
CREATE TABLE IF NOT EXISTS `visitor` (
  `visitor_id` int NOT NULL AUTO_INCREMENT,
  `visitor_name` varchar(50) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `tenant_name` varchar(50) DEFAULT NULL,
  `room_no` int DEFAULT NULL,
  `purpose` varchar(100) DEFAULT NULL,
  `checkin_time` datetime DEFAULT NULL,
  `checkout_time` datetime DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`visitor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table: weekly_menu
-- ----------------------------
CREATE TABLE IF NOT EXISTS `weekly_menu` (
  `menu_id` int NOT NULL AUTO_INCREMENT,
  `day_name` varchar(20) DEFAULT NULL,
  `breakfast` varchar(200) DEFAULT NULL,
  `lunch` varchar(200) DEFAULT NULL,
  `snacks` varchar(200) DEFAULT NULL,
  `dinner` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- -------------------------------------------------------------
-- Additional databases & views to match hardcoded JSP/Servlet JDBC URLs
-- -------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS `pg_info_table`;
USE `pg_info_table`;
CREATE OR REPLACE VIEW `pg_info` AS SELECT * FROM `smart_pg`.`pg_info`;

CREATE DATABASE IF NOT EXISTS `tenant_table`;
USE `tenant_table`;
CREATE OR REPLACE VIEW `tenant` AS SELECT * FROM `smart_pg`.`tenant`;

-- Switch back to smart_pg
USE `smart_pg`;

