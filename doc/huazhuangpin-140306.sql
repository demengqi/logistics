/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50532
Source Host           : localhost:3306
Source Database       : huazhuangpin

Target Server Type    : MYSQL
Target Server Version : 50532
File Encoding         : 65001

Date: 2014-03-06 23:28:39
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
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='品牌';

-- ----------------------------
-- Records of brands
-- ----------------------------
INSERT INTO `brands` VALUES ('2', '韩雅');
INSERT INTO `brands` VALUES ('3', '温碧泉');
INSERT INTO `brands` VALUES ('5', '仟佰草');

-- ----------------------------
-- Table structure for `entry`
-- ----------------------------
DROP TABLE IF EXISTS `entry`;
CREATE TABLE `entry` (
  `entryid` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `goodsno` char(32) NOT NULL,
  `inprice` decimal(7,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '进货价',
  `goodsnum` int(5) NOT NULL DEFAULT '0',
  `memo` text,
  `adddate` date NOT NULL DEFAULT '0000-00-00' COMMENT '采购日期',
  `addtime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `adduserid` int(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entryid`),
  KEY `goodsno` (`goodsno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='入库单商品详细信息';

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
  `unitid` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '单位',
  `typeid` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '类别',
  `brandid` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '品牌id',
  `xinghao` varchar(30) DEFAULT NULL COMMENT '型号或尺码',
  `goodsname` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `huohao` varchar(30) DEFAULT NULL COMMENT '货号',
  `inprice` decimal(7,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '最后录入的进货价',
  `outprice` decimal(7,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '销售价格',
  `goodsnum` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '商品数量',
  `guige` varchar(30) DEFAULT NULL COMMENT '规格或颜色',
  `memo` text COMMENT '备注',
  `isover` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1为停售',
  `addtime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `lasttime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后更新时间',
  PRIMARY KEY (`goodsid`),
  UNIQUE KEY `goodsno` (`goodsno`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品信息';

-- ----------------------------
-- Records of goods
-- ----------------------------

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
  `sailnum` int(3) unsigned NOT NULL DEFAULT '1' COMMENT '销售数量',
  `discount` decimal(3,2) NOT NULL DEFAULT '1.00' COMMENT '折扣',
  `yingshou` decimal(8,2) NOT NULL DEFAULT '0.00',
  `shishou` decimal(8,2) NOT NULL DEFAULT '0.00',
  `sailerid` int(5) NOT NULL DEFAULT '0' COMMENT '销售员id',
  `sailer` char(10) DEFAULT NULL COMMENT '业务员，没有可不填',
  `addtime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `laikuan` decimal(8,2) NOT NULL DEFAULT '0.00',
  `zhaohui` decimal(8,2) NOT NULL DEFAULT '0.00',
  `paytype` char(10) NOT NULL DEFAULT 'cash' COMMENT 'cash现金或card刷卡',
  PRIMARY KEY (`orderid`),
  UNIQUE KEY `sailno` (`orderno`),
  KEY `day` (`day`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单表';

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for `sails`
-- ----------------------------
DROP TABLE IF EXISTS `sails`;
CREATE TABLE `sails` (
  `sailid` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `orderid` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '关联orders表id',
  `goodsid` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `goodsno` char(32) NOT NULL DEFAULT '' COMMENT '商品编码',
  `goodsnum` int(5) NOT NULL DEFAULT '0' COMMENT '购买数量',
  `price` decimal(7,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '实收金额',
  `trueprice` decimal(7,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '应收金额',
  `discount` decimal(3,2) unsigned DEFAULT '0.00' COMMENT '折扣',
  `addtime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `adduserid` int(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`sailid`),
  KEY `orderid` (`orderid`),
  KEY `goodsid` (`goodsid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品销售表';

-- ----------------------------
-- Records of sails
-- ----------------------------

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
INSERT INTO `settings` VALUES ('actionlist', 'sail,history,goods,stat,set', '0', '模块列表');
INSERT INTO `settings` VALUES ('company', '名优化妆品', '0', '公司名称');
INSERT INTO `settings` VALUES ('copyright', '©2014 MingYouHuaZhuangPin All Rights Reserved.', '0', '底部版权信息');
INSERT INTO `settings` VALUES ('phone', '13641219388', '0', '联系电话');

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
INSERT INTO `users` VALUES ('1', '01', '超级管理员', '96e79218965eb72c92a549dd5a330112', null, 'sail,set,stat,user,history,goods,entry', '1394114367', '105');
INSERT INTO `users` VALUES ('2', '02', '收银员01', '96e79218965eb72c92a549dd5a330112', null, 'sail,history', '1392450825', '5');

-- ----------------------------
-- View structure for `entry_v`
-- ----------------------------
DROP VIEW IF EXISTS `entry_v`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `entry_v` AS select `entry`.`entryid` AS `entryid`,`entry`.`goodsno` AS `goodsno`,`entry`.`inprice` AS `inprice`,`entry`.`goodsnum` AS `goodsnum`,`entry`.`memo` AS `memo`,`entry`.`adddate` AS `adddate`,`entry`.`addtime` AS `addtime`,`entry`.`adduserid` AS `adduserid`,`goods`.`goodsname` AS `goodsname`,`goods`.`goodsid` AS `goodsid`,`brands`.`brandname` AS `brandname`,`types`.`typename` AS `typename`,`units`.`unitname` AS `unitname`,`goods`.`outprice` AS `outprice`,`goods`.`huohao` AS `huohao`,`goods`.`guige` AS `guige`,`goods`.`xinghao` AS `xinghao`,`goods`.`isover` AS `isover` from ((((`entry` left join `goods` on((`entry`.`goodsno` = `goods`.`goodsno`))) left join `brands` on((`goods`.`brandid` = `brands`.`brandid`))) left join `types` on((`goods`.`typeid` = `types`.`typeid`))) left join `units` on((`goods`.`unitid` = `units`.`unitid`))) ;

-- ----------------------------
-- View structure for `goods_v`
-- ----------------------------
DROP VIEW IF EXISTS `goods_v`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `goods_v` AS select `goods`.`goodsid` AS `goodsid`,`goods`.`goodsno` AS `goodsno`,`goods`.`unitid` AS `unitid`,`goods`.`typeid` AS `typeid`,`goods`.`brandid` AS `brandid`,`goods`.`xinghao` AS `xinghao`,`goods`.`goodsname` AS `goodsname`,`goods`.`huohao` AS `huohao`,`goods`.`outprice` AS `outprice`,`goods`.`goodsnum` AS `goodsnum`,`goods`.`guige` AS `guige`,`goods`.`memo` AS `memo`,`goods`.`addtime` AS `addtime`,`goods`.`lasttime` AS `lasttime`,`types`.`typename` AS `typename`,`units`.`unitname` AS `unitname`,`brands`.`brandname` AS `brandname`,`goods`.`isover` AS `isover`,`goods`.`inprice` AS `inprice` from (((`goods` left join `types` on((`goods`.`typeid` = `types`.`typeid`))) left join `units` on((`goods`.`unitid` = `units`.`unitid`))) left join `brands` on((`goods`.`brandid` = `brands`.`brandid`))) ;

-- ----------------------------
-- View structure for `sail_order_v`
-- ----------------------------
DROP VIEW IF EXISTS `sail_order_v`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sail_order_v` AS select `sails`.`sailid` AS `sailid`,`sails`.`orderid` AS `orderid`,`sails`.`goodsid` AS `goodsid`,`sails`.`goodsno` AS `goodsno`,`sails`.`goodsnum` AS `goodsnum`,`sails`.`price` AS `price`,`sails`.`trueprice` AS `trueprice`,`sails`.`discount` AS `discount`,`sails`.`addtime` AS `addtime`,`sails`.`adduserid` AS `adduserid`,`orders`.`orderno` AS `orderno`,`orders`.`opuserid` AS `opuserid`,`orders`.`workid` AS `workid`,`orders`.`day` AS `day`,`orders`.`shishou` AS `shishou`,`orders`.`yingshou` AS `yingshou`,`orders`.`sailerid` AS `sailerid`,`orders`.`sailer` AS `sailer`,`orders`.`laikuan` AS `laikuan`,`orders`.`zhaohui` AS `zhaohui`,`orders`.`paytype` AS `paytype`,`goods`.`goodsname` AS `goodsname`,`goods`.`xinghao` AS `xinghao`,`goods`.`brandid` AS `brandid`,`goods`.`typeid` AS `typeid`,`goods`.`unitid` AS `unitid`,`goods`.`outprice` AS `outprice`,`goods`.`guige` AS `guige`,`goods`.`isover` AS `isover`,`goods`.`memo` AS `memo`,`orders`.`sailnum` AS `sailnum`,`units`.`unitname` AS `unitname`,`goods`.`inprice` AS `inprice`,`goods`.`huohao` AS `huohao` from (((`sails` left join `orders` on((`sails`.`orderid` = `orders`.`orderid`))) left join `goods` on((`sails`.`goodsno` = `goods`.`goodsno`))) left join `units` on((`goods`.`unitid` = `units`.`unitid`))) ;
