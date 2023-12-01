/*
 Navicat Premium Data Transfer

 Source Server         : Mysql
 Source Server Type    : MySQL
 Source Server Version : 80031
 Source Host           : localhost:3306
 Source Schema         : projectt

 Target Server Type    : MySQL
 Target Server Version : 80031
 File Encoding         : 65001

 Date: 01/12/2023 11:09:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart_item
-- ----------------------------
DROP TABLE IF EXISTS `cart_item`;
CREATE TABLE `cart_item`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id`, `user_id`, `product_id`) USING BTREE,
  INDEX `fk_cart_item_product`(`product_id` ASC) USING BTREE,
  INDEX `fk_cart_item_user`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_cart_item_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_cart_item_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cart_item
-- ----------------------------
INSERT INTO `cart_item` VALUES (2, 5, 4, 3);
INSERT INTO `cart_item` VALUES (4, 5, 10, 5);
INSERT INTO `cart_item` VALUES (5, 5, 45, 1);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `pa_category` int NULL DEFAULT NULL,
  `status` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pa_category`(`pa_category` ASC) USING BTREE,
  INDEX `id`(`id` ASC) USING BTREE,
  CONSTRAINT `fk_category_category` FOREIGN KEY (`pa_category`) REFERENCES `category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 'Gỗ', NULL, 0);
INSERT INTO `category` VALUES (2, 'Gốm', NULL, 0);
INSERT INTO `category` VALUES (3, 'Tranh', NULL, 0);
INSERT INTO `category` VALUES (4, 'Mô hình', 1, 0);
INSERT INTO `category` VALUES (5, 'Gia dụng', 1, 0);
INSERT INTO `category` VALUES (6, 'Văn phòng', 1, 0);
INSERT INTO `category` VALUES (7, 'Trang sức', 1, 0);
INSERT INTO `category` VALUES (8, 'Trang trí', 1, 0);
INSERT INTO `category` VALUES (9, 'Trang trí', 2, 0);
INSERT INTO `category` VALUES (10, 'Mô hình', 2, 0);
INSERT INTO `category` VALUES (11, 'Gia dụng', 2, 0);
INSERT INTO `category` VALUES (12, 'Văn phòng', 2, 0);
INSERT INTO `category` VALUES (13, 'Trang sức', 2, 0);
INSERT INTO `category` VALUES (14, 'Sơn dầu', 3, 0);
INSERT INTO `category` VALUES (15, 'Sơn mài', 3, 0);
INSERT INTO `category` VALUES (16, 'Vải', 3, 0);

-- ----------------------------
-- Table structure for discount
-- ----------------------------
DROP TABLE IF EXISTS `discount`;
CREATE TABLE `discount`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `value` double NOT NULL,
  `condition` int NOT NULL,
  `quantity` int NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of discount
-- ----------------------------
INSERT INTO `discount` VALUES (1, 'XinChao', 100000, 100000, 50, '2023-04-04 18:08:30', '2024-01-01 18:08:38');
INSERT INTO `discount` VALUES (3, '0', 0, 0, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for discount_order
-- ----------------------------
DROP TABLE IF EXISTS `discount_order`;
CREATE TABLE `discount_order`  (
  `order_id` int NOT NULL,
  `discount_id` int NOT NULL,
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `fk_discount_order_discount`(`discount_id` ASC) USING BTREE,
  CONSTRAINT `fk_discount_order_discount` FOREIGN KEY (`discount_id`) REFERENCES `discount` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_discount_order_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of discount_order
-- ----------------------------

-- ----------------------------
-- Table structure for discount_product
-- ----------------------------
DROP TABLE IF EXISTS `discount_product`;
CREATE TABLE `discount_product`  (
  `discount_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  PRIMARY KEY (`discount_id`, `product_id`) USING BTREE,
  INDEX `fk_discount_product_product`(`product_id` ASC) USING BTREE,
  CONSTRAINT `fk_discount_product_discount` FOREIGN KEY (`discount_id`) REFERENCES `discount` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_discount_product_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of discount_product
-- ----------------------------

-- ----------------------------
-- Table structure for event
-- ----------------------------
DROP TABLE IF EXISTS `event`;
CREATE TABLE `event`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of event
-- ----------------------------

-- ----------------------------
-- Table structure for export
-- ----------------------------
DROP TABLE IF EXISTS `export`;
CREATE TABLE `export`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `total` int NOT NULL,
  `create_date` datetime NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_export_user`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_export_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of export
-- ----------------------------

-- ----------------------------
-- Table structure for export_line
-- ----------------------------
DROP TABLE IF EXISTS `export_line`;
CREATE TABLE `export_line`  (
  `export_id` int NOT NULL,
  `line_item_id` int NOT NULL,
  PRIMARY KEY (`export_id`, `line_item_id`) USING BTREE,
  INDEX `fk_export_line_line_item`(`line_item_id` ASC) USING BTREE,
  CONSTRAINT `fk_export_line_export` FOREIGN KEY (`export_id`) REFERENCES `export` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_export_line_line_item` FOREIGN KEY (`line_item_id`) REFERENCES `line_item` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of export_line
-- ----------------------------

-- ----------------------------
-- Table structure for history_price
-- ----------------------------
DROP TABLE IF EXISTS `history_price`;
CREATE TABLE `history_price`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `price` int NOT NULL,
  `price_sale` int NOT NULL,
  `product_id` int NOT NULL,
  `create_date` datetime NOT NULL,
  `status` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_history_price_product`(`product_id` ASC) USING BTREE,
  CONSTRAINT `fk_history_price_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of history_price
-- ----------------------------
INSERT INTO `history_price` VALUES (1, 563348, 704185, 1, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (2, 1241000, 1551000, 2, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (3, 725000, 0, 3, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (4, 548000, 0, 4, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (5, 2519000, 0, 5, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (6, 330000, 490000, 6, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (7, 750000, 0, 7, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (8, 1023000, 0, 8, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (9, 466000, 0, 9, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (10, 2900000, 0, 10, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (11, 536000, 595000, 11, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (12, 1270000, 0, 12, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (13, 630000, 0, 13, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (14, 664000, 0, 14, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (15, 816000, 906000, 15, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (16, 563348, 704185, 16, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (17, 2897727, 3409091, 17, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (18, 252273, 504798, 18, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (19, 1240909, 1378788, 19, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (20, 883838, 0, 20, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (21, 5353535, 0, 21, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (22, 5555556, 0, 22, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (23, 2525253, 0, 23, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (24, 1919192, 0, 24, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (25, 1919192, 0, 25, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (26, 650000, 0, 26, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (27, 644444, 805556, 27, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (28, 303951, 0, 28, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (29, 896798, 996422, 29, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (30, 666855, 740866, 30, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (31, 328283, 0, 31, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (32, 2202020, 2752525, 32, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (33, 1448276, 2413793, 33, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (34, 551747, 0, 34, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (35, 617042, 0, 35, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (36, 458404, 0, 36, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (37, 492360, 0, 37, '2022-11-26 03:00:00', 0);
INSERT INTO `history_price` VALUES (38, 492360, 0, 38, '2023-01-08 03:00:00', 0);
INSERT INTO `history_price` VALUES (39, 520000, 0, 39, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (40, 925000, 0, 40, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (41, 1300000, 0, 41, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (42, 6000000, 0, 42, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (43, 500000, 0, 43, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (44, 400000, 0, 44, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (45, 2204000, 0, 45, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (46, 2234000, 0, 46, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (47, 1700000, 0, 47, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (48, 2500000, 0, 48, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (49, 203000, 0, 49, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (50, 707000, 0, 50, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (51, 751000, 0, 51, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (52, 751000, 0, 52, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (53, 830000, 0, 53, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (54, 593000, 0, 54, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (55, 880000, 0, 55, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (56, 1000000, 0, 56, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (57, 453000, 0, 57, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (58, 1100000, 0, 58, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (59, 462000, 0, 59, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (60, 845000, 0, 60, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (61, 1340000, 0, 61, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (62, 6435000, 0, 62, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (63, 5656000, 0, 63, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (64, 6540000, 0, 64, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (65, 1434000, 0, 65, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (66, 129000, 0, 66, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (67, 903000, 0, 67, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (68, 965000, 0, 68, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (69, 903000, 0, 69, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (70, 3005000, 0, 70, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (71, 823000, 0, 71, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (72, 760000, 0, 72, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (73, 650000, 0, 73, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (74, 650000, 0, 74, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (75, 869000, 0, 75, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (76, 734000, 0, 76, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (77, 1130000, 0, 77, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (78, 1230000, 0, 78, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (79, 1155000, 0, 79, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (80, 2568000, 0, 80, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (81, 2345000, 0, 81, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (82, 2450000, 0, 82, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (83, 565000, 0, 83, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (84, 2657000, 0, 84, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (85, 435000, 0, 85, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (86, 877000, 0, 86, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (87, 659000, 0, 87, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (88, 654000, 0, 88, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (89, 945000, 0, 89, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (90, 793000, 0, 90, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (91, 894000, 0, 91, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (92, 1323000, 0, 92, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (93, 343000, 0, 93, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (94, 1236000, 0, 94, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (95, 674000, 0, 95, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (96, 324000, 0, 96, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (97, 674000, 0, 97, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (98, 324000, 0, 98, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (99, 435000, 0, 99, '2023-01-08 16:02:21', 0);
INSERT INTO `history_price` VALUES (100, 534000, 0, 100, '2023-01-08 16:02:21', 0);

-- ----------------------------
-- Table structure for image
-- ----------------------------
DROP TABLE IF EXISTS `image`;
CREATE TABLE `image`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `source` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 501 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of image
-- ----------------------------
INSERT INTO `image` VALUES (1, 'https://i.etsystatic.com/34082332/r/il/1daebc/3697370887/il_794xN.3697370887_1gqq.jpg');
INSERT INTO `image` VALUES (2, 'https://i.etsystatic.com/34082332/r/il/40eca9/3697370969/il_794xN.3697370969_s1yf.jpg');
INSERT INTO `image` VALUES (3, 'https://i.etsystatic.com/34082332/r/il/3c138f/3697371081/il_794xN.3697371081_psd3.jpg');
INSERT INTO `image` VALUES (4, 'https://i.etsystatic.com/34082332/r/il/f92d64/3697371185/il_794xN.3697371185_1znh.jpg');
INSERT INTO `image` VALUES (5, 'https://i.etsystatic.com/28326759/r/il/35b67b/2949468266/il_794xN.2949468266_kpha.jpg');
INSERT INTO `image` VALUES (6, 'https://i.etsystatic.com/28326759/r/il/42c82a/2949468682/il_794xN.2949468682_deei.jpg');
INSERT INTO `image` VALUES (7, 'https://i.etsystatic.com/28326759/r/il/510770/2997170905/il_794xN.2997170905_krpk.jpg');
INSERT INTO `image` VALUES (8, 'https://i.etsystatic.com/28326759/r/il/f48e99/2997170599/il_794xN.2997170599_grbo.jpg');
INSERT INTO `image` VALUES (9, 'https://i.etsystatic.com/26845987/r/il/f21e6e/2857907681/il_794xN.2857907681_5wpp.jpg');
INSERT INTO `image` VALUES (10, 'https://i.etsystatic.com/26845987/r/il/d2957e/2857952603/il_794xN.2857952603_ezi9.jpg');
INSERT INTO `image` VALUES (11, 'https://i.etsystatic.com/26845987/r/il/19fbed/2857907717/il_794xN.2857907717_gayh.jpg');
INSERT INTO `image` VALUES (12, 'https://i.etsystatic.com/26845987/r/il/3f591d/2810286592/il_794xN.2810286592_8nbb.jpg');
INSERT INTO `image` VALUES (13, 'https://i.etsystatic.com/23214896/r/il/eb4e9b/2384657876/il_794xN.2384657876_je98.jpg');
INSERT INTO `image` VALUES (14, 'https://i.etsystatic.com/23214896/r/il/23fba5/2432269365/il_794xN.2432269365_3bit.jpg');
INSERT INTO `image` VALUES (15, 'https://i.etsystatic.com/23214896/r/il/c0c990/2432269949/il_794xN.2432269949_gze3.jpg');
INSERT INTO `image` VALUES (16, 'https://i.etsystatic.com/23214896/r/il/904644/2384659960/il_794xN.2384659960_tdas.jpg');
INSERT INTO `image` VALUES (17, 'https://i.etsystatic.com/21252371/r/il/62708b/2086462853/il_794xN.2086462853_qu14.jpg');
INSERT INTO `image` VALUES (18, 'https://i.etsystatic.com/21252371/r/il/bd25d2/2038850806/il_794xN.2038850806_h083.jpg');
INSERT INTO `image` VALUES (19, 'https://i.etsystatic.com/21252371/r/il/bd25d2/2038850806/il_794xN.2038850806_h083.jpg');
INSERT INTO `image` VALUES (20, 'https://i.etsystatic.com/21252371/r/il/9b3682/2038852378/il_794xN.2038852378_mk9a.jpg');
INSERT INTO `image` VALUES (21, 'https://i.etsystatic.com/18808630/r/il/331264/3862763678/il_794xN.3862763678_oqlt.jpg');
INSERT INTO `image` VALUES (22, 'https://i.etsystatic.com/18808630/r/il/53972b/3812956630/il_794xN.3812956630_2gct.jpg');
INSERT INTO `image` VALUES (23, 'https://i.etsystatic.com/18808630/r/il/bd4fca/3812956628/il_794xN.3812956628_lgzv.jpg');
INSERT INTO `image` VALUES (24, 'https://i.etsystatic.com/18808630/r/il/dc2092/4424820403/il_794xN.4424820403_9b6v.jpg');
INSERT INTO `image` VALUES (25, 'https://i.etsystatic.com/21232771/r/il/bd2947/2841761411/il_794xN.2841761411_ci6x.jpg');
INSERT INTO `image` VALUES (26, 'https://i.etsystatic.com/21232771/r/il/c6febf/2841744015/il_794xN.2841744015_o5li.jpg');
INSERT INTO `image` VALUES (27, 'https://i.etsystatic.com/21232771/r/il/a3162a/2841763443/il_794xN.2841763443_omoa.jpg');
INSERT INTO `image` VALUES (28, 'https://i.etsystatic.com/21232771/r/il/739f35/2535772368/il_794xN.2535772368_nu4b.jpg');
INSERT INTO `image` VALUES (29, 'https://i.etsystatic.com/19076644/r/il/c89987/3915192477/il_794xN.3915192477_jfjd.jpg');
INSERT INTO `image` VALUES (30, 'https://i.etsystatic.com/19076644/r/il/e3fbbe/2643678393/il_794xN.2643678393_6t6t.jpg');
INSERT INTO `image` VALUES (31, 'https://i.etsystatic.com/19076644/r/il/933366/2643678425/il_794xN.2643678425_s7bx.jpg');
INSERT INTO `image` VALUES (32, 'https://i.etsystatic.com/19076644/r/il/aa5dc0/2596004520/il_794xN.2596004520_oj0m.jpg');
INSERT INTO `image` VALUES (33, 'https://i.etsystatic.com/28083097/r/il/eda35b/3478699330/il_794xN.3478699330_pcmo.jpg');
INSERT INTO `image` VALUES (34, 'https://i.etsystatic.com/28083097/r/il/6c4fd5/3526347481/il_794xN.3526347481_pe6z.jpg');
INSERT INTO `image` VALUES (35, 'https://i.etsystatic.com/28083097/r/il/e1be22/3478675386/il_794xN.3478675386_g3io.jpg');
INSERT INTO `image` VALUES (36, 'https://i.etsystatic.com/28083097/r/il/4d0be8/3478700194/il_794xN.3478700194_lwhz.jpg');
INSERT INTO `image` VALUES (37, 'https://i.etsystatic.com/15079459/r/il/38450a/3973525957/il_794xN.3973525957_8bvk.jpg');
INSERT INTO `image` VALUES (38, 'https://i.etsystatic.com/15079459/r/il/251071/3926052242/il_794xN.3926052242_ml5g.jpg');
INSERT INTO `image` VALUES (39, 'https://i.etsystatic.com/15079459/r/il/17eb71/3926052240/il_794xN.3926052240_kxy2.jpg');
INSERT INTO `image` VALUES (40, 'https://i.etsystatic.com/15079459/r/il/617f68/3973512287/il_794xN.3973512287_rkp0.jpg');
INSERT INTO `image` VALUES (41, 'https://i.etsystatic.com/28475776/r/il/458db8/3242190537/il_794xN.3242190537_j8oa.jpg');
INSERT INTO `image` VALUES (42, 'https://i.etsystatic.com/28475776/r/il/411c78/3242190441/il_794xN.3242190441_bfqi.jpg');
INSERT INTO `image` VALUES (43, 'https://i.etsystatic.com/28475776/r/il/5a2837/3194492190/il_794xN.3194492190_rdn9.jpg');
INSERT INTO `image` VALUES (44, 'https://i.etsystatic.com/28475776/r/il/9b78e1/3242190489/il_794xN.3242190489_swiu.jpg');
INSERT INTO `image` VALUES (45, 'https://i.etsystatic.com/27431999/r/il/a94e41/4160019288/il_794xN.4160019288_3gtt.jpg');
INSERT INTO `image` VALUES (46, 'https://i.etsystatic.com/27431999/r/il/8ee0bc/4207673907/il_794xN.4207673907_5ejq.jpg');
INSERT INTO `image` VALUES (47, 'https://i.etsystatic.com/27431999/r/il/250a48/4160019312/il_794xN.4160019312_1v2r.jpg');
INSERT INTO `image` VALUES (48, 'https://i.etsystatic.com/27431999/r/il/ec35d5/4207680673/il_794xN.4207680673_9ong.jpg');
INSERT INTO `image` VALUES (49, 'https://i.etsystatic.com/5407182/r/il/44c561/2534365288/il_794xN.2534365288_lgku.jpg');
INSERT INTO `image` VALUES (50, 'https://i.etsystatic.com/5407182/r/il/51718b/2144048444/il_794xN.2144048444_hq8k.jpg');
INSERT INTO `image` VALUES (51, 'https://i.etsystatic.com/5407182/r/il/f0e121/2582016289/il_794xN.2582016289_3a0r.jpg');
INSERT INTO `image` VALUES (52, 'https://i.etsystatic.com/5407182/r/il/bebd07/2534366726/il_794xN.2534366726_mqgb.jpg');
INSERT INTO `image` VALUES (53, 'https://i.etsystatic.com/36832986/r/il/15ce83/4175328297/il_794xN.4175328297_m31a.jpg');
INSERT INTO `image` VALUES (54, 'https://i.etsystatic.com/36832986/r/il/306290/4175328227/il_794xN.4175328227_37fu.jpg');
INSERT INTO `image` VALUES (55, 'https://i.etsystatic.com/36832986/r/il/cf831e/4127665588/il_794xN.4127665588_j17v.jpg');
INSERT INTO `image` VALUES (56, 'https://i.etsystatic.com/36832986/r/il/7993fa/4127665626/il_794xN.4127665626_pdaj.jpg');
INSERT INTO `image` VALUES (57, 'https://i.etsystatic.com/26186931/r/il/2f47c6/3224650156/il_794xN.3224650156_gzj8.jpg');
INSERT INTO `image` VALUES (58, 'https://i.etsystatic.com/26186931/r/il/fbbb77/3272332049/il_794xN.3272332049_ewcw.jpg');
INSERT INTO `image` VALUES (59, 'https://i.etsystatic.com/26186931/r/il/cb6ce0/3224650300/il_794xN.3224650300_2ss8.jpg');
INSERT INTO `image` VALUES (60, 'https://i.etsystatic.com/26186931/r/il/c09ead/3224650158/il_794xN.3224650158_mvwz.jpg');
INSERT INTO `image` VALUES (61, 'https://i.etsystatic.com/17142610/r/il/d31c25/1985560571/il_794xN.1985560571_smfa.jpg');
INSERT INTO `image` VALUES (62, 'https://i.etsystatic.com/17142610/r/il/613332/1938023514/il_794xN.1938023514_da3k.jpg');
INSERT INTO `image` VALUES (63, 'https://i.etsystatic.com/17142610/r/il/45766a/1917335974/il_794xN.1917335974_i1of.jpg');
INSERT INTO `image` VALUES (64, 'https://i.etsystatic.com/17142610/r/il/79bffd/1917336068/il_794xN.1917336068_lp8t.jpg');
INSERT INTO `image` VALUES (65, 'https://i.etsystatic.com/34419527/r/il/8c448e/3842629194/il_794xN.3842629194_1e80.jpg');
INSERT INTO `image` VALUES (66, 'https://i.etsystatic.com/34419527/r/il/f9a6d8/3842629232/il_794xN.3842629232_7dhy.jpg');
INSERT INTO `image` VALUES (67, 'https://i.etsystatic.com/34419527/r/il/24a940/3890127851/il_794xN.3890127851_bnq9.jpg');
INSERT INTO `image` VALUES (68, 'https://i.etsystatic.com/34419527/r/il/aa60d6/3842629230/il_794xN.3842629230_18c3.jpg');
INSERT INTO `image` VALUES (69, 'https://i.etsystatic.com/11544714/r/il/d6fc81/2495023096/il_794xN.2495023096_2irx.jpg');
INSERT INTO `image` VALUES (70, 'https://i.etsystatic.com/11544714/r/il/3e7d77/1995413786/il_794xN.1995413786_th4h.jpg');
INSERT INTO `image` VALUES (71, 'https://i.etsystatic.com/11544714/r/il/fbcb1d/2042979487/il_794xN.2042979487_t5zj.jpg');
INSERT INTO `image` VALUES (72, 'https://i.etsystatic.com/11544714/r/il/9c02f8/1995415136/il_794xN.1995415136_7zig.jpg');
INSERT INTO `image` VALUES (73, 'https://i.etsystatic.com/26821883/r/il/a0faef/2804326619/il_794xN.2804326619_tndb.jpg');
INSERT INTO `image` VALUES (74, 'https://i.etsystatic.com/26821883/r/il/f3317f/2804326565/il_794xN.2804326565_bsub.jpg');
INSERT INTO `image` VALUES (75, 'https://i.etsystatic.com/26821883/r/il/17fb97/2756643758/il_794xN.2756643758_jldl.jpg');
INSERT INTO `image` VALUES (76, 'https://i.etsystatic.com/26821883/r/il/1a0470/2756643648/il_794xN.2756643648_egjb.jpg');
INSERT INTO `image` VALUES (77, 'https://i.etsystatic.com/32760853/r/il/7856d0/3499631784/il_794xN.3499631784_dkzd.jpg');
INSERT INTO `image` VALUES (78, 'https://i.etsystatic.com/32760853/r/il/a9fae2/3548784906/il_794xN.3548784906_nzvc.jpg');
INSERT INTO `image` VALUES (79, 'https://i.etsystatic.com/32760853/r/il/435644/3596420217/il_794xN.3596420217_k2f9.jpg');
INSERT INTO `image` VALUES (80, 'https://i.etsystatic.com/32760853/r/il/d16890/3596420463/il_794xN.3596420463_bxc9.jpg');
INSERT INTO `image` VALUES (81, 'https://i.etsystatic.com/25577822/r/il/4f09cc/2744292627/il_794xN.2744292627_hcxn.jpg');
INSERT INTO `image` VALUES (82, 'https://i.etsystatic.com/25577822/r/il/b1ef44/2693666752/il_794xN.2693666752_o4vj.jpg');
INSERT INTO `image` VALUES (83, 'https://i.etsystatic.com/25577822/r/il/a7e189/2741352473/il_794xN.2741352473_iepy.jpg');
INSERT INTO `image` VALUES (84, 'https://i.etsystatic.com/25577822/r/il/ddfac2/2741354653/il_794xN.2741354653_prkp.jpg');
INSERT INTO `image` VALUES (85, 'https://i.etsystatic.com/25577822/r/il/056981/3572451243/il_794xN.3572451243_emv0.jpg');
INSERT INTO `image` VALUES (86, 'https://i.etsystatic.com/25577822/r/il/f87bbe/3571106219/il_794xN.3571106219_bwlk.jpg');
INSERT INTO `image` VALUES (87, 'https://i.etsystatic.com/25577822/r/il/db98b7/3523471070/il_794xN.3523471070_aeop.jpg');
INSERT INTO `image` VALUES (88, 'https://i.etsystatic.com/25577822/r/il/9cc5c1/3571147007/il_794xN.3571147007_pbuq.jpg');
INSERT INTO `image` VALUES (89, 'https://i.etsystatic.com/28925255/r/il/2c3af2/3533942998/il_794xN.3533942998_fnxb.jpg');
INSERT INTO `image` VALUES (90, 'https://i.etsystatic.com/28925255/r/il/6d63fd/3533942428/il_794xN.3533942428_9sgm.jpg');
INSERT INTO `image` VALUES (91, 'https://i.etsystatic.com/28925255/r/il/cbae8a/3581584209/il_794xN.3581584209_mncy.jpg');
INSERT INTO `image` VALUES (92, 'https://i.etsystatic.com/28925255/r/il/df98e1/3533942484/il_794xN.3533942484_gsxf.jpg');
INSERT INTO `image` VALUES (93, 'https://i.etsystatic.com/28925255/r/il/0aee4c/3461544619/il_794xN.3461544619_ftrj.jpg');
INSERT INTO `image` VALUES (94, 'https://i.etsystatic.com/28925255/r/il/4e5843/3413871996/il_794xN.3413871996_rgfy.jpg');
INSERT INTO `image` VALUES (95, 'https://i.etsystatic.com/28925255/r/il/d0d4e1/3413872128/il_794xN.3413872128_1zs2.jpg');
INSERT INTO `image` VALUES (96, 'https://i.etsystatic.com/28925255/r/il/fb2c67/3413872004/il_794xN.3413872004_rqd3.jpg');
INSERT INTO `image` VALUES (97, 'https://i.etsystatic.com/28925255/r/il/7ce1b8/3461385423/il_794xN.3461385423_478w.jpg');
INSERT INTO `image` VALUES (98, 'https://i.etsystatic.com/28925255/r/il/ce6ea8/3413715588/il_794xN.3413715588_f351.jpg');
INSERT INTO `image` VALUES (99, 'https://i.etsystatic.com/28925255/r/il/1b35fc/3461387863/il_794xN.3461387863_3igy.jpg');
INSERT INTO `image` VALUES (100, 'https://i.etsystatic.com/28925255/r/il/58513d/3413715560/il_794xN.3413715560_kmgz.jpg');
INSERT INTO `image` VALUES (101, 'https://i.etsystatic.com/27692523/r/il/bb6617/3326750421/il_794xN.3326750421_g49q.jpg');
INSERT INTO `image` VALUES (102, 'https://i.etsystatic.com/27692523/r/il/0e6af4/3279063922/il_794xN.3279063922_ihno.jpg');
INSERT INTO `image` VALUES (103, 'https://i.etsystatic.com/27692523/r/il/71a170/3171408842/il_794xN.3171408842_nwcw.jpg');
INSERT INTO `image` VALUES (104, 'https://i.etsystatic.com/27692523/r/il/686714/3219111331/il_794xN.3219111331_end9.jpg');
INSERT INTO `image` VALUES (105, 'https://i.etsystatic.com/11226095/r/il/96894d/3004768032/il_794xN.3004768032_bg4z.jpg');
INSERT INTO `image` VALUES (106, 'https://i.etsystatic.com/11226095/r/il/7c02de/3052481435/il_794xN.3052481435_9nv5.jpg');
INSERT INTO `image` VALUES (107, 'https://i.etsystatic.com/11226095/r/il/258883/3052476377/il_794xN.3052476377_1wkc.jpg');
INSERT INTO `image` VALUES (108, 'https://i.etsystatic.com/11226095/r/il/7ac250/3004763540/il_794xN.3004763540_b3fs.jpg');
INSERT INTO `image` VALUES (109, 'https://i.etsystatic.com/9577345/r/il/16dd8c/2647917274/il_794xN.2647917274_dq85.jpg');
INSERT INTO `image` VALUES (110, 'https://i.etsystatic.com/9577345/r/il/a5c841/2647914396/il_794xN.2647914396_lv1f.jpg');
INSERT INTO `image` VALUES (111, 'https://i.etsystatic.com/9577345/r/il/42f0d5/2695633501/il_794xN.2695633501_igxm.jpg');
INSERT INTO `image` VALUES (112, 'https://i.etsystatic.com/9577345/r/il/5226be/2391165200/il_794xN.2391165200_sd0h.jpg');
INSERT INTO `image` VALUES (113, 'https://i.etsystatic.com/21044348/r/il/497f96/2590995221/il_794xN.2590995221_mbf6.jpg');
INSERT INTO `image` VALUES (114, 'https://i.etsystatic.com/21044348/r/il/10aa34/2590995189/il_794xN.2590995189_7prr.jpg');
INSERT INTO `image` VALUES (115, 'https://i.etsystatic.com/21044348/r/il/786d4d/2543351102/il_794xN.2543351102_nryu.jpg');
INSERT INTO `image` VALUES (116, 'https://i.etsystatic.com/21044348/r/il/2b37fc/2543351288/il_794xN.2543351288_1wwa.jpg');
INSERT INTO `image` VALUES (117, 'https://i.etsystatic.com/21044348/r/il/a580d0/2224060728/il_794xN.2224060728_78zf.jpg');
INSERT INTO `image` VALUES (118, 'https://i.etsystatic.com/21044348/r/il/d9e9f6/2271651371/il_794xN.2271651371_hu68.jpg');
INSERT INTO `image` VALUES (119, 'https://i.etsystatic.com/21044348/r/il/008d3a/2224060698/il_794xN.2224060698_aheu.jpg');
INSERT INTO `image` VALUES (120, 'https://i.etsystatic.com/21044348/r/il/a51924/2271651379/il_794xN.2271651379_2ueu.jpg');
INSERT INTO `image` VALUES (121, 'https://i.etsystatic.com/28541017/r/il/ec48ab/3747993878/il_794xN.3747993878_hh1h.jpg');
INSERT INTO `image` VALUES (122, 'https://i.etsystatic.com/28541017/r/il/96621c/3795588115/il_794xN.3795588115_kf9t.jpg');
INSERT INTO `image` VALUES (123, 'https://i.etsystatic.com/28541017/r/il/2e498e/3795588109/il_794xN.3795588109_l7oh.jpg');
INSERT INTO `image` VALUES (124, 'https://i.etsystatic.com/28541017/r/il/34d88a/3795588125/il_794xN.3795588125_rlqd.jpg');
INSERT INTO `image` VALUES (125, 'https://i.etsystatic.com/22591325/r/il/8248b3/3645769034/il_794xN.3645769034_jfxi.jpg');
INSERT INTO `image` VALUES (126, 'https://i.etsystatic.com/22591325/r/il/5b8eca/3645769020/il_794xN.3645769020_lrwj.jpg');
INSERT INTO `image` VALUES (127, 'https://i.etsystatic.com/22591325/r/il/b7f574/3645768712/il_794xN.3645768712_bd9i.jpg');
INSERT INTO `image` VALUES (128, 'https://i.etsystatic.com/22591325/r/il/d25fd3/3693380625/il_794xN.3693380625_gx78.jpg');
INSERT INTO `image` VALUES (129, 'https://i.etsystatic.com/20416287/r/il/7a4e1e/3044969319/il_794xN.3044969319_clmy.jpg');
INSERT INTO `image` VALUES (130, 'https://i.etsystatic.com/20416287/r/il/5dfc93/2997273654/il_794xN.2997273654_dm6r.jpg');
INSERT INTO `image` VALUES (131, 'https://i.etsystatic.com/20416287/r/il/d94ffc/2142193636/il_794xN.2142193636_blx1.jpg');
INSERT INTO `image` VALUES (132, 'https://i.etsystatic.com/20416287/r/il/1a68a6/2344876119/il_794xN.2344876119_dfa2.jpg');
INSERT INTO `image` VALUES (133, 'https://i.etsystatic.com/37014879/r/il/6027d5/4107843632/il_794xN.4107843632_tab7.jpg');
INSERT INTO `image` VALUES (134, 'https://i.etsystatic.com/37014879/r/il/701bcb/4107843810/il_794xN.4107843810_crm5.jpg');
INSERT INTO `image` VALUES (135, 'https://i.etsystatic.com/37014879/r/il/9e2903/4155499353/il_794xN.4155499353_n0rw.jpg');
INSERT INTO `image` VALUES (136, 'https://i.etsystatic.com/37014879/r/il/03768d/4107843780/il_794xN.4107843780_g28c.jpg');
INSERT INTO `image` VALUES (137, 'https://i.etsystatic.com/37014879/r/il/f0b2ac/4155588121/il_794xN.4155588121_36id.jpg');
INSERT INTO `image` VALUES (138, 'https://i.etsystatic.com/37014879/r/il/455e67/4155588083/il_794xN.4155588083_b2zm.jpg');
INSERT INTO `image` VALUES (139, 'https://i.etsystatic.com/37014879/r/il/dee84d/4107933114/il_794xN.4107933114_c9c0.jpg');
INSERT INTO `image` VALUES (140, 'https://i.etsystatic.com/37014879/r/il/630f44/4155588065/il_794xN.4155588065_nr0d.jpg');
INSERT INTO `image` VALUES (141, 'https://i.etsystatic.com/31698325/r/il/9116dc/3592716072/il_794xN.3592716072_oot7.jpg');
INSERT INTO `image` VALUES (142, 'https://i.etsystatic.com/31698325/r/il/765a3d/3640332457/il_794xN.3640332457_1d6e.jpg');
INSERT INTO `image` VALUES (143, 'https://i.etsystatic.com/31698325/r/il/18ffa6/3640332469/il_794xN.3640332469_8lo1.jpg');
INSERT INTO `image` VALUES (144, 'https://i.etsystatic.com/31698325/r/il/0e75df/3592715862/il_794xN.3592715862_jwfo.jpg');
INSERT INTO `image` VALUES (145, 'https://i.etsystatic.com/31698325/r/il/d67d6a/3541856723/il_794xN.3541856723_g8z0.jpg');
INSERT INTO `image` VALUES (146, 'https://i.etsystatic.com/31698325/r/il/8abe6a/3541856741/il_794xN.3541856741_3ww2.jpg');
INSERT INTO `image` VALUES (147, 'https://i.etsystatic.com/31698325/r/il/fda492/3494214148/il_794xN.3494214148_51ja.jpg');
INSERT INTO `image` VALUES (148, 'https://i.etsystatic.com/31698325/r/il/b25c90/3494214638/il_794xN.3494214638_mkr8.jpg');
INSERT INTO `image` VALUES (149, 'https://i.etsystatic.com/31698325/r/il/6adb6b/4045780302/il_794xN.4045780302_quha.jpg');
INSERT INTO `image` VALUES (150, 'https://i.etsystatic.com/31698325/r/il/d0c950/4045780268/il_794xN.4045780268_b2fu.jpg');
INSERT INTO `image` VALUES (151, 'https://i.etsystatic.com/31698325/r/il/cfbe07/4045780320/il_794xN.4045780320_nb10.jpg');
INSERT INTO `image` VALUES (152, 'https://i.etsystatic.com/31698325/r/il/e17d38/4045780276/il_794xN.4045780276_2acu.jpg');
INSERT INTO `image` VALUES (153, 'https://i.etsystatic.com/37014879/r/il/4e22bd/4155416891/il_794xN.4155416891_5lij.jpg');
INSERT INTO `image` VALUES (154, 'https://i.etsystatic.com/37014879/r/il/7e64e0/4155416571/il_794xN.4155416571_4n79.jpg');
INSERT INTO `image` VALUES (155, 'https://i.etsystatic.com/37014879/r/il/579802/4155416851/il_794xN.4155416851_9779.jpg');
INSERT INTO `image` VALUES (156, 'https://i.etsystatic.com/37014879/r/il/2eb5db/4107761116/il_794xN.4107761116_2l1q.jpg');
INSERT INTO `image` VALUES (157, 'https://i.etsystatic.com/33728464/r/il/f22d33/3958214899/il_794xN.3958214899_tv4i.jpg');
INSERT INTO `image` VALUES (158, 'https://i.etsystatic.com/33728464/r/il/51c168/3958223219/il_794xN.3958223219_o56n.jpg');
INSERT INTO `image` VALUES (159, 'https://i.etsystatic.com/33728464/r/il/cbffa7/3958213235/il_794xN.3958213235_gp00.jpg');
INSERT INTO `image` VALUES (160, 'https://i.etsystatic.com/33728464/r/il/90ed78/3910714646/il_794xN.3910714646_jp55.jpg');
INSERT INTO `image` VALUES (161, 'https://i.etsystatic.com/33728464/r/il/a719e9/3838326056/il_794xN.3838326056_qi8h.jpg');
INSERT INTO `image` VALUES (162, 'https://i.etsystatic.com/33728464/r/il/abc61e/3885819329/il_794xN.3885819329_iko0.jpg');
INSERT INTO `image` VALUES (163, 'https://i.etsystatic.com/33728464/r/il/b6315c/3885818179/il_794xN.3885818179_6lg0.jpg');
INSERT INTO `image` VALUES (164, 'https://i.etsystatic.com/33728464/r/il/cb4e4d/3838321304/il_794xN.3838321304_5bwl.jpg');
INSERT INTO `image` VALUES (165, 'https://i.etsystatic.com/7418174/r/il/ef737c/4166990422/il_794xN.4166990422_ifki.jpg');
INSERT INTO `image` VALUES (166, 'https://i.etsystatic.com/7418174/r/il/830f8e/4166990974/il_794xN.4166990974_53w3.jpg');
INSERT INTO `image` VALUES (167, 'https://i.etsystatic.com/7418174/r/il/386c89/4214653957/il_794xN.4214653957_ezsl.jpg');
INSERT INTO `image` VALUES (168, 'https://i.etsystatic.com/7418174/r/il/e87674/4166999270/il_794xN.4166999270_pys2.jpg');
INSERT INTO `image` VALUES (169, 'https://i.etsystatic.com/12529135/r/il/6ec023/2384904726/il_794xN.2384904726_464r.jpg');
INSERT INTO `image` VALUES (170, 'https://i.etsystatic.com/12529135/r/il/0a1a0c/2432516875/il_794xN.2432516875_q2p0.jpg');
INSERT INTO `image` VALUES (171, 'https://i.etsystatic.com/12529135/r/il/e9e975/2384904606/il_794xN.2384904606_jys3.jpg');
INSERT INTO `image` VALUES (172, 'https://i.etsystatic.com/12529135/r/il/9d8f79/2374911303/il_794xN.2374911303_6fca.jpg');
INSERT INTO `image` VALUES (173, 'https://i.etsystatic.com/12529135/r/il/4f3583/2766725495/il_794xN.2766725495_gkfj.jpg');
INSERT INTO `image` VALUES (174, 'https://i.etsystatic.com/12529135/r/il/6fc478/2348963478/il_794xN.2348963478_berx.jpg');
INSERT INTO `image` VALUES (175, 'https://i.etsystatic.com/12529135/r/il/37c69f/2396554381/il_794xN.2396554381_aptn.jpg');
INSERT INTO `image` VALUES (176, 'https://i.etsystatic.com/12529135/r/il/209b31/3660697191/il_794xN.3660697191_nz7r.jpg');
INSERT INTO `image` VALUES (177, 'https://i.etsystatic.com/26116447/r/il/a9fd5a/3450301137/il_794xN.3450301137_96zb.jpg');
INSERT INTO `image` VALUES (178, 'https://i.etsystatic.com/26116447/r/il/774097/3402636148/il_794xN.3402636148_c86f.jpg');
INSERT INTO `image` VALUES (179, 'https://i.etsystatic.com/26116447/r/il/bf351d/3450301257/il_794xN.3450301257_l4fv.jpg');
INSERT INTO `image` VALUES (180, 'https://i.etsystatic.com/26116447/r/il/6cd923/3402629542/il_794xN.3402629542_8njt.jpg');
INSERT INTO `image` VALUES (181, 'https://i.etsystatic.com/26116447/r/il/838a56/3578187313/il_794xN.3578187313_7obj.jpg');
INSERT INTO `image` VALUES (182, 'https://i.etsystatic.com/26116447/r/il/fa3aee/3530547152/il_794xN.3530547152_t0eh.jpg');
INSERT INTO `image` VALUES (183, 'https://i.etsystatic.com/26116447/r/il/8d3389/3530547366/il_794xN.3530547366_kjwu.jpg');
INSERT INTO `image` VALUES (184, 'https://i.etsystatic.com/26116447/r/il/793703/3530547116/il_794xN.3530547116_czzi.jpg');
INSERT INTO `image` VALUES (185, 'https://i.etsystatic.com/26116447/r/il/bd9490/3424187783/il_794xN.3424187783_3b0e.jpg');
INSERT INTO `image` VALUES (186, 'https://i.etsystatic.com/26116447/r/il/f1e32d/3424187951/il_794xN.3424187951_c8q0.jpg');
INSERT INTO `image` VALUES (187, 'https://i.etsystatic.com/26116447/r/il/a65971/3424188911/il_794xN.3424188911_41to.jpg');
INSERT INTO `image` VALUES (188, 'https://i.etsystatic.com/26116447/r/il/a0f0f5/3471683215/il_794xN.3471683215_22uz.jpg');
INSERT INTO `image` VALUES (189, 'https://i.etsystatic.com/26116447/r/il/512e02/3425199407/il_794xN.3425199407_iglw.jpg');
INSERT INTO `image` VALUES (190, 'https://i.etsystatic.com/26116447/r/il/1c9b87/3377523032/il_794xN.3377523032_1jzu.jpg');
INSERT INTO `image` VALUES (191, 'https://i.etsystatic.com/26116447/r/il/586b9b/3425198229/il_794xN.3425198229_rvrq.jpg');
INSERT INTO `image` VALUES (192, 'https://i.etsystatic.com/26116447/r/il/dc01a9/3402154036/il_794xN.3402154036_nlch.jpg');
INSERT INTO `image` VALUES (193, 'https://i.etsystatic.com/21139059/r/il/dcac7f/3348402484/il_794xN.3348402484_3v55.jpg');
INSERT INTO `image` VALUES (194, 'https://i.etsystatic.com/21139059/r/il/c70c18/4295581055/il_794xN.4295581055_bljd.jpg');
INSERT INTO `image` VALUES (195, 'https://i.etsystatic.com/21139059/r/il/e76f1f/4295582747/il_794xN.4295582747_ixte.jpg');
INSERT INTO `image` VALUES (196, 'https://i.etsystatic.com/21139059/r/il/c47051/4295569151/il_794xN.4295569151_qvwy.jpg');
INSERT INTO `image` VALUES (197, 'https://i.etsystatic.com/21232771/r/il/8049b3/3620088885/il_794xN.3620088885_qi6c.jpg');
INSERT INTO `image` VALUES (198, 'https://i.etsystatic.com/21232771/r/il/897ea3/3401311790/il_794xN.3401311790_3vox.jpg');
INSERT INTO `image` VALUES (199, 'https://i.etsystatic.com/21232771/r/il/f653bb/3448981389/il_794xN.3448981389_26hx.jpg');
INSERT INTO `image` VALUES (200, 'https://i.etsystatic.com/21232771/r/il/d37e6a/3448981489/il_794xN.3448981489_d81g.jpg');
INSERT INTO `image` VALUES (201, 'https://i.etsystatic.com/34691885/r/il/d82f2a/3906508375/il_794xN.3906508375_m7bp.jpg');
INSERT INTO `image` VALUES (202, 'https://i.etsystatic.com/34691885/r/il/99e340/3906508373/il_794xN.3906508373_o9s6.jpg');
INSERT INTO `image` VALUES (203, 'https://i.etsystatic.com/34691885/r/il/aab751/3859009432/il_794xN.3859009432_p03s.jpg');
INSERT INTO `image` VALUES (204, 'https://i.etsystatic.com/34691885/r/il/7a98e1/3859009446/il_794xN.3859009446_j7ow.jpg');
INSERT INTO `image` VALUES (205, 'https://i.etsystatic.com/26055747/r/il/83b89b/4338090977/il_794xN.4338090977_bxw6.jpg');
INSERT INTO `image` VALUES (206, 'https://i.etsystatic.com/26055747/r/il/d3c119/4290702736/il_794xN.4290702736_im6v.jpg');
INSERT INTO `image` VALUES (207, 'https://i.etsystatic.com/26055747/r/il/512aef/4338090995/il_794xN.4338090995_1c6m.jpg');
INSERT INTO `image` VALUES (208, 'https://i.etsystatic.com/26055747/r/il/a2c2cb/4290702778/il_794xN.4290702778_esrc.jpg');
INSERT INTO `image` VALUES (209, 'https://i.etsystatic.com/28648375/r/il/3720d8/4290906770/il_794xN.4290906770_i23o.jpg');
INSERT INTO `image` VALUES (210, 'https://i.etsystatic.com/28648375/r/il/041959/4290906752/il_794xN.4290906752_l3ri.jpg');
INSERT INTO `image` VALUES (211, 'https://i.etsystatic.com/28648375/r/il/94c67e/4290906760/il_794xN.4290906760_fco9.jpg');
INSERT INTO `image` VALUES (212, 'https://i.etsystatic.com/28648375/r/il/79bdab/4290906774/il_794xN.4290906774_ssky.jpg');
INSERT INTO `image` VALUES (213, 'https://i.etsystatic.com/26055747/r/il/8139f4/4068649200/il_794xN.4068649200_ji3i.jpg');
INSERT INTO `image` VALUES (214, 'https://i.etsystatic.com/26055747/r/il/3908ca/4068649210/il_794xN.4068649210_i6xv.jpg');
INSERT INTO `image` VALUES (215, 'https://i.etsystatic.com/26055747/r/il/6a30e6/3939226102/il_794xN.3939226102_55lc.jpg');
INSERT INTO `image` VALUES (216, 'https://i.etsystatic.com/26055747/r/il/a0aca9/4068649316/il_794xN.4068649316_c27h.jpg');
INSERT INTO `image` VALUES (217, 'https://i.etsystatic.com/23708165/r/il/8d95ff/3488649157/il_794xN.3488649157_8ogh.jpg');
INSERT INTO `image` VALUES (218, 'https://i.etsystatic.com/23708165/r/il/f4ebf5/3089123360/il_794xN.3089123360_2od5.jpg');
INSERT INTO `image` VALUES (219, 'https://i.etsystatic.com/23708165/r/il/d5752b/3076223839/il_794xN.3076223839_f1km.jpg');
INSERT INTO `image` VALUES (220, 'https://i.etsystatic.com/23708165/r/il/4c6da8/3028514298/il_794xN.3028514298_hul3.jpg');
INSERT INTO `image` VALUES (221, 'https://i.etsystatic.com/23708165/r/il/53d9f8/3117508428/il_794xN.3117508428_ejhq.jpg');
INSERT INTO `image` VALUES (222, 'https://i.etsystatic.com/23708165/r/il/8d5055/3165227985/il_794xN.3165227985_bv3y.jpg');
INSERT INTO `image` VALUES (223, 'https://i.etsystatic.com/23708165/r/il/67cb9e/3117509626/il_794xN.3117509626_5k3n.jpg');
INSERT INTO `image` VALUES (224, 'https://i.etsystatic.com/23708165/r/il/86dbc1/3165227939/il_794xN.3165227939_cihe.jpg');
INSERT INTO `image` VALUES (225, 'https://i.etsystatic.com/34691885/r/il/cb5f30/4084245731/il_794xN.4084245731_2fzu.jpg');
INSERT INTO `image` VALUES (226, 'https://i.etsystatic.com/34691885/r/il/652d89/4237522926/il_794xN.4237522926_nqtn.jpg');
INSERT INTO `image` VALUES (227, 'https://i.etsystatic.com/34691885/r/il/89200c/4285174179/il_794xN.4285174179_hd1q.jpg');
INSERT INTO `image` VALUES (228, 'https://i.etsystatic.com/34691885/r/il/401421/4036598324/il_794xN.4036598324_k5uf.jpg');
INSERT INTO `image` VALUES (229, 'https://i.etsystatic.com/34691885/r/il/98aa37/4400484343/il_794xN.4400484343_prl6.jpg');
INSERT INTO `image` VALUES (230, 'https://i.etsystatic.com/34691885/r/il/781e09/4400484845/il_794xN.4400484845_7xi4.jpg');
INSERT INTO `image` VALUES (231, 'https://i.etsystatic.com/34691885/r/il/9dd4e5/4400486315/il_794xN.4400486315_iyg9.jpg');
INSERT INTO `image` VALUES (232, 'https://i.etsystatic.com/34691885/r/il/ad16e2/4353095286/il_794xN.4353095286_6rmo.jpg');
INSERT INTO `image` VALUES (233, 'https://i.etsystatic.com/13285848/r/il/3e0ed5/2611132888/il_794xN.2611132888_7rvn.jpg');
INSERT INTO `image` VALUES (234, 'https://i.etsystatic.com/13285848/r/il/4905ed/2658793291/il_794xN.2658793291_dils.jpg');
INSERT INTO `image` VALUES (235, 'https://i.etsystatic.com/13285848/r/il/303e91/2611134712/il_794xN.2611134712_75cw.jpg');
INSERT INTO `image` VALUES (236, 'https://i.etsystatic.com/13285848/r/il/c6f09a/2658794983/il_794xN.2658794983_759y.jpg');
INSERT INTO `image` VALUES (237, 'https://i.etsystatic.com/15397008/r/il/0d68b3/2102683640/il_794xN.2102683640_i373.jpg');
INSERT INTO `image` VALUES (238, 'https://i.etsystatic.com/15397008/r/il/00123b/2663820263/il_794xN.2663820263_fnum.jpg');
INSERT INTO `image` VALUES (239, 'https://i.etsystatic.com/15397008/r/il/314894/2091725820/il_794xN.2091725820_4x3x.jpg');
INSERT INTO `image` VALUES (240, 'https://i.etsystatic.com/15397008/r/il/351370/2142292672/il_794xN.2142292672_7wc6.jpg');
INSERT INTO `image` VALUES (241, 'https://i.etsystatic.com/10446666/r/il/655bbb/4304482261/il_794xN.4304482261_shqz.jpg');
INSERT INTO `image` VALUES (242, 'https://i.etsystatic.com/10446666/r/il/eea839/4304482277/il_794xN.4304482277_8263.jpg');
INSERT INTO `image` VALUES (243, 'https://i.etsystatic.com/10446666/r/il/f1b866/4304482329/il_794xN.4304482329_b737.jpg');
INSERT INTO `image` VALUES (244, 'https://i.etsystatic.com/10446666/r/il/f7ff7e/4257087936/il_794xN.4257087936_dftd.jpg');
INSERT INTO `image` VALUES (245, 'https://i.etsystatic.com/25577822/r/il/a0d0e4/3842951511/il_794xN.3842951511_fykw.jpg');
INSERT INTO `image` VALUES (246, 'https://i.etsystatic.com/25577822/r/il/323ae9/3842951513/il_794xN.3842951513_gbgx.jpg');
INSERT INTO `image` VALUES (247, 'https://i.etsystatic.com/25577822/r/il/bd70f4/3795400008/il_794xN.3795400008_74ph.jpg');
INSERT INTO `image` VALUES (248, 'https://i.etsystatic.com/25577822/r/il/4870e6/3842951545/il_794xN.3842951545_79hn.jpg');
INSERT INTO `image` VALUES (249, 'https://i.etsystatic.com/20036453/r/il/3ebc84/4023391299/il_794xN.4023391299_pdfk.jpg');
INSERT INTO `image` VALUES (250, 'https://i.etsystatic.com/20036453/r/il/ae3241/3975747094/il_794xN.3975747094_kstu.jpg');
INSERT INTO `image` VALUES (251, 'https://i.etsystatic.com/20036453/r/il/c09d8c/3975749280/il_794xN.3975749280_knsb.jpg');
INSERT INTO `image` VALUES (252, 'https://i.etsystatic.com/20036453/r/il/e82ff8/3975735998/il_794xN.3975735998_dab3.jpg');
INSERT INTO `image` VALUES (253, 'https://i.etsystatic.com/23389117/r/il/1f2fc9/3106532574/il_794xN.3106532574_e88m.jpg');
INSERT INTO `image` VALUES (254, 'https://i.etsystatic.com/23389117/r/il/c9f999/3154248601/il_794xN.3154248601_gz4x.jpg');
INSERT INTO `image` VALUES (255, 'https://i.etsystatic.com/23389117/r/il/808089/3154248805/il_794xN.3154248805_s3sg.jpg');
INSERT INTO `image` VALUES (256, 'https://i.etsystatic.com/23389117/r/il/75da44/3154248371/il_794xN.3154248371_jrkv.jpg');
INSERT INTO `image` VALUES (257, 'https://i.etsystatic.com/15645889/r/il/98770f/2083699148/il_794xN.2083699148_gw4x.jpg');
INSERT INTO `image` VALUES (258, 'https://i.etsystatic.com/15645889/r/il/f2bf5a/2619805507/il_794xN.2619805507_q1kl.jpg');
INSERT INTO `image` VALUES (259, 'https://i.etsystatic.com/15645889/r/il/12a570/1253369484/il_794xN.1253369484_12vn.jpg');
INSERT INTO `image` VALUES (260, 'https://i.etsystatic.com/15645889/r/il/fb1a88/2619814073/il_794xN.2619814073_s5nu.jpg');
INSERT INTO `image` VALUES (261, 'https://i.etsystatic.com/34036755/r/il/fc46c2/3833919865/il_794xN.3833919865_pkrf.jpg');
INSERT INTO `image` VALUES (262, 'https://i.etsystatic.com/34036755/r/il/443826/3833919861/il_794xN.3833919861_p6fw.jpg');
INSERT INTO `image` VALUES (263, 'https://i.etsystatic.com/34036755/r/il/0d0901/3833919815/il_794xN.3833919815_ict9.jpg');
INSERT INTO `image` VALUES (264, 'https://i.etsystatic.com/34036755/r/il/20fa57/3786322496/il_794xN.3786322496_8v10.jpg');
INSERT INTO `image` VALUES (265, 'https://i.etsystatic.com/38458445/r/il/bc05fa/4275328932/il_794xN.4275328932_mtu0.jpg');
INSERT INTO `image` VALUES (266, 'https://i.etsystatic.com/38458445/r/il/8900e3/4322731207/il_794xN.4322731207_3sws.jpg');
INSERT INTO `image` VALUES (267, 'https://i.etsystatic.com/38458445/r/il/8d8965/4322731275/il_794xN.4322731275_hk85.jpg');
INSERT INTO `image` VALUES (268, 'https://i.etsystatic.com/38458445/r/il/ba6519/4275329172/il_794xN.4275329172_qkxt.jpg');
INSERT INTO `image` VALUES (269, 'https://i.etsystatic.com/34740142/r/il/01e3cf/4098882457/il_794xN.4098882457_t6d9.jpg');
INSERT INTO `image` VALUES (270, 'https://i.etsystatic.com/34740142/r/il/ab4f18/4098883889/il_794xN.4098883889_du04.jpg');
INSERT INTO `image` VALUES (271, 'https://i.etsystatic.com/34740142/r/il/d8592c/4051237416/il_794xN.4051237416_801y.jpg');
INSERT INTO `image` VALUES (272, 'https://i.etsystatic.com/34740142/r/il/8e926b/4098885525/il_794xN.4098885525_nua2.jpg');
INSERT INTO `image` VALUES (273, 'https://i.etsystatic.com/34740142/r/il/1c13d4/4143594322/il_794xN.4143594322_4cup.jpg');
INSERT INTO `image` VALUES (274, 'https://i.etsystatic.com/34740142/r/il/0830ba/4143594632/il_794xN.4143594632_jp19.jpg');
INSERT INTO `image` VALUES (275, 'https://i.etsystatic.com/34740142/r/il/6d5095/4191255635/il_794xN.4191255635_sk1v.jpg');
INSERT INTO `image` VALUES (276, 'https://i.etsystatic.com/34740142/r/il/20aa49/4191255823/il_794xN.4191255823_kfcg.jpg');
INSERT INTO `image` VALUES (277, 'https://i.etsystatic.com/33646290/r/il/c9e70c/3947232059/il_794xN.3947232059_60di.jpg');
INSERT INTO `image` VALUES (278, 'https://i.etsystatic.com/33646290/r/il/2ba5af/3622242178/il_794xN.3622242178_14y2.jpg');
INSERT INTO `image` VALUES (279, 'https://i.etsystatic.com/33646290/r/il/9c8e41/3622220430/il_794xN.3622220430_3fa3.jpg');
INSERT INTO `image` VALUES (280, 'https://i.etsystatic.com/33646290/r/il/f9f62c/3669839799/il_794xN.3669839799_m51q.jpg');
INSERT INTO `image` VALUES (281, 'https://i.etsystatic.com/16561114/r/il/55b439/4393357299/il_794xN.4393357299_7lor.jpg');
INSERT INTO `image` VALUES (282, 'https://i.etsystatic.com/16561114/r/il/2a9c0a/4345967736/il_794xN.4345967736_teo9.jpg');
INSERT INTO `image` VALUES (283, 'https://i.etsystatic.com/16561114/r/il/5fed23/4393358593/il_794xN.4393358593_38qu.jpg');
INSERT INTO `image` VALUES (284, 'https://i.etsystatic.com/16561114/r/il/4209ca/4345967774/il_794xN.4345967774_bfzu.jpg');
INSERT INTO `image` VALUES (285, 'https://i.etsystatic.com/16561114/r/il/6fac17/4126658621/il_794xN.4126658621_l6v5.jpg');
INSERT INTO `image` VALUES (286, 'https://i.etsystatic.com/16561114/r/il/c24364/4129240668/il_794xN.4129240668_a3s4.jpg');
INSERT INTO `image` VALUES (287, 'https://i.etsystatic.com/16561114/r/il/92aee3/4079012182/il_794xN.4079012182_q1pd.jpg');
INSERT INTO `image` VALUES (288, 'https://i.etsystatic.com/16561114/r/il/1373ab/4176900019/il_794xN.4176900019_w127.jpg');
INSERT INTO `image` VALUES (289, 'https://i.etsystatic.com/16561114/r/il/9dd716/4095114012/il_794xN.4095114012_l0wj.jpg');
INSERT INTO `image` VALUES (290, 'https://i.etsystatic.com/16561114/r/il/e974c3/4097403164/il_794xN.4097403164_3h2a.jpg');
INSERT INTO `image` VALUES (291, 'https://i.etsystatic.com/16561114/r/il/1707a5/4126668051/il_794xN.4126668051_pec3.jpg');
INSERT INTO `image` VALUES (292, 'https://i.etsystatic.com/16561114/r/il/1d2cb1/4079021314/il_794xN.4079021314_gonj.jpg');
INSERT INTO `image` VALUES (293, 'https://i.etsystatic.com/16561114/r/il/8b9b46/4079005932/il_794xN.4079005932_ee9b.jpg');
INSERT INTO `image` VALUES (294, 'https://i.etsystatic.com/16561114/r/il/31fb66/4176923771/il_794xN.4176923771_lu4s.jpg');
INSERT INTO `image` VALUES (295, 'https://i.etsystatic.com/16561114/r/il/cb6312/4129259818/il_794xN.4129259818_rsbs.jpg');
INSERT INTO `image` VALUES (296, 'https://i.etsystatic.com/16561114/r/il/93d835/4079005950/il_794xN.4079005950_fnra.jpg');
INSERT INTO `image` VALUES (297, 'https://i.etsystatic.com/16561114/r/il/395d04/4165523312/il_794xN.4165523312_dmoc.jpg');
INSERT INTO `image` VALUES (298, 'https://i.etsystatic.com/16561114/r/il/40f5ac/4309313433/il_794xN.4309313433_lb6u.jpg');
INSERT INTO `image` VALUES (299, 'https://i.etsystatic.com/16561114/r/il/19222a/4309313807/il_794xN.4309313807_3bst.jpg');
INSERT INTO `image` VALUES (300, 'https://i.etsystatic.com/16561114/r/il/0613f6/4097430160/il_794xN.4097430160_dehk.jpg');
INSERT INTO `image` VALUES (301, 'https://i.etsystatic.com/9009839/r/il/0dfe81/1488324340/il_794xN.1488324340_d32g.jpg');
INSERT INTO `image` VALUES (302, 'https://i.etsystatic.com/9009839/r/il/e43b64/1488324460/il_794xN.1488324460_dpaw.jpg');
INSERT INTO `image` VALUES (303, 'https://i.etsystatic.com/9009839/r/il/2a43ba/1488324300/il_794xN.1488324300_d6ra.jpg');
INSERT INTO `image` VALUES (304, 'https://i.etsystatic.com/9009839/r/il/d1685f/1535806389/il_794xN.1535806389_9un5.jpg');
INSERT INTO `image` VALUES (305, 'https://i.etsystatic.com/36836263/r/il/826d5f/4237878768/il_794xN.4237878768_h3o8.jpg');
INSERT INTO `image` VALUES (306, 'https://i.etsystatic.com/36836263/r/il/414212/4237884152/il_794xN.4237884152_45l6.jpg');
INSERT INTO `image` VALUES (307, 'https://i.etsystatic.com/36836263/r/il/0f7e07/4285529509/il_794xN.4285529509_4p8e.jpg');
INSERT INTO `image` VALUES (308, 'https://i.etsystatic.com/36836263/r/il/56167a/4237878766/il_794xN.4237878766_hamb.jpg');
INSERT INTO `image` VALUES (309, 'https://i.etsystatic.com/36836263/r/il/7727ca/4099998769/il_794xN.4099998769_t8n7.jpg');
INSERT INTO `image` VALUES (310, 'https://i.etsystatic.com/36836263/r/il/18a204/4052348782/il_794xN.4052348782_lawq.jpg');
INSERT INTO `image` VALUES (311, 'https://i.etsystatic.com/36836263/r/il/e5bbd8/4099998791/il_794xN.4099998791_7mad.jpg');
INSERT INTO `image` VALUES (312, 'https://i.etsystatic.com/36836263/r/il/70e6f4/4099998731/il_794xN.4099998731_725l.jpg');
INSERT INTO `image` VALUES (313, 'https://i.etsystatic.com/36836263/r/il/567d32/4052096254/il_794xN.4052096254_h8bp.jpg');
INSERT INTO `image` VALUES (314, 'https://i.etsystatic.com/36836263/r/il/521407/4099745477/il_794xN.4099745477_rxbt.jpg');
INSERT INTO `image` VALUES (315, 'https://i.etsystatic.com/36836263/r/il/458c12/4099745475/il_794xN.4099745475_924p.jpg');
INSERT INTO `image` VALUES (316, 'https://i.etsystatic.com/36836263/r/il/e32368/4052096280/il_794xN.4052096280_5ev7.jpg');
INSERT INTO `image` VALUES (317, 'https://i.etsystatic.com/15179876/r/il/207406/2618818348/il_794xN.2618818348_efd4.jpg');
INSERT INTO `image` VALUES (318, 'https://i.etsystatic.com/15179876/r/il/3d734d/2618818300/il_794xN.2618818300_r85z.jpg');
INSERT INTO `image` VALUES (319, 'https://i.etsystatic.com/15179876/r/il/0f72ca/2618818294/il_794xN.2618818294_gv1g.jpg');
INSERT INTO `image` VALUES (320, 'https://i.etsystatic.com/15179876/r/il/acaa51/2618818328/il_794xN.2618818328_8my0.jpg');
INSERT INTO `image` VALUES (321, 'https://i.etsystatic.com/15179876/r/il/65694a/2573287938/il_794xN.2573287938_oqsm.jpg');
INSERT INTO `image` VALUES (322, 'https://i.etsystatic.com/15179876/r/il/aff6d9/2573287530/il_794xN.2573287530_fmw5.jpg');
INSERT INTO `image` VALUES (323, 'https://i.etsystatic.com/15179876/r/il/f2ec88/2573287368/il_794xN.2573287368_cx0w.jpg');
INSERT INTO `image` VALUES (324, 'https://i.etsystatic.com/15179876/r/il/e66c6c/3229966623/il_794xN.3229966623_kvao.jpg');
INSERT INTO `image` VALUES (325, 'https://i.etsystatic.com/15179876/r/il/81eb46/2178951696/il_794xN.2178951696_3j5g.jpg');
INSERT INTO `image` VALUES (326, 'https://i.etsystatic.com/15179876/r/il/ff2495/2178952178/il_794xN.2178952178_5xyj.jpg');
INSERT INTO `image` VALUES (327, 'https://i.etsystatic.com/15179876/r/il/03d2c7/2178952770/il_794xN.2178952770_s41s.jpg');
INSERT INTO `image` VALUES (328, 'https://i.etsystatic.com/15179876/r/il/415f93/3975069030/il_794xN.3975069030_p37i.jpg');
INSERT INTO `image` VALUES (329, 'https://i.etsystatic.com/18683860/r/il/4f2162/2725292818/il_794xN.2725292818_lhwh.jpg');
INSERT INTO `image` VALUES (330, 'https://i.etsystatic.com/18683860/r/il/ffe3a6/2772983695/il_794xN.2772983695_i1ld.jpg');
INSERT INTO `image` VALUES (331, 'https://i.etsystatic.com/18683860/r/il/878b8b/2772983817/il_794xN.2772983817_3vf7.jpg');
INSERT INTO `image` VALUES (332, 'https://i.etsystatic.com/18683860/r/il/0ff5c4/2725292560/il_794xN.2725292560_p3zb.jpg');
INSERT INTO `image` VALUES (333, 'https://i.etsystatic.com/15179876/r/il/876055/1605472762/il_794xN.1605472762_9swm.jpg');
INSERT INTO `image` VALUES (334, 'https://i.etsystatic.com/15179876/r/il/e027f2/1605473544/il_794xN.1605473544_g7uw.jpg');
INSERT INTO `image` VALUES (335, 'https://i.etsystatic.com/15179876/r/il/940c57/2048517027/il_794xN.2048517027_1cux.jpg');
INSERT INTO `image` VALUES (336, 'https://i.etsystatic.com/15179876/r/il/7c6aaa/2000946586/il_794xN.2000946586_p45k.jpg');
INSERT INTO `image` VALUES (337, 'https://i.etsystatic.com/35776721/r/il/74881e/4273318277/il_794xN.4273318277_nqhz.jpg');
INSERT INTO `image` VALUES (338, 'https://i.etsystatic.com/35776721/r/il/c58de1/4273318269/il_794xN.4273318269_qipb.jpg');
INSERT INTO `image` VALUES (339, 'https://i.etsystatic.com/35776721/r/il/abbbdc/4225664606/il_794xN.4225664606_57jw.jpg');
INSERT INTO `image` VALUES (340, 'https://i.etsystatic.com/35776721/r/il/e21573/4273318265/il_794xN.4273318265_k14v.jpg');
INSERT INTO `image` VALUES (341, 'https://i.etsystatic.com/35776721/r/il/9d7277/4227572867/il_794xN.4227572867_bjid.jpg');
INSERT INTO `image` VALUES (342, 'https://i.etsystatic.com/35776721/r/il/2d0a99/4179921080/il_794xN.4179921080_2pzq.jpg');
INSERT INTO `image` VALUES (343, 'https://i.etsystatic.com/35776721/r/il/2b3aba/4227572857/il_794xN.4227572857_fn1p.jpg');
INSERT INTO `image` VALUES (344, 'https://i.etsystatic.com/35776721/r/il/f36df8/4179921078/il_794xN.4179921078_qej0.jpg');
INSERT INTO `image` VALUES (345, 'https://i.etsystatic.com/32075335/r/il/81188b/4105544617/il_794xN.4105544617_9iq6.jpg');
INSERT INTO `image` VALUES (346, 'https://i.etsystatic.com/32075335/r/il/cf19fd/4105544615/il_794xN.4105544615_6pcc.jpg');
INSERT INTO `image` VALUES (347, 'https://i.etsystatic.com/32075335/r/il/ccec16/4105544643/il_794xN.4105544643_8rk0.jpg');
INSERT INTO `image` VALUES (348, 'https://i.etsystatic.com/32075335/r/il/b8ce3c/4057899564/il_794xN.4057899564_ayq1.jpg');
INSERT INTO `image` VALUES (349, 'https://i.etsystatic.com/35219079/r/il/194141/3914959417/il_794xN.3914959417_php4.jpg');
INSERT INTO `image` VALUES (350, 'https://i.etsystatic.com/35219079/r/il/beaa58/3914959453/il_794xN.3914959453_ji14.jpg');
INSERT INTO `image` VALUES (351, 'https://i.etsystatic.com/35219079/r/il/a70666/3867469166/il_794xN.3867469166_78ed.jpg');
INSERT INTO `image` VALUES (352, 'https://i.etsystatic.com/35219079/r/il/2766a6/3914959457/il_794xN.3914959457_r2jl.jpg');
INSERT INTO `image` VALUES (353, 'https://i.etsystatic.com/36834045/r/il/d98571/4256344128/il_794xN.4256344128_pwem.jpg');
INSERT INTO `image` VALUES (354, 'https://i.etsystatic.com/36834045/r/il/dbf747/4083917783/il_794xN.4083917783_4vug.jpg');
INSERT INTO `image` VALUES (355, 'https://i.etsystatic.com/36834045/r/il/e14c31/4083917253/il_794xN.4083917253_3lcg.jpg');
INSERT INTO `image` VALUES (356, 'https://i.etsystatic.com/36834045/r/il/0792e3/4036269178/il_794xN.4036269178_lmv9.jpg');
INSERT INTO `image` VALUES (357, 'https://i.etsystatic.com/37138958/r/il/a11fb9/4353842299/il_794xN.4353842299_4lic.jpg');
INSERT INTO `image` VALUES (358, 'https://i.etsystatic.com/37138958/r/il/552e0b/4353737335/il_794xN.4353737335_69yg.jpg');
INSERT INTO `image` VALUES (359, 'https://i.etsystatic.com/37138958/r/il/b7e7e0/4353842977/il_794xN.4353842977_oze9.jpg');
INSERT INTO `image` VALUES (360, 'https://i.etsystatic.com/37138958/r/il/1d7db0/4306446052/il_794xN.4306446052_1ojs.jpg');
INSERT INTO `image` VALUES (361, 'https://i.etsystatic.com/22117099/r/il/e736bd/3906422523/il_794xN.3906422523_gvus.jpg');
INSERT INTO `image` VALUES (362, 'https://i.etsystatic.com/22117099/r/il/edee1f/3858925130/il_794xN.3858925130_cygw.jpg');
INSERT INTO `image` VALUES (363, 'https://i.etsystatic.com/22117099/r/il/559400/3906423851/il_794xN.3906423851_jn1h.jpg');
INSERT INTO `image` VALUES (364, 'https://i.etsystatic.com/22117099/r/il/f8e9fe/3906424417/il_794xN.3906424417_ctpg.jpg');
INSERT INTO `image` VALUES (365, 'https://i.etsystatic.com/27872640/r/il/a83583/4199916189/il_794xN.4199916189_sczg.jpg');
INSERT INTO `image` VALUES (366, 'https://i.etsystatic.com/27872640/r/il/9317e8/4199916191/il_794xN.4199916191_qw7h.jpg');
INSERT INTO `image` VALUES (367, 'https://i.etsystatic.com/27872640/r/il/f891ca/4152267078/il_794xN.4152267078_m6zi.jpg');
INSERT INTO `image` VALUES (368, 'https://i.etsystatic.com/27872640/r/il/d95b54/4152267122/il_794xN.4152267122_klbh.jpg');
INSERT INTO `image` VALUES (369, 'https://i.etsystatic.com/27872640/r/il/4cb259/3264840072/il_794xN.3264840072_4bxp.jpg');
INSERT INTO `image` VALUES (370, 'https://i.etsystatic.com/27872640/r/il/95a567/3264840252/il_794xN.3264840252_37jj.jpg');
INSERT INTO `image` VALUES (371, 'https://i.etsystatic.com/27872640/r/il/43aa66/3312527907/il_794xN.3312527907_dexy.jpg');
INSERT INTO `image` VALUES (372, 'https://i.etsystatic.com/27872640/r/il/85d10a/3312527095/il_794xN.3312527095_1hke.jpg');
INSERT INTO `image` VALUES (373, 'https://i.etsystatic.com/27475592/r/il/b09819/4103306742/il_794xN.4103306742_pwrt.jpg');
INSERT INTO `image` VALUES (374, 'https://i.etsystatic.com/27475592/r/il/951a04/4103306900/il_794xN.4103306900_9a5n.jpg');
INSERT INTO `image` VALUES (375, 'https://i.etsystatic.com/27475592/r/il/974193/4103306876/il_794xN.4103306876_hsj6.jpg');
INSERT INTO `image` VALUES (376, 'https://i.etsystatic.com/27475592/r/il/0153b5/4150960515/il_794xN.4150960515_rxze.jpg');
INSERT INTO `image` VALUES (377, 'https://i.etsystatic.com/17261916/r/il/a3f505/1944363745/il_794xN.1944363745_hggn.jpg');
INSERT INTO `image` VALUES (378, 'https://i.etsystatic.com/17261916/r/il/695321/1944363547/il_794xN.1944363547_c05r.jpg');
INSERT INTO `image` VALUES (379, 'https://i.etsystatic.com/17261916/r/il/074580/1661578901/il_794xN.1661578901_b2zb.jpg');
INSERT INTO `image` VALUES (380, 'https://i.etsystatic.com/17261916/r/il/76357d/1578117689/il_794xN.1578117689_svm1.jpg');
INSERT INTO `image` VALUES (381, 'https://i.etsystatic.com/14945583/r/il/bd80ef/2688190499/il_794xN.2688190499_hkph.jpg');
INSERT INTO `image` VALUES (382, 'https://i.etsystatic.com/14945583/r/il/3a28fe/2688190609/il_794xN.2688190609_tbj0.jpg');
INSERT INTO `image` VALUES (383, 'https://i.etsystatic.com/14945583/r/il/847b81/2685397747/il_794xN.2685397747_2ufg.jpg');
INSERT INTO `image` VALUES (384, 'https://i.etsystatic.com/14945583/r/il/c1a3be/2637734732/il_794xN.2637734732_puzb.jpg');
INSERT INTO `image` VALUES (385, 'https://i.etsystatic.com/15091677/r/il/4516cc/4277043919/il_794xN.4277043919_fpzi.jpg');
INSERT INTO `image` VALUES (386, 'https://i.etsystatic.com/15091677/r/il/7dda90/4277044411/il_794xN.4277044411_3x36.jpg');
INSERT INTO `image` VALUES (387, 'https://i.etsystatic.com/15091677/r/il/70ca9f/4229386878/il_794xN.4229386878_tjxd.jpg');
INSERT INTO `image` VALUES (388, 'https://i.etsystatic.com/15091677/r/il/5a6e0e/4229387046/il_794xN.4229387046_2k2l.jpg');
INSERT INTO `image` VALUES (389, 'https://i.etsystatic.com/17788439/r/il/3b2f15/3256722004/il_794xN.3256722004_q15h.jpg');
INSERT INTO `image` VALUES (390, 'https://i.etsystatic.com/17788439/r/il/501a7c/2720232989/il_794xN.2720232989_rj5q.jpg');
INSERT INTO `image` VALUES (391, 'https://i.etsystatic.com/17788439/r/il/1b20f9/3256718804/il_794xN.3256718804_a7ec.jpg');
INSERT INTO `image` VALUES (392, 'https://i.etsystatic.com/17788439/r/il/81dc15/3256724962/il_794xN.3256724962_3vz5.jpg');
INSERT INTO `image` VALUES (393, 'https://i.etsystatic.com/17788439/r/il/c36a47/2657308176/il_794xN.2657308176_7jvl.jpg');
INSERT INTO `image` VALUES (394, 'https://i.etsystatic.com/17788439/r/il/a283a7/2723119322/il_794xN.2723119322_qoiw.jpg');
INSERT INTO `image` VALUES (395, 'https://i.etsystatic.com/17788439/r/il/c2cb21/2704998561/il_794xN.2704998561_4jl8.jpg');
INSERT INTO `image` VALUES (396, 'https://i.etsystatic.com/17788439/r/il/583e98/2704999847/il_794xN.2704999847_5iw7.jpg');
INSERT INTO `image` VALUES (397, 'https://i.etsystatic.com/17788439/r/il/b31e92/3618277987/il_794xN.3618277987_6vox.jpg');
INSERT INTO `image` VALUES (398, 'https://i.etsystatic.com/17788439/r/il/e55ca1/2699074458/il_794xN.2699074458_d2qa.jpg');
INSERT INTO `image` VALUES (399, 'https://i.etsystatic.com/17788439/r/il/d7c957/3570672570/il_794xN.3570672570_amh8.jpg');
INSERT INTO `image` VALUES (400, 'https://i.etsystatic.com/17788439/r/il/2d656e/3618277611/il_794xN.3618277611_em8e.jpg');
INSERT INTO `image` VALUES (401, 'https://i.etsystatic.com/34082332/r/il/99c9af/3697371489/il_794xN.3697371489_avu8.jpg');
INSERT INTO `image` VALUES (402, 'https://i.etsystatic.com/28326759/r/il/145f2f/2997173961/il_794xN.2997173961_b29o.jpg');
INSERT INTO `image` VALUES (403, 'https://i.etsystatic.com/26845987/r/il/ff7985/2857907629/il_794xN.2857907629_ssxj.jpg');
INSERT INTO `image` VALUES (404, 'https://i.etsystatic.com/23214896/r/il/473823/2432267993/il_794xN.2432267993_7jam.jpg');
INSERT INTO `image` VALUES (405, 'https://i.etsystatic.com/21252371/r/il/54d7dc/2086463709/il_794xN.2086463709_41vg.jpg');
INSERT INTO `image` VALUES (406, 'https://i.etsystatic.com/18808630/r/il/da0c2e/3812956634/il_794xN.3812956634_gra1.jpg');
INSERT INTO `image` VALUES (407, 'https://i.etsystatic.com/21232771/r/il/07a850/2794057758/il_794xN.2794057758_fmnl.jpg');
INSERT INTO `image` VALUES (408, 'https://i.etsystatic.com/19076644/r/il/549709/4240974539/il_794xN.4240974539_nji7.jpg');
INSERT INTO `image` VALUES (409, 'https://i.etsystatic.com/28083097/r/il/572026/3526325433/il_794xN.3526325433_dup7.jpg');
INSERT INTO `image` VALUES (410, 'https://i.etsystatic.com/15079459/r/il/666d63/3974254269/il_794xN.3974254269_fctf.jpg');
INSERT INTO `image` VALUES (411, 'https://i.etsystatic.com/28475776/r/il/0217dd/3194568106/il_794xN.3194568106_2q9v.jpg');
INSERT INTO `image` VALUES (412, 'https://i.etsystatic.com/27431999/r/il/d76074/4160030118/il_794xN.4160030118_bdy0.jpg');
INSERT INTO `image` VALUES (413, 'https://i.etsystatic.com/5407182/r/il/d18075/2534365274/il_794xN.2534365274_28v8.jpg');
INSERT INTO `image` VALUES (414, 'https://i.etsystatic.com/36832986/r/il/5a7e1a/4127630124/il_794xN.4127630124_ktlk.jpg');
INSERT INTO `image` VALUES (415, 'https://i.etsystatic.com/26186931/r/il/4ebb7c/3272332567/il_794xN.3272332567_43j6.jpg');
INSERT INTO `image` VALUES (416, 'https://i.etsystatic.com/17142610/r/il/4e2a4c/1985559525/il_794xN.1985559525_20u2.jpg');
INSERT INTO `image` VALUES (417, 'https://i.etsystatic.com/34419527/r/il/5d30ba/3890127857/il_794xN.3890127857_a41m.jpg');
INSERT INTO `image` VALUES (418, 'https://i.etsystatic.com/11544714/r/il/9c02f8/1995415136/il_794xN.1995415136_7zig.jpg');
INSERT INTO `image` VALUES (419, 'https://i.etsystatic.com/26821883/r/il/fbf7fc/2804326473/il_794xN.2804326473_p5dk.jpg');
INSERT INTO `image` VALUES (420, 'https://i.etsystatic.com/32760853/r/il/b26114/3694276496/il_794xN.3694276496_2jiq.jpg');
INSERT INTO `image` VALUES (421, 'https://i.etsystatic.com/25577822/r/il/ba236a/2793055230/il_794xN.2793055230_mf06.jpg');
INSERT INTO `image` VALUES (422, 'https://i.etsystatic.com/25577822/r/il/221daf/3524815596/il_794xN.3524815596_n3z3.jpg');
INSERT INTO `image` VALUES (423, 'https://i.etsystatic.com/28925255/r/il/b02d46/3533945174/il_794xN.3533945174_g4w3.jpg');
INSERT INTO `image` VALUES (424, 'https://i.etsystatic.com/28925255/r/il/2ff97e/3461542893/il_794xN.3461542893_5hj4.jpg');
INSERT INTO `image` VALUES (425, 'https://i.etsystatic.com/28925255/r/il/d237b5/3600000174/il_794xN.3600000174_rqif.jpg');
INSERT INTO `image` VALUES (426, 'https://i.etsystatic.com/27692523/r/il/c4388f/3219111341/il_794xN.3219111341_qt8r.jpg');
INSERT INTO `image` VALUES (427, 'https://i.etsystatic.com/11226095/r/il/de384b/3004769672/il_794xN.3004769672_fn0o.jpg');
INSERT INTO `image` VALUES (428, 'https://i.etsystatic.com/9577345/r/il/a7fa39/2391172988/il_794xN.2391172988_4m6v.jpg');
INSERT INTO `image` VALUES (429, 'https://i.etsystatic.com/21044348/r/il/e7d6e6/2591004661/il_794xN.2591004661_4bpr.jpg');
INSERT INTO `image` VALUES (430, 'https://i.etsystatic.com/21044348/r/il/675553/2271653103/il_794xN.2271653103_ps7t.jpg');
INSERT INTO `image` VALUES (431, 'https://i.etsystatic.com/28541017/r/il/4e7702/3747993882/il_794xN.3747993882_by3o.jpg');
INSERT INTO `image` VALUES (432, 'https://i.etsystatic.com/22591325/r/il/1c5bfb/3645797842/il_794xN.3645797842_bjcy.jpg');
INSERT INTO `image` VALUES (433, 'https://i.etsystatic.com/20416287/r/il/c370c0/2997280320/il_794xN.2997280320_cs2j.jpg');
INSERT INTO `image` VALUES (434, 'https://i.etsystatic.com/37014879/r/il/19c16f/4107843952/il_794xN.4107843952_5dil.jpg');
INSERT INTO `image` VALUES (435, 'https://i.etsystatic.com/37014879/r/il/258ca9/4155588103/il_794xN.4155588103_biic.jpg');
INSERT INTO `image` VALUES (436, 'https://i.etsystatic.com/31698325/r/il/0895f9/3592715784/il_794xN.3592715784_iku1.jpg');
INSERT INTO `image` VALUES (437, 'https://i.etsystatic.com/31698325/r/il/00ea54/3541874161/il_794xN.3541874161_i2l8.jpg');
INSERT INTO `image` VALUES (438, 'https://i.etsystatic.com/31698325/r/il/dbf721/4045781224/il_794xN.4045781224_f659.jpg');
INSERT INTO `image` VALUES (439, 'https://i.etsystatic.com/37014879/r/il/696f09/4155416859/il_794xN.4155416859_14ai.jpg');
INSERT INTO `image` VALUES (440, 'https://i.etsystatic.com/33728464/r/il/e00767/3910726634/il_794xN.3910726634_dx67.jpg');
INSERT INTO `image` VALUES (441, 'https://i.etsystatic.com/33728464/r/il/d4b023/3838322396/il_794xN.3838322396_pv32.jpg');
INSERT INTO `image` VALUES (442, 'https://i.etsystatic.com/7418174/r/il/0ca1a8/1446768266/il_794xN.1446768266_59ya.jpg');
INSERT INTO `image` VALUES (443, 'https://i.etsystatic.com/12529135/r/il/23ae7b/2384905484/il_794xN.2384905484_ob8q.jpg');
INSERT INTO `image` VALUES (444, 'https://i.etsystatic.com/12529135/r/il/75a71c/2719044688/il_794xN.2719044688_5ifi.jpg');
INSERT INTO `image` VALUES (445, 'https://i.etsystatic.com/26116447/r/il/5fdbc2/3578329707/il_794xN.3578329707_imo8.jpg');
INSERT INTO `image` VALUES (446, 'https://i.etsystatic.com/26116447/r/il/71e580/3578325073/il_794xN.3578325073_mzri.jpg');
INSERT INTO `image` VALUES (447, 'https://i.etsystatic.com/26116447/r/il/9a9dda/3425200029/il_794xN.3425200029_qvxz.jpg');
INSERT INTO `image` VALUES (448, 'https://i.etsystatic.com/21139059/r/il/64d130/3396104353/il_794xN.3396104353_kkgv.jpg');
INSERT INTO `image` VALUES (449, 'https://i.etsystatic.com/21139059/r/il/64d130/3396104353/il_794xN.3396104353_kkgv.jpg');
INSERT INTO `image` VALUES (450, 'https://i.etsystatic.com/21232771/r/il/521fee/3750859129/il_794xN.3750859129_5yli.jpg');
INSERT INTO `image` VALUES (451, 'https://i.etsystatic.com/34691885/r/il/6645f4/3859009674/il_794xN.3859009674_kqwx.jpg');
INSERT INTO `image` VALUES (452, 'https://i.etsystatic.com/26055747/r/il/a75698/4290703368/il_794xN.4290703368_6cak.jpg');
INSERT INTO `image` VALUES (453, 'https://i.etsystatic.com/33855628/r/il/67ed8e/4416647473/il_794xN.4416647473_3ems.jpg');
INSERT INTO `image` VALUES (454, 'https://i.etsystatic.com/26055747/r/il/43056f/3939226096/il_794xN.3939226096_fhrm.jpg');
INSERT INTO `image` VALUES (455, 'https://i.etsystatic.com/23708165/r/il/0d1322/3028514248/il_794xN.3028514248_2dxj.jpg');
INSERT INTO `image` VALUES (456, 'https://i.etsystatic.com/23708165/r/il/5452cb/3527583883/il_794xN.3527583883_8c89.jpg');
INSERT INTO `image` VALUES (457, 'https://i.etsystatic.com/34691885/r/il/a3f9c8/4038578482/il_794xN.4038578482_ceos.jpg');
INSERT INTO `image` VALUES (458, 'https://i.etsystatic.com/34691885/r/il/ab3acf/4353128274/il_794xN.4353128274_d622.jpg');
INSERT INTO `image` VALUES (459, 'https://i.etsystatic.com/13285848/r/il/e2bb91/2658794245/il_794xN.2658794245_50gq.jpg');
INSERT INTO `image` VALUES (460, 'https://i.etsystatic.com/15397008/r/il/9bf56a/3219018437/il_794xN.3219018437_c99r.jpg');
INSERT INTO `image` VALUES (461, 'https://i.etsystatic.com/10446666/r/il/3148a8/4257087842/il_794xN.4257087842_9n2k.jpg');
INSERT INTO `image` VALUES (462, 'https://i.etsystatic.com/25577822/r/il/51115b/3843044283/il_794xN.3843044283_huox.jpg');
INSERT INTO `image` VALUES (463, 'https://i.etsystatic.com/20036453/r/il/fbe24f/3975796210/il_794xN.3975796210_a173.jpg');
INSERT INTO `image` VALUES (464, 'https://i.etsystatic.com/23389117/r/il/fb087f/3154248889/il_794xN.3154248889_4655.jpg');
INSERT INTO `image` VALUES (465, 'https://i.etsystatic.com/15645889/r/il/4d68af/2619813559/il_794xN.2619813559_q0yc.jpg');
INSERT INTO `image` VALUES (466, 'https://i.etsystatic.com/34036755/r/il/87793e/3786324874/il_794xN.3786324874_j0l4.jpg');
INSERT INTO `image` VALUES (467, 'https://i.etsystatic.com/38458445/r/il/ee49c6/4275328700/il_794xN.4275328700_giw2.jpg');
INSERT INTO `image` VALUES (468, 'https://i.etsystatic.com/34740142/r/il/8b01f0/4051234424/il_794xN.4051234424_qyc2.jpg');
INSERT INTO `image` VALUES (469, 'https://i.etsystatic.com/34740142/r/il/b08109/4191254913/il_794xN.4191254913_if5k.jpg');
INSERT INTO `image` VALUES (470, 'https://i.etsystatic.com/33646290/r/il/c8e453/3935659608/il_794xN.3935659608_l3mo.jpg');
INSERT INTO `image` VALUES (471, 'https://i.etsystatic.com/16561114/r/il/234ade/4393355127/il_794xN.4393355127_oxqd.jpg');
INSERT INTO `image` VALUES (472, 'https://i.etsystatic.com/16561114/r/il/542cf6/4079012740/il_794xN.4079012740_71ew.jpg');
INSERT INTO `image` VALUES (473, 'https://i.etsystatic.com/35217008/r/il/31cf5a/4547500409/il_794xN.4547500409_qy7k.jpg');
INSERT INTO `image` VALUES (474, 'https://i.etsystatic.com/26904175/r/il/f810f6/4547805177/il_794xN.4547805177_hby0.jpg');
INSERT INTO `image` VALUES (475, 'https://i.etsystatic.com/16561114/r/il/258922/4345884346/il_794xN.4345884346_f4sf.jpg');
INSERT INTO `image` VALUES (476, 'https://i.etsystatic.com/33150124/r/il/e84e7f/4089744108/il_794xN.4089744108_8pu8.jpg');
INSERT INTO `image` VALUES (477, 'https://i.etsystatic.com/36836263/r/il/6b8071/4054863346/il_794xN.4054863346_stxf.jpg');
INSERT INTO `image` VALUES (478, 'https://i.etsystatic.com/36836263/r/il/533795/4052348896/il_794xN.4052348896_cb5x.jpg');
INSERT INTO `image` VALUES (479, 'https://i.etsystatic.com/36836263/r/il/a51000/4237878756/il_794xN.4237878756_7bmf.jpg');
INSERT INTO `image` VALUES (480, 'https://i.etsystatic.com/9009839/r/il/d1f2fa/1488324250/il_794xN.1488324250_7ygb.jpg');
INSERT INTO `image` VALUES (481, 'https://i.etsystatic.com/15179876/r/il/87a611/2573287756/il_794xN.2573287756_h47c.jpg');
INSERT INTO `image` VALUES (482, 'https://i.etsystatic.com/15179876/r/il/f7decc/2226514701/il_794xN.2226514701_8kbe.jpg');
INSERT INTO `image` VALUES (483, 'https://i.etsystatic.com/18683860/r/il/cc18ce/2772983511/il_794xN.2772983511_9v2o.jpg');
INSERT INTO `image` VALUES (484, 'https://i.etsystatic.com/15179876/r/il/74ae87/1605473108/il_794xN.1605473108_tnnb.jpg');
INSERT INTO `image` VALUES (485, 'https://i.etsystatic.com/35776721/r/il/32bffe/4273318271/il_794xN.4273318271_t6xa.jpg');
INSERT INTO `image` VALUES (486, 'https://i.etsystatic.com/35776721/r/il/260807/4179921086/il_794xN.4179921086_sgeh.jpg');
INSERT INTO `image` VALUES (487, 'https://i.etsystatic.com/32075335/r/il/5d2560/4057899532/il_794xN.4057899532_s1ay.jpg');
INSERT INTO `image` VALUES (488, 'https://i.etsystatic.com/35219079/r/il/828e71/4028924507/il_794xN.4028924507_ai8b.jpg');
INSERT INTO `image` VALUES (489, 'https://i.etsystatic.com/36834045/r/il/e14c31/4083917253/il_794xN.4083917253_3lcg.jpg');
INSERT INTO `image` VALUES (490, 'https://i.etsystatic.com/37138958/r/il/582063/4306343920/il_794xN.4306343920_ijka.jpg');
INSERT INTO `image` VALUES (491, 'https://i.etsystatic.com/22117099/r/il/005a27/3906425289/il_794xN.3906425289_f63k.jpg');
INSERT INTO `image` VALUES (492, 'https://i.etsystatic.com/27872640/r/il/8919be/4152266986/il_794xN.4152266986_9h8g.jpg');
INSERT INTO `image` VALUES (493, 'https://i.etsystatic.com/27872640/r/il/37f4f2/3264839052/il_794xN.3264839052_mab2.jpg');
INSERT INTO `image` VALUES (494, 'https://i.etsystatic.com/27475592/r/il/767e1c/4103306672/il_794xN.4103306672_brv5.jpg');
INSERT INTO `image` VALUES (495, 'https://i.etsystatic.com/17261916/r/il/8e0164/1944363313/il_794xN.1944363313_fsms.jpg');
INSERT INTO `image` VALUES (496, 'https://i.etsystatic.com/14945583/r/il/401504/2640524706/il_794xN.2640524706_esoa.jpg');
INSERT INTO `image` VALUES (497, 'https://i.etsystatic.com/17261916/r/il/8e0164/1944363313/il_794xN.1944363313_fsms.jpg');
INSERT INTO `image` VALUES (498, 'https://i.etsystatic.com/14945583/r/il/401504/2640524706/il_794xN.2640524706_esoa.jpg');
INSERT INTO `image` VALUES (499, 'https://i.etsystatic.com/15091677/r/il/911f51/4277046193/il_794xN.4277046193_tfwp.jpg');
INSERT INTO `image` VALUES (500, 'https://i.etsystatic.com/17788439/r/il/ce48c4/3256718798/il_794xN.3256718798_8p35.jpg');
INSERT INTO `image` VALUES (501, 'images/user-avatar/defautAvtUser.png');

-- ----------------------------
-- Table structure for import
-- ----------------------------
DROP TABLE IF EXISTS `import`;
CREATE TABLE `import`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `vendor_id` int NOT NULL,
  `create_date` datetime NOT NULL,
  `user_import_id` int NOT NULL,
  `note` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `status` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_import_vendor`(`vendor_id` ASC) USING BTREE,
  INDEX `fk_user_import`(`user_import_id` ASC) USING BTREE,
  CONSTRAINT `fk_import_vendor` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_import` FOREIGN KEY (`user_import_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of import
-- ----------------------------
INSERT INTO `import` VALUES (1, 8, '2023-04-13 12:06:33', 1, 'sadfd4', 3);
INSERT INTO `import` VALUES (2, 9, '2023-04-13 12:06:33', 2, 'đaswfgre', 0);
INSERT INTO `import` VALUES (3, 9, '2023-06-22 21:17:33', 4, 'adsd', 0);
INSERT INTO `import` VALUES (5, 10, '2023-06-22 21:39:52', 4, '203', 0);
INSERT INTO `import` VALUES (6, 9, '2023-06-25 23:45:49', 4, 'ádasd', 0);
INSERT INTO `import` VALUES (7, 9, '2023-06-25 23:45:50', 4, 'ádasd', 0);
INSERT INTO `import` VALUES (8, 9, '2023-06-25 23:45:57', 4, 'ádasd', 0);
INSERT INTO `import` VALUES (9, 10, '2023-06-26 00:08:04', 4, 'hvbcgv', 0);
INSERT INTO `import` VALUES (10, 10, '2023-06-26 00:41:36', 4, 'jkgjtgft', 3);

-- ----------------------------
-- Table structure for incorrect_time
-- ----------------------------
DROP TABLE IF EXISTS `incorrect_time`;
CREATE TABLE `incorrect_time`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `incorrect_attempts` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `locked_until` datetime NULL DEFAULT NULL,
  `status` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_incorrect_times_user`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_incorrect_times_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of incorrect_time
-- ----------------------------

-- ----------------------------
-- Table structure for information
-- ----------------------------
DROP TABLE IF EXISTS `information`;
CREATE TABLE `information`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `detail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `district` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `province_id` int NULL DEFAULT NULL,
  `district_id` int NULL DEFAULT NULL,
  `ward_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of information
-- ----------------------------
INSERT INTO `information` VALUES (13, 'Thanh Phụng', '03273487', 'Xã An Hòa Hải', 'Huyện Tuy An', 'Phú Yên', 260, 3284, '800109', 0);
INSERT INTO `information` VALUES (14, 'Như', '45674567', 'Xã Cư Suê', 'Huyện Cư M gar', 'Đắk Lắk', 210, 1785, '400605', 0);
INSERT INTO `information` VALUES (15, 'Tuấn', '2352345', 'Xã Mê Linh', 'Huyện Mê Linh', 'Hà Nội', 201, 1581, '1B2908', 0);
INSERT INTO `information` VALUES (18, 'Go Hoang Gia Anh', '0128878957', 'Phu Lam', 'Phu Tan', 'An Giang', 1, 1, '0', 0);
INSERT INTO `information` VALUES (20, 'Xưởng mộc Nguyên', '059499569', '190/23, Lê Trọng Tấn', 'Tân Bình', 'HCM', 2, 14, '2132', 0);
INSERT INTO `information` VALUES (21, 'Mộc Cao Gia', '099569698', 'xã An Hào', 'Tịnh Biên', 'An Giang', 67, 5456, '56646', 0);

-- ----------------------------
-- Table structure for keys
-- ----------------------------
DROP TABLE IF EXISTS `keys`;
CREATE TABLE `keys`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `public_key_base64` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `locked_date` datetime NULL DEFAULT NULL,
  `status` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `keys_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of keys
-- ----------------------------
INSERT INTO `keys` VALUES (1, 13, 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA42FIg9xZ1/pCqui8RUYryhwgUGbr/vV7vzcRn73koMLC5LzLOdjydVr0xBdvBoSUAl+q6mj0honQIIy7BKjV2HZ8WBRgEgsE1X0KwzqiWE4GRRvp74/SLDhiwi+9zReCoW12ejDdipitvSYeHJXtR8sr02gw241QERsqOhpsfUbPwPjLAsENehAkQrr1Ma3+BePcpmtO08AFSOPU21AcUw5w8tyQZMUs9hGnumef+AaF4XME09epu6SzQZcV7Q8sMyGOfE04xsMnbNs119jQB4+8vl+wIMzHIIOvVgHPri6C/tAI5pGH6TopoYxnRMzLk7pXvMoEyKhUtZgBQmqs6QIDAQAB', NULL, 0);

-- ----------------------------
-- Table structure for line_item
-- ----------------------------
DROP TABLE IF EXISTS `line_item`;
CREATE TABLE `line_item`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `quantity` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_line_item_product`(`product_id` ASC) USING BTREE,
  CONSTRAINT `fk_line_item_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of line_item
-- ----------------------------
INSERT INTO `line_item` VALUES (10, 4, '1');
INSERT INTO `line_item` VALUES (11, 89, '2');
INSERT INTO `line_item` VALUES (12, 19, '1');
INSERT INTO `line_item` VALUES (13, 1, '2');
INSERT INTO `line_item` VALUES (14, 7, '2');
INSERT INTO `line_item` VALUES (15, 22, '1');
INSERT INTO `line_item` VALUES (16, 11, '1');

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `source_id` int NOT NULL,
  `severity_level` int NOT NULL,
  `create_date` datetime NOT NULL,
  `event_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_log_source`(`source_id` ASC) USING BTREE,
  INDEX `fk_log_event`(`event_id` ASC) USING BTREE,
  CONSTRAINT `fk_log_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_log_source` FOREIGN KEY (`source_id`) REFERENCES `source` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of log
-- ----------------------------

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `total` int NOT NULL,
  `transport_id` int NOT NULL,
  `status_delivery` int NOT NULL,
  `payment_method` int NOT NULL,
  `delivery_date` datetime NULL DEFAULT NULL,
  `receiving_date` datetime NULL DEFAULT NULL,
  `is_payment` bit(1) NOT NULL,
  `create_date` datetime NULL DEFAULT NULL,
  `user_id` int NOT NULL,
  `information_id` int NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `discount_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_transport`(`transport_id` ASC) USING BTREE,
  INDEX `fk_order_user`(`user_id` ASC) USING BTREE,
  INDEX `fk_order_infomation`(`information_id` ASC) USING BTREE,
  INDEX `fk_order_discount`(`discount_id` ASC) USING BTREE,
  CONSTRAINT `fk_order_discount` FOREIGN KEY (`discount_id`) REFERENCES `discount` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_order_infomation` FOREIGN KEY (`information_id`) REFERENCES `information` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_order_transport` FOREIGN KEY (`transport_id`) REFERENCES `transport` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (9, 'Giao buoi sang giup toi', 0, 3, 1, 0, NULL, NULL, b'0', '2023-05-03 14:43:22', 2, 15, '0', 1);
INSERT INTO `order` VALUES (10, '', 3059909, 4, 1, 0, NULL, NULL, b'0', '2023-05-03 15:08:06', 2, 13, '0', 1);
INSERT INTO `order` VALUES (15, '', 2655696, 10, 1, 0, NULL, NULL, b'0', '2023-05-03 15:30:35', 2, 14, '0', NULL);

-- ----------------------------
-- Table structure for order_line
-- ----------------------------
DROP TABLE IF EXISTS `order_line`;
CREATE TABLE `order_line`  (
  `order_id` int NOT NULL,
  `line_item_id` int NOT NULL,
  PRIMARY KEY (`order_id`, `line_item_id`) USING BTREE,
  INDEX `FK_line_item`(`line_item_id` ASC) USING BTREE,
  CONSTRAINT `fk_line_order_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_order_line_line_item` FOREIGN KEY (`line_item_id`) REFERENCES `line_item` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_line
-- ----------------------------
INSERT INTO `order_line` VALUES (9, 10);
INSERT INTO `order_line` VALUES (10, 11);
INSERT INTO `order_line` VALUES (10, 12);
INSERT INTO `order_line` VALUES (15, 13);
INSERT INTO `order_line` VALUES (15, 14);

-- ----------------------------
-- Table structure for order_signatures
-- ----------------------------
DROP TABLE IF EXISTS `order_signatures`;
CREATE TABLE `order_signatures`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `signature_base64` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id`(`order_id` ASC) USING BTREE,
  CONSTRAINT `order_signatures_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_signatures
-- ----------------------------

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `detail` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `rate` int NOT NULL,
  `category_id` int NOT NULL,
  `user_add_id` int NOT NULL,
  `status` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_product_category`(`category_id` ASC) USING BTREE,
  INDEX `fk_product_user`(`user_add_id` ASC) USING BTREE,
  CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_product_user` FOREIGN KEY (`user_add_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (1, 'Cú gỗ trên cây', 'THÔNG SỐ KỸ THUẬT<br>• Kích thước : 19cm x 7cm x 7cm<br>• Màu sắc : Trong suốt<br>• Chất liệu & Quy trình : Gỗ cú trang trí bàn ăn là sản phẩm thủ công của gia đình mình, chim cú được làm từ gỗ jempinis được gia công rất cẩn thận kỹ thuật điêu khắc để tạo ra hình chim cú rất đẹp, kết hợp với rễ gỗ tự nhiên và rất độc đáo làm nền, rất phù hợp để trang trí cho ngôi nhà của bạn trông đẹp hơn và cũng có thể làm quà tặng cho một người đặc biệt.<br ><br>XỬ LÝ & THỜI GIAN VẬN CHUYỂN<br>• chúng tôi cần thời gian để xử lý khoảng 2-5 ngày làm việc<br>• Indonesia Pos Express: 6-12 ngày sau khi tôi đánh dấu đơn hàng là đã hoàn thành', '• Chiều rộng: 7 cm <br>• Chiều cao: 19 cm<br>• Chiều sâu: 7 cm', '2023-04-13 12:06:33', 4, 4, 1, 0);
INSERT INTO `product` VALUES (2, 'Cặp đôi chim ruồi', 'Vận chuyển sẽ được nâng cấp thành vận chuyển nhanh nếu mua hai mặt hàng trở lên, áp dụng cho tất cả các mặt hàng.<br><br>Sử dụng các mã này để tiết kiệm khi bạn mua nhiều mặt hàng:<br>WDRS02 để tiết kiệm 10% cho 2 mặt hàng trở lên<br>WDRS04 để tiết kiệm 25% cho 4 mặt hàng trở lên<br><br>VẬN CHUYỂN<br>Vận chuyển tiêu chuẩn: 8-15 ngày làm việc<br>Vận chuyển nhanh: 5-8 ngày làm việc<br><br>Cơ sở của bức tượng được làm từ gỗ kí sinh, và chim ruồi được làm từ gỗ địa phương của Indonesia, cụ thể là gỗ Jempinis, sự kết hợp của hai loại gỗ tạo ra một bức tượng có hình dạng độc đáo.<br><br>Các tác phẩm điêu khắc được các nghệ nhân của chúng tôi thực hiện trong không gian nhỏ của chúng tôi xưởng đặt tại Ubud, Bali. Tác phẩm điêu khắc là một tác phẩm nghệ thuật tự nhiên, bạn sẽ nhận được các hình dạng khác nhau nhưng cùng kích thước.', 'Làm thủ công<br>• Vật liệu: Trung bình: Gỗ<br>• Chiều rộng: 9 inch<br>• Chiều cao: 9 inch<br> • Độ sâu: 3 inch', '2023-04-13 12:06:33', 5, 4, 1, 0);
INSERT INTO `product` VALUES (3, 'Keycap gỗ cho bàn phím cơ', ' BLACK WALNUT Keycap gỗ tùy chỉnh cho bàn phím cơ<br><br>Vui lòng chọn từ các tùy chọn có sẵn sau:<br>□R1-1u<br>□R2-1u<br>□R3-1u<br>□R4-1u <br>□Backspace-2u<br>□Nhập phím-2.25u<br>□Phím cách-6.25u<br>□Bộ WASD<br>□Bộ △▽▷◁<br><br>♥Material : Gỗ óc chó đen<br>♥Cấu hình: OEM<br>♥Khả năng tương thích: Bàn phím cơ MX stem<br><br>VẬN CHUYỂN MIỄN PHÍ TẠI HOA KỲ & CANADA<br>Do đại dịch COVID-19, vui lòng chờ thêm thời gian để giao hàng<br> br><br>Nếu bạn muốn có ghi chú quà tặng trong gói hàng, vui lòng để lại nội dung ghi chú trong hộp thông báo “Thêm ghi chú“ khi thanh toán ;)', '• Chất liệu: gỗ, óc chó đen', '2023-04-13 12:06:33', 5, 6, 1, 0);
INSERT INTO `product` VALUES (4, 'Táo gỗ', 'Những quả táo này là táo loại 1 vì gỗ được sử dụng đắt hơn để mua. Gỗ được sử dụng cho những quả táo này là Ziricote, Kingwood, Cocobolo, Tulipwood, Anjan và African Blackwood.Pau Rosa<br>Táo có thể khác so với ảnh. Những quả táo này đã được phun sơn và đánh bóng để có độ bóng cao Kích thước của những quả táo đều gần đúng : Chiều cao 2 3/8&quot; (60mm) và đường kính nằm trong khoảng 2 1/2 & 2 3/4&quot; (64-70mm).', '• Chiều rộng: 2 3/4 inch<br>• Chiều cao: 2 3/8 inch', '2023-04-13 12:06:33', 4, 8, 1, 0);
INSERT INTO `product` VALUES (5, 'Ghế đẩu bằng gỗ sồi', 'Ghế đẩu làm hoàn toàn bằng gỗ sồi. Nó được ngâm tẩm với dầu tự nhiên và sáp dán. Một món đồ nội thất rất phổ biến, nó có thể đứng ở bất cứ đâu trong nhà để lấp đầy khoảng trống và cách nhiệt cho nội thất. Nó cũng hoàn hảo như một chiếc bàn cạnh giường ngủ. Mặt bàn trên cùng có kích thước 49x25x2 cm. Chân rất ổn định, tiết diện của chúng là 3 × 3 cm. Nó được đặc trưng bởi các chi tiết đẹp.<br><br>Thông số kỹ thuật:<br>- kích thước tổng thể 49x25x48 cm,<br>- ngâm tẩm sáp dầu,<br>- chân ổn định với tiết diện 3 × 3 cm,< br>- trọng lượng cho phép 80 kg', '• Chiều rộng: 25 cm<br>• Chiều cao: 48 cm<br>• Chiều sâu: 49 cm', '2023-04-13 12:06:33', 4, 5, 1, 0);
INSERT INTO `product` VALUES (6, 'Đĩa tròn làm thủ công bằng gỗ', 'Chất liệu: Keo<br><br>Kích thước<br><br>•S - Đường kính Dài: 15cm Rộng: 15cm Dày 2cm<br><br>•M - Đường kính Dài: 20cm Rộng: 20cm Dày 2cm<br><br><br> <br>Khay vườn gỗ keo được làm bằng gỗ keo cứng từ Philippines. <br><br>Gỗ của gỗ keo cứng.<br><br>Gỗ keo cứng, tán cao, lá màu xanh tươi, khi đến mùa hoa có màu trắng xanh, thanh tao và thơm ngát. <br><br>Vân gỗ đẹp ly cafe cực hợp, dùng hàng ngày trong phòng khách làm khay giải khát cũng rất trang nhã.', '• Vật liệu: Gỗ', '2023-04-13 12:06:33', 4, 5, 1, 0);
INSERT INTO `product` VALUES (7, 'Thìa gỗ thủ công - Muỗng nấu ăn 12 inch', 'Sản xuất tại Mỹ - Được làm thủ công tại đất nước Amish, Pennsylvania bởi thợ thủ công lành nghề. Mang truyền thống trở lại nhà bếp của bạn với thiết kế mang tính biểu tượng, thìa gỗ của chúng tôi được chạm khắc từ cây anh đào, cây phong và quả óc chó được thu hoạch bền vững ở Pennsylvania.<br><br>Đa năng - Tuyệt vời để trộn, nấu và phục vụ. Thìa gỗ tốt nhất cho mọi bề mặt nấu nướng bao gồm dụng cụ nấu bằng gang, teflon chống dính, thép không gỉ và chảo. Hoàn hảo để nấu ăn trong nhà bếp hoặc phục vụ tại bàn ăn tối. Lý tưởng để nấu canh, xào rau, xào thịt và dùng với cơm.', '•Thủ công<br>• Vật liệu: Gỗ', '2023-04-13 12:06:33', 4, 5, 1, 0);
INSERT INTO `product` VALUES (8, 'Mô hình nấm làm bằng gỗ', 'Chúng tôi có hai tùy chọn vận chuyển, Tiêu chuẩn và Chuyển phát nhanh của DHL. Thời gian giao hàng ước tính cho chuyển phát nhanh là 3-7 ngày làm việc trên toàn thế giới. Vui lòng chọn vận chuyển nhanh trong quá trình thanh toán / xem xét đơn hàng nếu bạn cần bức tượng nhanh chóng.<br><br>Tự động nâng cấp lên vận chuyển nhanh nếu bạn mua hai món trở lên.<br><br>♥Giảm 15% khi bạn mua 3 bức giảm giá khi bạn mua 5 món đồ (Mã số: PAR05) hoặc bằng cách nhấp vào liên kết này ♥<br>♥vòng tay & đồ trang trí giáng sinh miễn phí♥<br><br>Nấm được làm từ gỗ địa phương, gỗ Jempinis. Phần đế của bức tượng này được làm bằng gỗ Ký Sinh. Gỗ trắc là một loại gỗ rất độc đáo.', 'thủ công\n•Vật liệu: Gỗ<br>•Chiều rộng: 9,1 inch<br>•Chiều cao: 5,3 inch <br>•Độ sâu: 3,5 inch', '2023-04-13 12:06:33', 4, 4, 1, 0);
INSERT INTO `product` VALUES (9, 'Bình hoa tối giản bằng gỗ', 'Bình Gỗ Tự Nhiên 01 | Bình hoa tối giản | Quà Tặng Gia Đình | Trang trí ngày lễ | Quà Giáng Sinh | Gỗ Nghệ Thuật | Quà Tặng Nàng Giáng Sinh<br><br>? Kích thước: cao 18cm, mặt trên 8cm, đáy 4cm<br>? Có 2 màu Đậm và Sáng<br>?Sản phẩm gỗ gợi ấn tượng đẹp về sự gần gũi với thiên nhiên, giản dị mà tinh tế , mộc mạc nhưng không hề thô sơ. Chiếc bình này được làm từ gỗ óc chó và gỗ phong trong một quá trình xử lý cẩn thận, chắc chắn nó sẽ mang đến cho ngôi nhà của bạn một vẻ tinh tế mộc mạc.<br>?Bạn có thể cắm những bông hoa lộng lẫy mà không cần cắm chúng trong một chiếc lọ cắm hoa bằng gỗ cầu kỳ. Chỉ có hoa khô, hoa giả hoặc thân cây khô tươi là phù hợp.', '•Thủ công<br>•Tàu từ một doanh nghiệp nhỏ ở Việt Nam<br>•Vật liệu: gỗ, óc chó, phong<br>•Chiều cao: 17 cm', '2023-04-13 12:06:33', 4, 8, 1, 0);
INSERT INTO `product` VALUES (10, 'Đồng hồ treo tường bằng gỗ 20 inch', 'Đồng hồ treo tường tối giản hiện đại. Mặt gỗ sồi sang trọng, vạch chỉ giờ và kim đồng hồ màu đen. Thiết kế độc đáo hấp dẫn. Có hai kích thước lớn 40 cm và 50 cm / 15,7 inch và 19,7 inch. Được trang bị một đồng hồ im lặng. <br><br>Quy cách:<br>- đồng hồ làm bằng gỗ sồi veneered 6mm/ ~ 0,24&#39;&#39; MDF dày,<br>- chỉ số: chèn màu đen, thiết kế bóng bẩy hiện đại,<br>- kim đồng hồ được làm bằng nhôm sơn đen,<br>- gỗ được sơn dầu kỹ lưỡng,<br>- đường kính có sẵn: 40 cm / ~ 15, 7&#39;&#39; hoặc 50 cm / ~19,7&#39;&#39;<br>- chuyển động đồng hồ: bộ máy Đức chất lượng cao, yên tĩnh, đáng tin cậy', '•Thủ công<br>•Đọc danh sách đầy đủ các tài liệu<br>•Vật liệu: gỗ, gỗ sồi, ván ép, cơ chế đồng hồ im lặng', '2023-04-13 12:06:33', 4, 4, 1, 0);
INSERT INTO `product` VALUES (11, 'Bình hoa gốm sứ thô -trang trí nội thất', 'Bình hoa gốm thô Embersceramic để trang trí nhà<br><br>Lọ hoa gốm này bao gồm:<br><br>Bình hoa x1 x1 (6x13cm)<br><br>Bình hoa x1 x1 (9x8,5cm)< br><br>Lọ hoa C x1 (4.8x14cm)<br><br>Lọ hoa D x1 (8.5x7.5cm)<br><br>Lọ hoa gốm sứ này cung cấp cho bạn tất cả những gì bạn cần cho một sự kiện Trà đạo / dự tiệc với bạn bè hoặc đồng nghiệp tại văn phòng ngoài trời hoặc ở nhà. Một món quà Giáng sinh hoặc sinh nhật hoàn hảo.<br><br>Lý tưởng cho buổi giới thiệu của bạn với những người yêu trà<br><br>Yêu cầu kinh doanh/yêu cầu đặc biệt/đặt hàng tùy chỉnh: chỉ cần viết thư cho chúng tôi.', '•Thủ công<br>•Vật liệu: gốm sứ<br>•Chiều rộng: 8,5 cm<br>•Chiều cao: 7,5 cm<br>•Độ sâu: 6,5 cm', '2023-04-13 12:06:33', 4, 9, 1, 0);
INSERT INTO `product` VALUES (12, 'Bộ tách trà gốm sứ', 'Chiếc cốc và đĩa vẽ bằng thảo dược được làm thủ công này là một món quà hoàn hảo cho bất kỳ người yêu trà hoặc cà phê nào! Họa tiết hoa màu xanh lam sẽ tạo tâm trạng vui vẻ trong bất kỳ thời tiết xấu nào.<br><br>Kích thước xấp xỉ:<br>Dung tích: 300ml hoặc 400 ml tùy bạn chọn<br>Đĩa lót đường kính 7 inch/18 cm', '•Thủ công<br>•Vật liệu: Gốm sứ<br>•Dung tích: 300 ml', '2023-04-13 12:06:33', 4, 11, 1, 0);
INSERT INTO `product` VALUES (13, 'Cốc cà phê', 'Lớp men chấm trong suốt trên những chiếc cốc này trông tinh nghịch và ngon miệng. Những cốc tên tùy chỉnh này là cốc cà phê hoặc cốc trà lý tưởng và hoạt động hoàn hảo khi độc lập hoặc theo bộ. Tất cả các tác phẩm của tôi đều là đồ gốm đất sét trắng và được tráng men an toàn cho thực phẩm.<br><br>Xin lưu ý rằng mỗi chiếc cốc được tạo thành riêng lẻ và do đó sẽ có đặc điểm, hình dạng và khuyết điểm riêng. <br><br>Bạn cũng có thể chọn cốc có đĩa được cá nhân hóa của mình (đĩa sẽ không cần cá nhân hóa).', '•Thủ công<br>•Vật liệu: Gốm sứ<br>•Dung tích: 220 ml', '2023-04-13 12:06:33', 4, 11, 1, 0);
INSERT INTO `product` VALUES (14, 'Bình gốm trang trí sáng tạo', 'BLEUS - Blue Ceramic Vase Hand Painted Creative Home Decoration Ornaments<br><br>Have you ever looked at a flower and thought to yourself, &quot;This would look so much better if it were in a vase?&quot; Well, we have the perfect product for you: our ceramic vases!<br><br>Our vases are made with green ceramic and are sure to enhance your floral arrangements. They come in three different sizes and can be used individually or together to create an eye-catching display.<br><br>So what are you waiting for? Add one or more of these beauties to your collection today!<br><br>IWYAH - I want you a home', '•Thủ công<br>•Vật liệu: Gốm sứ', '2023-04-13 12:06:33', 4, 9, 1, 0);
INSERT INTO `product` VALUES (15, 'Bình cắm hoa cổ điển', 'Những chiếc bình ném thủ công này được sản xuất tại thị trấn sứ Jingdezhen. Chúng là những chiếc bình nhỏ xinh, phù hợp để trang trí bàn trà Kungfu (Gongfu) / Chado Nhật Bản. Cũng là một món quà tân gia hoặc sinh nhật tuyệt vời. <br><br>Để biết kích thước của bình hoa, vui lòng tham khảo hình ảnh.', '•Thủ công<br>•Vật liệu: Gốm sứ', '2023-04-13 12:06:33', 4, 9, 1, 0);
INSERT INTO `product` VALUES (16, 'Bình gốm sứ cắm hoa', 'Bình hoa nụ <br><br>Làm sinh động ngôi nhà của bạn bằng những bông hoa tươi vào mùa hè hoặc sưởi ấm nó bằng một chiếc bình hoa khô và đầy màu sắc vào mùa đông. Bất kể thành phần nào bạn yêu thích, một chiếc bình gốm sẽ là nơi thích hợp để giữ nó. <br><br>- Kích thước: H: 7,48 inch (19 cm) Ø: 3,94 inch (10 cm)<br>- Dung tích: 43 fl oz (1300 ml)<br>- Chức năng<br>- Sẵn sàng vận chuyển <br><br>Chúng tôi cần khoảng ba tuần để làm chiếc bình. Ban đầu, chúng tôi tạo hình nó trên bánh xe của thợ gốm. Sau đó, nó trải qua quá trình nung, tráng men và nung lại ở nhiệt độ 2012°F (1100°C).', '•Thủ công<br>Vật liệu: Gốm Sứ', '2023-04-13 12:06:33', 4, 9, 1, 0);
INSERT INTO `product` VALUES (17, 'Bộ ấm trà tráng men thủ công', 'Bộ ấm trà này sẽ góp phần mang đến cho bạn những buổi thư giãn thoải mái bên gia đình bên những tách trà nóng thơm ngon, cũng như giúp tâm hồn trở về với sự bình yên trong cuộc sống.<br>- Cấu tạo ấm trà sứ cao cấp: đảm bảo độ thẩm thấu cao, lưu giữ hương thơm của trà<br>Sản phẩm được nung trong lò với nhiệt độ 1300 độ C loại bỏ hoàn toàn các chất độc hại đảm bảo sức khỏe người sử dụng.<br>- Sản phẩm đẹp, sang trọng có thể dùng làm quà biếu tặng người thân, bạn bè, tân gia.<br> - Chén được tráng men trong lòng, màu sắc sáng sạch giúp giữ hương vị trà thơm ngon, đẹp mắt, không bám dính, dễ dàng vệ sinh sau khi sử dụng.<br>- Bộ sản phẩm gồm: 01 ấm trà dung tích 500ml, 06 tách trà, 07 đĩa.', '•Thủ công•<br>Tàu từ một doanh nghiệp nhỏ ở Việt Nam•<br>Vật liệu: Gốm sứ', '2023-04-13 12:06:33', 4, 11, 1, 0);
INSERT INTO `product` VALUES (18, 'Vòng tay hạt dung nham', 'Mỗi vòng tay đều được làm thủ công bằng dây co giãn bền và đá bán quý. Tất cả các vòng đeo tay có thể được thực hiện để phù hợp với bất kỳ kích thước cổ tay. Nếu bạn cần kích thước khác với kích thước được cung cấp, vui lòng thêm kích thước đó vào phần &quot;ghi chú cho người bán&quot; hộp khi thanh toán.<br><br>Khi thanh toán, khách hàng có tùy chọn chọn loại đá quý họ muốn kết hợp và kích thước họ cần.<br><br>Cho dù là một hướng dẫn thiền định tĩnh lặng hay một tác phẩm tuyên bố đẹp, trung tính và tự nhiên, điều này vòng tay sẽ là một bổ sung tuyệt vời cho phong cách hoặc thực hành tâm linh của bạn.', '•Đồ thủ công<br>•Chất liệu: Đá quý<br>•Đá quý: Đá mặt trăng<br>•Có thể điều chỉnh<br>•Phong cách: Tối giản<br>•Có thể cá nhân hóa', '2023-04-13 12:06:33', 4, 7, 1, 0);
INSERT INTO `product` VALUES (19, 'Ấm trà sứ trắng xám', 'Kích thước chiều dài x chiều cao:<br>10cmx8.5cm<br>Dung tích<br>125ML.', '•Đồ thủ công', '2023-04-13 12:06:33', 4, 11, 1, 0);
INSERT INTO `product` VALUES (20, 'Bình gốm trắng phong cách Bắc Âu - phong cách hiện', 'Tạo phong cách cho không gian của bạn với sự tinh tế tối giản hiện đại với những chiếc bình gốm này. Đẹp mắt dù có hoặc không có hoa, lỗ nhỏ sẽ phù hợp với một vài nhánh thực vật yêu thích của bạn để tô điểm cho không gian của bạn. Sự kết hợp giữa kích thước bình với sức chứa làm cho điều này trở thành một bổ sung tuyệt đẹp cho bất kỳ không gian hiện đại nào. Sọc ngang mỏng, nhẹ nhàng được xác định bằng tay mang lại kết cấu và sự sang trọng cho hình dáng đẹp mắt.<br>Thiết kế sọc tối giản.<br>Bình hoa hiện đại.<br>Gốm thủ công.<br>Kích thước: A 15*8cm, B 8*15cm, C 11*25cm<br><br>giá cho một chiếc bình.', '•Đồ thủ công', '2023-04-13 12:06:33', 4, 9, 1, 0);
INSERT INTO `product` VALUES (21, 'Tranh nghệ thuật phố cổ', 'GIỚI THIỆU VỀ BỨC TRANH NÀY.<br>Người sáng tạo: Aoi Gallery Team<br> Phong cách: Tranh trừu tượng<br> Đóng gói: Được cuộn và vận chuyển trong một ống đặc.<br> Chất liệu: Acrylic chuyên nghiệp, sơn dầu, canvas, vẽ tay. <br> Acrylic thủ công, sơn dầu trên canvas. Không có khung, Không kéo giãn.<br> Tranh có thêm viền trắng 2-3 inch xung quanh để kéo giãn hoặc tạo khung.', '•Làm thủ công<br>•Ship từ tiểu thương tại Việt Nam<br>•Chất liệu: Bề mặt: Ván canvas', '2023-04-13 12:06:33', 4, 14, 1, 0);
INSERT INTO `product` VALUES (22, 'Tranh sơn dầu làm quà tặng mẹ', 'GIỚI THIỆU VỀ BỨC TRANH NÀY.<br> Người sáng tạo: Aoi Gallery Team<br> Phong cách: Tranh trừu tượng<br> Đóng gói: Được cuộn và vận chuyển trong một ống đặc.<br> Chất liệu: Acrylic chuyên nghiệp, sơn dầu, canvas, vẽ tay. <br> Acrylic thủ công, sơn dầu trên canvas. Không có khung, Không kéo giãn.<br> Tranh có thêm viền trắng 2-3 inch xung quanh để kéo giãn hoặc tạo khung.', '•Làm thủ công<br>•Ship từ tiểu thương tại Việt Nam<br>•Chất liệu: Bề mặt: Ván canvas', '2023-04-13 12:06:33', 4, 14, 1, 0);
INSERT INTO `product` VALUES (23, 'Tranh phong cảnh quê hương Việt Nam', 'LƯU Ý QUAN TRỌNG <br>* Tất cả các khung hình chỉ được hiển thị nhằm mục đích minh họa, chúng không được bao gồm.<br>* Sự hài lòng của bạn là điều tối quan trọng đối với chúng tôi, vì vậy đối với mỗi đơn đặt hàng của bạn, chúng tôi sẽ gửi ảnh xem trước để bạn kiểm tra và chỉ giao hàng sau khi bạn chấp thuận.<br>* Nếu bạn cho rằng chúng tôi không xứng đáng được đánh giá 5 sao, vui lòng liên hệ với chúng tôi vì bất kỳ lý do gì trước khi bạn để lại nhận xét và chúng tôi sẽ giải quyết vấn đề ngay lập tức một cách chân thành nhất.<br> * Tôi thực sự hy vọng rằng những bức tranh của tôi sẽ lấp đầy không gian của bạn với những lời chúc đầy màu sắc của phép thuật và niềm vui.<br> Cảm ơn bạn đã ủng hộ và hiểu biết của bạn!', '•Làm thủ công<br>•Ship từ tiểu thương tại Việt Nam', '2023-04-13 12:06:33', 4, 14, 1, 0);
INSERT INTO `product` VALUES (24, 'Tranh thiếu nữ Việt Nam', 'LƯU Ý QUAN TRỌNG <br>* Tất cả các khung hình chỉ được hiển thị nhằm mục đích minh họa, chúng không được bao gồm.<br>* Sự hài lòng của bạn là điều tối quan trọng đối với chúng tôi, vì vậy đối với mỗi đơn đặt hàng của bạn, chúng tôi sẽ gửi ảnh xem trước để bạn kiểm tra và chỉ giao hàng sau khi bạn chấp thuận.<br>* Nếu bạn cho rằng chúng tôi không xứng đáng được đánh giá 5 sao, vui lòng liên hệ với chúng tôi vì bất kỳ lý do gì trước khi bạn để lại nhận xét và chúng tôi sẽ giải quyết vấn đề ngay lập tức một cách chân thành nhất.<br> * Tôi thực sự hy vọng rằng những bức tranh của tôi sẽ lấp đầy không gian của bạn với những lời chúc đầy màu sắc của phép thuật và niềm vui.<br> Cảm ơn bạn đã ủng hộ và hiểu biết của bạn!', '•Làm thủ công<br>•Ship từ tiểu thương tại Việt Nam<br>•Chất liệu: Bề mặt: Ván canvas', '2023-04-13 12:06:33', 4, 14, 1, 0);
INSERT INTO `product` VALUES (25, 'Tranh sơn dầu phong cảnh Việt Nam', 'LƯU Ý QUAN TRỌNG <br>* Tất cả các khung hình chỉ được hiển thị nhằm mục đích minh họa, chúng không được bao gồm.<br>* Sự hài lòng của bạn là điều tối quan trọng đối với chúng tôi, vì vậy đối với mỗi đơn đặt hàng của bạn, chúng tôi sẽ gửi ảnh xem trước để bạn kiểm tra và chỉ giao hàng sau khi bạn chấp thuận.<br>* Nếu bạn cho rằng chúng tôi không xứng đáng được đánh giá 5 sao, vui lòng liên hệ với chúng tôi vì bất kỳ lý do gì trước khi bạn để lại nhận xét và chúng tôi sẽ giải quyết vấn đề ngay lập tức một cách chân thành nhất.<br> * Tôi thực sự hy vọng rằng những bức tranh của tôi sẽ lấp đầy không gian của bạn với những lời chúc đầy màu sắc của phép thuật và niềm vui.<br> Cảm ơn bạn đã ủng hộ và hiểu biết của bạn!', '•Làm thủ công<br>•Ship từ tiểu thương tại Việt Nam<br>•Chất liệu: Bề mặt: Ván canvas', '2023-04-13 12:06:33', 4, 14, 1, 0);
INSERT INTO `product` VALUES (26, 'Bộ phin cà phê gốm dành cho người yêu cà phê', 'Tận hưởng từng khoảnh khắc với một tách cà phê! ♡ Cà phê phin, hay phin Việt Nam, là một trong những di sản của Việt Nam và là phương pháp pha cà phê truyền thống. <br># Lưu ý: Sản phẩm được làm thủ công và sử dụng kỹ thuật tráng men hoạt tính nên màu sắc có thể hơi khác so với hình ảnh. <br><br>Bộ sản phẩm bao gồm: Phin, cốc và đĩa tròn<br>#Phin: D-9cm x H-7.3cm<br>#Cốc: D-8cm x H-5.8cm', '', '2023-04-13 12:06:33', 4, 11, 1, 0);
INSERT INTO `product` VALUES (27, 'Cốc đất sét uống trà', 'Cà phê hoặc trà buổi sáng của bạn sẽ đậm đà và thơm hơn với một chiếc cốc mộc mạc lớn xinh xắn như vậy vì gốm sứ không tráng men hấp thụ hương vị và trả lại hương vị mỗi khi bạn sử dụng!', '', '2023-04-13 12:06:33', 4, 11, 1, 0);
INSERT INTO `product` VALUES (28, 'Cốc sứ nghệ thuật dân gian', 'Những chiếc cốc này được chế tạo bởi các nhóm phụ nữ địa phương ở Palestine, những người cố gắng xóa đói giảm nghèo và thất nghiệp ở địa phương, đồng thời duy trì truyền thống thủ công mỹ nghệ của người Palestine. Một bổ sung đẹp cho nhà bếp của bạn đó là một thủ môn. Có sẵn dưới dạng cốc đơn hoặc bộ 2 và 4 cốc.<br><br>Chén gốm thủ công được làm theo kỹ thuật truyền thống của Palestine. Một loại gốm trắng tuyệt đẹp với họa tiết in hoa dân tộc nổi tiếng, với các chi tiết tuyệt vời. Cốc màu xanh trắng với thiết kế hoa và lá đẹp mắt, bạn thậm chí có thể gọi nó là cốc hoa mùa đông. Một thiết kế độc đáo kết hợp giữa nghệ thuật dân gian dân tộc truyền thống với cách tiếp cận hiện đại.<br><br>Nhiều năm trước, những chiếc cốc tuyệt vời này được dùng để tiếp khách hoặc được cất giữ trong tủ kính như một vật trưng bày, trang trí. Thậm chí ngày nay tác phẩm nghệ thuật tuyệt đẹp này thường được trưng bày như một món quà lưu niệm, tưởng nhớ về Palestine. Vừa thiết thực vừa đẹp mắt, đây là loại gốm ', '', '2023-04-13 12:06:33', 4, 11, 1, 0);
INSERT INTO `product` VALUES (29, 'Cốc Trà Gốm Sứ Núi Cà Phê Trà 480Ml', 'Bộ tách trà sứ này bao gồm :<br><br>x 1 Cốc uống trà (14.6x13.5cm 480ml)', '', '2023-04-13 12:06:33', 4, 11, 1, 0);
INSERT INTO `product` VALUES (30, 'Gốm thủ công – Cốc trà có bộ lọc 240ml', 'This ceramic tea mugs include :<br><br>~Tea mugs(10.3x7.8cm 240ml)', '', '2023-04-13 12:06:33', 4, 11, 1, 0);
INSERT INTO `product` VALUES (31, 'Gỗ thủ công – Bình hoa trang trí để bàn', 'Kích thước:<br>S: Đường kính 5,2cm Chiều cao 7,5cm<br><br>M: Đường kính 5,5cm Chiều cao 13cm<br><br>L: Đường kính 5,7cm Chiều cao 18,5cm', '', '2023-04-13 12:06:33', 4, 8, 1, 0);
INSERT INTO `product` VALUES (32, 'Gỗ thủ công – Đèn chùm treo trần nhà', 'Đèn chùm nhỏ phong cách Nhật Bản đèn treo sáng tạo bằng gỗ. Đèn treo bằng gỗ tự nhiên hiện đại<br><br>Sản phẩm có sáu loại khác nhau về hình dạng và màu sắc một phần.<br><br>Đèn treo bằng gỗ được chế tác rất đẹp mắt cho phép bạn trải nghiệm vẻ đẹp của một không gian được chiếu sáng tốt phòng. Vật cố treo mặt dây chuyền hiện đại và có hình dạng tự nhiên này là sự kết hợp hoàn hảo giữa chức năng và tính thẩm mỹ tuyệt vời. Mỗi sản phẩm đều được làm thủ công và tuân theo các tiêu chuẩn quốc tế về chất lượng và kiểu dáng. Để tận hưởng một môi trường tươi sáng và sảng khoái, hãy chọn Đèn được thiết kế đầy phong cách này, nó sẽ làm bừng sáng trang trí nhà của bạn theo cách nghệ thuật nhất. Với sự hấp dẫn đáng chú ý, đèn treo này sẽ hoàn thiện không gian nội thất hiện đại của bạn. <br><br>Đây là sự lựa chọn hoàn hảo để bạn trang trí Phòng khách, Phòng ngủ, Phòng khách, Nhà bếp, Quán bar, Nhà hàng, Quán rượu và Quán ăn và Văn phòng.', '', '2023-04-13 12:06:33', 4, 8, 1, 0);
INSERT INTO `product` VALUES (33, 'Gỗ thủ công – Đèn treo bằng gỗ', 'Chụp đèn tròn nhỏ được làm bằng gỗ. Treo chúng xung quanh phòng một cách riêng biệt hoặc đặt chúng lại với nhau để tạo thành các tác phẩm khác nhau. Dù bằng cách nào, bạn sẽ muốn nhiều hơn và nhiều hơn nữa. <br><br>Chụp đèn bằng gỗ sẽ phù hợp với nhiều phong cách khác nhau. Và phù hợp với các phòng khác nhau trong nhà và nơi làm việc của bạn. <br><br>Ánh sáng tỏa sáng chân thực rất ấm áp và sẽ mang lại cảm giác ấm cúng cho nơi ở của bạn.<br><br>Các vòng tròn bằng gỗ có kích thước khác nhau được lắp ráp và sơn thủ công để tạo thành quả cầu gỗ dễ thương này.<br><br> Ánh sáng tỏa sáng chân thực rất ấm áp và sẽ mang đến cho không gian của bạn cảm giác ấm cúng.<br><br>LOẠI SẢN PHẨM: đèn treo<br><br>CHẤT LIỆU: gỗ cây dương', '', '2023-04-13 12:06:33', 4, 8, 1, 0);
INSERT INTO `product` VALUES (34, 'Gỗ thủ công – Tượng điêu khắc cừu dễ thương ', 'Điêu khắc gỗ động vật thủ công, Điêu khắc gỗ cừu dễ thương, Điêu khắc gỗ cừu trắng, Đồ trang trí động vật bằng gỗ, Điêu khắc trang trí bằng gỗ thủ công <br><br>Tác phẩm điêu khắc gỗ có thể dùng làm đồ trang trí bàn, trang trí phòng khách nhà ở, quà tặng tân gia, quà cưới.', '', '2023-04-13 12:06:33', 4, 4, 1, 0);
INSERT INTO `product` VALUES (35, 'Gỗ thủ công – Tượng điêu khắc sư tử', 'GIỚI THIỆU SẢN PHẨM NÀY<br>Đó là sản phẩm chạm khắc gỗ thủ công 100% của thợ chuyên nghiệp.<br>Sơn thủ công và đủ màu.<br>Làm từ gỗ tự nhiên, không mối mọt.', '', '2023-04-13 12:06:33', 4, 4, 1, 0);
INSERT INTO `product` VALUES (36, 'Gỗ thủ công – Tượng điêu khắc động vật sinh động', 'Có thể được sử dụng làm quà tặng cho bạn bè vào ngày sinh nhật, Giáng sinh, Lễ tạ ơn và những ngày khó quên khác. Kích thước của sinh vật nhỏ có thể được lắp đặt ở tất cả các phòng trong nhà, lối vào, phòng khách, nhà bếp, phòng ngủ, giá sách, bàn làm việc, v.v.<br><br>Tranh Tượng Trang Trí Nhà:<br>Chất liệu: Gỗ trầm <br>Kích thước : 3*3*6cm', '', '2023-04-13 12:06:33', 4, 4, 1, 0);
INSERT INTO `product` VALUES (37, 'Gỗ thủ công – Tượng điêu khắc chim béo dễ thương', 'Chim yêu tinh có thể được dùng làm quà tặng cho bạn bè vào ngày sinh nhật, Giáng sinh, Lễ tạ ơn và những ngày khó quên khác. Kích thước của sinh vật nhỏ có thể được lắp đặt ở tất cả các phòng trong nhà, lối vào, phòng khách, nhà bếp, phòng ngủ, giá sách, bàn làm việc, v.v.<br><br>Tranh Tượng Trang Trí Nhà:<br>Chất liệu: Gỗ trầm <br>Kích thước : 10*4.5*5cm', '', '2023-04-13 12:06:33', 4, 4, 1, 0);
INSERT INTO `product` VALUES (38, 'Gỗ thủ công – Tượng điêu khắc mèo dễ thương', 'Tác phẩm điêu khắc cá voi bằng gỗ thủ công, tác phẩm điêu khắc cá voi bằng gỗ, đồ trang trí động vật bằng gỗ, tác phẩm điêu khắc khắc gỗ cá voi dễ thương, trang trí chạm khắc thủ công<br><br>Tác phẩm điêu khắc gỗ có thể được sử dụng làm vật trang trí bàn, trang trí phòng khách nhà ở, quà tặng tân gia hoặc quà tặng đám cưới. <br><br>CHẤT LIỆU:<br>Gỗ<br><br>KÍCH THƯỚC:<br>Chiều dài: 4,3&quot;.<br><br>GIỚI THIỆU SẢN PHẨM NÀY<br>Đó là sản phẩm chạm khắc bằng gỗ thủ công 100% của nhà sản xuất chuyên nghiệp.<br>Sơn thủ công và đủ màu.<br>Làm từ gỗ tự nhiên, không mối mọt.<br><br>Cảm ơn bạn đã xem tin! Nếu bạn có bất kỳ câu hỏi xin vui lòng liên hệ với tôi\r\nTác phẩm điêu khắc cá voi bằng gỗ thủ công, tác phẩm điêu khắc cá voi bằng gỗ, đồ trang trí động vật bằng gỗ, tác phẩm điêu khắc khắc gỗ cá voi dễ thương, trang trí chạm khắc thủ công<br><br>Tác phẩm điêu khắc gỗ có thể được sử dụng làm vật trang trí bàn, trang trí phòng khách nhà ở, quà tặng tân gia hoặc quà tặng đám cưới. <br><br>CHẤT LI', '', '2023-04-13 12:06:33', 4, 4, 1, 0);
INSERT INTO `product` VALUES (39, 'Gỗ thủ công – Tượng điêu khắc cá voi xanh', 'Tác phẩm điêu khắc cá voi bằng gỗ thủ công, tác phẩm điêu khắc cá voi bằng gỗ, đồ trang trí động vật bằng gỗ, tác phẩm điêu khắc khắc gỗ cá voi dễ thương, trang trí chạm khắc thủ công<br><br>Tác phẩm điêu khắc gỗ có thể được sử dụng làm vật trang trí bàn, trang trí phòng khách nhà ở, quà tặng tân gia hoặc quà tặng đám cưới. <br><br>CHẤT LIỆU:<br>Gỗ<br><br>KÍCH THƯỚC:<br>Chiều dài: 4,3&quot;.<br><br>GIỚI THIỆU SẢN PHẨM NÀY<br>Đó là sản phẩm chạm khắc bằng gỗ thủ công 100% của nhà sản xuất chuyên nghiệp.<br>Sơn thủ công và đủ màu.<br>Làm từ gỗ tự nhiên, không mối mọt.<br><br>Cảm ơn bạn đã xem tin! Nếu bạn có bất kỳ câu hỏi xin vui lòng liên hệ với tôi', NULL, '2023-04-13 12:06:33', 4, 4, 1, 0);
INSERT INTO `product` VALUES (40, 'Khay trà bằng gỗ thủ công', 'Khay gỗ chữ nhật nhẹ, bền, mẫu mã đẹp - phụ kiện bàn ăn, decor.<br><br>THÔNG TIN SẢN PHẨM:<br>- Chất liệu: Gỗ đặc<br>- Kích thước và trọng lượng:<br>A: 21.5x2x13 .5 - 320g<br>B: 23x2x9 - 160g<br>C: 25x2x25 - 645g<br><br>- ĐẶC ĐIỂM<br>+ Hình chữ nhật, các góc bo tròn, tay cầm tích hợp<br>+ Nhẹ, bền hơn sứ Mỹ phẩm. Khó nứt, vỡ khi rơi<br>+ Thân thiện với môi trường<br>+ An toàn cho sức khỏe<br>+ Mẫu mã đẹp: Màu sắc và vân gỗ sẽ khác nhau tùy theo sản phẩm và chất liệu gỗ. <br>Vành được đẽo thủ công lấy cảm hứng từ tổ ong.', NULL, '2023-04-13 12:06:33', 4, 5, 1, 0);
INSERT INTO `product` VALUES (41, 'Đĩa gỗ thủ công – Đĩa gỗ con cá', 'Khay gỗ óc chó tự nhiên họa tiết cá. Được làm bằng gỗ tự nhiên và làm thủ công. Gỗ óc chó có độ bền cao, độ cứng tốt, màu sắc và đường vân đẹp. Do đặc tính kháng côn trùng tự nhiên nên gỗ óc chó không dễ bị mối mọt, ẩm mốc. Do đó, các sản phẩm làm từ gỗ óc chó không lo bị gãy hay cong vênh dễ dàng.<br>Sản phẩm có thể dùng để đựng thức ăn và trình bày các món ăn đẹp mắt theo phong cách Âu Mỹ hiện đại hay cổ điển.<br><br>THÔNG TIN SẢN PHẨM:< br>- Chất liệu: Gỗ óc chó tự nhiên<br>- Kết cấu: Vảy cá hoặc xương cá<br>- Màu sắc: nâu sẫm, không bóng<br>- Công dụng: Phục vụ và trang trí món ăn, trang trí bếp, cửa hàng.<br>- Kích thước: 34x15x1<br>- Trọng lượng: 200g<br><br>HƯỚNG DẪN BẢO QUẢN:<br>- Tránh để sản phẩm dưới nắng quá lâu<br>- Tránh để sản phẩm tiếp xúc với nước quá lâu<br> >- Sau khi sử dụng cần giặt sạch, phơi khô và bảo quản nơi khô ráo, thoáng mát<br><br>Để có thêm những món đồ cực ngầu cho ngôi nhà của bạn, hãy ghé thăm shop nhé ^^', NULL, '2023-04-13 12:06:33', 4, 5, 1, 0);
INSERT INTO `product` VALUES (42, 'Nhẫn gỗ thủ công', 'Vòng gỗ được làm bằng Gỗ thích mắt chim xám, Gỗ hồng mộc Santos và khảm Xương khủng long, Đồng và thiên thạch Tektite. Được làm thủ công để đặt hàng ở bất kỳ kích thước nào ở Vương quốc Anh hoặc Hoa Kỳ cho nam và nữ, với giao hàng miễn phí trên toàn thế giới!<br><br>Vui lòng đọc qua danh sách này để bạn hiểu chính sách cửa hàng của tôi và những gì mong đợi, đây là những gì bạn cần biết trong một vỏ hạt!<br><br> - Đây là một chiếc “vòng gỗ uốn cong” chắc chắn và bền bỉ<br> - Nó có lớp hoàn thiện chống thấm nước và bền lâu<br> - Chọn bất kỳ kích thước nào của Vương quốc Anh hoặc Hoa Kỳ <br> - Chọn chiều rộng trong khoảng 6-10mm<br> - Sẵn sàng đăng sau 1-2 tuần<br><br>Sự kết hợp tuyệt đẹp giữa Gỗ hồng sắc Santos và Gỗ thích mắt chim xám chắc chắn sẽ mê hoặc bất kỳ ai nhìn thấy nó!<br><br> lớp phủ đầu tiên là xương khủng long khoáng hóa, có các tế bào riêng lẻ được hóa thạch bằng các khoáng chất quý. Những khoáng chất này sau đó được nghiền nát và khảm để tạo thêm một dải màu nâu/đỏ.<br><b', NULL, '2023-04-13 12:06:33', 4, 7, 1, 0);
INSERT INTO `product` VALUES (43, 'Vòng tay bằng gỗ sồi – Vòng gỗ thủ công', 'Nhẫn gỗ dành cho nữ của chúng tôi được làm thủ công bằng phương pháp uốn cong. Phong cách tối giản với gỗ rất độc đáo. Mỗi chiếc vòng gỗ chỉ được làm bằng bàn tay, tình yêu và sự chăm chút.<br><br>♥ Giới thiệu về vòng gỗ cho nữ ♥<br>❯ Gỗ sồi và Gỗ ngựa vằn.<br>❯ Chiều rộng của vòng gỗ từ 5 - 10 mm. Trong ảnh, chiều rộng là 5 mm.<br>❯ Kích thước từ US 4 đến US 16. Nếu bạn không chắc chắn, vui lòng đọc về kích thước bên dưới trong phần Câu hỏi thường gặp của chúng tôi.<br><br>♥ Những gì bạn sẽ nhận ♥<br>❯ 1x Nhẫn gỗ thủ công cho nữ - Gỗ sồi và gỗ ngựa vằn.<br>❯ 1x Gói quà.<br>❯ 1x Ghi chú cá nhân.<br><br>♥ Tại sao bạn sẽ yêu nó ♥<br>❯ Được làm thủ công bằng tình yêu và sự cẩn thận.<br>❯ Mỗi món đồ trang sức đều được làm theo đơn đặt hàng nên mỗi món đồ gỗ đều khác biệt và độc đáo. Màu sắc và kiểu vân gỗ của mỗi chiếc nhẫn, bông tai hoặc vòng cổ bằng gỗ khác nhau. <br>❯ Tất cả các vòng gỗ của chúng tôi đều được làm bằng phương pháp uốn cong. Điều này làm cho những chiếc vòng chắc chắn và ', NULL, '2023-04-13 12:06:33', 4, 7, 1, 0);
INSERT INTO `product` VALUES (44, 'Nhẫn gỗ thủ công – Nhẫn đôi tình nhân', 'Bộ nhẫn đôi bằng gỗ của chúng tôi được làm thủ công, chúng tôi sử dụng phương pháp uốn cong để làm cho chúng siêu bền. Phong cách tối giản nhưng rất độc đáo với chất liệu gỗ Zebrano cao cấp. Mỗi chiếc vòng gỗ chỉ được làm bằng tay, tình yêu và sự chăm sóc. <br><br>♥ Những gì bạn sẽ nhận được ♥<br>❯ 1x Nơ đeo nhẫn bằng gỗ thủ công cho nữ - Zebrano.<br>❯ 1x Nhẫn gỗ thủ công cho nam Victory - Zebrano.<br>❯ 1x Gói quà.< br>❯ 1x Ghi chú được cá nhân hóa.<br><br>♥ Tại sao bạn sẽ thích ♥<br>❯ Được làm thủ công bằng tình yêu và sự cẩn thận.<br>❯ Mỗi món đồ trang sức đều được làm theo đơn đặt hàng nên mỗi món đồ bằng gỗ là khác biệt và độc đáo. Màu sắc và kiểu vân gỗ của mỗi chiếc nhẫn, bông tai hoặc vòng cổ bằng gỗ khác nhau. <br>❯ Tất cả các vòng gỗ của chúng tôi đều được làm bằng phương pháp uốn cong. Điều này làm cho nhẫn chắc chắn và bền.<br>❯ Vòng gỗ rất nhẹ và mỏng nên đeo rất thoải mái.<br>❯ Vòng gỗ tự nhiên và thân thiện với môi trường.<br>❯ Nếu nó&#39; Đó là một món quà, chúng tôi có ', NULL, '2023-04-13 12:06:33', 4, 7, 1, 0);
INSERT INTO `product` VALUES (45, 'Tượng gỗ - Tượng người phụ nữ thủ công', 'Tác phẩm điêu khắc này là một tác phẩm điêu khắc hấp dẫn, khắc họa một cách tự nhiên sự thuần khiết và gợi cảm của một trinh nữ.<br>Có thể đặt tượng ở bất kỳ đâu trong nhà, khách sạn hoặc địa điểm kinh doanh của bạn.<br><br><br> Thu hút ánh nhìn của bất kỳ ai người lạ Tác phẩm điêu khắc này cũng gây ra cuộc trò chuyện của họ<br><br>Được làm bằng 100% gỗ hoàng dương và được phủ một lớp thuốc chống côn trùng để bạn có thể đầu tư qua nhiều thế hệ. Sự đơn giản của việc làm sạch và khả năng sơn lại và có được một diện mạo mới, ngay cả khi nó thay đổi lớp phủ trong thời gian dài. Nó có một lợi thế độc đáo so với các bức tượng bằng đất sét và thủy tinh.<br><br><br>Bức tượng này chắc chắn sẽ bổ sung vào bộ sưu tập trang trí nhà đắt tiền của bạn do được sắp xếp tinh xảo và chạm khắc tinh xảo do các nhà điêu khắc của chúng tôi thực hiện.<br><br > Ảnh của mặt hàng nhìn thấy trên trang giống nhau khi chúng tôi giao hàng. Chúng tôi cố gắng thể hiện màu sắc và tình trạng thực của chúng ở mọi góc độ.', NULL, '2023-04-13 12:06:33', 4, 8, 1, 0);
INSERT INTO `product` VALUES (46, 'Tượng gỗ - Tượng nàng tiên cá được chạm khắc bằng ', 'Tác phẩm điêu khắc này là một tác phẩm điêu khắc hấp dẫn, khắc họa một cách tự nhiên sự thuần khiết và gợi cảm của Nàng tiên cá.<br>Có thể đặt ở bất cứ đâu trong nhà, khách sạn, trong phòng tắm, cạnh bể cá, trong ao hoa hoặc nơi kinh doanh .<br><br><br> Thu hút ánh nhìn của bất kỳ người lạ nào Tác phẩm điêu khắc này cũng thu hút cuộc trò chuyện của họ<br><br>Được làm bằng 100% gỗ hoàng dương và phủ thuốc chống côn trùng để bạn có thể đầu tư qua nhiều thế hệ. Sự đơn giản của việc làm sạch và khả năng sơn lại và có được một diện mạo mới, ngay cả khi nó thay đổi lớp phủ trong thời gian dài. Nó có một lợi thế độc đáo so với các bức tượng bằng đất sét và thủy tinh.<br><br><br>Bức tượng này chắc chắn sẽ bổ sung vào bộ sưu tập trang trí nhà đắt tiền của bạn do được sắp xếp tinh xảo và chạm khắc tinh xảo do các nhà điêu khắc của chúng tôi thực hiện.<br><br > Ảnh của mặt hàng nhìn thấy trên trang giống nhau khi chúng tôi giao hàng. Chúng tôi cố gắng thể hiện màu sắc và tình trạng thực của chúng', NULL, '2023-04-13 12:06:33', 4, 8, 1, 0);
INSERT INTO `product` VALUES (47, ' Tượng gỗ - Tượng cú gỗ thủ công', 'Tác phẩm điêu khắc này được thực hiện bằng cách chạm khắc bản chất tối đa của một con cú trong môi trường tự nhiên và là một thiết kế hấp dẫn. Bạn có thể đặt nó ở bất cứ đâu trong nhà, khách sạn hoặc địa điểm kinh doanh của bạn.<br><br><br> Giao diện tự nhiên táo bạo của thiết bị này chắc chắn sẽ thu hút sự chú ý của bất kỳ vị khách nào và sẽ thêm vào cuộc trò chuyện của họ.<br> <br>Được làm bằng 100% gỗ và phủ chất chống côn trùng để bạn có thể đầu tư qua nhiều thế hệ. Sự đơn giản của việc làm sạch và khả năng sơn lại và có được một diện mạo mới, ngay cả khi nó thay đổi lớp phủ trong thời gian dài. Nó có một lợi thế độc đáo so với các bức tượng bằng đất sét và thủy tinh.<br><br><br>Bức tượng này chắc chắn sẽ bổ sung vào bộ sưu tập trang trí nhà đắt tiền của bạn do được sắp xếp tinh xảo và chạm khắc tinh xảo do các nhà điêu khắc của chúng tôi thực hiện.<br><br > Ảnh của mặt hàng nhìn thấy trên trang giống nhau khi chúng tôi giao hàng. Chúng tôi cố gắng thể hiện màu sắc và tình trạng th', NULL, '2023-04-13 12:06:33', 4, 8, 1, 0);
INSERT INTO `product` VALUES (48, 'Tượng gỗ - Tượng sư tử bằng gỗ nghệ thuật', 'Tác phẩm điêu khắc này được thực hiện bằng cách chạm khắc bản chất tối đa của một con sư tử trong môi trường tự nhiên và là một thiết kế hấp dẫn. Bạn có thể đặt nó ở bất cứ đâu trong nhà, khách sạn hoặc địa điểm kinh doanh của bạn.<br><br><br> Giao diện tự nhiên táo bạo của thiết bị này chắc chắn sẽ thu hút sự chú ý của bất kỳ vị khách nào và sẽ thêm vào cuộc trò chuyện của họ.<br> <br>Được làm bằng 100% gỗ và phủ một lớp thuốc chống côn trùng để bạn có thể đầu tư qua nhiều thế hệ. Sự đơn giản của việc làm sạch và khả năng sơn lại và có được một diện mạo mới, ngay cả khi nó thay đổi lớp phủ trong thời gian dài. Nó có một lợi thế độc đáo so với các bức tượng bằng đất sét và thủy tinh.<br><br><br>Bức tượng này chắc chắn sẽ bổ sung vào bộ sưu tập trang trí nhà đắt tiền của bạn do được sắp xếp tinh xảo và chạm khắc tinh xảo do các nhà điêu khắc của chúng tôi thực hiện.<br><br > Ảnh của mặt hàng nhìn thấy trên trang giống nhau khi chúng tôi giao hàng. Chúng tôi cố gắng thể hiện màu sắc và t', NULL, '2023-04-13 12:06:33', 4, 8, 1, 0);
INSERT INTO `product` VALUES (49, 'Bộ gỗ lót ly uống trà độc đáo', 'Tất cả các thiết kế, mô tả, hình ảnh và nội dung của sản phẩm đều thuộc bản quyền của Gohobi. All right reserved©<br><br>Số lượng có hạn, chất lượng hàng đầu và đế lót ly bằng gỗ thiết kế độc quyền trên thị trường! Mỗi mảnh có một mẫu gỗ độc đáo! Tiện dụng để bảo vệ bàn của bạn khỏi đồ uống nóng nhưng cũng tuyệt vời như một món đồ trang trí khi không sử dụng. <br><br>Xin lưu ý rằng chúng có thể đậm hơn hoặc nhạt hơn tùy thuộc vào các mảnh gỗ (Tuyết tùng). Tất cả các sản phẩm đều được làm thủ công từ vật liệu tự nhiên, cũng có thể có một số điểm/đường kẻ bằng gỗ trên đó. <br><br>Chúng tôi có 4 kích cỡ đế lót ly và 3 kích cỡ tấm lót cho bộ sưu tập bằng gỗ thủ công này. Sản phẩm này thích hợp để làm quà tặng hoặc trang trí cho ngôi nhà của bạn. <br><br>Hãy nhắn tin cho tôi nếu bạn có bất kỳ câu hỏi nào :)<br><br>Kích thước tàu lượn<br><br>CỔ ĐIỂN<br>Hình vuông 8x8x0,8 CM (Xấp xỉ 3,15 x 3,15 x 0,315 inch) là phù hợp với cốc trà bình thường <br>*giá đỡ phù hợp với đế lót ly 8CM (Tối đa 6 đế', NULL, '2023-04-13 12:06:33', 4, 5, 1, 0);
INSERT INTO `product` VALUES (50, 'Gỗ thủ công – Thớt gỗ thủ công', 'Thớt của chúng tôi có hai kích thước khác nhau: 9x6 và 14x9. Thớt và phục vụ này sẽ trở thành công cụ nhà bếp mới yêu thích của bạn để chuẩn bị bữa ăn hoặc phục vụ các món khai vị đẹp mắt cho khách. Được thiết kế và làm thủ công tại Lancaster, PA, chúng tôi chỉ sử dụng loại gỗ cứng cao cấp nhất có nguồn gốc địa phương. Chúng tôi cung cấp sự lựa chọn Cherry, Maple và Walnut. Mỗi bảng gỗ có một dải điểm nhấn làm cho bảng này nổi bật. Thớt được xử lý bằng khoáng chất cấp thực phẩm.<br><br>Tính năng:<br><br>Thớt nhỏ<br>9&quot; dài và 6&quot; rộng x 5/8&quot; dày<br>Được làm từ Anh đào đen Pennsylvania, Phong và Quả óc chó<br><br>Ván lớn<br>14&quot; dài x 9&quot; rộng x 5/8&quot; dày<br>Được làm từ Cherry đen Pennsylvania, Maple và Walnut', NULL, '2023-04-13 12:06:33', 4, 5, 1, 0);
INSERT INTO `product` VALUES (51, 'Keycap – Keycap bằng gỗ thủ công', 'Keycaps chắc chắn tuyệt vời, mỗi cái là duy nhất và chiều cao OEM của nó rất thuận tiện và thoải mái cho người dùng. (KHÔNG BAO GỒM BÀN PHÍM)<br><br>✔️ Khả năng tương thích: Hoạt động với tất cả Cherry MX Gateron MX Kailh MX và tất cả các bàn phím công tắc MX khác. <br><br>✔️ Chất lượng cao cấp: Được làm thủ công từ 100% gỗ óc chó, chỉ phủ một lớp sáp dầu để bảo vệ vẻ ngoài vân gỗ tự nhiên ban đầu. Cảm giác chạm tuyệt vời! <br><br>✔️ Biến thể<br>4 Keycaps: WASD<br>4 Keycaps: Mũi tên<br>2 keycaps: Spacebar + Enter<br>2 keycaps: Left Shift + Enter<br>2 keycaps: Right Shift + Ctrl <br>1 keycap: Phím cách<br>1 keycap: Enter <br>1 keycap: Left Shift <br>1 keycap: Right Shift <br>1 keycap: R1 * 1u<br>1 keycap: R2 * 1u< br>1 keycap: R3 * 1u<br>1 keycap: R4 * 1u<br>1 keycap: Left Tab (R3*1.5u)<br>1 Keycap: Left CapsLock (R2*1.75u) <br><br ><br>✔️Tùy chỉnh: Cá nhân hóa có sẵn và MIỄN PHÍ, chúng tôi không tính thêm chi phí cho bất kỳ thiết kế nào. Vui lòng liên hệ với chúng tôi trước hoặc sau kh', NULL, '2023-04-13 12:06:33', 4, 6, 1, 0);
INSERT INTO `product` VALUES (52, 'Keycap – Keycap thủ công One Pice', 'Artisan Keycap, Keycap, keycaps Resin, Keycap Handmade SA Keycaps Cho Cherry MX Mechanical Gaming Keyboard, Ý tưởng quà tặng, Quà tặng cho người ấy<br><br>Chào bạn, ký tự bên trong keycap rất nhỏ, chi tiết ký tự đôi khi như nhỏ như đầu kim.<br> Khi thiết kế chúng tôi cố gắng tiết kiệm từng milimet để thêm thắt chi tiết cho nhân vật.<br> Bạn biết đấy, trong thiết kế 3D, chúng ta có thể vẽ từng sợi lông chân cho nhân vật, nhưng khi tô màu hoặc đưa vào thực tế sản xuất. các chi tiết chỉ nhỏ như đầu mũi kim. nên đây thực sự là một sản phẩm khó.<br> Dù đã cố gắng hết sức để hoàn thiện nhưng các chi tiết vẽ tay đôi khi vẫn chưa hoàn hảo, dù chúng ta có thể dành hàng giờ chỉ để phác thảo một chi tiết rất nhỏ nhưng đôi khi chúng vẫn có thể bị nhòe hoặc bị bóp méo. nên nếu bạn là người cầu toàn hay khó tính. Vui lòng cân nhắc và suy nghĩ kỹ trước khi đặt hàng keycap này. (chúng tôi mất 2-3 ngày làm việc để tô màu cho các ký tự bên trong)<br> Nếu bạn yêu thích các sản phẩm thủ công và hiểu rằng ', NULL, '2023-04-13 12:06:33', 4, 6, 1, 0);
INSERT INTO `product` VALUES (53, 'Keycap – Keycap thủ công minion', 'Nếu bạn đặt hàng hôm nay, thì đây là <a href=\'https://help.etsy.com/hc/articles/360020601674\' target=\'_blank\'>ngày giao hàng ước tính</a> và dựa trên thời gian xử lý của người bán và nhà cung cấp dịch vụ của bạn vị trí, thời gian vận chuyển, và địa chỉ vận chuyển. Hãy ghi nhớ: sự chậm trễ của nhà cung cấp dịch vụ hoặc đặt hàng vào cuối tuần hoặc ngày lễ có thể đẩy ngày này.\r\nNếu bạn đặt hàng hôm nay, thì đây là <a href=\'https://help.etsy.com/hc/articles/360020601674\' target=\'_blank\'>ngày giao hàng ước tính</a> và dựa trên thời gian xử lý của người bán và nhà cung cấp dịch vụ của bạn vị trí, thời gian vận chuyển, và địa chỉ vận chuyển. Hãy ghi nhớ: sự chậm trễ của nhà cung cấp dịch vụ hoặc đặt hàng vào cuối tuần hoặc ngày lễ có thể đẩy ngày này.\r\nHãy ghi nhớ: sự chậm trễ của nhà cung cấp dịch vụ hoặc đặt hàng vào cuối tuần hoặc ngày lễ có thể đẩy ngày này.', NULL, '2023-04-13 12:06:33', 4, 6, 1, 0);
INSERT INTO `product` VALUES (54, 'Keycap – Keycap nghệ thuật núi Phú Sỹ', 'Artisan Keycap,Keycap,keycaps Resin,Keycap Handmade SA và OEM Keycaps Cho Cherry MX Mechanical Gaming Keyboard,Ý tưởng quà tặng,Quà tặng cho người ấy<br><br>Vũ trụ huyền bí luôn là câu đố lớn nhất từ ​​trước đến nay mà con người chúng ta luôn muốn giải , nếu câu đố này được giải, nó sẽ mở ra một kỷ nguyên vĩ đại nhất mà chúng ta có thể tưởng tượng. Để giải quyết những bí ẩn này, chúng ta cần những người làm việc với chúng, các phi hành gia! Họ là những người chấp nhận hy sinh để làm việc trong không gian bất chấp những tổn thương về thể xác sau một thời gian dài sống trong không gian.<br><br>Du hành vũ trụ là một trong những ước mơ của cậu em út nhà BreakWooden, cậu luôn hi vọng một ngày nào đó có thể du hành giữa các vì sao trong vũ trụ. Và anh luôn ngưỡng mộ những phi hành gia dũng cảm. Để cảm ơn và tôn vinh họ, nghệ sĩ của chúng tôi không ngần ngại tạo ra chúng bằng tác phẩm mà anh ấy giỏi nhất trong keycap tùy chỉnh. Nghệ sĩ của chúng tôi sẵn sàng làm việc liên tục trong nhiều ngày', NULL, '2023-04-13 12:06:33', 4, 6, 1, 0);
INSERT INTO `product` VALUES (55, 'Keycap – Keycap bằng gỗ chạm khắc hình gấu', 'Cảm ứng tuyệt vời để cá nhân hóa bàn phím của bạn. Bao bì đẹp. <br>Thiết kế: Gấu Pooh và Bóng bay. Khá độc đáo, Đầy tính sáng tạo không giới hạn cho bạn mang lại sự mới mẻ và giải trí. <br> Mẫu này được chạm khắc thủ công và nhuộm màu. Đảm bảo nó không thấm nước, không thể xóa nhòa. Chắc chắn!!!!<br><br>Chiều cao/Kích thước: Cấu hình OEM<br>Mẫu: Num Enter Keycap. 【Keycap kích thước khác cũng có thể được tùy chỉnh.】<br>Tính năng: Siêu tuyệt vời Hiếm. Cảm giác chạm thoải mái. Kết hợp hoàn hảo. Bền, Không phai màu<br>Vật liệu: Quả óc chó, Gỗ hồng sắc, Gỗ mun<br><br>Khả năng tương thích < br>Phù hợp với tất cả Cherry MX Gateron MX Kailh MX và tất cả các bàn phím công tắc MX khác.<br>Như Filco,ikbc,Keycool, Ducky, Ganss...etc đã gắn công tắc Cherry MX RGB Bàn phím cơ<br><br>Đóng gói bao gồm (LƯU Ý)<br>Chỉ có một Keycap Num Enter + Bao bì đẹp.', NULL, '2023-04-13 12:06:33', 4, 6, 1, 0);
INSERT INTO `product` VALUES (56, 'Keycap – Keycap bằng gỗ chạm khắc thủ công', 'Cảm ứng tuyệt vời để cá nhân hóa bàn phím của bạn. <br>Các phím có thiết kế chống trượt và màu sắc nổi bật trực quan giúp bạn phát hiện ngay các phím chức năng cụ thể.<br><br>Chiều cao/Kích thước: Cấu hình OEM<br>Mẫu: nắp phím QWER 4, nắp phím WASD 4, nắp phím ASDF 4, Mũi tên 4 keycaps.Enter, Backspace, Spacebar, v.v....<br>Kích thước: QWER=R3, ASD=R2, v.v....<br>Chất liệu: Gỗ óc chó nguyên khối<br>Tính năng: Siêu hiếm .Cảm giác chạm thoải mái.Kết hợp hoàn hảo.Bền, Không phai màu<br><br>Khả năng tương thích 【Chỉ phù hợp với công tắc MX】<br>Phù hợp với tất cả Cherry MX Gateron MX Kailh MX và tất cả bàn phím công tắc MX khác.<br>Như Filco ,ikbc,Keycool, Ducky, Ganss...etc đã gắn công tắc Cherry MX RGB Bàn phím cơ<br><br>Đóng gói bao gồm (LƯU Ý)<br>Chỉ Keycaps, Không phải Bàn phím.<br><br>【Nếu bạn muốn keycaps gỗ có đèn nền, nó đã có trong kho, vui lòng tìm kiếm nó trong cửa hàng của tôi.', NULL, '2023-04-13 12:06:33', 4, 6, 1, 0);
INSERT INTO `product` VALUES (57, 'Vỏ bảo vệ AirPods Pro bằng gỗ thủ công', 'Được thiết kế cho Airpods Pro 2nd mới, lỗ nhỏ ở phía dưới dành cho loa nhỏ của Airpods Pro 2nd.<br><br>Hộp đựng AirPods bằng gỗ mỏng của chúng tôi có mọi thứ bạn cần để phản ánh phong cách cá nhân của bạn với vẻ đẹp của thiên nhiên. Là một món quà hoàn hảo cho người khác hoặc một món quà đặc biệt cho chính bạn.<br><br>✔️Chất lượng cao cấp: 100% gỗ óc chó nguyên khối và da PU. <br>✔️Hai tùy chọn kiểu dáng: Gỗ óc chó, Gỗ kết hợp da<br>✔️Dễ dàng lắp ráp: Tách rời hai phần (trên và dưới), đặt trực tiếp vào hộp sạc AirPods<br>✔️Sạc: Tương thích với mọi trạm sạc QI không dây .<br>✔️Hiệu suất tốt: Được trang bị nhiều miếng lót sợi nhỏ giúp bảo vệ hộp sạc AirPods. <br>✔️ Hộp gỗ có móc đi kèm; Vỏ gỗ có dây đeo bằng da<br><br>✔️Thiết kế tùy chỉnh: Cá nhân hóa có sẵn và MIỄN PHÍ, chúng tôi không tính thêm chi phí cho bất kỳ thiết kế nào.<br>1) Chọn Thiết kế cho Tùy chọn thiết kế (A - H), hoặc thiết kế của riêng bạn<br>2) Thông tin tùy chỉnh, tên/ghi chú/số<br>3) Tôi sẽ gửi cho bạn bản thảo thiết ', NULL, '2023-04-13 12:06:33', 4, 8, 1, 0);
INSERT INTO `product` VALUES (58, 'Đế sạc Iphone không dây – Đế sạc bằng gỗ thủ công', 'Đế sạc MagSafe của chúng tôi được thiết kế để giúp việc sạc và trưng bày iphone của bạn thuận tiện nhất có thể bằng cách hoạt động như một giá đỡ đầu giường hoặc đế để bàn, cũng như giữ cho dây cáp của bạn gọn gàng (KHÔNG BAO GỒM BỘ SẠC VÀ CÁP). <br><br>✔️Khả năng tương thích rộng rãi: <br>Tương thích với bộ sạc Magsafe chính thức của Apple dành cho iPhone 12/12 Pro/12 Mini/12 Max/13/13 Pro/13 Pro Max. KHÔNG BAO GỒM Sạc Iphone và MagSafe. <br><br>✔️ Thiết kế từ tính: Được trang bị nam châm có thể hấp thụ magsafe và giữ cho nó trượt lên xuống. Ngay cả đối với điện thoại có vỏ không nam châm, nó vẫn có thể giữ iphone để sạc với đế gỗ chắc chắn. <br><br>✔️Chất lượng cao cấp: Được làm thủ công từ 100% gỗ óc chó, chỉ phủ một lớp sáp dầu để bảo vệ vẻ ngoài vân gỗ tự nhiên ban đầu. Gỗ đặc nặng, cứng cáp và chắc chắn, nặng tới 540g (1,2lb) <br><br>✔️Tùy chỉnh: Cá nhân hóa có sẵn và MIỄN PHÍ, chúng tôi không tính thêm chi phí cho bất kỳ thiết kế nào. Vui lòng chọn một trong các thiết kế của chú', NULL, '2023-04-13 12:06:33', 4, 4, 1, 0);
INSERT INTO `product` VALUES (59, 'Ốp lưng iphone 11 promax bằng gỗ thủ công', 'Vỏ gỗ iPhone. Lớp bảo vệ tự nhiên và bằng gỗ độc đáo dành cho iPhone 7/8/SE, iPhone 7+/8+, iPhone X/Xs, iPhone Xr, iPhone Xs Max, iPhone 11, 11 Pro hoặc 11 Pro Max mới của bạn. Mỗi chiếc hộp đều được chế tác từ gỗ thật và được đánh bóng bằng tay để đạt được độ bóng của gỗ tự nhiên, trước khi được gắn vào một chiếc hộp chắc chắn để đảm bảo khả năng bảo vệ vượt trội khỏi bị rơi hoặc va đập.<br><br>Bạn muốn CÁ NHÂN HÓA hộp đựng? Thêm cái này - <a href=\"https://www.etsy.com/listing/662276951/custom-engraving-on-our-products\" target=\"_blank\">https://www.etsy.com/listing/ 662276951</a><br><br>FE A T U R E S:<br>•Dễ dàng lắp ráp - vừa vặn với từng mẫu iPhone<br>•Thân thiện với môi trường, Siêu mỏng, Trọng lượng nhẹ<br>•Vỏ Polycarbonate giúp bảo vệ iPhone tuyệt vời <br>•Hỗ trợ công nghệ sạc không dây QI<br>•Hoạt động với tất cả các đế sạc Oakywood<br><br>ĐẸP & PHONG CÁCH<br>Được làm thủ công bằng gỗ óc chó hoặc gỗ anh đào nguyên khối do bạn lựa chọn. Được đánh bóng bằng tay để đạt được độ bóng', NULL, '2023-04-13 12:06:33', 4, 8, 1, 0);
INSERT INTO `product` VALUES (60, 'Ốp lưng iphone thủ công bằng gỗ có đệm cao su ', 'Ốp lưng iPhone bằng gỗ thủ công thẩm mỹ & Vỏ gỗ cho Samsung<br><br>Vỏ điện thoại bằng gỗ + nhựa vàng của chúng tôi là sự lựa chọn hoàn hảo vì phong cách và sự độc đáo. Lấy cảm hứng từ vẻ đẹp của trái đất, nó giúp bạn cảm thấy thoải mái và đặc biệt hơn. Mỗi chiếc ốp điện thoại đều được làm từ gỗ tự nhiên, vì vậy bạn có thể chắc chắn rằng bạn sẽ có được một thiết kế độc đáo và duy nhất trên thế giới.<br><br>THỦ CÔNG- Được làm thủ công tại Litva, sử dụng những vật liệu tốt nhất.<br>GỖ TỰ NHIÊN- Gỗ đã qua xử lý có tuổi thọ cao và chống nước, mỡ và bùn.<br>BẢO VỆ - Vỏ bảo vệ cản làm từ cao su mềm đặc biệt (TPU) – bảo vệ tuyệt vời khỏi hư hỏng. Viền nhô cao để bảo vệ màn hình thêm.<br>THIẾT KẾ SANG TRỌNG ĐỘC ĐÁO- Ốp lưng làm cho điện thoại trông nguyên bản, khác thường và thanh lịch hơn.', NULL, '2023-04-13 12:06:33', 4, 8, 1, 0);
INSERT INTO `product` VALUES (61, 'Tranh sơn mài – Làng quê Viet Nam', 'Đồng quê Việt Nam với con Trâu - Tranh sơn mài nghệ thuật Việt Nam Tranh trang trí tường nghệ thuật Tranh sơn mài khảm vỏ trứng<br><br>✅Kích thước: 30 cm (Cao) x 20 cm (Rộng) <br> (12 inch x 7.8 inch)<br>✅ Nhà sản xuất: Nghệ nhân Việt Nam<br>✅Chất liệu: Gỗ, Sơn mài khảm vỏ trứng, vỏ sò, cát.<br>✅Tình trạng: Mới', NULL, '2023-04-13 12:06:33', 4, 15, 1, 0);
INSERT INTO `product` VALUES (62, 'Tranh vải – tranh hoa vàng', 'Nhấp để biết thêm chi tiết về các bức tranh chúng tôi cung cấp!<br>Chào mừng chào mừng chào mừng! Aoi Art Team xin chao!<br><br>--- Bạn đang tìm kiếm một bức tranh mang lại cảm giác ấm cúng cho ngôi nhà hoặc không gian văn phòng của bạn? Nếu câu trả lời là có, thì bạn đang ở đúng nơi! Nếu không, chờ đã, nó theo cách này, bạn sắp thấy nó -&gt; Khám phá thêm để tìm tác phẩm nghệ thuật đích thực của bạn với nhiều phong cách tại đây: <a href=\"https://www.etsy.com/shop/AoiGallery\" target=\"_blank\">https://www.etsy.com /shop/AoiGallery</a><br><br>--- Bạn có quan tâm đến TRANH TRÚC TÍCH không? Chúng tôi có thêm một số bộ sưu tập mỹ thuật tại đây:<br><a href=\"https://www.etsy.com/shop/AoiGallery\" target=\"_blank\">https://www.etsy.com/shop/AoiGallery </a><br><br>Mời các bạn thưởng thức! Giữ sức khỏe và nghệ thuật!<br><br>▷ GIỚI THIỆU VỀ BỨC TRANH NÀY.<br>✔ Người sáng tạo: Nhóm Aoi Gallery<br>✔ Phong cách: Tranh trừu tượng<br>✔ Đóng gói: Cuộn và vận chuyển trong ống đặc.<br> ✔ Họa sĩ: Tranh sơn dầ', NULL, '2023-04-13 12:06:33', 4, 16, 1, 0);
INSERT INTO `product` VALUES (63, 'Tranh vải – tranh đương đại trừu tượng', 'bức tranh vàng bức tranh acrylic trừu tượng trên vải vải canvas lớn nghệ thuật treo tường kết cấu trừu tượng nghệ thuật treo tường bức tranh đương đại trừu tượng <br><br>========================= =====<br><br>1.Về Tranh<br>-Tranh: Tất cả các bức tranh của chúng tôi đều được vẽ tay 100% trên vải với chất liệu acrylic/dầu chất lượng hàng đầu. <br>-Tất cả các bức tranh được thiết kế và vẽ bởi Heidi Guldana. Hầu hết các tác phẩm nghệ thuật là nghệ thuật trừu tượng đương đại. Tất cả các tác phẩm gốc của tôi đều có thể được bán.<br>-Đối với canvas cuộn, chúng tôi sẽ để lại THÊM 2-3 inch viền trắng trên bốn mặt của bức tranh để kéo căng hoặc đóng khung.<br>-Phong cách: Nghệ thuật trừu tượng đương đại<br>-Đây bức tranh sơn dầu ban đầu đã được bán hết. Nếu bạn thích, chúng ta có thể vẽ cùng một tác phẩm nghệ thuật với tông màu, hình dạng và chi tiết tương tự.<br>- Thông thường, tất cả các tác phẩm nghệ thuật của chúng tôi đều không có chữ ký. Nhưng nếu bạn cần ký, vui lòng để lại tin nhắn khi b', NULL, '2023-04-13 12:06:33', 4, 16, 1, 0);
INSERT INTO `product` VALUES (64, 'Tranh sơn dầu – Tranh nghệ thuật', 'nghệ thuật treo tường canvas trừu tượng, tranh sơn dầu trừu tượng gốc, tranh hoa, nghệ thuật trừu tượng cực lớn, tranh treo tường hoa trừu tượng khổ lớn<br><br><br>1. Giới thiệu về Tranh<br>* Tất cả tranh của chúng tôi đều được vẽ thủ công 100% bằng sơn acrylic hoặc sơn dầu trên canvas.<br>* Đối với tranh canvas cuộn, sẽ có thêm 2-3 inch viền trắng xung quanh tranh để bạn căng hoặc đóng khung . <br>* Tranh của chúng tôi mặc định không có chữ ký, nếu bạn cần chữ ký của họa sĩ, vui lòng ghi chú khi đặt hàng. <br>*Bức tranh gốc này đã được bán hết. Tất cả chúng tôi sơn theo đơn đặt hàng của chúng tôi. Bởi vì tất cả các bức tranh của chúng tôi đều được làm thủ công 100%, mỗi bức tranh có thể có sự khác biệt nhỏ hoặc tinh tế, tức là bức tranh của bạn có thể không hoàn toàn giống với bức tranh trong danh sách của chúng tôi, bởi vì chỉ có máy mới có thể in chính xác như vậy. Nhưng chúng tôi hứa rằng bức tranh mà bạn nhận được sẽ có chất lượng như những gì bạn nhìn thấy trong cửa hàng của chún', NULL, '2023-04-13 12:06:33', 4, 14, 1, 0);
INSERT INTO `product` VALUES (65, 'Bộ bát đĩa gốm sứ thủ công', 'MIỄN PHÍ VẬN CHUYỂN cho các đơn hàng trên 300 EUR / 345 USD<br>Bộ bát đĩa bằng gốm đất nung thủ công nguyên chất và chân thực. Bao gồm một trong những thứ sau:<br><br>Đĩa ăn tối:<br>- 265x20 mm / 10,4x1,0 &quot;<br>- 0,75 kg / 26,5 US oz<br><br>Salad Dĩa: <br>- 220x20 mm / 8,7x0,8 &quot;<br>- 0,65 kg / 22,9 US oz<br><br>19 cm Bát đựng súp hoặc ngũ cốc ăn sáng lớn:<br>- 190x70 mm / 7,5 x2,8 \"<br>- 1,0 l / 33,8 US fl oz<br>- 0,6 kg / 21,2 US oz<br><br>VẬT LIỆU<br>- Đất sét đỏ Latvia<br>- Tráng men không chì<br ><br>Bộ sưu tập TRÁI ĐẤT. Bộ bát đĩa kết nối truyền thống gốm sứ Latvia và thiết kế tối giản của Bắc Âu. Sự đơn giản và đường nét sạch sẽ làm cho bộ sưu tập đồ gốm này trở thành một kiệt tác của thiết kế vượt thời gian. Được tạo ra bởi đội ngũ nghệ nhân của chúng tôi, để thể hiện tình cảm đối với chất liệu mà chúng tôi đang làm việc - đất sét đỏ của Latvia.<br><br>Bên ngoài không tráng men, chỉ làm phẳng và đánh bóng kỹ lưỡng để lộ ra độ mịn của đất sét và ngăn ngừa để hấp thụ nước', NULL, '2023-04-13 12:06:33', 4, 11, 1, 0);
INSERT INTO `product` VALUES (66, 'Lá gỗ nghệ thuật', 'Bộ đế lót ly bằng gỗ hình chiếc lá. Những chiếc đế lót ly tự nhiên tuyệt đẹp này là những món quà tốt nhất hiện có. Được làm bằng gỗ, những chiếc đế lót ly đồ uống này sẽ bảo vệ bàn của bạn khỏi vết bẩn. Bạn cũng có thể tránh để lại vết thủy tinh ẩm bằng những chiếc đế lót ly bằng gỗ này.<br><br>Những chiếc đế lót ly tùy chỉnh được cá nhân hóa sẽ là món quà tuyệt vời cho bất kỳ sự kiện nào có phục vụ đồ uống! Chúng tạo thêm điểm nhấn độc đáo, được cá nhân hóa cho quầy bar của bạn và phục vụ mục đích thiết thực.<br><br> Nếu bạn cần một món đồ trang trí nhà đẹp sẽ là một điểm nhấn tuyệt vời cho ngôi nhà của bạn, một thứ sẽ bắt đầu cuộc trò chuyện, hãy thu hút sự chú ý và kể một chút về câu chuyện của bạn, thì bộ lót ly này là dành cho bạn. Hãy mua một bộ cho chính bạn hoặc lấy một bộ làm quà tặng cho món đồ cá nhân sẽ được trưng bày trong nhiều năm tới.<br>Đế lót ly bằng gỗ cá nhân hóa của chúng tôi được sản xuất tại Porto, Bồ Đào Nha. <br>Những chiếc đế lót ly thủ công này có đường kính', NULL, '2023-04-13 12:06:33', 4, 7, 1, 0);
INSERT INTO `product` VALUES (67, 'Bộ đĩa gốm thủ công', '6 Đĩa Hòa Bình Trong 1 Bộ | Đĩa Tráng Miệng | Dĩa Ăn Tối | Bộ đồ ăn thủ công<br><br>Mỗi chiếc đĩa đều được làm thủ công/thủ công và có những đặc điểm riêng, rất vui vì có chất lượng gốm cao cấp. <br>Đĩa gốm làm đồ dùng nhà bếp thủ công, được trang trí bằng men an toàn thực phẩm, phù hợp cho bữa sáng, bữa trưa và bữa tối.<br>Đĩa đất sét thủ công với thiết kế độc đáo là món quà hoàn hảo cho bạn bè, thành viên gia đình hoặc người đặc biệt ! <br><br>?Số đo<br><br>Khoảng 21 cm (8,2 inch)<br><br><br>?Chăm sóc<br><br>Để làm nóng lò với nhiệt độ tối đa là 120°C/ 248°F được khuyến nghị. <br>Bạn thậm chí có thể sử dụng nó trong lò nướng để hâm nóng bữa ăn của mình. <br>Nó phù hợp để rửa tay.', NULL, '2023-04-13 12:06:33', 4, 14, 1, 0);
INSERT INTO `product` VALUES (68, 'Đèn bàn bằng gốm thủ công', 'Zen và thanh thản mang đèn bàn này trong nhà của bạn. Làm thủ công và sơn thủ công bằng tình yêu và cẩn thận.<br>Cạnh dưới của rèm vải lanh rộng 38 cm. Chiều cao của đèn là 59 cm.\r\nZen và thanh thản mang đèn bàn này trong nhà của bạn. Làm thủ công và sơn thủ công bằng tình yêu và cẩn thận.<br>Cạnh dưới của rèm vải lanh rộng 38 cm. Chiều cao của đèn là 59 cm.\r\nZen và thanh thản mang đèn bàn này trong nhà của bạn. Làm thủ công và sơn thủ công bằng tình yêu và cẩn thận.<br>Cạnh dưới của rèm vải lanh rộng 38 cm. Chiều cao của đèn là 59 cm.\r\nZen và thanh thản mang đèn bàn này trong nhà của bạn. Làm thủ công và sơn thủ công bằng tình yêu và cẩn thận.<br>Cạnh dưới của rèm vải lanh rộng 38 cm. Chiều cao của đèn là 59 cm.\r\nZen và thanh thản mang đèn bàn này trong nhà của bạn. Làm thủ công và sơn thủ công bằng tình yêu và cẩn thận.<br>Cạnh dưới của rèm vải lanh rộng 38 cm. Chiều cao của đèn là 59 cm.', NULL, '2023-04-13 12:06:33', 4, 12, 1, 0);
INSERT INTO `product` VALUES (69, 'Đèn bàn bằng gốm – Đèn phòng ngủ', 'Mademoiselle cho không gian nhỏ. Ánh sáng mềm mại và dịu dàng. Tâm trạng tự nhiên. Chụp đèn vẽ tay.<br>Chiều cao của đèn là 39 cm. Cạnh dưới của bóng râm rộng 27 cm.', NULL, '2023-04-13 12:06:33', 4, 9, 1, 0);
INSERT INTO `product` VALUES (70, 'Đèn gốm – Đèn đá điêu khắc trừu tượng', 'Đèn gốm điêu khắc trừu tượng<br><br>Vật liệu: Đất sét đá, vải lanh, đồng thau chưa hoàn thành<br><br>Kích thước (bao gồm đầu chụp đèn): H: 20,8\" W: 13\" D: 13\" <br><br> Đèn này được vận chuyển cùng với ổ cắm đèn E27 có công tắc bật tắt và cáp 60 inch (1,5 mét)<br><br>Bạn có thể chọn loại phích cắm ở bước thêm sản phẩm vào giỏ hàng (Mỹ/EU/Anh /AUS)<br><br>Tôi đã chế tác món đồ này trên bàn làm việc bằng gốm nhỏ của mình bằng cách sử dụng đất sét đồ đá, loại đất phù hợp để nung ở nhiệt độ cao, hoàn toàn sử dụng các kỹ thuật tạo hình thủ công. <br><br>Sau khi hoàn thành quy trình làm khô chậm Sau quá trình tạo hình, lần nung đầu tiên được thực hiện ở 900°C, sau đó, quá trình nung lần cuối được thực hiện ở 1200°C.', NULL, '2023-04-13 12:06:33', 4, 9, 1, 0);
INSERT INTO `product` VALUES (71, 'Trang sức thủ công – Mặc dây chuyền bằng đá thủ cô', 'Thiết kế thủ công độc đáo <br>Bạc và bê tông <br>Bộ bông tai và mặt dây chuyền với dây chuyền<br>Màu sắc : sơn trắng và vàng<br><br>Kích thước mặt dây chuyền : L 2,5 x W 2,5 x H 0,4<br>Kích thước bông tai : Dài 1,6 x Rộng 1,6 x Cao 0,4<br>Dây chuyền bạc 925 : 46 cm<br><br>Mỗi bông tai và/hoặc mặt dây chuyền là duy nhất và được làm thủ công (Chúng tôi tạo khuôn riêng). Do đó, tất cả chúng đều hơi khác nhau và chúng có thể có bọt khí. Mỗi mảnh được làm chống thấm nước với một lớp phủ và đánh vecni. Móc nhỏ của mặt dây chuyền bằng bạc 925 hoặc 950. <br><br>Lấy cảm hứng từ... <br>Mặt dây chuyền này có hoa văn dân tộc Tà Ôi, một bộ tộc địa phương của Việt Nam sống ở miền Trung Việt Nam, gần biên giới Lào. Cảm hứng này đến từ chuyến đi xe máy của chúng tôi đến đó vào tháng 9 năm 2019 và những ngôi nhà sàn mà chúng tôi đi qua dọc theo đường mòn Hồ Chí Minh từ Huế đến Đồng Hới.', NULL, '2023-04-13 12:06:33', 4, 13, 1, 0);
INSERT INTO `product` VALUES (72, 'Trang sức thủ công – Mặc dây chuyền hình học', 'tất cả chúng đều hơi khác nhau và chúng có thể có bọt khí. Mỗi mảnh được làm chống thấm nước với một lớp phủ và đánh vecni. Móc treo mặt dây chuyền nhỏ bằng bạc 925 hoặc 950. <br><br>Lấy cảm hứng từ... <br>Mặt dây chuyền này có hoa văn dân tộc Mường, một bộ tộc địa phương sống ở miền Bắc Việt Nam, phía Nam Hà Nội, thủ đô của đất nước. Cảm hứng này đến từ những chuyến đi khắp các tỉnh đó, khi chúng tôi sống ở Hà Nội.', NULL, '2023-04-13 12:06:33', 4, 13, 1, 0);
INSERT INTO `product` VALUES (73, 'Trang sức thủ công – Dây chuyền nghệ thuật', 'Vui lòng thêm mã phiếu giảm giá:SPECIALDISCOUNT15 tại trang thanh toán.Nhận 15OFF, không giới hạn số lượng đơn đặt hàng. Nó được áp dụng cho tất cả các mặt hàng.(ngoại trừ larimar giải phóng mặt bằng)<br>(Đơn hàng: 100 đô la tiết kiệm 15 đô la; 200 đô la tiết kiệm 30 đô la ;$300 tiết kiệm $45)<br>Số lượng đặt hàng trên $300 , vui lòng liên hệ với tôi để biết giá bán buôn. :)<br> <br>-Kích thước:13X23,9X9,9mm<br>Trọng lượng: 5,68g<br>-Đây là sản phẩm Larimar 100% màu tự nhiên, độc nhất vô nhị từ Cộng hòa Dominica. <br>-Chất lượng: -(AAA--Bình thường) (AAAA--Tốt) (5A-Chất lượng tốt nhất) (6A--Chất lượng hàng đầu) (7A--Chất lượng sưu tầm) <br> <br><br>-Trên cả ảnh là phần chính xác mà bạn sẽ nhận được sau khi hoàn tất đơn đặt hàng của mình.<br><br>-Chúng tôi có nhà máy ở Barahona, Cộng hòa Dominica và Quảng Đông Trung Quốc, Chúng tôi chấp nhận tất cả các loại đơn đặt hàng tùy chỉnh. <br><br>-Tất cả Vận chuyển bằng dịch vụ International Express Air có thể đến trong khoảng 2 tuần. Không áp ', NULL, '2023-04-13 12:06:33', 4, 13, 1, 0);
INSERT INTO `product` VALUES (74, 'Trang sức thủ công – Mặc dây chuyền may mắn', 'Mặt dây chuyền vầng hào quang này sẽ biến diện mạo của bạn lên một tầm cao mới. Với đá tanzanite cao cấp, mặt dây chuyền này trông giống như một tác phẩm nghệ thuật có thể đeo được. Những viên kim cương được đặt theo kiểu tia nắng tạo thêm độ lấp lánh, thu hút mọi ánh nhìn. Hãy đeo mặt dây chuyền này trong một sự kiện sắp tới và tạo nên một tuyên bố về thời trang và phong cách.<br><br><br>Loại mặt dây chuyền Halo Drop<br><br>Kim loại Vàng hồng 14K<br><br>Chiều cao 17 mm<br <br>Trọng lượng xấp xỉ 1 gam<br><br>Thông tin về đá tanzanite<br><br>Số lượng (các) Tanzanite hình bát giác 1<br><br>Tổng trọng lượng tối thiểu (ct. tw) 1,20<br><br><br> br>Kích thước tối thiểu 7x5 mm<br><br>Màu trung bình Xanh tím<br><br>Độ trong trung bình Làm sạch mắt<br><br>Tăng cường nhiệt<br><br>Loại cài đặt Ngạnh<br><br>< br><br>Thông tin về kim cương<br><br>Số lượng Viên kim cương tròn 18<br><br>Tổng trọng lượng Carat tối thiểu (ct. tw) 0,18<br><br>Kích thước tối thiểu 1,3 mm<br> <br>Màu trắng trung bình<br><', NULL, '2023-04-13 12:06:33', 4, 13, 1, 0);
INSERT INTO `product` VALUES (75, 'Trang sức thủ công – Bộ bông tai mặc dây chuyền đá', 'Thiết kế thủ công độc đáo <br>Bạc và bê tông <br>Bộ bông tai và mặt dây chuyền bạc<br>Màu sắc : xanh nước & vàng lá giả<br><br>Kích thước mặt dây chuyền : L 2.5 x W 2.5 x H 0.4<br> >Kích thước bông tai : L 1,6 x W 1,6 x H 0,4<br>Dây chuyền bạc 925 : 43-46 cm<br><br>Mỗi bông tai và/hoặc mặt dây chuyền là duy nhất và được làm thủ công (Chúng tôi tạo khuôn riêng). Do đó, tất cả chúng đều hơi khác nhau và chúng có thể có bọt khí. Mỗi mảnh được làm chống thấm nước với một lớp phủ và đánh vecni. Dây chuyền và chiếc lá bằng bạc 925 và móc treo bằng bạc 950. <br><br>Lấy cảm hứng từ... <br>Mặt dây chuyền này có hoa văn dân tộc Tà Ôi, một bộ tộc địa phương của Việt Nam sống ở miền Trung Việt Nam, gần đến biên giới Lào. Cảm hứng này đến từ chuyến đi xe máy của chúng tôi đến đó vào tháng 9 năm 2019 và những ngôi nhà sàn mà chúng tôi đi qua dọc theo đường mòn Hồ Chí Minh từ Huế đến Đồng Hới. <br><br>Chăm sóc...<br>Bởi vì các hình chạm khắc mỏng và kích thước của mặt dây chuyền nhỏ nên nó phải được ', NULL, '2023-04-13 12:06:33', 4, 13, 1, 0);
INSERT INTO `product` VALUES (76, 'Trang sức thủ công – Vòng cổ đá may mắn', 'Mặt dây chuyền tròn bằng bê tông với dây chuyền hình con rắn màu vàng 43 cm (17 inch). <br><br>Mặt dây chuyền hình tròn trên dây chuyền con rắn màu vàng. ♥<br><br>Biến thể: <br>-Xám nhạt với sơn vàng<br>-Xám đậm với sơn vàng<br>-Xanh bạc hà với sơn vàng<br>- Xanh dương với sơn vàng<br>-v.v.< br><br>Nếu bạn không thích sơn vàng, vui lòng ghi chú cho tôi. <br><br>Mặt dây chuyền được làm bằng bê tông tốt. <br><br>Kích thước: 25 mm<br><br>Kích thước vòng cổ màu vàng: 43 cm (17 inch)<br><br>♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥<br><br>Một món quà hoàn hảo để tặng mẹ hoặc bạn gái hoặc vợ của bạn trong bất kỳ dịp đặc biệt nào, đặc biệt là Giáng sinh! ♥<br><br>Bọt khí, kết cấu và màu sắc có thể hơi khác một chút.<br><br>Bề mặt của trang sức được xử lý bằng sơn mài để bảo vệ trang sức.<br>Tuy nhiên, vui lòng bảo vệ khỏi nước hoặc bất kỳ chất lỏng hóa học nào.<br> br><br>Được sản xuất tại Studio của chúng tôi ở Hungary.', NULL, '2023-04-13 12:06:33', 4, 13, 1, 0);
INSERT INTO `product` VALUES (77, 'Mô hình thủ công – Máy bay trực thăng UH-60', 'Máy bay trực thăng UH-60 Black Hawk, Mô hình máy bay trực thăng bằng gỗ thủ công, Lực lượng quân sự, kỷ vật, quà tặng cho phi công hoặc thêm vào bộ sưu tập của bạn<br>---------------------- -----------------<br><br>Mẫu Trực Thăng UH-60 Black Hawk tuyệt đẹp làm thủ công từ gỗ gụ. Đã hoàn thành và sẵn sàng giao hàng.<br>Độ bóng cao cho thấy vẻ đẹp của vân gỗ và tất cả các chi tiết tinh xảo<br>Mô hình thủ công có thể khác một chút về màu sắc<br>Mô hình gỗ độc đáo làm quà tặng cho người thân, quà tặng cho phi công, kỷ vật hoặc thêm vào bộ sưu tập của bạn<br><br>Kích thước: L22.5&quot; x W20.5&quot; x H8.5&quot; (bao gồm giá đỡ)<br><br>* TÙY CHỌN KHẮC (+10$)<br>- Bạn có thể cá nhân hóa món quà của mình bằng cách KHẮC, chỉ cần để lại lời nhắn cho chúng tôi về những gì bạn muốn khắc trên mô hình (1 - 15 ký tự)', NULL, '2023-04-13 12:06:33', 4, 4, 1, 0);
INSERT INTO `product` VALUES (78, 'Mô hình thủ công – Máy bay F-100 supper sabre', 'F-100 SUPER SABER tuyệt đẹp được làm thủ công từ gỗ gụ. Đã hoàn thành và sẵn sàng vận chuyển.<br>Lớp hoàn thiện có độ bóng cao cho thấy vẻ đẹp của thớ gỗ và tất cả các chi tiết tinh xảo<br>Mô hình thủ công có thể khác một chút về màu sắc<br>Một món quà mô hình bằng gỗ độc đáo cho người thân của bạn, quà tặng cho phi công, kỷ vật hoặc thêm vào bộ sưu tập của bạn<br><br>Kích thước: L16&quot; x W14&quot; x H7&quot; (bao gồm giá đỡ)<br><br>* TÙY CHỌN KHẮC (+10$)<br>- Bạn có thể cá nhân hóa món quà của mình bằng cách KHẮC, chỉ cần để lại lời nhắn cho chúng tôi về những gì bạn muốn khắc trên mô hình (1 - 15 ký tự)', NULL, '2023-04-13 12:06:33', 4, 4, 1, 0);
INSERT INTO `product` VALUES (79, 'Mô hình thủ công – Mô hình máy bay bằng gỗ', 'Baby Groot được in 3D và vẽ tay lấy cảm hứng từ Guardians Of The Galaxy. Được làm từ nhựa PLA, sau đó được đánh bóng và sơn bằng tay.<br><br>Ưu đãi!!! Hiện đang giảm giá 40%<br>!!<br><br>Việc gửi bưu điện quốc tế vẫn còn chậm trễ nên cuối cùng họ vẫn hoàn thành công việc.', NULL, '2023-04-13 12:06:33', 4, 4, 1, 0);
INSERT INTO `product` VALUES (80, 'Mô hình thủ công – Mô hình xe hơi bằng gỗ', 'Cản phẳng 4x4 Thủ công Willys Đặc biệt, Quà tặng Năm mới<br><br>Sản phẩm của chúng tôi có thể khác về hoa văn và tông màu so với sản phẩm nhìn thấy trong hình ảnh do cấu trúc tự nhiên của gỗ.<br><br> Bạn có thể yêu cầu trẻ em sơn đồ chơi tự nhiên của chúng tôi, nếu bạn muốn, để các kỹ năng vận động của họ sẽ tăng lên.<br><br>Sản phẩm của chúng tôi được sản xuất từ ​​gỗ tự nhiên. Các loài cây mà chúng tôi sử dụng thường bao gồm Cây sồi và Gỗ sồi nguyên khối, không sinh ra vi khuẩn.<br><br>Sau giai đoạn sản xuất sản phẩm, gỗ được cung cấp dầu ô liu tự nhiên. Tuyệt đối không sử dụng vecni hóa học và các chất dẫn xuất tương tự.<br><br>Kích thước sản phẩm L:20 cm W:10 cm H:9 cm<br><br>Sản phẩm của chúng tôi được làm hoàn toàn thủ công dưới bàn tay của những người thợ lành nghề. Nó không phải là chế tạo.<br><br>Mỗi đồ chơi hoặc đồ vật đều có một câu chuyện sản xuất và mỗi sản phẩm của chúng tôi đều độc đáo theo cách riêng.<br><br><br>\"Xin lưu ý, các đơn đặt hàng có thể khác nhau về hình thức', NULL, '2023-04-13 12:06:33', 4, 4, 1, 0);
INSERT INTO `product` VALUES (81, 'Mô hình thủ công - Mô hình xe Camaro 1969', 'Được làm thủ công tuyệt đẹp từ gỗ Mahogany nguyên khối<br>Được làm bằng Máy tiện gỗ, chạm khắc và đánh bóng bằng tay<br>Lớp hoàn thiện có độ bóng cao cho thấy các vân gỗ phong phú<br>Các mẫu sản phẩm thủ công có thể hơi khác một chút về màu sắc', NULL, '2023-04-13 12:06:33', 4, 4, 1, 0);
INSERT INTO `product` VALUES (82, 'Mô hình thủ công – Mô hình xe máy Harley W', 'Wood Art USA đã thực hiện mục này với sự giúp đỡ của Wood Artist, Jacksonville, FL', NULL, '2023-04-13 12:06:33', 4, 4, 1, 0);
INSERT INTO `product` VALUES (83, 'Mô hình thủ công – Mô hình xe tay ga bằng gỗ', 'CÔNG TY MÔ HÌNH BẰNG GỖ<br><br>...QUÀ TẶNG...<br><br>Mô hình Xe trượt Scooter bằng gỗ trên giá để bàn.<br><br>MÔ HÌNH MÁY TÍNH ĐỂ BÀN SAO<br><br>Chạm khắc bằng tay tuyệt đẹp mô hình bản sao của Xe tay ga.<br><br><br><br>Mô hình được lắp ráp hoàn chỉnh - không cần dùng keo dán!!<br><br><br>Mô hình bản sao này sẽ là một món quà, cúp hoặc phần trình bày tuyệt vời cái.<br><br>Kích thước gần đúng<br><br>Chiều dài: 21 cm<br><br>Chiều cao: 13 cm<br><br>Chiều rộng: 8cm<br><br>BẠN CÓ THỂ THÊM SỐ ĐIỆN THOẠI NHƯ THẾ NÀY LÀ BẮT BUỘC CHO NGƯỜI CHUYỂN PHÁT NHANH.', NULL, '2023-04-13 12:06:33', 4, 4, 1, 0);
INSERT INTO `product` VALUES (84, 'Mô hình thủ công – Mô hình ô tô bằng gỗ ', 'Được làm thủ công tuyệt đẹp từ gỗ Mahogany nguyên khối<br>Được làm bằng Máy tiện gỗ, chạm khắc và đánh bóng bằng tay<br>Lớp hoàn thiện có độ bóng cao cho thấy các vân gỗ phong phú<br>Các mẫu sản phẩm thủ công có thể hơi khác một chút về màu sắc', NULL, '2023-04-13 12:06:33', 4, 4, 1, 0);
INSERT INTO `product` VALUES (85, 'Mô hình thủ công – Mô hình xe hơi trang trí bằng g', 'Đồ trang trí ô tô cổ điển thủ công, Đồ chơi ô tô bằng gỗ, Trang trí kệ bàn làm việc tại nhà, Quà tặng cho những người yêu thích ô tô<br><br>Chào mừng bạn đến với LovePeaceWood<br>?Thêm nét tự nhiên vào ngôi nhà xinh xắn của bạn với những đồ thủ công bằng gỗ này   <br>< br>Đồ chơi ô tô bằng gỗ<br>● Ô tô bằng gỗ thủ công<br>● Ô tô theo phong cách cổ điển/Trang trại/Mộc mạc<br>● Trang trí phòng cho trẻ mới biết đi/ Cậu bé lớn<br>● Món quà Giáng sinh hoặc quà sinh nhật hoàn hảo cho trẻ em, con trai, bạn trai< br><br>Kích thước:<br>Như trong ảnh<br><br>Gói hàng bao gồm:<br>1 x xe gỗ<br><br>Liên hệ với tôi nếu bạn có bất kỳ câu hỏi nào❤️<br ><br>VẬN CHUYỂN:<br>Thời gian xử lý: 2-7 ngày. .<br>Thời gian vận chuyển: 7-12 ngày làm việc tới Mỹ, 6-10 ngày làm việc tới Châu Âu.', NULL, '2023-04-13 12:06:33', 4, 4, 1, 0);
INSERT INTO `product` VALUES (86, 'Mô hình đồ chơi xe lửa bằng gỗ thủ công', 'Đồ chơi tàu hỏa bằng gỗ, Mô hình tàu hỏa cổ điển, Đồ trang trí bằng gỗ thủ công, Trang trí kệ để bàn, Quà tặng Giáng sinh cho trẻ em, bé trai<br><br>Chào mừng bạn đến với LovePeaceWood<br>?Thêm nét tự nhiên vào ngôi nhà thân yêu của bạn với những món đồ thủ công bằng gỗ này   < br><br>Xin lưu ý rằng các bánh xe không thể lăn<br><br>Đồ chơi tàu hỏa bằng gỗ<br>● Tàu hỏa bằng gỗ thủ công<br>● Tàu hỏa theo phong cách Cổ điển/Trang trại/Mộc mạc<br>● Trẻ mới biết đi/ Cậu bé lớn trang trí phòng<br>● Món quà Giáng sinh hoặc quà sinh nhật hoàn hảo cho trẻ em, con trai, bạn trai<br><br>Kích thước:<br>Như trong ảnh<br><br>Bao gồm những gì:<br>1 tàu gỗ x<br><br>Liên hệ với tôi nếu bạn có bất kỳ câu hỏi nào❤️<br><br>VẬN CHUYỂN:<br>Thời gian xử lý: 2-7 ngày. .<br>Thời gian vận chuyển: 7-12 ngày làm việc tới Mỹ, 6-10 ngày làm việc tới Châu Âu.', NULL, '2023-04-13 12:06:33', 4, 4, 1, 0);
INSERT INTO `product` VALUES (87, 'Cốc trà gốm – Cốc cà phê ốc sên', 'Dung tích:<br>360ml<br><br>Cốc chạm khắc với bề mặt gốm lốm đốm toàn bộ, hoàn hảo để thưởng thức một tách trà với cảm giác ấm cúng. Sinh vật bằng gốm ở phần đế bên trong mang đến khoảnh khắc nhìn lén vui vẻ.<br><br><br>- An toàn với máy rửa chén<br>- An toàn với lò vi sóng; không an toàn với lò nướng', NULL, '2023-04-13 12:06:33', 4, 11, 1, 0);
INSERT INTO `product` VALUES (88, 'Bộ cốc đĩa cà phê bằng gốm thủ công', 'Bộ cốc và đĩa gốm hoa thủ công, cốc cà phê độc đáo, cốc cà phê, bộ cà phê gốm, bộ trà gốm hoa. Những bức tranh này được vẽ bằng tay nên hình in có thể khác một chút so với những bức tranh phía trên.<br><br><br>Hãy biến ngôi nhà của bạn phản ánh cá tính của bạn. Hãy thử bộ cốc thủ công này để có thêm điểm nhấn. Một bổ sung đầy màu sắc cho bất kỳ ngôi nhà nào, những bộ cốc này cũng có thể là một món quà chu đáo cho bạn bè và gia đình của bạn. <br><br><br>?☕️????<br>➤ Làm bằng gốm sứ. <br>➤ CHẮC CHẮN & BỀN: Được thiết kế với cấu trúc gốm chắc chắn, làm bằng gốm chất lượng cao, không chứa chì. Thích hợp cho đồ uống nóng và lạnh. <br>➤ Dễ dàng vệ sinh. An toàn với máy rửa chén, lò vi sóng và lò nướng.<br>➤ Kích thước: 300ml<br>➤ Thân thiện với thú cưng ?????<br><br> **** Đã sử dụng mã khuyến mại 10OFFTHREEE khi bạn mua 3 cái trở lên để được giảm 10%* ***<br><br>Chúng tôi là một nhóm nghệ sĩ cung cấp sự kết hợp đáng yêu giữa thảm tùy chỉnh và đồ trang trí nhà ở với giá cả phải chăng. Xưởng t', NULL, '2023-04-13 12:06:33', 4, 11, 1, 0);
INSERT INTO `product` VALUES (89, 'Cốc cà phê bằng gốm vẽ tay', 'Bộ cốc và đĩa gốm Vẽ tay!<br>Kích thước cốc: Cao 7 cm x rộng 13 cm<br>Đĩa: 15,5 cm<br><br>Có họa tiết kẻ sọc, hoa hoặc đám mây<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br br>*không trả lại hoặc hoàn lại tiền, tia', NULL, '2023-04-13 12:06:33', 4, 11, 1, 0);
INSERT INTO `product` VALUES (90, ' Cốc cà phê vẽ tay – Cốc gốm dễ thương', 'Những chiếc cốc ấm cúng này rất phù hợp cho những lần uống cà phê/trà của bạn. Chúng cũng là những món quà Giáng sinh, sinh nhật và tân gia hoàn hảo cho những người thân yêu của bạn!<br><br><br>An toàn với lò vi sóng<br><br>Đặc tính: Thân thiện với môi trường<br>Chất liệu: Gốm <br>Loại gốm: Sứ <br><br>-Do ảnh hưởng của dịch Covid-19, chúng tôi không chấp nhận trả lại hàng-<br><br>-nếu bạn nhận được một mặt hàng không chính xác hoặc bị hư hỏng, vui lòng liên hệ với chúng tôi để được hỗ trợ. Chúng tôi chỉ gửi hàng thay thế cho những mặt hàng bị lỗi.-<br><br>Cốc hồng, Cốc hoa, Cốc dễ thương, Cốc quà tặng, Cốc thủ công, Cốc vẽ tay', NULL, '2023-04-13 12:06:33', 4, 11, 1, 0);
INSERT INTO `product` VALUES (91, 'Cốc gốm – Cốc trái cây mùa hè', 'Thông tin chi tiết:<br>• Chất liệu: sứ cao cấp không chứa chì, dễ vệ sinh và bảo quản.<br>• Tay cầm và thân tráng men màu cao cấp, đáy không tráng men chống trơn trượt<br>• Thể tích: 400ml<br>• Kích thước: Chiều cao 10 cm, chiều rộng 8 cm không có tay cầm<br>• An toàn với lò vi sóng và máy rửa chén<br>• Có thể dùng làm cốc cà phê, cốc trà, cốc sữa hoặc thậm chí là cốc ngũ cốc và súp<br>⦁ Xin lưu ý rằng các màu sắc trong hình ảnh có thể hơi khác so với những gì bạn thấy trong hình.', NULL, '2023-04-13 12:06:33', 4, 11, 1, 0);
INSERT INTO `product` VALUES (92, 'Tách trà và đĩa phong cách Phần Lan', 'Ả Rập Phần Lan ARCTICA PUDAS tách trà & đĩa<br><br>Trang trí của Pudas mô tả một nhánh sông. Nó có hai màu xanh lam khác nhau trên nền trắng.<br><br>Thiết kế bởi Inkeri Leivo, mẫu và hoa văn.<br><br>Sản xuất: 1981-1987<br><br>KÍCH THƯỚC<br>cúp: cao 6 ,5 cm, đường kính 9 cm<br>đĩa: đường kính 16,2 cm<br><br><br>CHẤT LIỆU:<br>Sứ Vitro<br><br>TÌNH TRẠNG: 5/5<br>Vui lòng xem kỹ sản phẩm hình ảnh trước khi mua hàng.<br><br>*PHÂN LOẠI<br>MINT <br>Các mặt hàng chưa được sử dụng.<br><br>5 <br>Các mặt hàng gần như chưa sử dụng.<br>Những vết trầy xước nhỏ đến mức chúng không nhìn thấy được trong ảnh hoặc video.<br>Có thể nhìn thấy các vết trầy xước bằng nguồn sáng.<br>Không có khuyết tật.<br><br>4 <br>Các mặt hàng đã qua sử dụng.<br>Có thể có các vết trầy xước nhỏ có thể nhìn thấy trong ảnh hoặc video.<br>Không có lỗi.<br><br>3 <br>Các mặt hàng hơi cũ.<br>Có thể nhìn thấy một số vết xước sâu trong ảnh hoặc video<br>Không có lỗi.< br> <br>2 <br>Các mặt hàng đã bị mòn.<br>Các khuyết tật nhỏ như vế', NULL, '2023-04-13 12:06:33', 4, 11, 1, 0);
INSERT INTO `product` VALUES (93, 'Bộ cốc đĩa cà phê bằng gốm', 'Các mặt hàng đã qua sử dụng.<br>Các mặt hàng có vết trầy xước nhỏ mà chúng có thể nhìn thấy trong ảnh hoặc video.<br>Không có khuyết tật.<br><br>3 <br>Các mặt hàng bị mòn nhẹ.<br>Có một số vết xước sâu có thể nhìn thấy trong ảnh hoặc video<br>Không có lỗi.<br><br>2 <br>Các mặt hàng đã cũ.<br>Các lỗi nhỏ như vết nứt, vết bẩn, sứt mẻ, vết nứt.<br><br> SỰ THẬT . TÌM KIẾM<br>Các mặt hàng thậm chí có thể đã sờn rách nhưng chúng là những mặt hàng hiếm và được các nhà sưu tập ưa chuộng.<br><br>Vì sản phẩm đã qua sử dụng nên có thể chấp nhận một vài vết trầy xước nhỏ. Các dấu hiệu sử dụng là rất nhiều đảm bảo rằng các sản phẩm là chính hãng. Xin lưu ý rằng đây là những mặt hàng cổ điển mang dấu ấn của quá trình sản xuất trong thời gian đó. Dấu sàn bên dưới các tấm.<br><br>*ĐÓNG GÓI VÀ VẬN CHUYỂN<br>Chúng tôi luôn đóng gói các mặt hàng rất cẩn thận bằng vật liệu tái chế. Chúng tôi vận chuyển trên toàn thế giới từ Phần Lan bằng Posti của Phần Lan. Chúng tôi đã thương lượng chi phí vận chuyển rẻ ', NULL, '2023-04-13 12:06:33', 4, 11, 1, 0);
INSERT INTO `product` VALUES (94, 'Bộ cốc và đĩa uống trà cổ điển', 'Một chiếc thớt cá nhân hóa là một cách tuyệt vời để thể hiện cá tính của bạn trong trang trí nhà bếp. Với rất nhiều thiết kế thú vị và độc đáo để lựa chọn<br><br>Những chiếc thớt cá nhân hóa của chúng tôi, có các màu Walnut, Maple và White Oak, có thể được tùy chỉnh làm quà tặng tân gia hoặc bất kỳ dịp đặc biệt nào.<br>Một chiếc thớt cá nhân hóa là lý tưởng cho một món quà tân gia hoặc đám cưới hoặc để kỷ niệm một dịp đặc biệt. Các tùy chọn để tùy chỉnh thớt gỗ bao gồm từ chữ lồng đơn giản đến công thức nấu ăn viết tay và chúng có sẵn ở nhiều chất liệu và kích cỡ khác nhau.<br>Bạn có thể cá nhân hóa bất kỳ sản phẩm nào của chúng tôi bằng cách khắc một thông điệp đặc biệt, ngày tháng hoặc bất kỳ thứ gì khác điều đó sẽ làm cho sản phẩm của bạn thực sự độc đáo. Hoàn hảo cho bất kỳ dịp nào. Tạo của bạn ngay bây giờ chỉ trong vài cú nhấp chuột với các thiết kế đẹp mắt của chúng tôi. <br><br>Với nhiều ứng dụng và tùy chọn có sẵn, thớt, thớt khối và thớt phô mai được cá nhân hóa & chạm khắc c', NULL, '2023-04-13 12:06:33', 4, 11, 1, 0);
INSERT INTO `product` VALUES (95, 'Thớt gỗ - Thớt thủ công nghệ thuật', 'Một chiếc thớt cá nhân hóa là một cách tuyệt vời để thể hiện cá tính của bạn trong trang trí nhà bếp. Với rất nhiều thiết kế thú vị và độc đáo để lựa chọn<br><br>Những chiếc thớt cá nhân hóa của chúng tôi, có các màu Walnut, Maple và White Oak, có thể được tùy chỉnh làm quà tặng tân gia hoặc bất kỳ dịp đặc biệt nào.<br>Một chiếc thớt cá nhân hóa là lý tưởng cho một món quà tân gia hoặc đám cưới hoặc để kỷ niệm một dịp đặc biệt. Các tùy chọn để tùy chỉnh thớt gỗ bao gồm từ chữ lồng đơn giản đến công thức nấu ăn viết tay và chúng có sẵn ở nhiều chất liệu và kích cỡ khác nhau.<br>Bạn có thể cá nhân hóa bất kỳ sản phẩm nào của chúng tôi bằng cách khắc một thông điệp đặc biệt, ngày tháng hoặc bất kỳ thứ gì khác điều đó sẽ làm cho sản phẩm của bạn thực sự độc đáo. Hoàn hảo cho bất kỳ dịp nào. Tạo của bạn ngay bây giờ chỉ trong vài cú nhấp chuột với các thiết kế đẹp mắt của chúng tôi.', NULL, '2023-04-13 12:06:33', 4, 5, 1, 0);
INSERT INTO `product` VALUES (96, 'Thớt gỗ thủ công khắc tên theo yêu cầu', 'l Ả Rập Phần Lan Bộ ba tách trà Aprikoosi. Bộ ba bao gồm một tách trà, đĩa và đĩa bên. Aprikoosi là một từ tiếng Phần Lan và có nghĩa là quả mơ. Người mẫu FC. Người mẫu được thiết kế bởi Kaarina Aho và phần trang trí được thiết kế bởi Esteri Tomula. Những năm sản xuất 1965-1970. Sản xuất tại Phần Lan. <br><br>ĐO LƯỜNG<br>Dung tích: 200 ml<br>Chiều cao: 60 mm (cốc), 20 mm (đĩa)<br>Đường kính: 95 mm (cốc), 135 mm (đĩa), 173 mm ( tấm)<br>Trọng lượng: 500 g<br><br>TÌNH TRẠNG<br>Ở tình trạng cổ điển tốt với các dấu hiệu sử dụng. Bên trong cốc bị sẫm màu một số chỗ (ảnh 6 & 7). Đĩa và đĩa cũng có thể bị sẫm màu. Trên đĩa là một số vết trầy xước. Trên đĩa bánh có nhiều vết trầy xước và cũng có những dấu hiệu khác của quá trình sử dụng. Trên cốc có thể có một khu vực nhẹ hơn do sản xuất (ảnh 5). Nước men sáng bóng. Không bị sứt mẻ, nứt vỡ hay sứt mẻ.<br><br>Trên đĩa và đĩa bánh có tem Ả Rập. Trên cốc không có tem Ả Rập. Con tem đã được dán trên mặt tráng men nên nó đã bong ra khi rửa cốc.<br><', NULL, '2023-04-13 12:06:33', 4, 5, 1, 0);
INSERT INTO `product` VALUES (97, 'Thớt gỗ ô liu', 'Vui lòng chọn kích thước thớt và lựa chọn thiết kế từ trình đơn thả xuống và nhập văn bản bạn muốn khắc lên thớt vào ô bên dưới<br>Vui lòng gửi email hình ảnh của bạn (nếu có) đến etsy@photobookshop.com. Vui lòng bao gồm số thứ tự của bạn.', NULL, '2023-04-13 12:06:33', 4, 5, 1, 0);
INSERT INTO `product` VALUES (98, 'Thớt dài bằng gỗ thủ công', 'Thớt gỗ phục vụ bữa ăn nhẹ, Thớt Charcuterie dài cho bữa tối<br>MADE IN UKRAINE<br><br>Những tấm ván có mái chèo có màu sắc tự nhiên đậm và hình dáng trang nhã giúp bạn trang trí bàn ăn và nhà bếp của mình. Chúng tôi đã tạo bảng của mình để phục vụ và phục vụ phô mai, thịt nguội. Chúng tôi làm nó bằng gỗ sồi tự nhiên không nhuộm. Tấm bảng đẹp mắt sẽ trở thành điểm nhấn hoàn hảo cho bàn lễ hội.<br><br>KÍCH THƯỚC: <br>20x5 inch (49x12 cm)<br><br>MÀU SẮC: <br>✓ Màu nâu nhạt<br> ✓ Màu nâu đậm <br><br>VẬT LIỆU: <br>✓ gỗ sồi chọn lọc<br><br>ƯU ĐIỂM CHÍNH:<br><br> ✓ Gỗ được xử lý bằng dầu và sáp bảo vệ để ngăn ván hấp thụ độ ẩm và mùi thơm của gỗ sản phẩm.<br> ✓ Một món quà thú vị và độc đáo.<br> ✓ Dùng làm thớt, khay, giá để các món ăn nóng.<br><br>CHĂM SÓC BÀN:<br> ✓ Rửa bằng các sản phẩm thân thiện với môi trường, không ngâm nước, lau khô.<br> ✓ Không rửa trong máy rửa chén.<br> ✓ Cấm đổ nước sôi và phơi khô gần nguồn nhiệt.<br><br>CHẾ BIẾN & VẬN CHUYỂN<br><br> Chúng tôi sẽ có thể gửi đơn ', NULL, '2023-04-13 12:06:33', 4, 5, 1, 0);
INSERT INTO `product` VALUES (99, 'Thớt gỗ tròn thủ công', '??? Thớt gỗ thủ công???<br><br>Betelgeuse là một ngôi sao khổng lồ màu đỏ trong chòm sao Orion Chúng tôi đặt tên này cho nhóm sản phẩm này vì tác dụng của nó. Vì nó là một trong những ngôi sao được quan tâm nhiều nhất trên bầu trời nên chúng tôi biết rằng sản phẩm của mình sẽ được đưa vào nhóm được quan tâm nhất cùng với mức độ nhận biết của nó.<br><br>Một trong những ngôi sao may mắn và linh thiêng nhất trên bầu trời, nó hứa hẹn thành công không gặp sự cố trên bảng xếp hạng. Nó mang lại may mắn cho người trên biểu đồ của nó. Chúng tôi tin rằng nhóm sản phẩm được thiết kế đặc biệt này sẽ mang lại may mắn cho bạn.<br><br>?Sản phẩm phù hợp với các diện tích sử dụng khác nhau. Bạn có thể sử dụng nó khi trang trí nhà bếp, trình bày các bữa ăn được chế biến đặc biệt hoặc theo nghĩa đen là một chiếc thớt.<br><br>?Thớt Betelgeuse được làm bằng gỗ óc chó và có dây da để treo.<br> <br> Óc chó thuộc nhóm cây thân gỗ rốn. Nó có một cấu trúc với lỗ chân lông rải rác. Cấu trúc lỗ chân lông hình thà', NULL, '2023-04-13 12:06:33', 4, 5, 1, 0);
INSERT INTO `product` VALUES (100, ' Thớt gỗ sồi', 'Bộ thớt Charcuterie bằng gỗ màu tối được làm thủ công và làm bằng gỗ sồi sẫm màu chắc chắn và bền.<br><br>Thớt có thiết kế thẩm mỹ, hình dáng tối giản và tay cầm chức năng:<br>- thớt tròn có các cạnh vát nhẵn <br >- Thớt dài có thiết kế tròn và các cạnh cong<br>- Thớt bít tết hình chữ nhật với bề mặt cắt sâu để lấy thức ăn lỏng và lạ<br><br>Hoàn hảo như một đĩa phục vụ phô mai, bít tết, thịt, bánh mì, rau, trái cây, đồ ăn nhẹ hoặc chỉ dùng làm thớt.<br>Đó là một ý tưởng quà tặng tuyệt vời cho những dịp đặc biệt.<br><br>Tất cả các loại thớt Charcuterie được làm thủ công từ gỗ sồi có nguồn gốc bền vững tự nhiên.<br><br>Sồi là tốt nhất gỗ có giá trị nổi lên trong thiết kế đồ dùng nhà bếp và đồ nội thất, là loại gỗ tự nhiên, bền vững và hữu cơ.<br>Màu tối, cảm giác ấm áp và bề mặt hữu cơ. <br>Họ cảm thấy rất tốt khi họ nhìn.', NULL, '2023-04-13 12:06:33', 4, 5, 1, 0);

-- ----------------------------
-- Table structure for product_image
-- ----------------------------
DROP TABLE IF EXISTS `product_image`;
CREATE TABLE `product_image`  (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `image_id` int NOT NULL,
  PRIMARY KEY (`product_id`, `image_id`) USING BTREE,
  INDEX `fk_product_image_image`(`image_id` ASC) USING BTREE,
  CONSTRAINT `fk_product_image_image` FOREIGN KEY (`image_id`) REFERENCES `image` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_product_image_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_image
-- ----------------------------
INSERT INTO `product_image` VALUES (1, 1);
INSERT INTO `product_image` VALUES (1, 2);
INSERT INTO `product_image` VALUES (1, 3);
INSERT INTO `product_image` VALUES (1, 4);
INSERT INTO `product_image` VALUES (2, 5);
INSERT INTO `product_image` VALUES (2, 6);
INSERT INTO `product_image` VALUES (2, 7);
INSERT INTO `product_image` VALUES (2, 8);
INSERT INTO `product_image` VALUES (3, 9);
INSERT INTO `product_image` VALUES (3, 10);
INSERT INTO `product_image` VALUES (3, 11);
INSERT INTO `product_image` VALUES (3, 12);
INSERT INTO `product_image` VALUES (4, 13);
INSERT INTO `product_image` VALUES (4, 14);
INSERT INTO `product_image` VALUES (4, 15);
INSERT INTO `product_image` VALUES (4, 16);
INSERT INTO `product_image` VALUES (5, 17);
INSERT INTO `product_image` VALUES (5, 18);
INSERT INTO `product_image` VALUES (5, 19);
INSERT INTO `product_image` VALUES (5, 20);
INSERT INTO `product_image` VALUES (6, 21);
INSERT INTO `product_image` VALUES (6, 22);
INSERT INTO `product_image` VALUES (6, 23);
INSERT INTO `product_image` VALUES (6, 24);
INSERT INTO `product_image` VALUES (7, 25);
INSERT INTO `product_image` VALUES (7, 26);
INSERT INTO `product_image` VALUES (7, 27);
INSERT INTO `product_image` VALUES (7, 28);
INSERT INTO `product_image` VALUES (8, 29);
INSERT INTO `product_image` VALUES (8, 30);
INSERT INTO `product_image` VALUES (8, 31);
INSERT INTO `product_image` VALUES (8, 32);
INSERT INTO `product_image` VALUES (9, 33);
INSERT INTO `product_image` VALUES (9, 34);
INSERT INTO `product_image` VALUES (9, 35);
INSERT INTO `product_image` VALUES (9, 36);
INSERT INTO `product_image` VALUES (10, 37);
INSERT INTO `product_image` VALUES (10, 38);
INSERT INTO `product_image` VALUES (10, 39);
INSERT INTO `product_image` VALUES (10, 40);
INSERT INTO `product_image` VALUES (11, 41);
INSERT INTO `product_image` VALUES (11, 42);
INSERT INTO `product_image` VALUES (11, 43);
INSERT INTO `product_image` VALUES (11, 44);
INSERT INTO `product_image` VALUES (12, 45);
INSERT INTO `product_image` VALUES (12, 46);
INSERT INTO `product_image` VALUES (12, 47);
INSERT INTO `product_image` VALUES (12, 48);
INSERT INTO `product_image` VALUES (13, 49);
INSERT INTO `product_image` VALUES (13, 50);
INSERT INTO `product_image` VALUES (13, 51);
INSERT INTO `product_image` VALUES (13, 52);
INSERT INTO `product_image` VALUES (14, 53);
INSERT INTO `product_image` VALUES (14, 54);
INSERT INTO `product_image` VALUES (14, 55);
INSERT INTO `product_image` VALUES (14, 56);
INSERT INTO `product_image` VALUES (15, 57);
INSERT INTO `product_image` VALUES (15, 58);
INSERT INTO `product_image` VALUES (15, 59);
INSERT INTO `product_image` VALUES (15, 60);
INSERT INTO `product_image` VALUES (16, 61);
INSERT INTO `product_image` VALUES (16, 62);
INSERT INTO `product_image` VALUES (16, 63);
INSERT INTO `product_image` VALUES (16, 64);
INSERT INTO `product_image` VALUES (17, 65);
INSERT INTO `product_image` VALUES (17, 66);
INSERT INTO `product_image` VALUES (17, 67);
INSERT INTO `product_image` VALUES (17, 68);
INSERT INTO `product_image` VALUES (18, 69);
INSERT INTO `product_image` VALUES (18, 70);
INSERT INTO `product_image` VALUES (18, 71);
INSERT INTO `product_image` VALUES (18, 72);
INSERT INTO `product_image` VALUES (19, 73);
INSERT INTO `product_image` VALUES (19, 74);
INSERT INTO `product_image` VALUES (19, 75);
INSERT INTO `product_image` VALUES (19, 76);
INSERT INTO `product_image` VALUES (20, 77);
INSERT INTO `product_image` VALUES (20, 78);
INSERT INTO `product_image` VALUES (20, 79);
INSERT INTO `product_image` VALUES (20, 80);
INSERT INTO `product_image` VALUES (21, 81);
INSERT INTO `product_image` VALUES (21, 82);
INSERT INTO `product_image` VALUES (21, 83);
INSERT INTO `product_image` VALUES (21, 84);
INSERT INTO `product_image` VALUES (22, 85);
INSERT INTO `product_image` VALUES (22, 86);
INSERT INTO `product_image` VALUES (22, 87);
INSERT INTO `product_image` VALUES (22, 88);
INSERT INTO `product_image` VALUES (23, 89);
INSERT INTO `product_image` VALUES (23, 90);
INSERT INTO `product_image` VALUES (23, 91);
INSERT INTO `product_image` VALUES (23, 92);
INSERT INTO `product_image` VALUES (24, 93);
INSERT INTO `product_image` VALUES (24, 94);
INSERT INTO `product_image` VALUES (24, 95);
INSERT INTO `product_image` VALUES (24, 96);
INSERT INTO `product_image` VALUES (25, 97);
INSERT INTO `product_image` VALUES (25, 98);
INSERT INTO `product_image` VALUES (25, 99);
INSERT INTO `product_image` VALUES (25, 100);
INSERT INTO `product_image` VALUES (26, 101);
INSERT INTO `product_image` VALUES (26, 102);
INSERT INTO `product_image` VALUES (26, 103);
INSERT INTO `product_image` VALUES (26, 104);
INSERT INTO `product_image` VALUES (27, 105);
INSERT INTO `product_image` VALUES (27, 106);
INSERT INTO `product_image` VALUES (27, 107);
INSERT INTO `product_image` VALUES (27, 108);
INSERT INTO `product_image` VALUES (28, 109);
INSERT INTO `product_image` VALUES (28, 110);
INSERT INTO `product_image` VALUES (28, 111);
INSERT INTO `product_image` VALUES (28, 112);
INSERT INTO `product_image` VALUES (29, 113);
INSERT INTO `product_image` VALUES (29, 114);
INSERT INTO `product_image` VALUES (29, 115);
INSERT INTO `product_image` VALUES (29, 116);
INSERT INTO `product_image` VALUES (30, 117);
INSERT INTO `product_image` VALUES (30, 118);
INSERT INTO `product_image` VALUES (30, 119);
INSERT INTO `product_image` VALUES (30, 120);
INSERT INTO `product_image` VALUES (31, 121);
INSERT INTO `product_image` VALUES (31, 122);
INSERT INTO `product_image` VALUES (31, 123);
INSERT INTO `product_image` VALUES (31, 124);
INSERT INTO `product_image` VALUES (32, 125);
INSERT INTO `product_image` VALUES (32, 126);
INSERT INTO `product_image` VALUES (32, 127);
INSERT INTO `product_image` VALUES (32, 128);
INSERT INTO `product_image` VALUES (33, 129);
INSERT INTO `product_image` VALUES (33, 130);
INSERT INTO `product_image` VALUES (33, 131);
INSERT INTO `product_image` VALUES (33, 132);
INSERT INTO `product_image` VALUES (34, 133);
INSERT INTO `product_image` VALUES (34, 134);
INSERT INTO `product_image` VALUES (34, 135);
INSERT INTO `product_image` VALUES (34, 136);
INSERT INTO `product_image` VALUES (35, 137);
INSERT INTO `product_image` VALUES (35, 138);
INSERT INTO `product_image` VALUES (35, 139);
INSERT INTO `product_image` VALUES (35, 140);
INSERT INTO `product_image` VALUES (36, 141);
INSERT INTO `product_image` VALUES (36, 142);
INSERT INTO `product_image` VALUES (36, 143);
INSERT INTO `product_image` VALUES (36, 144);
INSERT INTO `product_image` VALUES (37, 145);
INSERT INTO `product_image` VALUES (37, 146);
INSERT INTO `product_image` VALUES (37, 147);
INSERT INTO `product_image` VALUES (37, 148);
INSERT INTO `product_image` VALUES (38, 149);
INSERT INTO `product_image` VALUES (38, 150);
INSERT INTO `product_image` VALUES (38, 151);
INSERT INTO `product_image` VALUES (38, 152);
INSERT INTO `product_image` VALUES (39, 153);
INSERT INTO `product_image` VALUES (39, 154);
INSERT INTO `product_image` VALUES (39, 155);
INSERT INTO `product_image` VALUES (39, 156);
INSERT INTO `product_image` VALUES (40, 157);
INSERT INTO `product_image` VALUES (40, 158);
INSERT INTO `product_image` VALUES (40, 159);
INSERT INTO `product_image` VALUES (40, 160);
INSERT INTO `product_image` VALUES (41, 161);
INSERT INTO `product_image` VALUES (41, 162);
INSERT INTO `product_image` VALUES (41, 163);
INSERT INTO `product_image` VALUES (41, 164);
INSERT INTO `product_image` VALUES (42, 165);
INSERT INTO `product_image` VALUES (42, 166);
INSERT INTO `product_image` VALUES (42, 167);
INSERT INTO `product_image` VALUES (42, 168);
INSERT INTO `product_image` VALUES (43, 169);
INSERT INTO `product_image` VALUES (43, 170);
INSERT INTO `product_image` VALUES (43, 171);
INSERT INTO `product_image` VALUES (43, 172);
INSERT INTO `product_image` VALUES (44, 173);
INSERT INTO `product_image` VALUES (44, 174);
INSERT INTO `product_image` VALUES (44, 175);
INSERT INTO `product_image` VALUES (44, 176);
INSERT INTO `product_image` VALUES (45, 177);
INSERT INTO `product_image` VALUES (45, 178);
INSERT INTO `product_image` VALUES (45, 179);
INSERT INTO `product_image` VALUES (45, 180);
INSERT INTO `product_image` VALUES (46, 181);
INSERT INTO `product_image` VALUES (46, 182);
INSERT INTO `product_image` VALUES (46, 183);
INSERT INTO `product_image` VALUES (46, 184);
INSERT INTO `product_image` VALUES (47, 185);
INSERT INTO `product_image` VALUES (47, 186);
INSERT INTO `product_image` VALUES (47, 187);
INSERT INTO `product_image` VALUES (47, 188);
INSERT INTO `product_image` VALUES (48, 189);
INSERT INTO `product_image` VALUES (48, 190);
INSERT INTO `product_image` VALUES (48, 191);
INSERT INTO `product_image` VALUES (48, 192);
INSERT INTO `product_image` VALUES (49, 193);
INSERT INTO `product_image` VALUES (49, 194);
INSERT INTO `product_image` VALUES (49, 195);
INSERT INTO `product_image` VALUES (49, 196);
INSERT INTO `product_image` VALUES (50, 197);
INSERT INTO `product_image` VALUES (50, 198);
INSERT INTO `product_image` VALUES (50, 199);
INSERT INTO `product_image` VALUES (50, 200);
INSERT INTO `product_image` VALUES (51, 201);
INSERT INTO `product_image` VALUES (51, 202);
INSERT INTO `product_image` VALUES (51, 203);
INSERT INTO `product_image` VALUES (51, 204);
INSERT INTO `product_image` VALUES (52, 205);
INSERT INTO `product_image` VALUES (52, 206);
INSERT INTO `product_image` VALUES (52, 207);
INSERT INTO `product_image` VALUES (52, 208);
INSERT INTO `product_image` VALUES (53, 209);
INSERT INTO `product_image` VALUES (53, 210);
INSERT INTO `product_image` VALUES (53, 211);
INSERT INTO `product_image` VALUES (53, 212);
INSERT INTO `product_image` VALUES (54, 213);
INSERT INTO `product_image` VALUES (54, 214);
INSERT INTO `product_image` VALUES (54, 215);
INSERT INTO `product_image` VALUES (54, 216);
INSERT INTO `product_image` VALUES (55, 217);
INSERT INTO `product_image` VALUES (55, 218);
INSERT INTO `product_image` VALUES (55, 219);
INSERT INTO `product_image` VALUES (55, 220);
INSERT INTO `product_image` VALUES (56, 221);
INSERT INTO `product_image` VALUES (56, 222);
INSERT INTO `product_image` VALUES (56, 223);
INSERT INTO `product_image` VALUES (56, 224);
INSERT INTO `product_image` VALUES (57, 225);
INSERT INTO `product_image` VALUES (57, 226);
INSERT INTO `product_image` VALUES (57, 227);
INSERT INTO `product_image` VALUES (57, 228);
INSERT INTO `product_image` VALUES (58, 229);
INSERT INTO `product_image` VALUES (58, 230);
INSERT INTO `product_image` VALUES (58, 231);
INSERT INTO `product_image` VALUES (58, 232);
INSERT INTO `product_image` VALUES (59, 233);
INSERT INTO `product_image` VALUES (59, 234);
INSERT INTO `product_image` VALUES (59, 235);
INSERT INTO `product_image` VALUES (59, 236);
INSERT INTO `product_image` VALUES (60, 237);
INSERT INTO `product_image` VALUES (60, 238);
INSERT INTO `product_image` VALUES (60, 239);
INSERT INTO `product_image` VALUES (60, 240);
INSERT INTO `product_image` VALUES (61, 241);
INSERT INTO `product_image` VALUES (61, 242);
INSERT INTO `product_image` VALUES (61, 243);
INSERT INTO `product_image` VALUES (61, 244);
INSERT INTO `product_image` VALUES (62, 245);
INSERT INTO `product_image` VALUES (62, 246);
INSERT INTO `product_image` VALUES (62, 247);
INSERT INTO `product_image` VALUES (62, 248);
INSERT INTO `product_image` VALUES (63, 249);
INSERT INTO `product_image` VALUES (63, 250);
INSERT INTO `product_image` VALUES (63, 251);
INSERT INTO `product_image` VALUES (63, 252);
INSERT INTO `product_image` VALUES (64, 253);
INSERT INTO `product_image` VALUES (64, 254);
INSERT INTO `product_image` VALUES (64, 255);
INSERT INTO `product_image` VALUES (64, 256);
INSERT INTO `product_image` VALUES (65, 257);
INSERT INTO `product_image` VALUES (65, 258);
INSERT INTO `product_image` VALUES (65, 259);
INSERT INTO `product_image` VALUES (65, 260);
INSERT INTO `product_image` VALUES (66, 261);
INSERT INTO `product_image` VALUES (66, 262);
INSERT INTO `product_image` VALUES (66, 263);
INSERT INTO `product_image` VALUES (66, 264);
INSERT INTO `product_image` VALUES (67, 265);
INSERT INTO `product_image` VALUES (67, 266);
INSERT INTO `product_image` VALUES (67, 267);
INSERT INTO `product_image` VALUES (67, 268);
INSERT INTO `product_image` VALUES (68, 269);
INSERT INTO `product_image` VALUES (68, 270);
INSERT INTO `product_image` VALUES (68, 271);
INSERT INTO `product_image` VALUES (68, 272);
INSERT INTO `product_image` VALUES (69, 273);
INSERT INTO `product_image` VALUES (69, 274);
INSERT INTO `product_image` VALUES (69, 275);
INSERT INTO `product_image` VALUES (69, 276);
INSERT INTO `product_image` VALUES (70, 277);
INSERT INTO `product_image` VALUES (70, 278);
INSERT INTO `product_image` VALUES (70, 279);
INSERT INTO `product_image` VALUES (70, 280);
INSERT INTO `product_image` VALUES (71, 281);
INSERT INTO `product_image` VALUES (71, 282);
INSERT INTO `product_image` VALUES (71, 283);
INSERT INTO `product_image` VALUES (71, 284);
INSERT INTO `product_image` VALUES (72, 285);
INSERT INTO `product_image` VALUES (72, 286);
INSERT INTO `product_image` VALUES (72, 287);
INSERT INTO `product_image` VALUES (72, 288);
INSERT INTO `product_image` VALUES (73, 289);
INSERT INTO `product_image` VALUES (73, 290);
INSERT INTO `product_image` VALUES (73, 291);
INSERT INTO `product_image` VALUES (73, 292);
INSERT INTO `product_image` VALUES (74, 293);
INSERT INTO `product_image` VALUES (74, 294);
INSERT INTO `product_image` VALUES (74, 295);
INSERT INTO `product_image` VALUES (74, 296);
INSERT INTO `product_image` VALUES (75, 297);
INSERT INTO `product_image` VALUES (75, 298);
INSERT INTO `product_image` VALUES (75, 299);
INSERT INTO `product_image` VALUES (75, 300);
INSERT INTO `product_image` VALUES (76, 301);
INSERT INTO `product_image` VALUES (76, 302);
INSERT INTO `product_image` VALUES (76, 303);
INSERT INTO `product_image` VALUES (76, 304);
INSERT INTO `product_image` VALUES (77, 305);
INSERT INTO `product_image` VALUES (77, 306);
INSERT INTO `product_image` VALUES (77, 307);
INSERT INTO `product_image` VALUES (77, 308);
INSERT INTO `product_image` VALUES (78, 309);
INSERT INTO `product_image` VALUES (78, 310);
INSERT INTO `product_image` VALUES (78, 311);
INSERT INTO `product_image` VALUES (78, 312);
INSERT INTO `product_image` VALUES (79, 313);
INSERT INTO `product_image` VALUES (79, 314);
INSERT INTO `product_image` VALUES (79, 315);
INSERT INTO `product_image` VALUES (79, 316);
INSERT INTO `product_image` VALUES (80, 317);
INSERT INTO `product_image` VALUES (80, 318);
INSERT INTO `product_image` VALUES (80, 319);
INSERT INTO `product_image` VALUES (80, 320);
INSERT INTO `product_image` VALUES (81, 321);
INSERT INTO `product_image` VALUES (81, 322);
INSERT INTO `product_image` VALUES (81, 323);
INSERT INTO `product_image` VALUES (81, 324);
INSERT INTO `product_image` VALUES (82, 325);
INSERT INTO `product_image` VALUES (82, 326);
INSERT INTO `product_image` VALUES (82, 327);
INSERT INTO `product_image` VALUES (82, 328);
INSERT INTO `product_image` VALUES (83, 329);
INSERT INTO `product_image` VALUES (83, 330);
INSERT INTO `product_image` VALUES (83, 331);
INSERT INTO `product_image` VALUES (83, 332);
INSERT INTO `product_image` VALUES (84, 333);
INSERT INTO `product_image` VALUES (84, 334);
INSERT INTO `product_image` VALUES (84, 335);
INSERT INTO `product_image` VALUES (84, 336);
INSERT INTO `product_image` VALUES (85, 337);
INSERT INTO `product_image` VALUES (85, 338);
INSERT INTO `product_image` VALUES (85, 339);
INSERT INTO `product_image` VALUES (85, 340);
INSERT INTO `product_image` VALUES (86, 341);
INSERT INTO `product_image` VALUES (86, 342);
INSERT INTO `product_image` VALUES (86, 343);
INSERT INTO `product_image` VALUES (86, 344);
INSERT INTO `product_image` VALUES (87, 345);
INSERT INTO `product_image` VALUES (87, 346);
INSERT INTO `product_image` VALUES (87, 347);
INSERT INTO `product_image` VALUES (87, 348);
INSERT INTO `product_image` VALUES (88, 349);
INSERT INTO `product_image` VALUES (88, 350);
INSERT INTO `product_image` VALUES (88, 351);
INSERT INTO `product_image` VALUES (88, 352);
INSERT INTO `product_image` VALUES (89, 353);
INSERT INTO `product_image` VALUES (89, 354);
INSERT INTO `product_image` VALUES (89, 355);
INSERT INTO `product_image` VALUES (89, 356);
INSERT INTO `product_image` VALUES (90, 357);
INSERT INTO `product_image` VALUES (90, 358);
INSERT INTO `product_image` VALUES (90, 359);
INSERT INTO `product_image` VALUES (90, 360);
INSERT INTO `product_image` VALUES (91, 361);
INSERT INTO `product_image` VALUES (91, 362);
INSERT INTO `product_image` VALUES (91, 363);
INSERT INTO `product_image` VALUES (91, 364);
INSERT INTO `product_image` VALUES (92, 365);
INSERT INTO `product_image` VALUES (92, 366);
INSERT INTO `product_image` VALUES (92, 367);
INSERT INTO `product_image` VALUES (92, 368);
INSERT INTO `product_image` VALUES (93, 369);
INSERT INTO `product_image` VALUES (93, 370);
INSERT INTO `product_image` VALUES (93, 371);
INSERT INTO `product_image` VALUES (93, 372);
INSERT INTO `product_image` VALUES (94, 373);
INSERT INTO `product_image` VALUES (94, 374);
INSERT INTO `product_image` VALUES (94, 375);
INSERT INTO `product_image` VALUES (94, 376);
INSERT INTO `product_image` VALUES (95, 377);
INSERT INTO `product_image` VALUES (95, 378);
INSERT INTO `product_image` VALUES (95, 379);
INSERT INTO `product_image` VALUES (95, 380);
INSERT INTO `product_image` VALUES (96, 381);
INSERT INTO `product_image` VALUES (96, 382);
INSERT INTO `product_image` VALUES (96, 383);
INSERT INTO `product_image` VALUES (96, 384);
INSERT INTO `product_image` VALUES (97, 385);
INSERT INTO `product_image` VALUES (97, 386);
INSERT INTO `product_image` VALUES (97, 387);
INSERT INTO `product_image` VALUES (97, 388);
INSERT INTO `product_image` VALUES (98, 389);
INSERT INTO `product_image` VALUES (98, 390);
INSERT INTO `product_image` VALUES (98, 391);
INSERT INTO `product_image` VALUES (98, 392);
INSERT INTO `product_image` VALUES (99, 393);
INSERT INTO `product_image` VALUES (99, 394);
INSERT INTO `product_image` VALUES (99, 395);
INSERT INTO `product_image` VALUES (99, 396);
INSERT INTO `product_image` VALUES (100, 397);
INSERT INTO `product_image` VALUES (100, 398);
INSERT INTO `product_image` VALUES (100, 399);
INSERT INTO `product_image` VALUES (100, 400);
INSERT INTO `product_image` VALUES (1, 401);
INSERT INTO `product_image` VALUES (2, 402);
INSERT INTO `product_image` VALUES (3, 403);
INSERT INTO `product_image` VALUES (4, 404);
INSERT INTO `product_image` VALUES (5, 405);
INSERT INTO `product_image` VALUES (6, 406);
INSERT INTO `product_image` VALUES (7, 407);
INSERT INTO `product_image` VALUES (8, 408);
INSERT INTO `product_image` VALUES (9, 409);
INSERT INTO `product_image` VALUES (10, 410);
INSERT INTO `product_image` VALUES (11, 411);
INSERT INTO `product_image` VALUES (12, 412);
INSERT INTO `product_image` VALUES (13, 413);
INSERT INTO `product_image` VALUES (14, 414);
INSERT INTO `product_image` VALUES (15, 415);
INSERT INTO `product_image` VALUES (16, 416);
INSERT INTO `product_image` VALUES (17, 417);
INSERT INTO `product_image` VALUES (18, 418);
INSERT INTO `product_image` VALUES (19, 419);
INSERT INTO `product_image` VALUES (20, 420);
INSERT INTO `product_image` VALUES (21, 421);
INSERT INTO `product_image` VALUES (22, 422);
INSERT INTO `product_image` VALUES (23, 423);
INSERT INTO `product_image` VALUES (24, 424);
INSERT INTO `product_image` VALUES (25, 425);
INSERT INTO `product_image` VALUES (26, 426);
INSERT INTO `product_image` VALUES (27, 427);
INSERT INTO `product_image` VALUES (28, 428);
INSERT INTO `product_image` VALUES (29, 429);
INSERT INTO `product_image` VALUES (30, 430);
INSERT INTO `product_image` VALUES (31, 431);
INSERT INTO `product_image` VALUES (32, 432);
INSERT INTO `product_image` VALUES (33, 433);
INSERT INTO `product_image` VALUES (34, 434);
INSERT INTO `product_image` VALUES (35, 435);
INSERT INTO `product_image` VALUES (36, 436);
INSERT INTO `product_image` VALUES (37, 437);
INSERT INTO `product_image` VALUES (38, 438);
INSERT INTO `product_image` VALUES (39, 439);
INSERT INTO `product_image` VALUES (40, 440);
INSERT INTO `product_image` VALUES (41, 441);
INSERT INTO `product_image` VALUES (42, 442);
INSERT INTO `product_image` VALUES (43, 443);
INSERT INTO `product_image` VALUES (44, 444);
INSERT INTO `product_image` VALUES (45, 445);
INSERT INTO `product_image` VALUES (46, 446);
INSERT INTO `product_image` VALUES (47, 447);
INSERT INTO `product_image` VALUES (48, 448);
INSERT INTO `product_image` VALUES (49, 449);
INSERT INTO `product_image` VALUES (50, 450);
INSERT INTO `product_image` VALUES (51, 451);
INSERT INTO `product_image` VALUES (52, 452);
INSERT INTO `product_image` VALUES (53, 453);
INSERT INTO `product_image` VALUES (54, 454);
INSERT INTO `product_image` VALUES (55, 455);
INSERT INTO `product_image` VALUES (56, 456);
INSERT INTO `product_image` VALUES (57, 457);
INSERT INTO `product_image` VALUES (58, 458);
INSERT INTO `product_image` VALUES (59, 459);
INSERT INTO `product_image` VALUES (60, 460);
INSERT INTO `product_image` VALUES (61, 461);
INSERT INTO `product_image` VALUES (62, 462);
INSERT INTO `product_image` VALUES (63, 463);
INSERT INTO `product_image` VALUES (64, 464);
INSERT INTO `product_image` VALUES (65, 465);
INSERT INTO `product_image` VALUES (66, 466);
INSERT INTO `product_image` VALUES (67, 467);
INSERT INTO `product_image` VALUES (68, 468);
INSERT INTO `product_image` VALUES (69, 469);
INSERT INTO `product_image` VALUES (70, 470);
INSERT INTO `product_image` VALUES (71, 471);
INSERT INTO `product_image` VALUES (72, 472);
INSERT INTO `product_image` VALUES (73, 473);
INSERT INTO `product_image` VALUES (74, 474);
INSERT INTO `product_image` VALUES (75, 475);
INSERT INTO `product_image` VALUES (76, 476);
INSERT INTO `product_image` VALUES (77, 477);
INSERT INTO `product_image` VALUES (78, 478);
INSERT INTO `product_image` VALUES (79, 479);
INSERT INTO `product_image` VALUES (80, 480);
INSERT INTO `product_image` VALUES (81, 481);
INSERT INTO `product_image` VALUES (82, 482);
INSERT INTO `product_image` VALUES (83, 483);
INSERT INTO `product_image` VALUES (84, 484);
INSERT INTO `product_image` VALUES (85, 485);
INSERT INTO `product_image` VALUES (86, 486);
INSERT INTO `product_image` VALUES (87, 487);
INSERT INTO `product_image` VALUES (88, 488);
INSERT INTO `product_image` VALUES (89, 489);
INSERT INTO `product_image` VALUES (90, 490);
INSERT INTO `product_image` VALUES (91, 491);
INSERT INTO `product_image` VALUES (92, 492);
INSERT INTO `product_image` VALUES (93, 493);
INSERT INTO `product_image` VALUES (94, 494);
INSERT INTO `product_image` VALUES (95, 495);
INSERT INTO `product_image` VALUES (96, 496);
INSERT INTO `product_image` VALUES (97, 497);
INSERT INTO `product_image` VALUES (98, 498);
INSERT INTO `product_image` VALUES (99, 499);
INSERT INTO `product_image` VALUES (100, 500);

-- ----------------------------
-- Table structure for product_import
-- ----------------------------
DROP TABLE IF EXISTS `product_import`;
CREATE TABLE `product_import`  (
  `id` int NOT NULL,
  `import_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price_import` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `import_id`) USING BTREE,
  INDEX `fk_product_import_import`(`import_id` ASC) USING BTREE,
  CONSTRAINT `fk_product_import_import` FOREIGN KEY (`import_id`) REFERENCES `import` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_product_import_product` FOREIGN KEY (`id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_import
-- ----------------------------
INSERT INTO `product_import` VALUES (1, 1, 2, 100);
INSERT INTO `product_import` VALUES (1, 2, 3232, 132312);
INSERT INTO `product_import` VALUES (1, 3, 10, 10);
INSERT INTO `product_import` VALUES (1, 5, 5, 70000);
INSERT INTO `product_import` VALUES (1, 6, 3, 3);
INSERT INTO `product_import` VALUES (1, 7, 3, 3);
INSERT INTO `product_import` VALUES (1, 8, 3, 3);
INSERT INTO `product_import` VALUES (1, 9, 4, 4);
INSERT INTO `product_import` VALUES (1, 10, 6, 100000);
INSERT INTO `product_import` VALUES (4, 5, 10, 500000);
INSERT INTO `product_import` VALUES (4, 6, 4, 4);
INSERT INTO `product_import` VALUES (4, 7, 4, 4);
INSERT INTO `product_import` VALUES (4, 8, 4, 4);
INSERT INTO `product_import` VALUES (4, 9, 4, 5);

-- ----------------------------
-- Table structure for review
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `rate` int NOT NULL,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `create_date` datetime NOT NULL,
  `status` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_review_user`(`user_id` ASC) USING BTREE,
  INDEX `fk_review_product`(`product_id` ASC) USING BTREE,
  CONSTRAINT `fk_review_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_review_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of review
-- ----------------------------
INSERT INTO `review` VALUES (1, 'comment', 5, 2, 2, '2023-04-10 16:34:26', 1);
INSERT INTO `review` VALUES (2, 'comment', 5, 2, 2, '2023-04-08 16:34:30', 1);
INSERT INTO `review` VALUES (5, 'Sản phẩm này đẹp lắm', 5, 2, 2, '2023-04-17 17:15:57', 0);
INSERT INTO `review` VALUES (6, 'xcgsfdg', 0, 2, 2, '2023-04-17 17:18:19', 0);
INSERT INTO `review` VALUES (7, 'ádfgsdfg', 0, 2, 2, '2023-04-17 17:18:21', 0);
INSERT INTO `review` VALUES (8, 'sdfgsdfg', 5, 2, 2, '2023-04-17 17:18:23', 0);
INSERT INTO `review` VALUES (9, 'ádfasdfdsda', 0, 2, 2, '2023-04-17 17:18:38', 0);
INSERT INTO `review` VALUES (10, 'dhjhdgjjjjjjjhfgfhgfhghjfghj', 0, 2, 2, '2023-04-17 17:18:41', 0);
INSERT INTO `review` VALUES (11, 'fghjfghjfghjfhgjfghj', 3, 2, 2, '2023-04-17 17:18:46', 0);
INSERT INTO `review` VALUES (12, 'jfghjfhgjfhgj', 5, 2, 2, '2023-04-17 17:18:50', 0);
INSERT INTO `review` VALUES (13, 'sýytry', 0, 2, 2, '2023-04-17 17:19:03', 0);
INSERT INTO `review` VALUES (14, 'sản phẩm quá đẹp', 0, 2, 85, '2023-04-24 15:05:55', 0);

-- ----------------------------
-- Table structure for source
-- ----------------------------
DROP TABLE IF EXISTS `source`;
CREATE TABLE `source`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of source
-- ----------------------------

-- ----------------------------
-- Table structure for third_party
-- ----------------------------
DROP TABLE IF EXISTS `third_party`;
CREATE TABLE `third_party`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `value` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of third_party
-- ----------------------------
INSERT INTO `third_party` VALUES (1, 'viettel post', '1');

-- ----------------------------
-- Table structure for transport
-- ----------------------------
DROP TABLE IF EXISTS `transport`;
CREATE TABLE `transport`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `fee` int NOT NULL,
  `time` datetime NOT NULL,
  `id_shipping` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_date` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of transport
-- ----------------------------
INSERT INTO `transport` VALUES (3, 29000, '2023-05-05 23:59:59', NULL, '2023-05-03 14:43:22');
INSERT INTO `transport` VALUES (4, 29000, '2023-05-05 23:59:59', NULL, '2023-05-03 15:08:06');
INSERT INTO `transport` VALUES (5, 29000, '2023-05-06 23:59:59', NULL, '2023-05-03 15:16:01');
INSERT INTO `transport` VALUES (6, 29000, '2023-05-06 23:59:59', NULL, '2023-05-03 15:20:01');
INSERT INTO `transport` VALUES (7, 29000, '2023-05-06 23:59:59', NULL, '2023-05-03 15:23:33');
INSERT INTO `transport` VALUES (8, 29000, '2023-05-06 23:59:59', NULL, '2023-05-03 15:23:49');
INSERT INTO `transport` VALUES (9, 29000, '2023-05-06 23:59:59', NULL, '2023-05-03 15:26:33');
INSERT INTO `transport` VALUES (10, 29000, '2023-05-06 23:59:59', NULL, '2023-05-03 15:30:35');
INSERT INTO `transport` VALUES (11, 10000, '2023-12-01 08:38:58', NULL, '2023-12-01 08:38:58');
INSERT INTO `transport` VALUES (12, 25000, '2023-12-01 08:51:03', NULL, '2023-12-01 08:51:03');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `avatar` int NULL DEFAULT NULL,
  `password` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `id_third_party` int NULL DEFAULT NULL,
  `variety` int NOT NULL,
  `status` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_avatar_image`(`avatar` ASC) USING BTREE,
  INDEX `fk_user_third_party`(`id_third_party` ASC) USING BTREE,
  CONSTRAINT `fk_avatar_image` FOREIGN KEY (`avatar`) REFERENCES `image` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_third_party` FOREIGN KEY (`id_third_party`) REFERENCES `third_party` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'Khôi Nhơn', '0900000001', 'khoinhon@gmail.com', 501, '8d24fb929520962c781bf5012154797c7ecf777088ba2834e170bc2c8ac93407', 1, 0, 0);
INSERT INTO `user` VALUES (2, 'Dương Thanh Phụng', '0900000123', '20130099@st.hcmuaf.edu.vn', 501, 'c417f965b5250b14c38e60d342d98bd804695dbc7dc3cd9f8ca6e7da20df7dcc', 1, 0, 0);
INSERT INTO `user` VALUES (3, 'Quỳnh Như', '0900000023', '20130356@st.hcmuaf.edu.vn', 501, '2ed14052289b558400fdbade3aa186457618f97f7489649166add723d65676ea', 1, 0, 0);
INSERT INTO `user` VALUES (4, 'Lê Bảo Đặng', '0999999999', '20130010@st.hcmuaf.edu.vn', 501, '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', 1, 1, 0);
INSERT INTO `user` VALUES (5, 'Xuân Hoa', '0819541222', 'qinhuuuuu@gmail.com', 501, '851aeae07e83ff0ac3ae4cbf204e58d7f7c3cbd5d83554f5843e8ba7d5d7b090', 1, 0, 0);
INSERT INTO `user` VALUES (6, 'Gia Bảo', '888888881', 'quynhnhuuww22@gmail.com', 501, '573e6b939dde87164c18eb5092ba3291c801a2bbb0d177128ab8a7d5e238000d', 1, 0, 0);
INSERT INTO `user` VALUES (7, 'Hồ An', '0146598444', 'thphung2@gmail.com', 501, '1833b312305b6510a8a142b3759711be882aacf2397525434206916f778ba955', 1, 0, 0);
INSERT INTO `user` VALUES (13, 'Dam Thanh', '0123456789', 'kanatovn02@gmail.com', 501, '60166a3b3b252885e0c489b2da291048d8af0349326d23d96140b065f65f31f5', NULL, 0, 0);

-- ----------------------------
-- Table structure for user_information
-- ----------------------------
DROP TABLE IF EXISTS `user_information`;
CREATE TABLE `user_information`  (
  `user_id` int NOT NULL,
  `information_id` int NOT NULL,
  PRIMARY KEY (`user_id`, `information_id`) USING BTREE,
  INDEX `fk_user_infomation_infomation`(`information_id` ASC) USING BTREE,
  CONSTRAINT `fk_user_infomation_infomation` FOREIGN KEY (`information_id`) REFERENCES `information` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_information_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_information
-- ----------------------------
INSERT INTO `user_information` VALUES (2, 13);
INSERT INTO `user_information` VALUES (2, 14);
INSERT INTO `user_information` VALUES (2, 15);

-- ----------------------------
-- Table structure for vendor
-- ----------------------------
DROP TABLE IF EXISTS `vendor`;
CREATE TABLE `vendor`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `information_id` int NOT NULL,
  `website` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `status` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_vendor_infomation`(`information_id` ASC) USING BTREE,
  CONSTRAINT `fk_vendor_infomation` FOREIGN KEY (`information_id`) REFERENCES `information` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vendor
-- ----------------------------
INSERT INTO `vendor` VALUES (8, 'gohoanggiaanh@gmail.com', 18, 'google.com', 0);
INSERT INTO `vendor` VALUES (9, 'mocnguyen@gmail.com', 20, 'nguyenmoc.com', 0);
INSERT INTO `vendor` VALUES (10, 'caogia@mail.com', 21, 'moccaogia.com', 0);

SET FOREIGN_KEY_CHECKS = 1;
