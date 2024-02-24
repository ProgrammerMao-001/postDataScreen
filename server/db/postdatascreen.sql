/*
Navicat MySQL Data Transfer

Source Server         : hello
Source Server Version : 50505
Source Host           : 127.0.0.1:3306
Source Database       : postdatascreen

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2024-02-24 14:29:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `arealist`
-- ----------------------------
DROP TABLE IF EXISTS `arealist`;
CREATE TABLE `arealist` (
  `id` varchar(600) NOT NULL,
  `province` varchar(600) DEFAULT NULL,
  `city` varchar(600) DEFAULT NULL,
  `pid` varchar(600) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of arealist
-- ----------------------------
INSERT INTO `arealist` VALUES ('210100', '辽宁省', '沈阳市', 'null');
INSERT INTO `arealist` VALUES ('210100-1', '辽宁省', '和平区', '210100');
INSERT INTO `arealist` VALUES ('210100-10', '辽宁省', '辽中区', '210100');
INSERT INTO `arealist` VALUES ('210100-11', '辽宁省', '新民市', '210100');
INSERT INTO `arealist` VALUES ('210100-12', '辽宁省', '康平县', '210100');
INSERT INTO `arealist` VALUES ('210100-13', '辽宁省', '法库县', '210100');
INSERT INTO `arealist` VALUES ('210100-2', '辽宁省', '沈河区', '210100');
INSERT INTO `arealist` VALUES ('210100-3', '辽宁省', '大东区', '210100');
INSERT INTO `arealist` VALUES ('210100-4', '辽宁省', '皇姑区', '210100');
INSERT INTO `arealist` VALUES ('210100-5', '辽宁省', '铁西区', '210100');
INSERT INTO `arealist` VALUES ('210100-6', '辽宁省', '苏家屯区', '210100');
INSERT INTO `arealist` VALUES ('210100-7', '辽宁省', '浑南区', '210100');
INSERT INTO `arealist` VALUES ('210100-8', '辽宁省', '沈北新区', '210100');
INSERT INTO `arealist` VALUES ('210100-9', '辽宁省', '于洪区', '210100');
INSERT INTO `arealist` VALUES ('210200', '辽宁省', '大连市', 'null');
INSERT INTO `arealist` VALUES ('210200-1', '辽宁省', '中山区', '210200');
INSERT INTO `arealist` VALUES ('210200-10', '辽宁省', '长海县', '210200');
INSERT INTO `arealist` VALUES ('210200-2', '辽宁省', '西岗区', '210200');
INSERT INTO `arealist` VALUES ('210200-3', '辽宁省', '沙河口区', '210200');
INSERT INTO `arealist` VALUES ('210200-4', '辽宁省', '甘井子区', '210200');
INSERT INTO `arealist` VALUES ('210200-5', '辽宁省', '旅顺口区', '210200');
INSERT INTO `arealist` VALUES ('210200-6', '辽宁省', '金州区', '210200');
INSERT INTO `arealist` VALUES ('210200-7', '辽宁省', '普兰店区', '210200');
INSERT INTO `arealist` VALUES ('210200-8', '辽宁省', '瓦房店市', '210200');
INSERT INTO `arealist` VALUES ('210200-9', '辽宁省', '庄河市', '210200');
INSERT INTO `arealist` VALUES ('210300', '辽宁省', '鞍山市', 'null');
INSERT INTO `arealist` VALUES ('210300-1', '辽宁省', '铁东区', '210300');
INSERT INTO `arealist` VALUES ('210300-2', '辽宁省', '铁西区', '210300');
INSERT INTO `arealist` VALUES ('210300-3', '辽宁省', '立山区', '210300');
INSERT INTO `arealist` VALUES ('210300-4', '辽宁省', '千山区', '210300');
INSERT INTO `arealist` VALUES ('210300-5', '辽宁省', '海城市', '210300');
INSERT INTO `arealist` VALUES ('210300-6', '辽宁省', '台安县', '210300');
INSERT INTO `arealist` VALUES ('210300-7', '辽宁省', '岫岩满族自治县', '210300');
INSERT INTO `arealist` VALUES ('210400', '辽宁省', '抚顺市', 'null');
INSERT INTO `arealist` VALUES ('210400-1', '辽宁省', '新抚区', '210400');
INSERT INTO `arealist` VALUES ('210400-2', '辽宁省', '顺城区', '210400');
INSERT INTO `arealist` VALUES ('210400-3', '辽宁省', '望花区', '210400');
INSERT INTO `arealist` VALUES ('210400-4', '辽宁省', '东洲区', '210400');
INSERT INTO `arealist` VALUES ('210400-5', '辽宁省', '抚顺县', '210400');
INSERT INTO `arealist` VALUES ('210400-6', '辽宁省', '新宾满族自治县', '210400');
INSERT INTO `arealist` VALUES ('210400-7', '辽宁省', '清原满族自治县', '210400');
INSERT INTO `arealist` VALUES ('210500', '辽宁省', '本溪市', 'null');
INSERT INTO `arealist` VALUES ('210500-1', '辽宁省', '平山区', '210500');
INSERT INTO `arealist` VALUES ('210500-2', '辽宁省', '溪湖区', '210500');
INSERT INTO `arealist` VALUES ('210500-3', '辽宁省', '明山区', '210500');
INSERT INTO `arealist` VALUES ('210500-4', '辽宁省', '南芬区', '210500');
INSERT INTO `arealist` VALUES ('210500-5', '辽宁省', '本溪满族自治县', '210500');
INSERT INTO `arealist` VALUES ('210500-6', '辽宁省', '桓仁满族自治县', '210500');
INSERT INTO `arealist` VALUES ('210600', '辽宁省', '丹东市', 'null');
INSERT INTO `arealist` VALUES ('210600-1', '辽宁省', '元宝区', '210600');
INSERT INTO `arealist` VALUES ('210600-2', '辽宁省', '振兴区', '210600');
INSERT INTO `arealist` VALUES ('210600-3', '辽宁省', '振安区', '210600');
INSERT INTO `arealist` VALUES ('210600-4', '辽宁省', '东港市', '210600');
INSERT INTO `arealist` VALUES ('210600-5', '辽宁省', '凤城市', '210600');
INSERT INTO `arealist` VALUES ('210600-6', '辽宁省', '宽甸满族自治县', '210600');
INSERT INTO `arealist` VALUES ('210700', '辽宁省', '锦州市', 'null');
INSERT INTO `arealist` VALUES ('210700-1', '辽宁省', '古塔区', '210700');
INSERT INTO `arealist` VALUES ('210700-2', '辽宁省', '凌河区', '210700');
INSERT INTO `arealist` VALUES ('210700-3', '辽宁省', '太和区', '210700');
INSERT INTO `arealist` VALUES ('210700-4', '辽宁省', '凌海市', '210700');
INSERT INTO `arealist` VALUES ('210700-5', '辽宁省', '北镇市', '210700');
INSERT INTO `arealist` VALUES ('210700-6', '辽宁省', '黑山县', '210700');
INSERT INTO `arealist` VALUES ('210700-7', '辽宁省', '义县', '210700');
INSERT INTO `arealist` VALUES ('210800', '辽宁省', '营口市', 'null');
INSERT INTO `arealist` VALUES ('210800-1', '辽宁省', '站前区', '210800');
INSERT INTO `arealist` VALUES ('210800-2', '辽宁省', '西市区', '210800');
INSERT INTO `arealist` VALUES ('210800-3', '辽宁省', '鲅鱼圈区', '210800');
INSERT INTO `arealist` VALUES ('210800-4', '辽宁省', '老边区', '210800');
INSERT INTO `arealist` VALUES ('210800-5', '辽宁省', '盖州市', '210800');
INSERT INTO `arealist` VALUES ('210800-6', '辽宁省', '大石桥市', '210800');
INSERT INTO `arealist` VALUES ('210900', '辽宁省', '阜新市', 'null');
INSERT INTO `arealist` VALUES ('210900-1', '辽宁省', '海州区', '210900');
INSERT INTO `arealist` VALUES ('210900-2', '辽宁省', '新邱区', '210900');
INSERT INTO `arealist` VALUES ('210900-3', '辽宁省', '太平区', '210900');
INSERT INTO `arealist` VALUES ('210900-4', '辽宁省', '清河门区', '210900');
INSERT INTO `arealist` VALUES ('210900-5', '辽宁省', '细河区', '210900');
INSERT INTO `arealist` VALUES ('210900-6', '辽宁省', '阜新蒙古族自治县', '210900');
INSERT INTO `arealist` VALUES ('210900-7', '辽宁省', '彰武县', '210900');
INSERT INTO `arealist` VALUES ('211000', '辽宁省', '辽阳市', 'null');
INSERT INTO `arealist` VALUES ('211000-1', '辽宁省', '白塔区', '211000');
INSERT INTO `arealist` VALUES ('211000-2', '辽宁省', '文圣区', '211000');
INSERT INTO `arealist` VALUES ('211000-3', '辽宁省', '宏伟区', '211000');
INSERT INTO `arealist` VALUES ('211000-4', '辽宁省', '弓长岭区', '211000');
INSERT INTO `arealist` VALUES ('211000-5', '辽宁省', '太子河区', '211000');
INSERT INTO `arealist` VALUES ('211000-6', '辽宁省', '灯塔市', '211000');
INSERT INTO `arealist` VALUES ('211000-7', '辽宁省', '辽阳县', '211000');
INSERT INTO `arealist` VALUES ('211100', '辽宁省', '盘锦市', 'null');
INSERT INTO `arealist` VALUES ('211100-1', '辽宁省', '双台子区', '211100');
INSERT INTO `arealist` VALUES ('211100-2', '辽宁省', '兴隆台区', '211100');
INSERT INTO `arealist` VALUES ('211100-3', '辽宁省', '大洼区', '211100');
INSERT INTO `arealist` VALUES ('211100-4', '辽宁省', '盘山县', '211100');
INSERT INTO `arealist` VALUES ('211200', '辽宁省', '铁岭市', 'null');
INSERT INTO `arealist` VALUES ('211200-1', '辽宁省', '银州区', '211200');
INSERT INTO `arealist` VALUES ('211200-2', '辽宁省', '清河区', '211200');
INSERT INTO `arealist` VALUES ('211200-3', '辽宁省', '调兵山市', '211200');
INSERT INTO `arealist` VALUES ('211200-4', '辽宁省', '开原市', '211200');
INSERT INTO `arealist` VALUES ('211200-5', '辽宁省', '铁岭县', '211200');
INSERT INTO `arealist` VALUES ('211200-6', '辽宁省', '昌图县', '211200');
INSERT INTO `arealist` VALUES ('211200-7', '辽宁省', '西丰县', '211200');
INSERT INTO `arealist` VALUES ('211300', '辽宁省', '朝阳市', 'null');
INSERT INTO `arealist` VALUES ('211300-1', '辽宁省', '双塔区', '211300');
INSERT INTO `arealist` VALUES ('211300-2', '辽宁省', '龙城区', '211300');
INSERT INTO `arealist` VALUES ('211300-3', '辽宁省', '北票市', '211300');
INSERT INTO `arealist` VALUES ('211300-4', '辽宁省', '凌源市', '211300');
INSERT INTO `arealist` VALUES ('211300-5', '辽宁省', '朝阳县', '211300');
INSERT INTO `arealist` VALUES ('211300-6', '辽宁省', '建平县', '211300');
INSERT INTO `arealist` VALUES ('211300-7', '辽宁省', '喀喇沁左翼蒙古族自治县', '211300');
INSERT INTO `arealist` VALUES ('211400', '辽宁省', '葫芦岛市', 'null');
INSERT INTO `arealist` VALUES ('211400-1', '辽宁省', '连山区', '211400');
INSERT INTO `arealist` VALUES ('211400-2', '辽宁省', '龙港区', '211400');
INSERT INTO `arealist` VALUES ('211400-3', '辽宁省', '南票区', '211400');
INSERT INTO `arealist` VALUES ('211400-4', '辽宁省', '兴城市', '211400');
INSERT INTO `arealist` VALUES ('211400-5', '辽宁省', '绥中县', '211400');
INSERT INTO `arealist` VALUES ('211400-6', '辽宁省', '建昌县', '211400');

-- ----------------------------
-- Table structure for `clocklist`
-- ----------------------------
DROP TABLE IF EXISTS `clocklist`;
CREATE TABLE `clocklist` (
  `datetime` varchar(1000) DEFAULT NULL,
  `userid` varchar(1000) DEFAULT NULL,
  `id` varchar(600) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of clocklist
-- ----------------------------
INSERT INTO `clocklist` VALUES ('2023-05-27', 'bc1d42a1-64bb-4dd3-97f1-38cb483ddda6', '83c1e340-88ba-4948-a13e-01bd5d9da2e2');
INSERT INTO `clocklist` VALUES ('2024-02-21', '456asd', 'c7d3a770-4b09-44b8-8375-2e906c34a13c');
INSERT INTO `clocklist` VALUES ('2023-10-27', '456asd', 'cabbf8ef-5ec5-49d4-b66b-237db2410a2e');
INSERT INTO `clocklist` VALUES ('2023-05-27', '456asd', 'daf95e67-d0f3-46b7-88e1-5a5c67201354');

-- ----------------------------
-- Table structure for `definitelist`
-- ----------------------------
DROP TABLE IF EXISTS `definitelist`;
CREATE TABLE `definitelist` (
  `id` varchar(600) NOT NULL,
  `name` varchar(600) DEFAULT NULL,
  `namephone` varchar(600) DEFAULT NULL,
  `namein` varchar(600) DEFAULT '',
  `namestatusid` varchar(600) DEFAULT NULL,
  `namestatus` varchar(600) DEFAULT NULL,
  `namewhere` varchar(600) DEFAULT '',
  `staticname` varchar(600) DEFAULT NULL,
  `staticphone` varchar(600) DEFAULT NULL,
  `staticin` varchar(600) DEFAULT NULL,
  `staticwhere` varchar(600) DEFAULT NULL,
  `staticstatusid` varchar(600) DEFAULT NULL,
  `staticstatus` varchar(600) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of definitelist
-- ----------------------------

-- ----------------------------
-- Table structure for `dictlist`
-- ----------------------------
DROP TABLE IF EXISTS `dictlist`;
CREATE TABLE `dictlist` (
  `id` varchar(600) COLLATE utf8_bin NOT NULL,
  `data` varchar(8000) COLLATE utf8_bin DEFAULT '',
  `name` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `remark` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of dictlist
-- ----------------------------
INSERT INTO `dictlist` VALUES ('aaa', '{\n    \"errorCode\": \"SVCSTG.ALS.200.200\",\n    \"errorMessage\": \"Report success.\",\n    \"result\": null\n}', 'sys_test', '系统测试数据');

-- ----------------------------
-- Table structure for `hospitallist`
-- ----------------------------
DROP TABLE IF EXISTS `hospitallist`;
CREATE TABLE `hospitallist` (
  `areaid` varchar(600) DEFAULT '',
  `hname` varchar(1000) DEFAULT NULL,
  `firstnum` varchar(1000) DEFAULT NULL,
  `secondnum` varchar(1000) DEFAULT NULL,
  `thirdnum` varchar(1000) DEFAULT NULL,
  `id` varchar(600) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of hospitallist
-- ----------------------------
INSERT INTO `hospitallist` VALUES ('210100-1', '盛京医院', '111', '222', '333', '1');
INSERT INTO `hospitallist` VALUES ('210400-2', '抚顺市中心医院', '234', '3', '645', '10');
INSERT INTO `hospitallist` VALUES ('210400-1', '抚顺市第五医院', '14', '56', '74', '11');
INSERT INTO `hospitallist` VALUES ('210500-3', '本溪市金山医院', '4123', '51', '3431', '12');
INSERT INTO `hospitallist` VALUES ('210500-1', '本溪市第六人民医院', '12', '0', '23', '13');
INSERT INTO `hospitallist` VALUES ('210500-6', '本溪县第三人民医院', '12', '0', '24', '14');
INSERT INTO `hospitallist` VALUES ('210600-2', '凤城市中医院', '124', '12', '234', '15');
INSERT INTO `hospitallist` VALUES ('210600-3', '振安区医院', '41', '56', '23', '16');
INSERT INTO `hospitallist` VALUES ('210700-2', '锦州医科大学附属第二医院', '124', '36', '1', '17');
INSERT INTO `hospitallist` VALUES ('210700-3', '锦州市康宁医院', '0', '156', '21', '18');
INSERT INTO `hospitallist` VALUES ('210800-5', '营口市经济技术开发区妇婴医院', '0', '56', '4', '19');
INSERT INTO `hospitallist` VALUES ('210100-1', '北部战区总医院', '23', '56', '432', '2');
INSERT INTO `hospitallist` VALUES ('210800-6', '营口市中医院', '4', '89', '453', '20');
INSERT INTO `hospitallist` VALUES ('210800-1', '营口开发区中心医院', '54', '6', '34', '21');
INSERT INTO `hospitallist` VALUES ('210900-6', '阜新市第五人民医院', '0', '6', '765', '22');
INSERT INTO `hospitallist` VALUES ('210900-5', '阜新市中心医院', '24', '656', '56', '23');
INSERT INTO `hospitallist` VALUES ('210900-2', '阜新市中医院', '4', '9', '34', '24');
INSERT INTO `hospitallist` VALUES ('211000-1', '新城医院', '0', '23', '234', '25');
INSERT INTO `hospitallist` VALUES ('211000-3', '辽阳辽化医院', '54', '1000', '234', '26');
INSERT INTO `hospitallist` VALUES ('211000-4', '辽阳县中心医院', '8', '89', '235', '27');
INSERT INTO `hospitallist` VALUES ('211100-1', '盘锦市中心医院', '7', '87', '5', '28');
INSERT INTO `hospitallist` VALUES ('211100-3', '盘锦辽油宝石花医院(渤海院区)', '548', '89', '42', '29');
INSERT INTO `hospitallist` VALUES ('210100-6', '辽宁省人民医院', '12', '2321', '52', '3');
INSERT INTO `hospitallist` VALUES ('211100-2', '盘锦市大洼区人民医院', '87', '15', '234', '30');
INSERT INTO `hospitallist` VALUES ('211200-1', '铁岭市中心医院', '83', '23', '65', '31');
INSERT INTO `hospitallist` VALUES ('211200-2', '调兵山市人民医院', '54', '23', '547', '32');
INSERT INTO `hospitallist` VALUES ('211300-1', '朝阳市中心医院', '45', '546', '765', '33');
INSERT INTO `hospitallist` VALUES ('211300-1', '凌源市中心医院', '4', '23', '8', '34');
INSERT INTO `hospitallist` VALUES ('211300-2', '朝阳市第二医院', '34', '2', '9', '35');
INSERT INTO `hospitallist` VALUES ('211300-3', '北票市中医院', '5', '156', '67', '36');
INSERT INTO `hospitallist` VALUES ('211300-4', '朝阳市妇幼保健院', '45', '2', '345', '37');
INSERT INTO `hospitallist` VALUES ('211400-2', '葫芦岛市妇幼保健计划生育服务中心', '45', '98', '234', '38');
INSERT INTO `hospitallist` VALUES ('211400-3', '葫芦岛市第二人民医院', '7', '84', '24', '39');
INSERT INTO `hospitallist` VALUES ('210100-4', '北部战区总医院和平院区', '214', '89', '234', '4');
INSERT INTO `hospitallist` VALUES ('210100-3', '沈阳市第一人民医院', '324', '89', '123', '5');
INSERT INTO `hospitallist` VALUES ('210200-1', '大连市中心医院', '425', '56', '5', '6');
INSERT INTO `hospitallist` VALUES ('210200-3', '大连大学附属中山医院', '342', '22', '23', '7');
INSERT INTO `hospitallist` VALUES ('210300-3', '鞍钢总医院', '22', '1', '125', '8');
INSERT INTO `hospitallist` VALUES ('210300-5', '海城市中心医院', '3', '1', '435', '9');

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
INSERT INTO `piclist` VALUES ('3315980d-b5b1-47f3-8f9f-8440c04c0058', '/uploads/file/2023044/file-1680621500871-csdn.png');
INSERT INTO `piclist` VALUES ('3d50753c-6adf-4707-bc1a-c14cbd7c6938', '/uploads/file/20231028/file-1698466923212-aXlsTest.xls');
INSERT INTO `piclist` VALUES ('470d143f-7750-4c52-9b91-cd5af2f6b094', '/uploads/file/20230527/file-1685155066292-3.jpg');
INSERT INTO `piclist` VALUES ('48328797-943e-436a-999c-f49431a3d44e', '/uploads/file/20230527/file-1685157707001-eventReportNew.png');
INSERT INTO `piclist` VALUES ('5659067f-f823-424d-811a-50c951583f02', '/uploads/file/20240224/file-1708704036704-3.jpg');
INSERT INTO `piclist` VALUES ('5f5ab796-ff66-43e9-80f8-20f440d469ac', '/uploads/file/20231028/file-1698476018770-aDocxTest.docx');
INSERT INTO `piclist` VALUES ('63269a62-efbc-4f98-a379-f3e703ed883f', '/uploads/file/20240221/file-1708528376738-aJpeTest1.jpg');
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
-- Table structure for `statuslist`
-- ----------------------------
DROP TABLE IF EXISTS `statuslist`;
CREATE TABLE `statuslist` (
  `id` varchar(600) NOT NULL,
  `status` varchar(600) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of statuslist
-- ----------------------------
INSERT INTO `statuslist` VALUES ('111', '已治愈');
INSERT INTO `statuslist` VALUES ('222', '已死亡');
INSERT INTO `statuslist` VALUES ('333', '治疗中');

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
INSERT INTO `userlist` VALUES ('公司壹', 'a123', 'https://img-blog.csdnimg.cn/img_convert/efc034d110fe11e1f82c86a4f3cd9377.jpeg', 'token-pci1s95z1kw0000000', '用户', '2', '302f3d54-0c50-409d-991a-45ebb0f971a7');
INSERT INTO `userlist` VALUES ('admin', '123456', 'http://127.0.0.1:3003/api/getImg?url=/uploads/file/20240224/file-1708704036704-3.jpg', 'token-asdsad', '管理员', '1', '456asd');
INSERT INTO `userlist` VALUES ('毛大仙', 'a123', 'http://127.0.0.1:3003/api/getImg?url=/uploads/file/20240224/file-1708705733198-colorFlower1.jpeg', 'token-78lfrh1oja000000000', '用户', '2', '6014d307-9278-4047-8446-8b066d200781');
INSERT INTO `userlist` VALUES ('哈哈', 'a123456', 'http://127.0.0.1:3003/api/getImg?url=/uploads/file/20240224/file-1708704036704-3.jpg', 'token-7hifdpgrqnk00000000', '用户', '2', '88003824-2d1d-4ff9-a46e-3e0efab12d8b');
INSERT INTO `userlist` VALUES ('f', 'a1', null, null, '用户', '2', 'a');
INSERT INTO `userlist` VALUES ('呵呵呵', 'hehe123', 'http://127.0.0.1:3002/api/getImg?url=/uploads/file/20240221/file-1708528053966-3.jpg', 'token-9e9xsaieo640000000', '用户', '2', 'a1382bc7-bcf4-485a-8f13-9a4d24527407');
INSERT INTO `userlist` VALUES ('ffff', 'ffff', null, null, '用户', '2', 'afgg');
INSERT INTO `userlist` VALUES ('fff', 'f', null, null, '用户', '2', 'asasfasfasf');
INSERT INTO `userlist` VALUES ('阿萨德', 'a1', null, null, '用户', '2', 'asdasdasd');
INSERT INTO `userlist` VALUES ('asaa', 'a', null, null, '用户', '2', 'asdasdasda');
INSERT INTO `userlist` VALUES ('asd ', 'a', null, null, '用户', '2', 'asdasdasdasd ');
INSERT INTO `userlist` VALUES ('hyhyth', 'yyhyhy', null, null, '用户', '2', 'asdasdsad');
INSERT INTO `userlist` VALUES ('毛三仙', 'a1', 'http://127.0.0.1:3002/api/getImg?url=/uploads/file/20230527/file-1685155078371-3.jpg', 'token-9p3tb0mkses0000000', '用户', '2', 'b08ac22c-3f07-48ed-8f71-128defd5d4f3');
INSERT INTO `userlist` VALUES ('啊啊啊', 'a1', 'https://img-blog.csdnimg.cn/img_convert/efc034d110fe11e1f82c86a4f3cd9377.jpeg', 'token-h93zuf8b5tk0000000', '用户', '2', 'b635da01-b85a-457d-a3f1-f51013e07078');
INSERT INTO `userlist` VALUES ('啊啊', 'a1', 'https://img-blog.csdnimg.cn/img_convert/efc034d110fe11e1f82c86a4f3cd9377.jpeg', 'token-1wmp9zt8f5pc000000', '用户', '2', 'c912781d-a3d9-4c3a-889d-25bead65ba97');
INSERT INTO `userlist` VALUES ('gs', 'a', null, null, '用户', '2', 'g');
INSERT INTO `userlist` VALUES ('a', 'a1', null, null, '用户', '2', 'gggg');
INSERT INTO `userlist` VALUES ('af', 'a', null, null, '用户', '2', 'ggggaaa');
INSERT INTO `userlist` VALUES ('asd ', '2', null, null, '用户', '2', 'gsggewg');
INSERT INTO `userlist` VALUES ('g', 'g', null, null, '用户', '2', 'jtujyujuj');
