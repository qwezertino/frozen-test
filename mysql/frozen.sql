/*
 Navicat Premium Data Transfer

 Source Server         : LOCALHOST
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : frozen

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 18/03/2021 14:27:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for boosterpack
-- ----------------------------
DROP TABLE IF EXISTS `boosterpack`;
CREATE TABLE `boosterpack`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `bank` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `time_created` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `time_updated` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of boosterpack
-- ----------------------------
INSERT INTO `boosterpack` VALUES (1, 5.00, 3.00, '2020-03-30 03:17:28', '2021-03-18 14:16:16');
INSERT INTO `boosterpack` VALUES (2, 20.00, 6.00, '2020-03-30 03:17:28', '2021-03-18 13:04:05');
INSERT INTO `boosterpack` VALUES (3, 50.00, 24.00, '2020-03-30 03:17:28', '2021-03-18 14:16:19');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `assign_id` int(10) UNSIGNED NOT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time_created` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `time_updated` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, 1, 1, 'Ну чо ассигн проверим', '2020-03-27 23:39:44', '2021-03-16 09:21:51');
INSERT INTO `comment` VALUES (2, 1, 1, 'Второй коммент', '2020-03-27 23:39:55', '2021-03-16 09:21:51');
INSERT INTO `comment` VALUES (3, 2, 1, 'Второй коммент от второго человека', '2020-03-27 23:40:22', '2021-03-16 09:21:51');
INSERT INTO `comment` VALUES (4, 1, 1, 'test1243', '2021-03-18 11:17:16', '2021-03-18 11:17:16');

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `likes` int(255) NOT NULL,
  `img` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `time_created` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `time_updated` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES (1, 1, 'Тестовый постик 1', 9, '/images/posts/1.png', '2018-08-30 16:31:14', '2021-03-18 11:58:39');
INSERT INTO `post` VALUES (2, 1, 'Печальный пост', 0, '/images/posts/2.png', '2018-10-11 04:33:27', '2021-03-16 09:21:52');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `personaname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `avatarfull` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `rights` tinyint(4) NOT NULL DEFAULT 0,
  `like_balance` int(10) NOT NULL,
  `like_total_balance` int(10) NOT NULL,
  `wallet_balance` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `wallet_total_refilled` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `wallet_total_withdrawn` decimal(10, 2) NOT NULL DEFAULT 0.00,
  `time_created` datetime(0) NOT NULL,
  `time_updated` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE,
  INDEX `time_created`(`time_created`) USING BTREE,
  INDEX `time_updated`(`time_updated`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin@niceadminmail.pl', '123', 'AdminProGod', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/96/967871835afdb29f131325125d4395d55386c07a_full.jpg', 0, 90, 90, 24.00, 134.00, 110.00, '2019-07-26 01:53:54', '2021-03-18 14:16:19');
INSERT INTO `user` VALUES (2, 'simpleuser@niceadminmail.pl', NULL, 'simpleuser', 'https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/86/86a0c845038332896455a566a1f805660a13609b_full.jpg', 0, 0, 0, 0.00, 0.00, 0.00, '2019-07-26 01:53:54', '2021-03-16 09:21:52');

-- ----------------------------
-- Table structure for user_pack_log
-- ----------------------------
DROP TABLE IF EXISTS `user_pack_log`;
CREATE TABLE `user_pack_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `pack_id` int(11) NOT NULL,
  `likes` int(10) NOT NULL,
  `time_created` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_user_id`(`user_id`) USING BTREE,
  INDEX `pack_pack_id`(`pack_id`) USING BTREE,
  CONSTRAINT `pack_pack_id` FOREIGN KEY (`pack_id`) REFERENCES `boosterpack` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `user_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_pack_log
-- ----------------------------
INSERT INTO `user_pack_log` VALUES (1, 1, 3, 54, '2021-03-18 14:10:19');
INSERT INTO `user_pack_log` VALUES (2, 1, 1, 8, '2021-03-18 14:16:08');
INSERT INTO `user_pack_log` VALUES (3, 1, 1, 2, '2021-03-18 14:16:16');
INSERT INTO `user_pack_log` VALUES (4, 1, 3, 26, '2021-03-18 14:16:19');

SET FOREIGN_KEY_CHECKS = 1;
