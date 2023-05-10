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

CREATE TABLE IF NOT EXISTS `t_newsClass` (
  `newsClassId` int(11) NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `newsClassName` varchar(20)  NOT NULL COMMENT '分类名称',
  PRIMARY KEY (`newsClassId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_news` (
  `newsId` int(11) NOT NULL AUTO_INCREMENT COMMENT '新闻id',
  `newsClassObj` int(11) NOT NULL COMMENT '新闻类别',
  `newsTitle` varchar(50)  NOT NULL COMMENT '新闻标题',
  `newsPhoto` varchar(60)  NOT NULL COMMENT '新闻图片',
  `content` varchar(5000)  NOT NULL COMMENT '新闻内容',
  `comFrom` varchar(20)  NOT NULL COMMENT '新闻来源',
  `hitNum` int(11) NOT NULL COMMENT '浏览次数',
  `addTime` varchar(20)  NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`newsId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `user_name` varchar(20)  NOT NULL COMMENT 'user_name',
  `password` varchar(20)  NOT NULL COMMENT '密码',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `sex` varchar(4)  NOT NULL COMMENT '性别',
  `birthday` varchar(20)  NULL COMMENT '出生日期',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `email` varchar(40)  NULL COMMENT '邮箱地址',
  `address` varchar(60)  NULL COMMENT '家庭地址',
  `photo` varchar(60)  NOT NULL COMMENT '照片',
  `memo` varchar(500)  NULL COMMENT '附加信息',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_newsTag` (
  `tagId` int(11) NOT NULL AUTO_INCREMENT COMMENT '标记id',
  `newsObj` int(11) NOT NULL COMMENT '被标记新闻',
  `userObj` varchar(20)  NOT NULL COMMENT '标记的用户',
  `newsState` int(11) NOT NULL COMMENT '新闻状态',
  `tagTime` varchar(30)  NOT NULL COMMENT '标记时间',
  PRIMARY KEY (`tagId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_newsComment` (
  `commentId` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `newsObj` int(11) NOT NULL COMMENT '被评新闻',
  `userObj` varchar(20)  NOT NULL COMMENT '评论人',
  `content` varchar(100)  NOT NULL COMMENT '评论内容',
  `commentTime` varchar(30)  NOT NULL COMMENT '评论时间',
  PRIMARY KEY (`commentId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_newsCollection` (
  `collectionId` int(11) NOT NULL AUTO_INCREMENT COMMENT '收藏id',
  `newsObj` int(11) NOT NULL COMMENT '被收藏新闻',
  `userObj` varchar(20)  NOT NULL COMMENT '收藏人',
  `collectTime` varchar(30)  NOT NULL COMMENT '收藏时间',
  PRIMARY KEY (`collectionId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_zambia` (
  `zambiaId` int(11) NOT NULL AUTO_INCREMENT COMMENT '赞id',
  `newsObj` int(11) NOT NULL COMMENT '被赞新闻',
  `userObj` varchar(20)  NOT NULL COMMENT '用户',
  `zambiaTime` varchar(20)  NOT NULL COMMENT '被赞时间',
  PRIMARY KEY (`zambiaId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_news ADD CONSTRAINT FOREIGN KEY (newsClassObj) REFERENCES t_newsClass(newsClassId);
ALTER TABLE t_newsTag ADD CONSTRAINT FOREIGN KEY (newsObj) REFERENCES t_news(newsId);
ALTER TABLE t_newsTag ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_newsComment ADD CONSTRAINT FOREIGN KEY (newsObj) REFERENCES t_news(newsId);
ALTER TABLE t_newsComment ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_newsCollection ADD CONSTRAINT FOREIGN KEY (newsObj) REFERENCES t_news(newsId);
ALTER TABLE t_newsCollection ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_zambia ADD CONSTRAINT FOREIGN KEY (newsObj) REFERENCES t_news(newsId);
ALTER TABLE t_zambia ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);


