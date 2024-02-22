/*
Navicat MySQL Data Transfer

Source Server         : hello
Source Server Version : 50505
Source Host           : 127.0.0.1:3306
Source Database       : liaoningepidemicmanagementplatform

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2023-03-11 18:57:15
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
INSERT INTO `clocklist` VALUES ('2023-05-25', 'b08ac22c-3f07-48ed-8f71-128defd5d4f3', '19852e5e-4f89-427f-8538-85e3cae30505');
INSERT INTO `clocklist` VALUES ('2023-03-09', 'b08ac22c-3f07-48ed-8f71-128defd5d4f3', '391a3664-819c-48b3-8f5b-b2ea6da7feef');
INSERT INTO `clocklist` VALUES ('2023-03-12', 'b08ac22c-3f07-48ed-8f71-128defd5d4f3', '54d2efd7-a1ae-4ae1-9825-75dc93c1d5ae');
INSERT INTO `clocklist` VALUES ('2023-03-11', 'b08ac22c-3f07-48ed-8f71-128defd5d4f3', '570eba53-e972-4395-84b9-1bc4298492ae');
INSERT INTO `clocklist` VALUES ('2023-03-03', 'b08ac22c-3f07-48ed-8f71-128defd5d4f3', '6868cbd4-5de6-4243-a581-89200d68841b');
INSERT INTO `clocklist` VALUES ('2023-04-09', 'b08ac22c-3f07-48ed-8f71-128defd5d4f3', '8075aed3-c07f-408d-8051-6ef880aa2849');
INSERT INTO `clocklist` VALUES ('2023-03-31', 'b08ac22c-3f07-48ed-8f71-128defd5d4f3', '8a351a9b-3950-4f16-94c0-d529ad0e7eb2');
INSERT INTO `clocklist` VALUES ('2023-03-19', '456asd', '97391591-0af0-4b35-8661-eb04602c0b80');
INSERT INTO `clocklist` VALUES ('2023-05-01', '456asd', 'ad1be7fd-b457-4362-9e91-cbe39b11ad72');
INSERT INTO `clocklist` VALUES ('2023-03-17', '456asd', 'b1ed9bd9-df82-4b5d-9caa-2c2ab4c8adad');
INSERT INTO `clocklist` VALUES ('2023-03-11', '456asd', 'bba810c1-7659-4093-9682-de5cc2f97822');
INSERT INTO `clocklist` VALUES ('2023-03-19', 'b08ac22c-3f07-48ed-8f71-128defd5d4f3', 'd172a67f-fe5b-44a1-959d-687150b62816');
INSERT INTO `clocklist` VALUES ('2023-03-31', '456asd', 'vddfsa');

-- ----------------------------
-- Table structure for `definitelist`
-- ----------------------------
DROP TABLE IF EXISTS `definitelist`;
CREATE TABLE `definitelist` (
  `id` varchar(600) NOT NULL,
  `name` varchar(600) DEFAULT NULL,
  `namephone` varchar(600) DEFAULT NULL,
  `namein` varchar(600) DEFAULT '',
  `namewhere` varchar(600) DEFAULT '',
  `staticname` varchar(600) DEFAULT NULL,
  `staticphone` varchar(600) DEFAULT NULL,
  `staticin` varchar(600) DEFAULT NULL,
  `staticwhere` varchar(600) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of definitelist
-- ----------------------------
INSERT INTO `definitelist` VALUES ('4a7f2a26-8e9f-4a8b-8f02-ea27b687c74a', '确诊人:', '15157526236', '确诊人隔离地点:\n', '确诊人居住地:\n', '密接人:', '12444523412', '密接人隔离地点:', '密接人居住地:\n');
INSERT INTO `definitelist` VALUES ('b0fa1874-d469-48c9-82e7-5c058f71b0c9', 'eqwe', null, 'dsa as', 'd ad', 'sada', null, 'sd', 'asdas');

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
INSERT INTO `hospitallist` VALUES ('210500-6', '本溪县第三人民医院', '12', '0', '124', '14');
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
INSERT INTO `piclist` VALUES ('da061db4-d7c4-40f1-87ce-ff6e0283f3fc', '/uploads/file/20230311/file-1678490998969-3.jpg');
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
INSERT INTO `routerlist` VALUES ('个人中心', '/personalCenter', 'el-icon-user\r\n', '46GFSDOFOKPkop', 'null', '用户');
INSERT INTO `routerlist` VALUES ('打卡', '/clockCard', 'el-icon-thumb', 'asdasdvas12312re', 'null', '管理员');
INSERT INTO `routerlist` VALUES ('确诊人', '/userManage/confirmed', 'el-icon-s-claim', 'dasd1213asas', 'mfpafpfaf1', '管理员');
INSERT INTO `routerlist` VALUES ('角色管理', '/roleManage', 'el-icon-takeaway-box', 'fasfa123fafa', 'null', '管理员');
INSERT INTO `routerlist` VALUES ('用户', '/userManage/peopleManage', 'el-icon-user', 'fsf45fasf489vdsa489', 'mfpafpfaf1', '管理员');
INSERT INTO `routerlist` VALUES ('人员管理', '/userManage/peopleManage', 'el-icon-s-open\r\n', 'mfpafpfaf1', 'null', '管理员');
INSERT INTO `routerlist` VALUES ('疫苗信息', '/vaccineInformation', 'el-icon-document-checked', 'sadasvaasd', 'null', '管理员,用户');

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
INSERT INTO `userlist` VALUES ('admin', '123456', 'http://127.0.0.1:3000/api/getImg?url=/uploads/file/20230311/file-1678490998969-3.jpg', 'token-asdsad', '管理员', '1', '456asd');
INSERT INTO `userlist` VALUES ('毛三仙', 'a1', 'http://127.0.0.1:3000/api/getImg?url=/uploads/file/20230311/file-1678490998969-3.jpg', 'token-9p3tb0mkses0000000', '用户', '2', 'b08ac22c-3f07-48ed-8f71-128defd5d4f3');
