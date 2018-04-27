/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : 91system

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2018-04-27 15:58:25
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for doctor
-- ----------------------------
DROP TABLE IF EXISTS `doctor`;
CREATE TABLE `doctor` (
  `did` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `gender` int(11) NOT NULL,
  `title` int(11) NOT NULL,
  `path` varchar(128) DEFAULT NULL,
  `goodat` varchar(255) DEFAULT NULL,
  `intro` varchar(255) DEFAULT NULL,
  `oid` int(11) NOT NULL,
  PRIMARY KEY (`did`),
  KEY `oid-fk_idx` (`oid`),
  CONSTRAINT `o_d_fk` FOREIGN KEY (`oid`) REFERENCES `office` (`oid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of doctor
-- ----------------------------
INSERT INTO `doctor` VALUES ('1', 'testdoc1', '0', '0', null, null, null, '1');
INSERT INTO `doctor` VALUES ('2', 'testdoc2', '0', '0', null, null, null, '1');
INSERT INTO `doctor` VALUES ('3', 'testdoc2', '0', '0', null, null, null, '1');

-- ----------------------------
-- Table structure for hadmin
-- ----------------------------
DROP TABLE IF EXISTS `hadmin`;
CREATE TABLE `hadmin` (
  `haid` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(10) NOT NULL,
  `hid` int(11) NOT NULL,
  `password` varchar(16) NOT NULL,
  PRIMARY KEY (`haid`),
  UNIQUE KEY `UK_kugoa4lamvqo1p56lhsusic5h` (`account`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hadmin
-- ----------------------------
INSERT INTO `hadmin` VALUES ('1', 'hadmintest', '1', '123456');

-- ----------------------------
-- Table structure for hospital
-- ----------------------------
DROP TABLE IF EXISTS `hospital`;
CREATE TABLE `hospital` (
  `hid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `address` varchar(128) NOT NULL,
  `telephone` varchar(16) NOT NULL,
  `intro` varchar(225) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `region` int(11) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  PRIMARY KEY (`hid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hospital
-- ----------------------------
INSERT INTO `hospital` VALUES ('1', 'scut_hospital', 'scut', '123456789', null, '0', '0', '0', '0');
INSERT INTO `hospital` VALUES ('2', '华工大医院', '华南理工大学', '123456789', null, '0', '0', '0', '0');
INSERT INTO `hospital` VALUES ('3', '华工大医院', '华南理工大学', '123456789', null, '0', '0', '0', '0');
INSERT INTO `hospital` VALUES ('4', '华工中医院', '华南理工大学大学城校区', '123456789', null, '0', '0', '0', '0');
INSERT INTO `hospital` VALUES ('5', '大学城医院', '华南理工大学大学城校区', '123456789', null, '0', '0', '0', '0');
INSERT INTO `hospital` VALUES ('6', '大学城中医院', '大学城', '123456789', null, '0', '0', '0', '0');
INSERT INTO `hospital` VALUES ('7', '番禺中医院', '大学城', '123456789', null, '0', '0', '0', '0');

-- ----------------------------
-- Table structure for office
-- ----------------------------
DROP TABLE IF EXISTS `office`;
CREATE TABLE `office` (
  `oid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `type` int(11) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `hid` int(11) NOT NULL,
  PRIMARY KEY (`oid`),
  KEY `hid_idx` (`hid`),
  CONSTRAINT `h_o_fk` FOREIGN KEY (`hid`) REFERENCES `hospital` (`hid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of office
-- ----------------------------
INSERT INTO `office` VALUES ('1', '手术室', '0', '0', '1');
INSERT INTO `office` VALUES ('2', '妇科', '0', '0', '1');
INSERT INTO `office` VALUES ('3', '门诊室', '0', '0', '1');
INSERT INTO `office` VALUES ('4', '儿科', '0', '0', '1');

-- ----------------------------
-- Table structure for orderitem
-- ----------------------------
DROP TABLE IF EXISTS `orderitem`;
CREATE TABLE `orderitem` (
  `oiid` varchar(32) NOT NULL,
  `timing` time NOT NULL,
  `pname` varchar(10) NOT NULL,
  `pbirthday` date NOT NULL,
  `pgender` int(11) NOT NULL,
  `pphone` varchar(11) NOT NULL,
  `pinfo` varchar(255) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `payed` timestamp NULL DEFAULT NULL,
  `status` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `uiid` int(11) NOT NULL,
  PRIMARY KEY (`oiid`),
  KEY `sid-fk_idx` (`sid`),
  KEY `uiid-fk_idx` (`uiid`),
  CONSTRAINT `s_oi_fk` FOREIGN KEY (`sid`) REFERENCES `schedule` (`sid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ui_oi_fk` FOREIGN KEY (`uiid`) REFERENCES `userinfo` (`uiid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orderitem
-- ----------------------------
INSERT INTO `orderitem` VALUES ('orderitem1461240435571', '20:07:15', 'xiaojin', '2016-04-21', '0', '18814122697', null, '2016-04-21 20:07:16', '2016-04-21 20:32:12', '0', '1', '1');
INSERT INTO `orderitem` VALUES ('orderitem1524813961035', '09:30:00', '测试人员', '2018-02-28', '0', '123', '阿斯顿', '2018-04-27 15:26:01', '2018-04-27 15:26:01', '0', '1', '2');

-- ----------------------------
-- Table structure for refund
-- ----------------------------
DROP TABLE IF EXISTS `refund`;
CREATE TABLE `refund` (
  `rid` int(11) NOT NULL AUTO_INCREMENT,
  `apply` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `amount` double NOT NULL,
  `status` int(11) NOT NULL,
  `completed` timestamp NULL DEFAULT NULL,
  `oiid` varchar(32) NOT NULL,
  `wid` int(11) NOT NULL,
  PRIMARY KEY (`rid`),
  KEY `w_r_fk_idx` (`wid`),
  KEY `oi_r_fk_idx` (`oiid`),
  CONSTRAINT `oi_r_fk` FOREIGN KEY (`oiid`) REFERENCES `orderitem` (`oiid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `w_r_fk` FOREIGN KEY (`wid`) REFERENCES `wallet` (`wid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of refund
-- ----------------------------

-- ----------------------------
-- Table structure for sadmin
-- ----------------------------
DROP TABLE IF EXISTS `sadmin`;
CREATE TABLE `sadmin` (
  `said` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(10) NOT NULL,
  `isroot` int(11) NOT NULL,
  `password` varchar(16) NOT NULL,
  PRIMARY KEY (`said`),
  UNIQUE KEY `UK_o6b4stf9u5kpds05c2jbr5umt` (`account`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sadmin
-- ----------------------------
INSERT INTO `sadmin` VALUES ('1', 'sadmintest', '1', '123456');

-- ----------------------------
-- Table structure for schedule
-- ----------------------------
DROP TABLE IF EXISTS `schedule`;
CREATE TABLE `schedule` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `time` int(11) NOT NULL,
  `num` int(11) NOT NULL,
  `ordernum` int(11) NOT NULL,
  `fee` double NOT NULL,
  `did` int(11) NOT NULL,
  PRIMARY KEY (`sid`),
  KEY `did-fk_idx` (`did`),
  CONSTRAINT `d_s_fk` FOREIGN KEY (`did`) REFERENCES `doctor` (`did`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of schedule
-- ----------------------------
INSERT INTO `schedule` VALUES ('1', '2018-04-27', '0', '20', '11', '4', '2');
INSERT INTO `schedule` VALUES ('2', '2016-04-28', '5', '6', '7', '8', '1');

-- ----------------------------
-- Table structure for trade
-- ----------------------------
DROP TABLE IF EXISTS `trade`;
CREATE TABLE `trade` (
  `tid` int(11) NOT NULL AUTO_INCREMENT,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `amount` double NOT NULL,
  `oiid` varchar(32) NOT NULL,
  `wid` int(11) NOT NULL,
  PRIMARY KEY (`tid`),
  KEY `oi_t_fk_idx` (`oiid`),
  KEY `w_t_fk_idx` (`wid`),
  CONSTRAINT `oi_t_fk` FOREIGN KEY (`oiid`) REFERENCES `orderitem` (`oiid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `w_t_fk` FOREIGN KEY (`wid`) REFERENCES `wallet` (`wid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of trade
-- ----------------------------
INSERT INTO `trade` VALUES ('1', '2016-04-21 20:32:12', '4', 'orderitem1461240435571', '1');
INSERT INTO `trade` VALUES ('2', '2018-04-27 15:26:01', '4', 'orderitem1524813961035', '2');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(11) NOT NULL,
  `password` varchar(16) NOT NULL,
  `identified` int(11) NOT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `phone_UNIQUE` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '123', '123456', '1');

-- ----------------------------
-- Table structure for userinfo
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `uiid` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(11) NOT NULL,
  `name` varchar(10) NOT NULL,
  `gender` int(11) NOT NULL,
  `birthday` date NOT NULL,
  `idcard` varchar(32) NOT NULL,
  `email` varchar(32) DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  `blood` int(11) DEFAULT NULL,
  `married` int(11) DEFAULT NULL,
  `career` varchar(32) DEFAULT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`uiid`),
  UNIQUE KEY `phone_UNIQUE` (`phone`),
  KEY `uid-fk_idx` (`uid`),
  CONSTRAINT `u_ui_fk` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
INSERT INTO `userinfo` VALUES ('1', '18814122697', '肖劲', '0', '2016-04-21', '12345678910', null, null, '0', '0', null, '1');
INSERT INTO `userinfo` VALUES ('2', '123', '测试人员', '0', '2018-02-28', '', '', '', '0', '0', '', '1');

-- ----------------------------
-- Table structure for wallet
-- ----------------------------
DROP TABLE IF EXISTS `wallet`;
CREATE TABLE `wallet` (
  `wid` int(11) NOT NULL AUTO_INCREMENT,
  `account` double NOT NULL,
  `uiid` int(11) NOT NULL,
  PRIMARY KEY (`wid`),
  KEY `uiid-fk_idx` (`uiid`),
  CONSTRAINT `ui_w_fk` FOREIGN KEY (`uiid`) REFERENCES `userinfo` (`uiid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wallet
-- ----------------------------
INSERT INTO `wallet` VALUES ('1', '100', '1');
INSERT INTO `wallet` VALUES ('2', '26', '2');
