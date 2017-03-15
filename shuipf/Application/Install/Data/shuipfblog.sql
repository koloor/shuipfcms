/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50536
Source Host           : 127.0.0.1:3306
Source Database       : shuipfcms

Target Server Type    : MYSQL
Target Server Version : 50536
File Encoding         : 65001

Date: 2014-06-14 11:40:16
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for shuipfcms_access
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_access`;
CREATE TABLE `shuipfcms_access` (
  `role_id` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '角色id',
  `app` varchar(20) NOT NULL DEFAULT '' COMMENT '模块',
  `controller` varchar(20) NOT NULL DEFAULT '' COMMENT '控制器',
  `action` varchar(20) NOT NULL DEFAULT '' COMMENT '方法',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否有效',
  KEY `role_id` (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='角色权限表';

-- ----------------------------
-- Records of shuipfcms_access
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_admin_panel
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_admin_panel`;
CREATE TABLE `shuipfcms_admin_panel` (
  `mid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '菜单ID',
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `name` char(32) NOT NULL DEFAULT '' COMMENT '菜单名',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '菜单地址',
  UNIQUE KEY `userid` (`mid`,`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='常用菜单';

-- ----------------------------
-- Records of shuipfcms_admin_panel
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_attachment
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_attachment`;
CREATE TABLE `shuipfcms_attachment` (
  `aid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '附件ID',
  `module` char(15) NOT NULL DEFAULT '' COMMENT '模块名称',
  `catid` smallint(5) NOT NULL DEFAULT '0' COMMENT '栏目ID',
  `filename` char(50) NOT NULL DEFAULT '' COMMENT '上传附件名称',
  `filepath` char(200) NOT NULL DEFAULT '' COMMENT '附件路径',
  `filesize` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '附件大小',
  `fileext` char(10) NOT NULL DEFAULT '' COMMENT '附件扩展名',
  `isimage` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为图片 1为图片',
  `isthumb` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为缩略图 1为缩略图',
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '上传用户ID',
  `isadmin` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否后台用户上传',
  `uploadtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传时间',
  `uploadip` char(15) NOT NULL DEFAULT '' COMMENT '上传ip',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '附件使用状态',
  `authcode` char(32) NOT NULL DEFAULT '' COMMENT '附件路径MD5值',
  PRIMARY KEY (`aid`),
  KEY `authcode` (`authcode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='附件表';

-- ----------------------------
-- Records of shuipfcms_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_attachment_index
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_attachment_index`;
CREATE TABLE `shuipfcms_attachment_index` (
  `keyid` char(30) NOT NULL DEFAULT '' COMMENT '关联id',
  `aid` char(10) NOT NULL DEFAULT '' COMMENT '附件ID',
  KEY `keyid` (`keyid`),
  KEY `aid` (`aid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='附件关系表';

-- ----------------------------
-- Records of shuipfcms_attachment_index
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_behavior
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_behavior`;
CREATE TABLE `shuipfcms_behavior` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '行为唯一标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '行为说明',
  `remark` char(140) NOT NULL DEFAULT '' COMMENT '行为描述',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1-控制器，2-视图',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态（0：禁用，1：正常）',
  `system` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否系统',
  `module` char(20) NOT NULL DEFAULT '' COMMENT '所属模块',
  `datetime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='系统行为表';

-- ----------------------------
-- Records of shuipfcms_behavior
-- ----------------------------
INSERT INTO `shuipfcms_behavior` VALUES ('1', 'app_init', '应用初始化标签位', '应用初始化标签位', '1', '1', '1', '', '1381021393');
INSERT INTO `shuipfcms_behavior` VALUES ('2', 'path_info', 'PATH_INFO检测标签位', 'PATH_INFO检测标签位', '1', '1', '1', '', '1381021411');
INSERT INTO `shuipfcms_behavior` VALUES ('3', 'app_begin', '应用开始标签位', '应用开始标签位', '1', '1', '1', '', '1381021424');
INSERT INTO `shuipfcms_behavior` VALUES ('4', 'action_name', '操作方法名标签位', '操作方法名标签位', '1', '1', '1', '', '1381021437');
INSERT INTO `shuipfcms_behavior` VALUES ('5', 'action_begin', '控制器开始标签位', '控制器开始标签位', '1', '1', '1', '', '1381021450');
INSERT INTO `shuipfcms_behavior` VALUES ('6', 'view_begin', '视图输出开始标签位', '视图输出开始标签位', '1', '1', '1', '', '1381021463');
INSERT INTO `shuipfcms_behavior` VALUES ('7', 'view_parse', '视图解析标签位', '视图解析标签位', '1', '1', '1', '', '1381021476');
INSERT INTO `shuipfcms_behavior` VALUES ('8', 'template_filter', '模板内容解析标签位', '模板内容解析标签位', '1', '1', '1', '', '1381021488');
INSERT INTO `shuipfcms_behavior` VALUES ('9', 'view_filter', '视图输出过滤标签位', '视图输出过滤标签位', '1', '1', '1', '', '1381021621');
INSERT INTO `shuipfcms_behavior` VALUES ('10', 'view_end', '视图输出结束标签位', '视图输出结束标签位', '1', '1', '1', '', '1381021631');
INSERT INTO `shuipfcms_behavior` VALUES ('11', 'action_end', '控制器结束标签位', '控制器结束标签位', '1', '1', '1', '', '1381021642');
INSERT INTO `shuipfcms_behavior` VALUES ('12', 'app_end', '应用结束标签位', '应用结束标签位', '1', '1', '1', '', '1381021654');
INSERT INTO `shuipfcms_behavior` VALUES ('13', 'appframe_rbac_init', '后台权限控制', '后台权限控制', '1', '1', '1', '', '1381023560');

-- ----------------------------
-- Table structure for shuipfcms_behavior_log
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_behavior_log`;
CREATE TABLE `shuipfcms_behavior_log` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ruleid` int(10) NOT NULL DEFAULT '0' COMMENT '行为ID',
  `guid` char(50) NOT NULL DEFAULT '' COMMENT '标识',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='行为日志';

-- ----------------------------
-- Records of shuipfcms_behavior_log
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_behavior_rule
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_behavior_rule`;
CREATE TABLE `shuipfcms_behavior_rule` (
  `ruleid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `behaviorid` int(11) NOT NULL DEFAULT '0' COMMENT '行为id',
  `system` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否系统',
  `module` char(20) NOT NULL DEFAULT '' COMMENT '规则所属模块',
  `addons` char(20) NOT NULL DEFAULT '' COMMENT '规则所属插件',
  `rule` text COMMENT '行为规则',
  `listorder` tinyint(3) NOT NULL DEFAULT '0' COMMENT '排序',
  `datetime` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`ruleid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='行为规则表';

-- ----------------------------
-- Records of shuipfcms_behavior_rule
-- ----------------------------
INSERT INTO `shuipfcms_behavior_rule` VALUES ('1', '1', '1', '', '', 'phpfile:BuildLiteBehavior', '0', '1381021954');
INSERT INTO `shuipfcms_behavior_rule` VALUES ('2', '3', '1', '', '', 'phpfile:ReadHtmlCacheBehavior', '0', '1381021954');
INSERT INTO `shuipfcms_behavior_rule` VALUES ('3', '12', '1', '', '', 'phpfile:ShowPageTraceBehavior', '0', '1381021954');
INSERT INTO `shuipfcms_behavior_rule` VALUES ('4', '7', '1', '', '', 'phpfile:ParseTemplateBehavior', '0', '1381021954');
INSERT INTO `shuipfcms_behavior_rule` VALUES ('5', '8', '1', '', '', 'phpfile:ContentReplaceBehavior', '0', '1381021954');
INSERT INTO `shuipfcms_behavior_rule` VALUES ('6', '9', '1', '', '', 'phpfile:WriteHtmlCacheBehavior', '0', '1381021954');
INSERT INTO `shuipfcms_behavior_rule` VALUES ('7', '1', '1', '', '', 'phpfile:AppInitBehavior|module:Common', '0', '1381021954');
INSERT INTO `shuipfcms_behavior_rule` VALUES ('8', '3', '1', '', '', 'phpfile:AppBeginBehavior|module:Common', '0', '1381021954');
INSERT INTO `shuipfcms_behavior_rule` VALUES ('9', '6', '1', '', '', 'phpfile:ViewBeginBehavior|module:Common', '0', '1381021954');

-- ----------------------------
-- Table structure for shuipfcms_cache
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_cache`;
CREATE TABLE `shuipfcms_cache` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `key` char(100) NOT NULL DEFAULT '' COMMENT '缓存key值',
  `name` char(100) NOT NULL DEFAULT '' COMMENT '名称',
  `module` char(20) NOT NULL DEFAULT '' COMMENT '模块名称',
  `model` char(30) NOT NULL DEFAULT '' COMMENT '模型名称',
  `action` char(30) NOT NULL DEFAULT '' COMMENT '方法名',
  `param` char(255) NOT NULL DEFAULT '' COMMENT '参数',
  `system` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否系统',
  PRIMARY KEY (`id`),
  KEY `ckey` (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='缓存更新列队';

-- ----------------------------
-- Records of shuipfcms_cache
-- ----------------------------
INSERT INTO `shuipfcms_cache` VALUES ('1', 'Config', '网站配置', '', 'Config', 'config_cache', '', '1');
INSERT INTO `shuipfcms_cache` VALUES ('2', 'Module', '可用模块列表', '', 'Module', 'module_cache', '', '1');
INSERT INTO `shuipfcms_cache` VALUES ('3', 'Behavior', '行为列表', '', 'Behavior', 'behavior_cache', '', '1');
INSERT INTO `shuipfcms_cache` VALUES ('4', 'Menu', '后台菜单', 'Admin', 'Menu', 'menu_cache', '', '0');
INSERT INTO `shuipfcms_cache` VALUES ('5', 'Category', '栏目索引', 'Content', 'Category', 'category_cache', '', '0');
INSERT INTO `shuipfcms_cache` VALUES ('6', 'Model', '模型列表', 'Content', 'Model', 'model_cache', '', '0');
INSERT INTO `shuipfcms_cache` VALUES ('7', 'Urlrules', 'URL规则', 'Content', 'Urlrule', 'urlrule_cache', '', '0');
INSERT INTO `shuipfcms_cache` VALUES ('8', 'ModelField', '模型字段', 'Content', 'ModelField', 'model_field_cache', '', '0');
INSERT INTO `shuipfcms_cache` VALUES ('9', 'Position', '推荐位', 'Content', 'Position', 'position_cache', '', '0');

-- ----------------------------
-- Table structure for shuipfcms_category
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_category`;
CREATE TABLE `shuipfcms_category` (
  `catid` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '栏目ID',
  `module` varchar(15) NOT NULL DEFAULT '' COMMENT '所属模块',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '类别',
  `modelid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '模型ID',
  `domain` varchar(200) NOT NULL DEFAULT '' COMMENT '栏目绑定域名',
  `parentid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `arrparentid` varchar(255) NOT NULL DEFAULT '' COMMENT '所有父ID',
  `child` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否存在子栏目，1存在',
  `arrchildid` mediumtext COMMENT '所有子栏目ID',
  `catname` varchar(30) NOT NULL DEFAULT '' COMMENT '栏目名称',
  `image` varchar(100) NOT NULL DEFAULT '' COMMENT '栏目图片',
  `description` mediumtext COMMENT '栏目描述',
  `parentdir` varchar(100) NOT NULL DEFAULT '' COMMENT '父目录',
  `catdir` varchar(30) NOT NULL DEFAULT '' COMMENT '栏目目录',
  `url` varchar(100) NOT NULL DEFAULT '' COMMENT '链接地址',
  `hits` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '栏目点击数',
  `setting` mediumtext COMMENT '相关配置信息',
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `ismenu` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示',
  `sethtml` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否生成静态',
  `letter` varchar(30) NOT NULL DEFAULT '' COMMENT '栏目拼音',
  PRIMARY KEY (`catid`),
  KEY `module` (`module`,`parentid`,`listorder`,`catid`),
  KEY `siteid` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='栏目表';

-- ----------------------------
-- Records of shuipfcms_category
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_category_field
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_category_field`;
CREATE TABLE `shuipfcms_category_field` (
  `fid` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `catid` smallint(5) NOT NULL DEFAULT '0' COMMENT '栏目ID',
  `fieldname` varchar(30) NOT NULL DEFAULT '' COMMENT '字段名',
  `type` varchar(10) NOT NULL DEFAULT '' COMMENT '类型,input',
  `setting` mediumtext COMMENT '其他',
  `createtime` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`fid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='栏目扩展字段列表';

-- ----------------------------
-- Records of shuipfcms_category_field
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_category_priv
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_category_priv`;
CREATE TABLE `shuipfcms_category_priv` (
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `roleid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '角色或者组ID',
  `is_admin` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为管理员 1、管理员',
  `action` char(30) NOT NULL DEFAULT '' COMMENT '动作',
  KEY `catid` (`catid`,`roleid`,`is_admin`,`action`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='栏目权限表';

-- ----------------------------
-- Records of shuipfcms_category_priv
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_config
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_config`;
CREATE TABLE `shuipfcms_config` (
  `id` smallint(8) unsigned NOT NULL AUTO_INCREMENT,
  `varname` varchar(20) NOT NULL DEFAULT '',
  `info` varchar(100) NOT NULL DEFAULT '',
  `groupid` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `value` text,
  PRIMARY KEY (`id`),
  KEY `varname` (`varname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='网站配置表';

-- ----------------------------
-- Records of shuipfcms_config
-- ----------------------------
INSERT INTO `shuipfcms_config` VALUES ('1', 'sitename', '网站名称', '1', 'ShuipFCMS内容管理系统');
INSERT INTO `shuipfcms_config` VALUES ('2', 'siteurl', '网站网址', '1', '/');
INSERT INTO `shuipfcms_config` VALUES ('3', 'sitefileurl', '附件地址', '1', '/d/file/');
INSERT INTO `shuipfcms_config` VALUES ('4', 'siteemail', '站点邮箱', '1', 'ad@qq.com');
INSERT INTO `shuipfcms_config` VALUES ('6', 'siteinfo', '网站介绍', '1', 'ShuipFCMS网站管理系统,是一款完全开源免费的PHP+MYSQL系统.核心采用了Thinkphp框架等众多开源软件,同时核心功能也作为开源软件发布');
INSERT INTO `shuipfcms_config` VALUES ('7', 'sitekeywords', '网站关键字', '1', 'ShuipFCMS内容管理系统');
INSERT INTO `shuipfcms_config` VALUES ('8', 'uploadmaxsize', '允许上传附件大小', '1', '20240');
INSERT INTO `shuipfcms_config` VALUES ('9', 'uploadallowext', '允许上传附件类型', '1', 'jpg|jpeg|gif|bmp|png|doc|docx|xls|xlsx|ppt|pptx|pdf|txt|rar|zip|swf');
INSERT INTO `shuipfcms_config` VALUES ('10', 'qtuploadmaxsize', '前台允许上传附件大小', '1', '200');
INSERT INTO `shuipfcms_config` VALUES ('11', 'qtuploadallowext', '前台允许上传附件类型', '1', 'jpg|jpeg|gif');
INSERT INTO `shuipfcms_config` VALUES ('12', 'watermarkenable', '是否开启图片水印', '1', '1');
INSERT INTO `shuipfcms_config` VALUES ('13', 'watermarkminwidth', '水印-宽', '1', '300');
INSERT INTO `shuipfcms_config` VALUES ('14', 'watermarkminheight', '水印-高', '1', '100');
INSERT INTO `shuipfcms_config` VALUES ('15', 'watermarkimg', '水印图片', '1', '/statics/images/mark_bai.png');
INSERT INTO `shuipfcms_config` VALUES ('16', 'watermarkpct', '水印透明度', '1', '80');
INSERT INTO `shuipfcms_config` VALUES ('17', 'watermarkquality', 'JPEG 水印质量', '1', '85');
INSERT INTO `shuipfcms_config` VALUES ('18', 'watermarkpos', '水印位置', '1', '7');
INSERT INTO `shuipfcms_config` VALUES ('19', 'theme', '主题风格', '1', 'Default');
INSERT INTO `shuipfcms_config` VALUES ('20', 'ftpstatus', 'FTP上传', '1', '0');
INSERT INTO `shuipfcms_config` VALUES ('21', 'ftpuser', 'FTP用户名', '1', '');
INSERT INTO `shuipfcms_config` VALUES ('22', 'ftppassword', 'FTP密码', '1', '');
INSERT INTO `shuipfcms_config` VALUES ('23', 'ftphost', 'FTP服务器地址', '1', '');
INSERT INTO `shuipfcms_config` VALUES ('24', 'ftpport', 'FTP服务器端口', '1', '21');
INSERT INTO `shuipfcms_config` VALUES ('25', 'ftppasv', 'FTP是否开启被动模式', '1', '1');
INSERT INTO `shuipfcms_config` VALUES ('26', 'ftpssl', 'FTP是否使用SSL连接', '1', '0');
INSERT INTO `shuipfcms_config` VALUES ('27', 'ftptimeout', 'FTP超时时间', '1', '10');
INSERT INTO `shuipfcms_config` VALUES ('28', 'ftpuppat', 'FTP上传目录', '1', '/');
INSERT INTO `shuipfcms_config` VALUES ('29', 'mail_type', '邮件发送模式', '1', '1');
INSERT INTO `shuipfcms_config` VALUES ('30', 'mail_server', '邮件服务器', '1', 'smtp.qq.com');
INSERT INTO `shuipfcms_config` VALUES ('31', 'mail_port', '邮件发送端口', '1', '25');
INSERT INTO `shuipfcms_config` VALUES ('32', 'mail_from', '发件人地址', '1', 'admin@abc3210.com');
INSERT INTO `shuipfcms_config` VALUES ('33', 'mail_auth', '密码验证', '1', '1');
INSERT INTO `shuipfcms_config` VALUES ('34', 'mail_user', '邮箱用户名', '1', '');
INSERT INTO `shuipfcms_config` VALUES ('35', 'mail_password', '邮箱密码', '1', '');
INSERT INTO `shuipfcms_config` VALUES ('36', 'mail_fname', '发件人名称', '1', 'ShuipFCMS管理员');
INSERT INTO `shuipfcms_config` VALUES ('37', 'domainaccess', '指定域名访问', '1', '0');
INSERT INTO `shuipfcms_config` VALUES ('38', 'generate', '是否生成首页', '1', '1');
INSERT INTO `shuipfcms_config` VALUES ('39', 'index_urlruleid', '首页URL规则', '1', '11');
INSERT INTO `shuipfcms_config` VALUES ('40', 'indextp', '首页模板', '1', 'index.php');
INSERT INTO `shuipfcms_config` VALUES ('41', 'tagurl', 'TagURL规则', '1', '8');
INSERT INTO `shuipfcms_config` VALUES ('42', 'checkcode_type', '验证码类型', '1', '0');
INSERT INTO `shuipfcms_config` VALUES ('43', 'attachment_driver', '附件驱动', '1', 'Local');

-- ----------------------------
-- Table structure for shuipfcms_config_field
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_config_field`;
CREATE TABLE `shuipfcms_config_field` (
  `fid` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `fieldname` varchar(30) NOT NULL DEFAULT '' COMMENT '字段名',
  `type` varchar(10) NOT NULL DEFAULT '' COMMENT '类型,input',
  `setting` mediumtext COMMENT '其他',
  `createtime` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`fid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='网站配置，扩展字段列表';

-- ----------------------------
-- Records of shuipfcms_config_field
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_customlist
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_customlist`;
CREATE TABLE `shuipfcms_customlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自定义列表ID',
  `url` char(100) NOT NULL DEFAULT '' COMMENT '访问地址',
  `name` varchar(60) NOT NULL DEFAULT '' COMMENT '列表标题',
  `title` varchar(120) NOT NULL DEFAULT '' COMMENT '网页标题',
  `keywords` varchar(40) NOT NULL DEFAULT '' COMMENT '网页关键字',
  `description` text COMMENT '页面简介',
  `totalsql` text COMMENT '数据统计SQL',
  `listsql` text COMMENT '数据查询SQL',
  `lencord` int(11) NOT NULL DEFAULT '0' COMMENT '每页显示',
  `urlruleid` int(11) NOT NULL DEFAULT '0' COMMENT 'URL规则ID',
  `urlrule` varchar(120) NOT NULL DEFAULT '' COMMENT 'URL规则',
  `template` mediumtext COMMENT '模板',
  `listpath` varchar(60) NOT NULL DEFAULT '' COMMENT '列表模板文件',
  `createtime` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='自定义列表';

-- ----------------------------
-- Records of shuipfcms_customlist
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_customtemp
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_customtemp`;
CREATE TABLE `shuipfcms_customtemp` (
  `tempid` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '模板ID',
  `name` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '模板名称',
  `tempname` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '模板完整文件名',
  `temppath` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '模板生成路径',
  `temptext` mediumtext CHARACTER SET utf8 COMMENT '模板内容',
  PRIMARY KEY (`tempid`),
  KEY `tempname` (`tempname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='自定义模板表';

-- ----------------------------
-- Records of shuipfcms_customtemp
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_locking
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_locking`;
CREATE TABLE `shuipfcms_locking` (
  `userid` int(11) NOT NULL COMMENT '用户ID',
  `username` varchar(30) NOT NULL DEFAULT '' COMMENT '用户名',
  `catid` smallint(5) NOT NULL DEFAULT '0' COMMENT '栏目ID',
  `id` mediumint(8) NOT NULL DEFAULT '0' COMMENT '信息ID',
  `locktime` int(10) NOT NULL DEFAULT '0' COMMENT '锁定时间',
  KEY `userid` (`userid`),
  KEY `onlinetime` (`locktime`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='信息锁定';

-- ----------------------------
-- Records of shuipfcms_locking
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_loginlog
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_loginlog`;
CREATE TABLE `shuipfcms_loginlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `username` char(30) NOT NULL DEFAULT '' COMMENT '登录帐号',
  `logintime` int(10) NOT NULL DEFAULT '0' COMMENT '登录时间戳',
  `loginip` char(20) NOT NULL DEFAULT '' COMMENT '登录IP',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态,1为登录成功，0为登录失败',
  `password` varchar(30) NOT NULL DEFAULT '' COMMENT '尝试错误密码',
  `info` varchar(255) NOT NULL DEFAULT '' COMMENT '其他说明',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='后台登陆日志表';

-- ----------------------------
-- Records of shuipfcms_loginlog
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_menu
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_menu`;
CREATE TABLE `shuipfcms_menu` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '菜单名称',
  `parentid` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '上级菜单',
  `app` char(20) NOT NULL DEFAULT '' COMMENT '应用标识',
  `controller` char(20) NOT NULL DEFAULT '' COMMENT '控制键',
  `action` char(20) NOT NULL DEFAULT '' COMMENT '方法',
  `parameter` char(255) NOT NULL DEFAULT '' COMMENT '附加参数',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '类型',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `listorder` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '排序ID',
  PRIMARY KEY (`id`),
  KEY `parentid` (`parentid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='后台菜单表';

-- ----------------------------
-- Records of shuipfcms_menu
-- ----------------------------
INSERT INTO `shuipfcms_menu` VALUES ('1', '缓存更新', '0', 'Admin', 'Index', 'cache', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('2', '我的面板', '0', 'Admin', 'Config', 'index', '', '0', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('3', '设置', '0', 'Admin', 'Config', 'index', '', '0', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('4', '个人信息', '2', 'Admin', 'Adminmanage', 'myinfo', '', '0', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('5', '修改个人信息', '4', 'Admin', 'Adminmanage', 'myinfo', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('6', '修改密码', '4', 'Admin', 'Adminmanage', 'chanpass', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('7', '系统设置', '3', 'Admin', 'Config', 'index', '', '0', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('8', '站点配置', '7', 'Admin', 'Config', 'index', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('9', '邮箱配置', '8', 'Admin', 'Config', 'mail', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('10', '附件配置', '8', 'Admin', 'Config', 'attach', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('11', '高级配置', '8', 'Admin', 'Config', 'addition', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('12', '扩展配置', '8', 'Admin', 'Config', 'extend', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('13', '行为管理', '7', 'Admin', 'Behavior', 'index', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('14', '行为日志', '13', 'Admin', 'Behavior', 'logs', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('15', '编辑行为', '13', 'Admin', 'Behavior', 'edit', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('16', '删除行为', '13', 'Admin', 'Behavior', 'delete', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('17', '后台菜单管理', '7', 'Admin', 'Menu', 'index', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('18', '添加菜单', '17', 'Admin', 'Menu', 'add', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('19', '修改', '17', 'Admin', 'Menu', 'edit', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('20', '删除', '17', 'Admin', 'Menu', 'delete', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('21', '管理员设置', '3', 'Admin', 'Management', 'index', '', '0', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('22', '管理员管理', '21', 'Admin', 'Management', 'manager', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('23', '添加管理员', '22', 'Admin', 'Management', 'adminadd', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('24', '编辑管理信息', '22', 'Admin', 'Management', 'edit', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('25', '删除管理员', '22', 'Admin', 'Management', 'delete', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('26', '角色管理', '21', 'Admin', 'Rbac', 'rolemanage', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('27', '添加角色', '26', 'Admin', 'Rbac', 'roleadd', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('28', '删除角色', '26', 'Admin', 'Rbac', 'roledelete', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('29', '角色编辑', '26', 'Admin', 'Rbac', 'roleedit', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('30', '角色授权', '26', 'Admin', 'Rbac', 'authorize', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('31', '日志管理', '3', 'Admin', 'Logs', 'index', '', '0', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('32', '后台登陆日志', '31', 'Admin', 'Logs', 'loginlog', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('33', '后台操作日志', '31', 'Admin', 'Logs', 'index', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('34', '删除一个月前的登陆日志', '32', 'Admin', 'Logs', 'deleteloginlog', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('35', '删除一个月前的操作日志', '33', 'Admin', 'Logs', 'deletelog', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('36', '添加行为', '13', 'Admin', 'Behavior', 'add', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('37', '模块', '0', 'Admin', 'Module', 'index', '', '0', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('38', '在线云平台', '37', 'Admin', 'Cloud', 'index', '', '0', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('39', '模块商店', '38', 'Admin', 'Moduleshop', 'index', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('40', '插件商店', '38', 'Admin', 'Addonshop', 'index', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('41', '在线升级', '38', 'Admin', 'Upgrade', 'index', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('42', '本地模块管理', '37', 'Admin', 'Module', 'local', '', '0', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('43', '模块管理', '42', 'Admin', 'Module', 'index', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('44', '内容', '0', 'Content', 'Index', 'index', '', '0', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('45', '内容管理', '44', 'Content', 'Content', 'index', '', '0', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('46', '内容相关设置', '44', 'Content', 'Category', 'index', '', '0', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('47', '栏目列表', '46', 'Content', 'Category', 'index', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('48', '添加栏目', '47', 'Content', 'Category', 'add', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('49', '添加单页', '47', 'Content', 'Category', 'singlepage', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('50', '添加外部链接栏目', '47', 'Content', 'Category', 'wadd', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('51', '编辑栏目', '47', 'Content', 'Category', 'edit', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('52', '删除栏目', '47', 'Content', 'Category', 'delete', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('53', '栏目属性转换', '47', 'Content', 'Category', 'categoryshux', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('54', '模型管理', '46', 'Content', 'Models', 'index', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('55', '创建新模型', '54', 'Content', 'Models', 'add', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('56', '删除模型', '54', 'Content', 'Models', 'delete', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('57', '编辑模型', '54', 'Content', 'Models', 'edit', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('58', '模型禁用', '54', 'Content', 'Models', 'disabled', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('59', '模型导入', '54', 'Content', 'Models', 'import', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('60', '字段管理', '54', 'Content', 'Field', 'index', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('61', '字段修改', '60', 'Content', 'Field', 'edit', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('62', '字段删除', '60', 'Content', 'Field', 'delete', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('63', '字段状态', '60', 'Content', 'Field', 'disabled', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('64', '模型预览', '60', 'Content', 'Field', 'priview', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('65', '管理内容', '45', 'Content', 'Content', 'index', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('66', '附件管理', '45', 'Attachment', 'Atadmin', 'index', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('67', '删除', '66', 'Attachment', 'Atadmin', 'delete', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('68', '发布管理', '44', 'Content', 'Createhtml', 'index', '', '0', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('69', '批量更新栏目页', '68', 'Content', 'Createhtml', 'category', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('70', '生成首页', '68', 'Content', 'Createhtml', 'index', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('71', '批量更新URL', '68', 'Content', 'Createhtml', 'update_urls', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('72', '批量更新内容页', '68', 'Content', 'Createhtml', 'update_show', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('73', '刷新自定义页面', '68', 'Template', 'Custompage', 'createhtml', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('74', 'URL规则管理', '46', 'Content', 'Urlrule', 'index', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('75', '添加规则', '74', 'Content', 'Urlrule', 'add', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('76', '编辑', '74', 'Content', 'Urlrule', 'edit', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('77', '删除', '74', 'Content', 'Urlrule', 'delete', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('78', '推荐位管理', '46', 'Content', 'Position', 'index', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('79', '信息管理', '78', 'Content', 'Position', 'item', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('80', '添加推荐位', '78', 'Content', 'Position', 'add', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('81', '修改推荐位', '78', 'Content', 'Position', 'edit', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('82', '删除推荐位', '78', 'Content', 'Position', 'delete', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('83', '信息编辑', '79', 'Content', 'Position', 'item_manage', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('84', '信息排序', '79', 'Content', 'Position', 'item_listorder', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('85', '数据重建', '78', 'Content', 'Position', 'rebuilding', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('86', 'Tags管理', '45', 'Content', 'Tags', 'index', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('87', '修改', '86', 'Content', 'Tags', 'edit', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('88', '删除', '86', 'Content', 'Tags', 'delete', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('89', 'Tags数据重建', '86', 'Content', 'Tags', 'create', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('90', '界面', '0', 'Template', 'Style', 'index', '', '0', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('91', '模板管理', '90', 'Template', 'Style', 'index', '', '0', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('92', '模板风格', '91', 'Template', 'Style', 'index', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('93', '添加模板页', '92', 'Template', 'Style', 'add', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('94', '删除模板', '92', 'Template', 'Style', 'delete', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('95', '修改模板', '92', 'Template', 'Style', 'edit', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('96', '主题管理', '91', 'Template', 'Theme', 'index', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('97', '主题更换', '96', 'Template', 'Theme', 'chose', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('98', '自定义页面', '90', 'Template', 'Custompage', 'index', '', '0', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('99', '自定义页面', '98', 'Template', 'Custompage', 'index', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('100', '添加自定义页面', '99', 'Template', 'Custompage', 'add', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('101', '删除自定义页面', '99', 'Template', 'Custompage', 'delete', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('102', '编辑自定义页面', '99', 'Template', 'Custompage', 'edit', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('103', '自定义列表', '98', 'Template', 'Customlist', 'index', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('104', '添加列表', '103', 'Template', 'Customlist', 'add', '', '1', '1', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('105', '删除列表', '103', 'Template', 'Customlist', 'delete', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('106', '编辑列表', '103', 'Template', 'Customlist', 'edit', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('107', '生成列表', '103', 'Template', 'Customlist', 'generate', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('108', '安装模块', '39', 'Admin', 'Moduleshop', 'install', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('109', '升级模块', '39', 'Admin', 'Moduleshop', 'upgrade', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('110', '安装插件', '40', 'Admin', 'Addonshop', 'install', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('111', '升级插件', '40', 'Admin', 'Addonshop', 'upgrade', '', '1', '0', '', '0');
INSERT INTO `shuipfcms_menu` VALUES ('112', '栏目授权', '26', 'Admin', 'Rbac', 'setting_cat_priv', '', '1', '0', '', '0');

-- ----------------------------
-- Table structure for shuipfcms_model
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_model`;
CREATE TABLE `shuipfcms_model` (
  `modelid` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(30) NOT NULL DEFAULT '' COMMENT '模型名称',
  `description` char(100) NOT NULL DEFAULT '' COMMENT '描述',
  `tablename` char(20) NOT NULL DEFAULT '' COMMENT '表名',
  `setting` text COMMENT '配置信息',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `items` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '信息数',
  `enablesearch` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否开启全站搜索',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否禁用 1禁用',
  `default_style` char(30) NOT NULL DEFAULT '' COMMENT '风格',
  `category_template` char(30) NOT NULL DEFAULT '' COMMENT '栏目模板',
  `list_template` char(30) NOT NULL DEFAULT '' COMMENT '列表模板',
  `show_template` char(30) NOT NULL DEFAULT '' COMMENT '内容模板',
  `js_template` varchar(30) NOT NULL DEFAULT '' COMMENT 'JS模板',
  `sort` tinyint(3) NOT NULL DEFAULT '0' COMMENT '排序',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '模块标识',
  PRIMARY KEY (`modelid`),
  KEY `type` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='内容模型列表';

-- ----------------------------
-- Records of shuipfcms_model
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_model_field
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_model_field`;
CREATE TABLE `shuipfcms_model_field` (
  `fieldid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `modelid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '模型ID',
  `field` varchar(20) NOT NULL DEFAULT '' COMMENT '字段名',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '别名',
  `tips` text COMMENT '字段提示',
  `css` varchar(30) NOT NULL DEFAULT '' COMMENT '表单样式',
  `minlength` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最小值',
  `maxlength` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最大值',
  `pattern` varchar(255) NOT NULL DEFAULT '' COMMENT '数据校验正则',
  `errortips` varchar(255) NOT NULL DEFAULT '' COMMENT '数据校验未通过的提示信息',
  `formtype` varchar(20) NOT NULL DEFAULT '' COMMENT '字段类型',
  `setting` mediumtext,
  `formattribute` varchar(255) NOT NULL DEFAULT '',
  `unsetgroupids` varchar(255) NOT NULL DEFAULT '',
  `unsetroleids` varchar(255) NOT NULL DEFAULT '',
  `iscore` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否内部字段 1是',
  `issystem` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否系统字段 1 是',
  `isunique` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '值唯一',
  `isbase` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '作为基本信息',
  `issearch` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '作为搜索条件',
  `isadd` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '在前台投稿中显示',
  `isfulltext` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '作为全站搜索信息',
  `isposition` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否入库到推荐位',
  `listorder` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1 禁用 0启用',
  `isomnipotent` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`fieldid`),
  KEY `modelid` (`modelid`,`disabled`),
  KEY `field` (`field`,`modelid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='模型字段列表';

-- ----------------------------
-- Records of shuipfcms_model_field
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_module
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_module`;
CREATE TABLE `shuipfcms_module` (
  `module` varchar(15) NOT NULL COMMENT '模块',
  `modulename` varchar(20) NOT NULL DEFAULT '' COMMENT '模块名称',
  `sign` varchar(255) NOT NULL DEFAULT '' COMMENT '签名',
  `iscore` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '内置模块',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否可用',
  `version` varchar(50) NOT NULL DEFAULT '' COMMENT '版本',
  `setting` mediumtext COMMENT '设置信息',
  `installtime` int(10) NOT NULL DEFAULT '0' COMMENT '安装时间',
  `updatetime` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `listorder` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`module`),
  KEY `sign` (`sign`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='已安装模块列表';

-- ----------------------------
-- Records of shuipfcms_module
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_operationlog
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_operationlog`;
CREATE TABLE `shuipfcms_operationlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `uid` smallint(6) NOT NULL DEFAULT '0' COMMENT '操作帐号ID',
  `time` int(10) NOT NULL DEFAULT '0' COMMENT '操作时间',
  `ip` char(20) NOT NULL DEFAULT '' COMMENT 'IP',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态,0错误提示，1为正确提示',
  `info` text COMMENT '其他说明',
  `get` varchar(255) NOT NULL DEFAULT '' COMMENT 'get数据',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `username` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='后台操作日志表';

-- ----------------------------
-- Records of shuipfcms_operationlog
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_page
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_page`;
CREATE TABLE `shuipfcms_page` (
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '栏目ID',
  `title` varchar(160) NOT NULL DEFAULT '' COMMENT '标题',
  `style` varchar(24) NOT NULL DEFAULT '' COMMENT '样式',
  `keywords` varchar(40) NOT NULL DEFAULT '' COMMENT '关键字',
  `content` text COMMENT '内容',
  `template` varchar(30) NOT NULL DEFAULT '',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`catid`),
  KEY `catid` (`catid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='单页内容表';

-- ----------------------------
-- Records of shuipfcms_page
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_position
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_position`;
CREATE TABLE `shuipfcms_position` (
  `posid` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '推荐位id',
  `modelid` char(30) NOT NULL DEFAULT '' COMMENT '模型id',
  `catid` varchar(255) NOT NULL DEFAULT '' COMMENT '栏目id',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '推荐位名称',
  `maxnum` smallint(5) NOT NULL DEFAULT '20' COMMENT '最大存储数据量',
  `extention` char(100) NOT NULL DEFAULT '',
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`posid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='推荐位';

-- ----------------------------
-- Records of shuipfcms_position
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_position_data
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_position_data`;
CREATE TABLE `shuipfcms_position_data` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'ID',
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '栏目ID',
  `posid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '推荐位ID',
  `module` char(20) NOT NULL DEFAULT '' COMMENT '模型',
  `modelid` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '模型ID',
  `thumb` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有缩略图',
  `data` mediumtext COMMENT '数据信息',
  `listorder` mediumint(8) NOT NULL DEFAULT '0' COMMENT '排序',
  `expiration` int(10) NOT NULL,
  `extention` char(30) NOT NULL DEFAULT '',
  `synedit` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否同步编辑',
  KEY `posid` (`posid`),
  KEY `listorder` (`listorder`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='推荐位数据表';

-- ----------------------------
-- Records of shuipfcms_position_data
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_role
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_role`;
CREATE TABLE `shuipfcms_role` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '角色名称',
  `parentid` smallint(6) NOT NULL DEFAULT '0' COMMENT '父角色ID',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `listorder` int(3) NOT NULL DEFAULT '0' COMMENT '排序字段',
  PRIMARY KEY (`id`),
  KEY `parentId` (`parentid`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='角色信息列表';

-- ----------------------------
-- Records of shuipfcms_role
-- ----------------------------
INSERT INTO `shuipfcms_role` VALUES ('1', '超级管理员', '0', '1', '拥有网站最高管理员权限！', '1329633709', '1329633709', '0');
INSERT INTO `shuipfcms_role` VALUES ('2', '站点管理员', '1', '1', '站点管理员', '1329633722', '1399780945', '0');
INSERT INTO `shuipfcms_role` VALUES ('3', '发布人员', '2', '1', '发布人员', '1329633733', '1399798954', '0');

-- ----------------------------
-- Table structure for shuipfcms_tags
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_tags`;
CREATE TABLE `shuipfcms_tags` (
  `tagid` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'tagID',
  `tag` char(20) NOT NULL DEFAULT '' COMMENT 'tag名称',
  `seo_title` varchar(255) NOT NULL DEFAULT '' COMMENT 'seo标题',
  `seo_keyword` varchar(255) NOT NULL DEFAULT '' COMMENT 'seo关键字',
  `seo_description` varchar(255) NOT NULL DEFAULT '' COMMENT 'seo简介',
  `style` char(5) NOT NULL DEFAULT '' COMMENT '附加状态码',
  `usetimes` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '信息总数',
  `lastusetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后使用时间',
  `hits` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '点击数',
  `lasthittime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最近访问时间',
  `listorder` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`tagid`),
  UNIQUE KEY `tag` (`tag`),
  KEY `usetimes` (`usetimes`,`listorder`),
  KEY `hits` (`hits`,`listorder`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='tags主表';

-- ----------------------------
-- Records of shuipfcms_tags
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_tags_content
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_tags_content`;
CREATE TABLE `shuipfcms_tags_content` (
  `tag` char(20) NOT NULL COMMENT 'tag名称',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '信息地址',
  `title` varchar(80) NOT NULL DEFAULT '' COMMENT '标题',
  `modelid` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '模型ID',
  `contentid` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '信息ID',
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '栏目ID',
  `updatetime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  KEY `modelid` (`modelid`,`contentid`),
  KEY `tag` (`tag`(10))
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='tags数据表';

-- ----------------------------
-- Records of shuipfcms_tags_content
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_terms
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_terms`;
CREATE TABLE `shuipfcms_terms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `parentid` smallint(5) NOT NULL DEFAULT '0' COMMENT '父ID',
  `name` varchar(200) NOT NULL DEFAULT '' COMMENT '分类名称',
  `module` varchar(200) NOT NULL DEFAULT '' COMMENT '所属模块',
  `setting` mediumtext COMMENT '相关配置信息',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `module` (`module`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='分类表';

-- ----------------------------
-- Records of shuipfcms_terms
-- ----------------------------

-- ----------------------------
-- Table structure for shuipfcms_urlrule
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_urlrule`;
CREATE TABLE `shuipfcms_urlrule` (
  `urlruleid` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id',
  `module` varchar(15) NOT NULL DEFAULT '' COMMENT '所属模块',
  `file` varchar(20) NOT NULL DEFAULT '' COMMENT '所属文件',
  `ishtml` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '生成静态规则 1 静态',
  `urlrule` varchar(255) NOT NULL DEFAULT '' COMMENT 'url规则',
  `example` varchar(255) NOT NULL DEFAULT '' COMMENT '示例',
  PRIMARY KEY (`urlruleid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='内容模型URL规则';

-- ----------------------------
-- Records of shuipfcms_urlrule
-- ----------------------------
INSERT INTO `shuipfcms_urlrule` VALUES ('1', 'content', 'category', '0', 'index.php?a=lists&catid={$catid}|index.php?a=lists&catid={$catid}&page={$page}', '动态：index.php?a=lists&catid=1&page=1');
INSERT INTO `shuipfcms_urlrule` VALUES ('2', 'content', 'category', '1', '{$categorydir}{$catdir}/index.shtml|{$categorydir}{$catdir}/index_{$page}.shtml', '静态：news/china/1000.shtml');
INSERT INTO `shuipfcms_urlrule` VALUES ('3', 'content', 'show', '1', '{$year}/{$catdir}_{$month}/{$id}.shtml|{$year}/{$catdir}_{$month}/{$id}_{$page}.shtml', '静态：2010/catdir_07/1_2.shtml');
INSERT INTO `shuipfcms_urlrule` VALUES ('4', 'content', 'show', '0', 'index.php?a=shows&catid={$catid}&id={$id}|index.php?a=shows&catid={$catid}&id={$id}&page={$page}', '动态：index.php?m=Index&a=shows&catid=1&id=1');
INSERT INTO `shuipfcms_urlrule` VALUES ('5', 'content', 'category', '1', 'news/{$catid}.shtml|news/{$catid}-{$page}.shtml', '静态：news/1.shtml');
INSERT INTO `shuipfcms_urlrule` VALUES ('6', 'content', 'category', '0', 'list-{$catid}.html|list-{$catid}-{$page}.html', '伪静态：list-1-1.html');
INSERT INTO `shuipfcms_urlrule` VALUES ('7', 'content', 'tags', '0', 'index.php?a=tags&amp;tagid={$tagid}|index.php?a=tags&amp;tagid={$tagid}&amp;page={$page}', '动态：index.php?a=tags&amp;tagid=1');
INSERT INTO `shuipfcms_urlrule` VALUES ('8', 'content', 'tags', '0', 'index.php?a=tags&amp;tag={$tag}|/index.php?a=tags&amp;tag={$tag}&amp;page={$page}', '动态：index.php?a=tags&amp;tag=标签');
INSERT INTO `shuipfcms_urlrule` VALUES ('9', 'content', 'tags', '0', 'tag-{$tag}.html|tag-{$tag}-{$page}.html', '伪静态：tag-标签.html');
INSERT INTO `shuipfcms_urlrule` VALUES ('10', 'content', 'tags', '0', 'tag-{$tagid}.html|tag-{$tagid}-{$page}.html', '伪静态：tag-1.html');
INSERT INTO `shuipfcms_urlrule` VALUES ('11', 'content', 'index', '1', 'index.html|index_{$page}.html', '静态：index_2.html');
INSERT INTO `shuipfcms_urlrule` VALUES ('12', 'content', 'index', '0', 'index.html|index_{$page}.html', '伪静态：index_2.html');
INSERT INTO `shuipfcms_urlrule` VALUES ('13', 'content', 'index', '0', 'index.php|index.php?page={$page}', '动态：index.php?page=2');
INSERT INTO `shuipfcms_urlrule` VALUES ('14', 'content', 'category', '1', 'download.shtml|download_{$page}.shtml', '静态：download.shtml');
INSERT INTO `shuipfcms_urlrule` VALUES ('15', 'content', 'show', '1', '{$categorydir}{$id}.shtml|{$categorydir}{$id}_{$page}.shtml', '静态：/父栏目/1.shtml');
INSERT INTO `shuipfcms_urlrule` VALUES ('16', 'content', 'show', '1', '{$catdir}/{$id}.shtml|{$catdir}/{$id}_{$page}.shtml', '示例：/栏目/1.html');

-- ----------------------------
-- Table structure for shuipfcms_user
-- ----------------------------
DROP TABLE IF EXISTS `shuipfcms_user`;
CREATE TABLE `shuipfcms_user` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '昵称/姓名',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '密码',
  `bind_account` varchar(50) NOT NULL DEFAULT '' COMMENT '绑定帐户',
  `last_login_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次登录时间',
  `last_login_ip` varchar(40) NOT NULL DEFAULT '' COMMENT '上次登录IP',
  `verify` varchar(32) NOT NULL DEFAULT '' COMMENT '证验码',
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT '邮箱',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `role_id` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '对应角色ID',
  `info` text COMMENT '信息',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='后台用户表';

-- ----------------------------
-- Records of shuipfcms_user
-- ----------------------------
