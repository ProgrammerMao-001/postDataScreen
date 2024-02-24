/*
Navicat MySQL Data Transfer

Source Server         : hello
Source Server Version : 50505
Source Host           : 127.0.0.1:3306
Source Database       : postdatascreen

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2024-02-25 01:55:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `companylist`
-- ----------------------------
DROP TABLE IF EXISTS `companylist`;
CREATE TABLE `companylist` (
  `name` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `id` varchar(200) COLLATE utf8_bin NOT NULL,
  `into` varchar(8000) COLLATE utf8_bin DEFAULT '',
  `username` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of companylist
-- ----------------------------

-- ----------------------------
-- Table structure for `dictlist`
-- ----------------------------
DROP TABLE IF EXISTS `dictlist`;
CREATE TABLE `dictlist` (
  `id` varchar(600) COLLATE utf8_bin NOT NULL,
  `data` varchar(20000) COLLATE utf8_bin DEFAULT '',
  `name` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `remark` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of dictlist
-- ----------------------------
INSERT INTO `dictlist` VALUES ('0fb7402d-3423-4fc4-bc29-af14d770c479', '[{\"label\":\"不限\",\"value\":\"0\"},{\"label\":\"在校生\",\"value\":\"1\"},{\"label\":\"应届生\",\"value\":\"2\"},{\"label\":\"1年以内\",\"value\":\"3\"},{\"label\":\"1-3年\",\"value\":\"4\"},{\"label\":\"3-5年\",\"value\":\"5\"},{\"label\":\"5-10年\",\"value\":\"6\"},{\"label\":\"10年以上\",\"value\":\"7\"}]', 'workExperience', '工作经验');
INSERT INTO `dictlist` VALUES ('8a736334-b1f3-4b64-a49a-8cec1b045f1c', '[{\"label\":\"存续\",\"value\":\"0\",\"color\":\"#128f8e\"},{\"label\":\"在业\",\"value\":\"1\",\"color\":\"#128f8e\"},{\"label\":\"未注销\",\"value\":\"2\",\"color\":\"#00b4b3 \"},{\"label\":\"注销\",\"value\":\"3\",\"color\":\"#bb2e3e\"},{\"label\":\"迁出\",\"value\":\"4\",\"color\":\"\"},{\"label\":\"迁入\",\"value\":\"5\",\"color\":\"\"},{\"label\":\"停业\",\"value\":\"6\",\"color\":\"#bb2e3e\"},{\"label\":\"清算\",\"value\":\"7\",\"color\":\"#ff0000\"}]', 'businessStatus', '企业经营状态');
INSERT INTO `dictlist` VALUES ('9dd35a51-cc63-4323-ada5-d7cd21611473', '[{\"label\":\"初中及以下\",\"value\":\"0\"},{\"label\":\"中专/中技\",\"value\":\"1\"},{\"label\":\"高中\",\"value\":\"2\"},{\"label\":\"大专\",\"value\":\"3\"},{\"label\":\"本科\",\"value\":\"4\"},{\"label\":\"硕士\",\"value\":\"5\"},{\"label\":\"博士\",\"value\":\"6\"},{\"label\":\"不限\",\"value\":\"7\"}]', 'education', '学历');
INSERT INTO `dictlist` VALUES ('a294d159-beca-4932-8b70-f38337c583e6', '[{\"value\":101010000,\"label\":\"北京\"},{\"value\":101020000,\"label\":\"上海\"},{\"value\":101030000,\"label\":\"天津\"},{\"value\":101040000,\"label\":\"重庆\"},{\"value\":101050000,\"label\":\"黑龙江\"},{\"value\":101060000,\"label\":\"吉林\"},{\"value\":101070000,\"label\":\"辽宁\"},{\"value\":101080000,\"label\":\"内蒙古\"},{\"value\":101090000,\"label\":\"河北\"},{\"value\":101100000,\"label\":\"山西\"},{\"value\":101110000,\"label\":\"陕西\"},{\"value\":101120000,\"label\":\"山东\"},{\"value\":101130000,\"label\":\"新疆\"},{\"value\":101140000,\"label\":\"西藏\"},{\"value\":101150000,\"label\":\"青海\"},{\"value\":101160000,\"label\":\"甘肃\"},{\"value\":101170000,\"label\":\"宁夏\"},{\"value\":101180000,\"label\":\"河南\"},{\"value\":101190000,\"label\":\"江苏\"},{\"value\":101200000,\"label', 'province', '全国省份列表');
INSERT INTO `dictlist` VALUES ('c28f5e02-6ce9-4ec4-b757-53dc706b10ae', '[{\"label\":\"招聘中\",\"value\":\"0\",\"color\":\"#128f8e\"},{\"label\":\"已关闭\",\"value\":\"1\",\"color\":\"#f56c6c\"}]', 'recruitmentStatus', '招聘状态');

-- ----------------------------
-- Table structure for `piclist`
-- ----------------------------
DROP TABLE IF EXISTS `piclist`;
CREATE TABLE `piclist` (
  `id` varchar(1000) NOT NULL,
  `url` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of piclist
-- ----------------------------
INSERT INTO `piclist` VALUES ('1a3146e3-a729-4661-8349-3ad30ecf0705', '/uploads/file/20230527/file-1685155034491-aPngTest.png');
INSERT INTO `piclist` VALUES ('24ef5ee0-dd36-40de-8733-abff8390a650', '/uploads/file/20231028/file-1698467026246-aXlsTest.xls');
INSERT INTO `piclist` VALUES ('252bff0a-b68e-4e4e-8742-2c6ce7a347ec', '/uploads/file/20240224/file-1708782801859-aPngTest.png');
INSERT INTO `piclist` VALUES ('3315980d-b5b1-47f3-8f9f-8440c04c0058', '/uploads/file/2023044/file-1680621500871-csdn.png');
INSERT INTO `piclist` VALUES ('3d50753c-6adf-4707-bc1a-c14cbd7c6938', '/uploads/file/20231028/file-1698466923212-aXlsTest.xls');
INSERT INTO `piclist` VALUES ('470d143f-7750-4c52-9b91-cd5af2f6b094', '/uploads/file/20230527/file-1685155066292-3.jpg');
INSERT INTO `piclist` VALUES ('48328797-943e-436a-999c-f49431a3d44e', '/uploads/file/20230527/file-1685157707001-eventReportNew.png');
INSERT INTO `piclist` VALUES ('5659067f-f823-424d-811a-50c951583f02', '/uploads/file/20240224/file-1708704036704-3.jpg');
INSERT INTO `piclist` VALUES ('5f5ab796-ff66-43e9-80f8-20f440d469ac', '/uploads/file/20231028/file-1698476018770-aDocxTest.docx');
INSERT INTO `piclist` VALUES ('63269a62-efbc-4f98-a379-f3e703ed883f', '/uploads/file/20240221/file-1708528376738-aJpeTest1.jpg');
INSERT INTO `piclist` VALUES ('682792a4-a1c5-4688-80bd-0b432391b722', '/uploads/file/20240224/file-1708757175757-aJpeTest1.jpg');
INSERT INTO `piclist` VALUES ('6efae018-e38f-4d7f-9904-9ae9957d15c3', '/uploads/file/20231028/file-1698475892077-aDocTest.doc');
INSERT INTO `piclist` VALUES ('7151fc92-3919-4072-8d27-b342ab338212', '/uploads/file/20231028/file-1698475948854-é³ä¹æ­æ¾ç³»ç»åå°.pdf');
INSERT INTO `piclist` VALUES ('8ee9cdc2-8bc6-4951-8974-5c8755a48e7d', '/uploads/file/20231028/file-1698424268855-aZipTest.zip');
INSERT INTO `piclist` VALUES ('955d061c-805d-4e60-89c1-fabc19a34f7d', '/uploads/file/20231028/file-1698424312583-aZipTest.zip');
INSERT INTO `piclist` VALUES ('a06ca5ab-01dd-42d4-83c1-795cc7101d47', '/uploads/file/20230527/file-1685155078371-3.jpg');
INSERT INTO `piclist` VALUES ('b4a708fc-630e-4f69-9df5-240a55c14b3d', '/uploads/file/2023044/file-1680621484935-3.jpg');
INSERT INTO `piclist` VALUES ('c00b7d94-0608-4279-bce3-50303bb2462d', '/uploads/file/20240224/file-1708705733198-colorFlower1.jpeg');
INSERT INTO `piclist` VALUES ('ca6fc96e-dbc5-47bb-863f-86e9a8f1801d', '/uploads/file/20231027/file-1698421221506-road.png');
INSERT INTO `piclist` VALUES ('d4835ebe-6658-4665-a92e-51282dd2f071', '/uploads/file/20231028/file-1698424136646-aXlsxTest.xlsx');
INSERT INTO `piclist` VALUES ('d6b0e8a9-ebba-480e-b419-a842bfbcfd4a', '/uploads/file/20230527/file-1685155308795-forkLiftLogo.png');
INSERT INTO `piclist` VALUES ('da061db4-d7c4-40f1-87ce-ff6e0283f3fc', '/uploads/file/20230311/file-1678490998969-3.jpg');
INSERT INTO `piclist` VALUES ('de99dfec-f49b-4550-9c8d-d4b88adbe925', '/uploads/file/20230527/file-1685155045647-3.jpg');
INSERT INTO `piclist` VALUES ('df1304e4-a2d1-4d7f-8807-298e2b17ece9', '/uploads/file/20240223/file-1708701955763-aPngTest.png');
INSERT INTO `piclist` VALUES ('e4e2cedc-b548-4a40-8bf6-490bbfb0a219', '/uploads/file/20240221/file-1708528393104-456.png');
INSERT INTO `piclist` VALUES ('ee73a063-6cd3-4ccf-a470-c6d50104b810', '/uploads/file/20231028/file-1698423812985-aXlsTest.xls');
INSERT INTO `piclist` VALUES ('f0da87c8-d124-4bff-839d-8f2ba6492333', '/uploads/file/20231028/file-1698466997782-aXlsTest.xls');
INSERT INTO `piclist` VALUES ('f300adf9-32b9-44d5-8fa7-5eac65ae29fc', '/uploads/file/20240224/file-1708757203582-3.jpg');
INSERT INTO `piclist` VALUES ('f3b4afe8-b5f7-480b-a9e6-228d50bb87c2', '/uploads/file/20240221/file-1708528053966-3.jpg');
INSERT INTO `piclist` VALUES ('fbc403aa-c37a-4af4-be1e-066bcfce9c48', '/uploads/file/20230311/file-1678522646063-girl.jpg');

-- ----------------------------
-- Table structure for `rolelist`
-- ----------------------------
DROP TABLE IF EXISTS `rolelist`;
CREATE TABLE `rolelist` (
  `name` varchar(100) NOT NULL,
  `id` varchar(100) NOT NULL,
  `pid` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rolelist
-- ----------------------------
INSERT INTO `rolelist` VALUES ('管理员', '1', 'null');
INSERT INTO `rolelist` VALUES ('用户', '2', 'null');

-- ----------------------------
-- Table structure for `routerlist`
-- ----------------------------
DROP TABLE IF EXISTS `routerlist`;
CREATE TABLE `routerlist` (
  `name` varchar(100) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `id` varchar(200) NOT NULL,
  `pid` varchar(200) DEFAULT NULL,
  `type` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of routerlist
-- ----------------------------
INSERT INTO `routerlist` VALUES ('首页', '/home', 'el-icon-s-home', '123456njkafas', 'null', '管理员,用户');
INSERT INTO `routerlist` VALUES ('个人中心', '/personalCenter', 'el-icon-user', '46GFSDOFOKPkop', 'null', '用户');
INSERT INTO `routerlist` VALUES ('公司', '/dataManage/company', 'el-icon-office-building', 'aaacompan', 'dataaaaaa', '管理员,用户');
INSERT INTO `routerlist` VALUES ('驾驶舱', '/dataScreen', 'el-icon-s-platform', 'daasacasdasdad', 'null', '管理员');
INSERT INTO `routerlist` VALUES ('数据管理', '/dataManage', 'el-icon-tickets', 'dataaaaaa', 'null', '管理员,用户');
INSERT INTO `routerlist` VALUES ('字典', '/sysManage/dict', 'el-icon-collection', 'dict13123123', 'mfpafpfaf1', '管理员');
INSERT INTO `routerlist` VALUES ('用户', '/sysManage/user', 'el-icon-user', 'fsf45fasf489vdsa489', 'mfpafpfaf1', '管理员');
INSERT INTO `routerlist` VALUES ('系统管理', '/userManage', 'el-icon-s-tools', 'mfpafpfaf1', 'null', '管理员');
INSERT INTO `routerlist` VALUES ('岗位', '/dataManage/post', 'el-icon-suitcase-1', 'postassagasfsfasdas', 'dataaaaaa', '管理员,用户');
INSERT INTO `routerlist` VALUES ('角色', '/sysManage/role', 'el-icon-s-custom', 'roleM12313', 'mfpafpfaf1', '管理员');

-- ----------------------------
-- Table structure for `userlist`
-- ----------------------------
DROP TABLE IF EXISTS `userlist`;
CREATE TABLE `userlist` (
  `username` varchar(1000) DEFAULT NULL,
  `password` varchar(1000) DEFAULT NULL,
  `headimg` varchar(9999) DEFAULT NULL,
  `token` varchar(1000) DEFAULT NULL,
  `role` varchar(100) DEFAULT NULL,
  `roleid` varchar(100) DEFAULT NULL,
  `id` varchar(300) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of userlist
-- ----------------------------
INSERT INTO `userlist` VALUES ('阿帆', '1', null, null, '用户', '2', '13123123');
INSERT INTO `userlist` VALUES ('撒发生', '1', null, null, '用户', '2', '21');
INSERT INTO `userlist` VALUES ('公司壹', 'a1231', 'https://img-blog.csdnimg.cn/img_convert/efc034d110fe11e1f82c86a4f3cd9377.jpeg', 'token-pci1s95z1kw0000000', '用户', '2', '302f3d54-0c50-409d-991a-45ebb0f971a7');
INSERT INTO `userlist` VALUES ('admin', '123456', 'http://127.0.0.1:3003/api/getImg?url=/uploads/file/20240224/file-1708704036704-3.jpg', 'token-asdsad', '管理员', '1', '456asd');
INSERT INTO `userlist` VALUES ('毛大仙', 'a123', 'http://127.0.0.1:3003/api/getImg?url=/uploads/file/20240224/file-1708705733198-colorFlower1.jpeg', 'token-78lfrh1oja000000000', '用户', '2', '6014d307-9278-4047-8446-8b066d200781');
INSERT INTO `userlist` VALUES ('用户啊', 'aa1', 'http://127.0.0.1:3003/api/getImg?url=/uploads/file/20240224/file-1708757203582-3.jpg', 'token-whzs41w6mkg0000000', '用户', '2', '736c1a53-5456-4212-8dc8-c03be6c10824');
INSERT INTO `userlist` VALUES ('哈哈', 'a123456', 'http://127.0.0.1:3003/api/getImg?url=/uploads/file/20240224/file-1708704036704-3.jpg', 'token-7hifdpgrqnk00000000', '用户', '2', '88003824-2d1d-4ff9-a46e-3e0efab12d8b');
INSERT INTO `userlist` VALUES ('辑用户', 'a1', '', '', '用户', '2', 'a');
INSERT INTO `userlist` VALUES ('呵呵呵', 'hehe123', 'http://127.0.0.1:3002/api/getImg?url=/uploads/file/20240221/file-1708528053966-3.jpg', 'token-9e9xsaieo640000000', '用户', '2', 'a1382bc7-bcf4-485a-8f13-9a4d24527407');
INSERT INTO `userlist` VALUES ('ffff', 'ffff', null, null, '用户', '2', 'afgg');
INSERT INTO `userlist` VALUES ('fff', 'f', null, null, '用户', '2', 'asasfasfasf');
INSERT INTO `userlist` VALUES ('阿萨德', 'a1', null, null, '用户', '2', 'asdasdasd');
INSERT INTO `userlist` VALUES ('asaa', 'a', null, null, '用户', '2', 'asdasdasda');
INSERT INTO `userlist` VALUES ('asd ', 'a', null, null, '用户', '2', 'asdasdasdasd ');
INSERT INTO `userlist` VALUES ('hyhyth', 'yyhyhy', null, null, '用户', '2', 'asdasdsad');
INSERT INTO `userlist` VALUES ('毛三仙', 'a1', 'http://127.0.0.1:3002/api/getImg?url=/uploads/file/20230527/file-1685155078371-3.jpg', 'token-9p3tb0mkses0000000', '用户', '2', 'b08ac22c-3f07-48ed-8f71-128defd5d4f3');
INSERT INTO `userlist` VALUES ('啊啊啊', 'a1', 'https://img-blog.csdnimg.cn/img_convert/efc034d110fe11e1f82c86a4f3cd9377.jpeg', 'token-h93zuf8b5tk0000000', '用户', '2', 'b635da01-b85a-457d-a3f1-f51013e07078');
INSERT INTO `userlist` VALUES ('用户名', 'add1', 'http://127.0.0.1:3003/api/getImg?url=/uploads/file/20240224/file-1708757175757-aJpeTest1.jpg', 'token-1dy8kly36ji800000000', '用户', '2', 'c834f1c9-e1b1-4c6f-b033-93b40418334a');
INSERT INTO `userlist` VALUES ('啊啊', 'a1', 'https://img-blog.csdnimg.cn/img_convert/efc034d110fe11e1f82c86a4f3cd9377.jpeg', 'token-1wmp9zt8f5pc000000', '用户', '2', 'c912781d-a3d9-4c3a-889d-25bead65ba97');
INSERT INTO `userlist` VALUES ('gs', 'a', null, null, '用户', '2', 'g');
INSERT INTO `userlist` VALUES ('a', 'a1', null, null, '用户', '2', 'gggg');
INSERT INTO `userlist` VALUES ('af', 'a', null, null, '用户', '2', 'ggggaaa');
INSERT INTO `userlist` VALUES ('asd ', '2', null, null, '用户', '2', 'gsggewg');
INSERT INTO `userlist` VALUES ('g', 'g', null, null, '用户', '2', 'jtujyujuj');
