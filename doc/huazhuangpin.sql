/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50532
Source Host           : localhost:3306
Source Database       : huazhuangpin

Target Server Type    : MYSQL
Target Server Version : 50532
File Encoding         : 65001

Date: 2013-08-19 22:49:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `brands`
-- ----------------------------
DROP TABLE IF EXISTS `brands`;
CREATE TABLE `brands` (
  `brandid` mediumint(5) NOT NULL AUTO_INCREMENT,
  `brandname` varchar(50) DEFAULT NULL COMMENT '品牌',
  PRIMARY KEY (`brandid`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='品牌';

-- ----------------------------
-- Records of brands
-- ----------------------------
INSERT INTO `brands` VALUES ('2', '韩雅');
INSERT INTO `brands` VALUES ('3', '温碧泉');
INSERT INTO `brands` VALUES ('4', '其他');

-- ----------------------------
-- Table structure for `entry`
-- ----------------------------
DROP TABLE IF EXISTS `entry`;
CREATE TABLE `entry` (
  `entryid` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `goodsid` int(8) unsigned NOT NULL DEFAULT '0',
  `goodsno` char(32) NOT NULL,
  `inprice` decimal(7,2) unsigned NOT NULL DEFAULT '0.00',
  `price` decimal(7,2) unsigned NOT NULL DEFAULT '0.00',
  `goodnum` int(5) NOT NULL DEFAULT '0',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  `adduserid` int(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entryid`),
  KEY `goodsid` (`goodsid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='入库单';

-- ----------------------------
-- Records of entry
-- ----------------------------

-- ----------------------------
-- Table structure for `goods`
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `goodsid` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `goodsno` char(32) NOT NULL COMMENT '商品编号或条形码',
  `unitid` int(5) NOT NULL DEFAULT '0' COMMENT '单位',
  `typeid` int(5) NOT NULL DEFAULT '0' COMMENT '类别',
  `brandid` int(5) NOT NULL DEFAULT '0' COMMENT '品牌id',
  `xinghao` varchar(30) DEFAULT NULL COMMENT '型号或尺码',
  `goodsname` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `huohao` varchar(30) DEFAULT NULL COMMENT '货号',
  `goodsnum` int(5) NOT NULL DEFAULT '0' COMMENT '商品数量',
  `guige` varchar(30) DEFAULT NULL COMMENT '规格或颜色',
  `inprice` decimal(7,2) DEFAULT '0.00' COMMENT '进货价格',
  `price` decimal(7,2) NOT NULL DEFAULT '0.00' COMMENT '零售价',
  `memo` text COMMENT '备注',
  `addtime` int(10) NOT NULL DEFAULT '0',
  `discount` decimal(3,2) NOT NULL DEFAULT '1.00' COMMENT '折扣，price*折扣，为 0.01~1小数',
  `lasttime` int(10) NOT NULL DEFAULT '0' COMMENT '最后更新时间',
  PRIMARY KEY (`goodsid`),
  KEY `goodsno` (`goodsno`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='商品信息';

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('3', '001', '1', '4', '2', '', '测试', '', '95', '', '100.00', '80.00', '', '1375024223', '1.00', '0');
INSERT INTO `goods` VALUES ('4', '002', '1', '5', '3', '', '测试1', '', '2', '', '100.00', '70.00', '', '1375024261', '1.00', '0');
INSERT INTO `goods` VALUES ('5', '021', '1', '5', '2', '', '商品2', '', '7', '', '150.00', '100.00', '', '1375197875', '1.00', '0');
INSERT INTO `goods` VALUES ('6', '022', '1', '6', '3', '', '商品22', '', '100', '', '150.00', '90.00', '', '1375197891', '1.00', '0');
INSERT INTO `goods` VALUES ('7', '003', '1', '5', '2', '', '啊的所发生的指甲油', '', '5', '', '30.00', '100.00', '', '1375284314', '1.00', '0');

-- ----------------------------
-- Table structure for `goods_delete`
-- ----------------------------
DROP TABLE IF EXISTS `goods_delete`;
CREATE TABLE `goods_delete` (
  `goodsid` int(8) unsigned NOT NULL,
  `goodsno` char(32) NOT NULL COMMENT '商品编号或条形码',
  `unitid` int(5) NOT NULL DEFAULT '0' COMMENT '单位',
  `typeid` int(5) NOT NULL DEFAULT '0' COMMENT '类别',
  `brandid` int(5) NOT NULL DEFAULT '0' COMMENT '品牌id',
  `xinghao` varchar(30) DEFAULT NULL COMMENT '型号或尺码',
  `goodsname` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `huohao` varchar(30) DEFAULT NULL COMMENT '货号',
  `goodsnum` int(5) NOT NULL DEFAULT '0' COMMENT '商品数量',
  `guige` varchar(30) DEFAULT NULL COMMENT '规格或颜色',
  `inprice` decimal(7,2) DEFAULT '0.00' COMMENT '进货价格',
  `price` decimal(7,2) NOT NULL DEFAULT '0.00' COMMENT '零售价',
  `memo` text COMMENT '备注',
  `addtime` int(10) NOT NULL DEFAULT '0',
  `discount` decimal(3,2) NOT NULL DEFAULT '1.00' COMMENT '折扣，price*折扣，为 0.01~1小数',
  `lasttime` int(10) NOT NULL DEFAULT '0',
  `movetime` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`goodsid`),
  UNIQUE KEY `goodsno` (`goodsno`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='商品信息';

-- ----------------------------
-- Records of goods_delete
-- ----------------------------
INSERT INTO `goods_delete` VALUES ('2', '爱的色放1', '1', '4', '2', '型号或尺码', '333', '货号', '22', '规格或颜色', '12.00', '5.00', '备注', '1374765949', '1.00', '0', '1374920189');
INSERT INTO `goods_delete` VALUES ('1', '商品编号或条形码12', '2', '5', '2', '型号或尺码', '商品名称', '货号', '11', '规格或颜色', '33.00', '13.00', '备注', '1374763547', '1.00', '0', '1374920733');

-- ----------------------------
-- Table structure for `orders`
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `orderid` int(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '销售编号',
  `orderno` char(15) NOT NULL COMMENT '销售单 yyyymmddxxx0000',
  `opuserid` int(5) NOT NULL DEFAULT '5',
  `workid` char(5) DEFAULT NULL COMMENT '工号',
  `day` date NOT NULL COMMENT '销售日期 yyyy-mm-dd',
  `vip` char(20) DEFAULT NULL COMMENT '会员，没有可不填',
  `discount` decimal(3,2) NOT NULL DEFAULT '1.00' COMMENT '折扣',
  `yingshou` decimal(8,2) NOT NULL DEFAULT '0.00',
  `shishou` decimal(8,2) NOT NULL DEFAULT '0.00',
  `sailerid` int(5) NOT NULL DEFAULT '0',
  `sailer` char(10) DEFAULT NULL COMMENT '业务员，没有可不填',
  `addtime` int(10) NOT NULL DEFAULT '0',
  `laikuan` decimal(8,2) NOT NULL DEFAULT '0.00',
  `zhaohui` decimal(8,2) NOT NULL DEFAULT '0.00',
  `paytype` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`orderid`),
  UNIQUE KEY `sailno` (`orderno`),
  KEY `day` (`day`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='订单表';

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('1', '20130805001001', '1', '01', '2013-08-05', null, '1.00', '150.00', '150.00', '0', null, '1375715115', '200.00', '50.00', '1');
INSERT INTO `orders` VALUES ('2', '20130805001002', '1', '01', '2013-08-05', null, '1.00', '80.00', '80.00', '0', null, '1375715326', '100.00', '20.00', '1');
INSERT INTO `orders` VALUES ('3', '20130805001003', '1', '01', '2013-08-05', null, '1.00', '170.00', '170.00', '0', null, '1375715393', '200.00', '30.00', '1');
INSERT INTO `orders` VALUES ('4', '20130805001004', '1', '01', '2013-08-05', null, '1.00', '80.00', '80.00', '0', null, '1375715531', '80.00', '0.00', '1');
INSERT INTO `orders` VALUES ('5', '20130805001005', '1', '01', '2013-08-05', null, '1.00', '80.00', '80.00', '0', null, '1375715598', '100.00', '20.00', '1');
INSERT INTO `orders` VALUES ('6', '20130805001006', '1', '01', '2013-08-05', null, '1.00', '70.00', '70.00', '0', null, '1375715684', '110.00', '40.00', '1');
INSERT INTO `orders` VALUES ('7', '20130805001007', '1', '01', '2013-08-05', null, '1.00', '340.00', '340.00', '0', null, '1375716702', '350.00', '10.00', '1');
INSERT INTO `orders` VALUES ('8', '20130810001001', '1', '01', '2013-08-10', null, '1.00', '80.00', '80.00', '0', null, '1376133653', '100.00', '20.00', '1');

-- ----------------------------
-- Table structure for `sails`
-- ----------------------------
DROP TABLE IF EXISTS `sails`;
CREATE TABLE `sails` (
  `sailid` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `orderid` int(8) unsigned NOT NULL DEFAULT '0',
  `goodsid` int(8) unsigned NOT NULL DEFAULT '0',
  `goodsno` char(32) NOT NULL DEFAULT '',
  `goodsnum` int(5) NOT NULL DEFAULT '0',
  `price` decimal(7,2) unsigned NOT NULL DEFAULT '0.00',
  `discount` decimal(3,2) unsigned NOT NULL DEFAULT '0.00',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  `adduserid` int(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`sailid`),
  KEY `orderid` (`orderid`),
  KEY `goodsid` (`goodsid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='销售表';

-- ----------------------------
-- Records of sails
-- ----------------------------
INSERT INTO `sails` VALUES ('1', '1', '3', '001', '1', '80.00', '1.00', '1375715115', '1');
INSERT INTO `sails` VALUES ('2', '1', '4', '002', '1', '70.00', '1.00', '1375715115', '1');
INSERT INTO `sails` VALUES ('3', '2', '3', '001', '1', '80.00', '1.00', '1375715326', '1');
INSERT INTO `sails` VALUES ('4', '3', '4', '002', '1', '70.00', '1.00', '1375715393', '1');
INSERT INTO `sails` VALUES ('5', '3', '7', '003', '1', '100.00', '1.00', '1375715393', '1');
INSERT INTO `sails` VALUES ('6', '4', '3', '001', '1', '80.00', '1.00', '1375715531', '1');
INSERT INTO `sails` VALUES ('7', '5', '3', '001', '1', '80.00', '1.00', '1375715598', '1');
INSERT INTO `sails` VALUES ('8', '6', '4', '002', '1', '70.00', '1.00', '1375715684', '1');
INSERT INTO `sails` VALUES ('9', '7', '3', '001', '1', '100.00', '1.00', '1375716702', '1');
INSERT INTO `sails` VALUES ('10', '7', '3', '001', '2', '80.00', '1.00', '1375716702', '1');
INSERT INTO `sails` VALUES ('11', '7', '3', '001', '1', '80.00', '1.00', '1375716702', '1');
INSERT INTO `sails` VALUES ('12', '8', '3', '001', '1', '80.00', '1.00', '1376133653', '1');

-- ----------------------------
-- Table structure for `settings`
-- ----------------------------
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `variable` char(255) NOT NULL,
  `value` text,
  `isjson` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1表示value字段为json',
  `readme` char(255) DEFAULT NULL,
  PRIMARY KEY (`variable`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='系统变量设置表';

-- ----------------------------
-- Records of settings
-- ----------------------------
INSERT INTO `settings` VALUES ('actionlist', 'sail,history,stat,entry,goods,set,user', '0', '模块列表');
INSERT INTO `settings` VALUES ('company', '名优化妆品', '0', '公司名称');
INSERT INTO `settings` VALUES ('copyright', '©2013 MingYouHuaZhuangPin All Rights Reserved.', '0', '底部版权信息');
INSERT INTO `settings` VALUES ('phone', '13641219388', '0', '联系电话');
INSERT INTO `settings` VALUES ('canChangePrice', '0', '0', '不允许销售时修改价格');
INSERT INTO `settings` VALUES ('isJiao', '0', '0', '销售四舍五入精确到角');

-- ----------------------------
-- Table structure for `types`
-- ----------------------------
DROP TABLE IF EXISTS `types`;
CREATE TABLE `types` (
  `typeid` mediumint(5) NOT NULL AUTO_INCREMENT,
  `typename` varchar(50) DEFAULT NULL COMMENT '商品类别',
  PRIMARY KEY (`typeid`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='商品类别';

-- ----------------------------
-- Records of types
-- ----------------------------
INSERT INTO `types` VALUES ('4', '睫毛膏');
INSERT INTO `types` VALUES ('5', '指甲油');
INSERT INTO `types` VALUES ('6', '杀杀杀');

-- ----------------------------
-- Table structure for `units`
-- ----------------------------
DROP TABLE IF EXISTS `units`;
CREATE TABLE `units` (
  `unitid` mediumint(5) NOT NULL AUTO_INCREMENT,
  `unitname` varchar(50) DEFAULT NULL COMMENT '单位',
  PRIMARY KEY (`unitid`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='单位';

-- ----------------------------
-- Records of units
-- ----------------------------
INSERT INTO `units` VALUES ('1', '盒');
INSERT INTO `units` VALUES ('2', '支');

-- ----------------------------
-- Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `workid` char(5) DEFAULT NULL COMMENT '工号',
  `username` varchar(60) DEFAULT NULL COMMENT '姓名',
  `password` varchar(32) DEFAULT NULL COMMENT '密码',
  `salt` varchar(10) DEFAULT NULL COMMENT '加密key',
  `action_list` text COMMENT '操作权限',
  `lasttime` int(10) NOT NULL DEFAULT '0',
  `login_num` int(8) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='登录用户';

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', '01', '超级管理员', '96e79218965eb72c92a549dd5a330112', null, 'sail,set,stat,user,history,goods,entry', '1376922753', '72');
INSERT INTO `users` VALUES ('2', '02', '收银员01', '96e79218965eb72c92a549dd5a330112', null, 'sail,history', '1376215309', '4');

-- ----------------------------
-- View structure for `goods_v`
-- ----------------------------
DROP VIEW IF EXISTS `goods_v`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `goods_v` AS select `goods`.`goodsid` AS `goodsid`,`goods`.`goodsno` AS `goodsno`,`goods`.`unitid` AS `unitid`,`goods`.`typeid` AS `typeid`,`goods`.`xinghao` AS `xinghao`,`goods`.`goodsname` AS `goodsname`,`goods`.`huohao` AS `huohao`,`goods`.`goodsnum` AS `goodsnum`,`goods`.`guige` AS `guige`,`goods`.`inprice` AS `inprice`,`goods`.`price` AS `price`,`goods`.`memo` AS `memo`,`goods`.`addtime` AS `addtime`,`goods`.`discount` AS `discount`,`goods`.`lasttime` AS `lasttime`,`brands`.`brandname` AS `brandname`,`goods`.`brandid` AS `brandid`,`types`.`typename` AS `typename`,`units`.`unitname` AS `unitname` from (((`goods` join `brands` on((`goods`.`brandid` = `brands`.`brandid`))) join `units` on((`goods`.`unitid` = `units`.`unitid`))) join `types` on((`goods`.`typeid` = `types`.`typeid`))) ;
