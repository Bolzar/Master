/*
Navicat MySQL Data Transfer

Source Server         : Holystone Productions
Source Server Version : 50509
Source Host           : localhost:3306
Source Database       : auth

Target Server Type    : MYSQL
Target Server Version : 50509
File Encoding         : 65001

Date: 2012-10-26 14:06:01
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `account`
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `username` varchar(32) NOT NULL DEFAULT '',
  `sha_pass_hash` varchar(40) NOT NULL DEFAULT '',
  `sessionkey` varchar(80) NOT NULL DEFAULT '',
  `v` varchar(64) NOT NULL DEFAULT '',
  `s` varchar(64) NOT NULL DEFAULT '',
  `email` varchar(254) NOT NULL DEFAULT '',
  `joindate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_ip` varchar(15) NOT NULL DEFAULT '127.0.0.1',
  `failed_logins` int(10) unsigned NOT NULL DEFAULT '0',
  `locked` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `last_login` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `online` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `expansion` tinyint(3) unsigned NOT NULL DEFAULT '3',
  `mutetime` bigint(20) NOT NULL DEFAULT '0',
  `locale` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `os` varchar(3) NOT NULL DEFAULT '',
  `recruiter` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Account System';

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES ('1', 'ADMIN', '8301316D0D8448A34FA6D0C6BF1CBFA2B4A1A93A', 'EDA88CE9F4C4FBD05D4904DBF845C4548E77DC156283ABE90CA600A160EEB2F3C4FC5DA8328A61A4', '6EC8908ABE1FF20DE1C1CDA6227E40817684E9766AE10B3634F7BD5840B85586', '8FE5FF0C237056972986201B6AA5C20F4C947F64E4EBA99099F8468EB7B19B63', '', '2012-10-10 16:58:42', '127.0.0.1', '0', '0', '2012-10-25 16:44:14', '1', '3', '0', '0', 'Win', '0');

-- ----------------------------
-- Table structure for `account_access`
-- ----------------------------
DROP TABLE IF EXISTS `account_access`;
CREATE TABLE `account_access` (
  `id` int(10) unsigned NOT NULL,
  `gmlevel` tinyint(3) unsigned NOT NULL,
  `RealmID` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`,`RealmID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account_access
-- ----------------------------
INSERT INTO `account_access` VALUES ('1', '3', '-1');

-- ----------------------------
-- Table structure for `account_banned`
-- ----------------------------
DROP TABLE IF EXISTS `account_banned`;
CREATE TABLE `account_banned` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Account id',
  `bandate` int(10) unsigned NOT NULL DEFAULT '0',
  `unbandate` int(10) unsigned NOT NULL DEFAULT '0',
  `bannedby` varchar(50) NOT NULL,
  `banreason` varchar(255) NOT NULL,
  `active` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`,`bandate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ban List';

-- ----------------------------
-- Records of account_banned
-- ----------------------------

-- ----------------------------
-- Table structure for `ip_banned`
-- ----------------------------
DROP TABLE IF EXISTS `ip_banned`;
CREATE TABLE `ip_banned` (
  `ip` varchar(15) NOT NULL DEFAULT '127.0.0.1',
  `bandate` int(10) unsigned NOT NULL,
  `unbandate` int(10) unsigned NOT NULL,
  `bannedby` varchar(50) NOT NULL DEFAULT '[Console]',
  `banreason` varchar(255) NOT NULL DEFAULT 'no reason',
  PRIMARY KEY (`ip`,`bandate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Banned IPs';

-- ----------------------------
-- Records of ip_banned
-- ----------------------------

-- ----------------------------
-- Table structure for `logs`
-- ----------------------------
DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs` (
  `time` int(10) unsigned NOT NULL,
  `realm` int(10) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `level` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `string` text CHARACTER SET latin1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of logs
-- ----------------------------

-- ----------------------------
-- Table structure for `realmcharacters`
-- ----------------------------
DROP TABLE IF EXISTS `realmcharacters`;
CREATE TABLE `realmcharacters` (
  `realmid` int(10) unsigned NOT NULL DEFAULT '0',
  `acctid` int(10) unsigned NOT NULL,
  `numchars` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`realmid`,`acctid`),
  KEY `acctid` (`acctid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Realm Character Tracker';

-- ----------------------------
-- Records of realmcharacters
-- ----------------------------
INSERT INTO `realmcharacters` VALUES ('1', '1', '3');

-- ----------------------------
-- Table structure for `realmlist`
-- ----------------------------
DROP TABLE IF EXISTS `realmlist`;
CREATE TABLE `realmlist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  `address` varchar(255) NOT NULL DEFAULT '127.0.0.1',
  `port` smallint(5) unsigned NOT NULL DEFAULT '8085',
  `icon` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `flag` tinyint(3) unsigned NOT NULL DEFAULT '2',
  `timezone` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `allowedSecurityLevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `population` float unsigned NOT NULL DEFAULT '0',
  `gamebuild` int(10) unsigned NOT NULL DEFAULT '15595',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Realm System';

-- ----------------------------
-- Records of realmlist
-- ----------------------------
INSERT INTO `realmlist` VALUES ('1', 'Holystone Productions', '127.0.0.1', '8085', '0', '0', '1', '0', '0', '15595');

-- ----------------------------
-- Table structure for `uptime`
-- ----------------------------
DROP TABLE IF EXISTS `uptime`;
CREATE TABLE `uptime` (
  `realmid` int(10) unsigned NOT NULL,
  `starttime` int(10) unsigned NOT NULL DEFAULT '0',
  `uptime` int(10) unsigned NOT NULL DEFAULT '0',
  `maxplayers` smallint(5) unsigned NOT NULL DEFAULT '0',
  `revision` varchar(255) NOT NULL DEFAULT 'Trinitycore',
  PRIMARY KEY (`realmid`,`starttime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Uptime system';

-- ----------------------------
-- Records of uptime
-- ----------------------------
INSERT INTO `uptime` VALUES ('1', '1349884160', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1349884702', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1349904057', '611', '1', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1349963180', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1349963275', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1350817099', '612', '1', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1350818306', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1350818692', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1350830877', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1350831048', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1350831399', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1350832344', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1350833260', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1350833414', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1350844002', '608', '1', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1350845152', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1350845785', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1350848123', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1350848378', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1350922428', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1350922821', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1350923633', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351003596', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351020865', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351022589', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351023848', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351024197', '602', '1', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351025310', '609', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351028117', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351094476', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351095750', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351115337', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351116175', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351171121', '4208', '1', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351175559', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351176111', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351176650', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351177323', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351178041', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351178345', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351178702', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351179283', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351179640', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
INSERT INTO `uptime` VALUES ('1', '1351179840', '0', '0', 'TrinityCore rev. 0000-00-00 00:00:00 +0000 (Archived) (Win64, Debug)');
