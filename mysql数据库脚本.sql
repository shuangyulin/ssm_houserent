-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `user_name` varchar(20)  NOT NULL COMMENT 'user_name',
  `password` varchar(20)  NULL COMMENT '密码',
  `realName` varchar(20)  NOT NULL COMMENT '姓名',
  `sex` varchar(4)  NOT NULL COMMENT '性别',
  `birthday` varchar(20)  NULL COMMENT '出生日期',
  `cardNumber` varchar(20)  NOT NULL COMMENT '身份证',
  `city` varchar(20)  NULL COMMENT '籍贯',
  `photo` varchar(60)  NOT NULL COMMENT '照片',
  `address` varchar(20)  NULL COMMENT '家庭地址',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_areaInfo` (
  `areaId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `areaName` varchar(20)  NOT NULL COMMENT '区域名称',
  PRIMARY KEY (`areaId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_buildingInfo` (
  `buildingId` int(11) NOT NULL AUTO_INCREMENT COMMENT '楼盘编号',
  `areaObj` int(11) NOT NULL COMMENT '所在区域',
  `buildingName` varchar(20)  NOT NULL COMMENT '楼盘名称',
  `buildingPhoto` varchar(60)  NOT NULL COMMENT '楼盘图片',
  PRIMARY KEY (`buildingId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_hourse` (
  `hourseId` int(11) NOT NULL AUTO_INCREMENT COMMENT '房屋编号',
  `hourseName` varchar(20)  NOT NULL COMMENT '房屋名称',
  `buildingObj` int(11) NOT NULL COMMENT '所在楼盘',
  `housePhoto` varchar(60)  NOT NULL COMMENT '房屋图片',
  `hourseTypeObj` int(11) NOT NULL COMMENT '房屋类型',
  `priceRangeObj` int(11) NOT NULL COMMENT '价格范围',
  `area` varchar(20)  NOT NULL COMMENT '面积',
  `price` float NOT NULL COMMENT '租金(元/月)',
  `louceng` varchar(20)  NOT NULL COMMENT '楼层/总楼层',
  `zhuangxiu` varchar(20)  NOT NULL COMMENT '装修',
  `caoxiang` varchar(20)  NULL COMMENT '朝向',
  `madeYear` varchar(20)  NULL COMMENT '建筑年代',
  `connectPerson` varchar(20)  NOT NULL COMMENT '联系人',
  `connectPhone` varchar(20)  NOT NULL COMMENT '联系电话',
  `detail` varchar(500)  NULL COMMENT '详细信息',
  `address` varchar(50)  NULL COMMENT '地址',
  PRIMARY KEY (`hourseId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_hourseType` (
  `typeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '类别编号',
  `typeName` varchar(20)  NOT NULL COMMENT '房屋类型',
  PRIMARY KEY (`typeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_priceRange` (
  `rangeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `priceName` varchar(20)  NOT NULL COMMENT '价格区间',
  PRIMARY KEY (`rangeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_wantHourseInfo` (
  `wantHourseId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `userObj` varchar(20)  NOT NULL COMMENT '求租用户',
  `title` varchar(20)  NOT NULL COMMENT '标题',
  `position` int(11) NOT NULL COMMENT '求租区域',
  `hourseTypeObj` int(11) NOT NULL COMMENT '房屋类型',
  `priceRangeObj` int(11) NOT NULL COMMENT '价格范围',
  `price` float NOT NULL COMMENT '最高能出租金',
  `lianxiren` varchar(20)  NOT NULL COMMENT '联系人',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  PRIMARY KEY (`wantHourseId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_guestBook` (
  `guestBookId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `title` varchar(40)  NOT NULL COMMENT '留言标题',
  `content` varchar(200)  NOT NULL COMMENT '留言内容',
  `userObj` varchar(20)  NOT NULL COMMENT '留言人',
  `addTime` varchar(20)  NOT NULL COMMENT '留言时间',
  PRIMARY KEY (`guestBookId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_newsInfo` (
  `newsId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `newsTitle` varchar(20)  NOT NULL COMMENT '标题',
  `newsContent` varchar(200)  NOT NULL COMMENT '新闻内容',
  `newsDate` varchar(20)  NULL COMMENT '发布日期',
  PRIMARY KEY (`newsId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_buildingInfo ADD CONSTRAINT FOREIGN KEY (areaObj) REFERENCES t_areaInfo(areaId);
ALTER TABLE t_hourse ADD CONSTRAINT FOREIGN KEY (buildingObj) REFERENCES t_buildingInfo(buildingId);
ALTER TABLE t_hourse ADD CONSTRAINT FOREIGN KEY (hourseTypeObj) REFERENCES t_hourseType(typeId);
ALTER TABLE t_hourse ADD CONSTRAINT FOREIGN KEY (priceRangeObj) REFERENCES t_priceRange(rangeId);
ALTER TABLE t_wantHourseInfo ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_wantHourseInfo ADD CONSTRAINT FOREIGN KEY (position) REFERENCES t_areaInfo(areaId);
ALTER TABLE t_wantHourseInfo ADD CONSTRAINT FOREIGN KEY (hourseTypeObj) REFERENCES t_hourseType(typeId);
ALTER TABLE t_wantHourseInfo ADD CONSTRAINT FOREIGN KEY (priceRangeObj) REFERENCES t_priceRange(rangeId);
ALTER TABLE t_guestBook ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);


