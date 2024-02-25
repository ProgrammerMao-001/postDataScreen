/*
Navicat MySQL Data Transfer

Source Server         : hello
Source Server Version : 50505
Source Host           : 127.0.0.1:3306
Source Database       : postdatascreen

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2024-02-26 04:36:52
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `companylist`
-- ----------------------------
DROP TABLE IF EXISTS `companylist`;
CREATE TABLE `companylist` (
  `name` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `id` varchar(200) COLLATE utf8_bin NOT NULL,
  `intro` varchar(8000) COLLATE utf8_bin DEFAULT '',
  `user_name` varchar(200) COLLATE utf8_bin DEFAULT '',
  `user_id` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `founded` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `business_status` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `address` varchar(1000) COLLATE utf8_bin DEFAULT '',
  `position` varchar(300) COLLATE utf8_bin DEFAULT '',
  `province` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `province_id` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `social_code` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `registration_authority` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `business_scope` varchar(5000) COLLATE utf8_bin DEFAULT '',
  `photos` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of companylist
-- ----------------------------
INSERT INTO `companylist` VALUES ('企业名称', '14a4319f-8f04-4bd6-8e44-32054bf3fbb5', '公司简介', '阿帆', '13123123', '2024-02-19', '5', '吉林省吉林市船营区松江路65号吉林市人民政府', '{\"lng\":126.556056,\"lat\":43.843566}', '吉林', '101060000', '统一社会信用代码：', '登记机关', '经营范围', 'http://127.0.0.1:3003/api/getImg?url=/uploads/file/20240225/file-1708832307223-aPngTest.png');
INSERT INTO `companylist` VALUES ('京东科技控股股份有限公司', '302f3d54-0c50-409d-991a-45ebb0f971a7', '京东科技集团是京东集团旗下专注于以技术为产业服务的业务子集团，致力于为企业、金融机构、政府等各类客户提供全价值链的技术性产品与解决方案。依托人工智能、大数据、云计算、物联网等前沿科技能力，京东科技打造出了面向不同行业的产品和解决方案，以此帮助全社会各行业企业降低供应链成本，提升运营效率，成为值得产业信赖的数字合作伙伴。\r\n融合了原京东数科及云与AI两大技术业务板块，京东科技现已成为整个京东集团对外提供技术服务的核心输出平台，拥有丰富的产业理解力、深厚的风险管理能力、用户运营能力和企业服务能力，能面向不同行业为客户提供行业应用、产品开发与产业数字化服务。截至2020年6月末，在政府及其他客户服务领域，京东科技服务了超过40家城市公共服务机构，在全国建立了50多个城市云服务基地，此外也建立了庞大的线下物联网营销平台，拥有自营和联盟媒体点位数超过1,500万，覆盖全国超过300座城市以及6亿多人次；在金融机构服务领域，京东科技已为包括银行、保险、基金、信托、证券公司在内的超600家各类金融机构提供了多层次数字化解决方案；在商户与企业服务领域，已为超100万家小微商户、超20万家中小企业、超700家大型商业中心等提供了包括业务和技术在内的数字化解决方案。\r\n目前京东科技拥有1万多名员工，其中70%以上为研发和专业人员，并且拥有多位入选IEEE Fellow的科学家。截止2020年底，集团累计申请专利3540个，在AAAI、IJCAI、CVPR、KDD、NeurIPS、ICML、ACL、ICASSP等国际AI顶级会议上共发表相关论文近350篇，并已在多项国际性学术赛事中斩获19项世界第一，与美国斯坦福大学、中国科技大学等多所国内外高校合作建立人工智能实验室，充分展开产学研一体化实践。在国际独立权威调研机构Forrester最新发布的《中国预测分析与机器学习解决方案厂商评测2020Q4》中，京东科技首次参评便跻身“卓越表现者”领域，京东NeuHub人工智能开放平台累计调用量已高达万亿次。\r\n依托京东集团整体深厚的生态平台与长期积累的技术实力，京东科技参与了多个国家级重大科研项目：入选人工智能“国家队”——科技部国家人工智能开放创新平台名单，承担起建设国家“新一代智能供应链人工智能开放创新平台”的重任；牵头承担科技部国家重点研发计划项目“国家中心城市数据管控与知识萃取技术和系统应用”、“国家新区数字孪生系统与融合网络计算体系建设”、工信部公共服务平台建设项目“面向人工智能创新应用先导区的应用场景公共服务平台建设”等多个国家级科研项目。', '李娅云', 'a642a063-9ef6-4fda-96b2-bb19cb4ca2b0', '2012-09-05 ', '0', '北京市通州区京东集团总部', '{\"lng\":116.569634,\"lat\":39.792377}', '北京', '101010000', '91110302053604529E', '北京经济技术开发区市场监督管理局', '企业总部管理；投资管理；资产管理；企业管理咨询、投资咨询；公共关系服务；版权代理；接受金融机构委托从事金融信息技术服务外包；接受金融机构委托从事金融业务流程外包；接受金融机构委托从事金融知识流程外包；技术推广服务；企业形象策划；市场调查；企业管理；计算机技术培训（不得面向全国招生）；财务咨询（不得开展审计、验资、查账、评估、会计咨询、代理记账等需专项审批的业务，不得出具相应的审计报告、验资报告、查账报告、评估报告等文字材料）；设计、制作、代理、发布广告；会议服务；承办展览展示活动；数据处理（数据处理中的银行卡中心、PUE值在1.5以上的云计算数据中心除外）；销售电子产品；设备租赁；劳务服务；贸易代理；互联网信息服务；经营电信业务。（“1、未经有关部门批准，不得以公开方式募集资金；2、不得公开开展证券类产品和金融衍生品交易活动；3、不得发放贷款；4、不得对所投资企业以外的其他企业提供担保；5、不得向投资者承诺投资本金不受损失或者承诺最低收益”；市场主体依法自主选择经营项目，开展经营活动；依法须经批准的项目，经相关部门批准后依批准的内容开展经营活动；不得从事国家和本市产业政策禁止和限制类项目的经营活动。）', 'https://img.bosszhipin.com/beijin/mcs/banner/03e20c586edcc2a1f2b9ec79de83368acfcd208495d565ef66e7dff9f98764da.png?x-oss-process=image/resize,w_120,limit_0');
INSERT INTO `companylist` VALUES ('称：', '785d79ca-c466-47cb-8485-ba8bef383d68', '司简介', 'admin', '456asd', null, '1', '澳门大堂区伦敦街170保利高有限公司(澳门离岸商业服务)', '{\"lng\":113.564812,\"lat\":22.19142}', '澳门', '101330000', null, null, '范围：', 'http://127.0.0.1:3003/api/getImg?url=/uploads/file/20240225/file-1708868131475-456.png');
INSERT INTO `companylist` VALUES ('企业名称1', '86587e76-10cb-4220-bfcb-c2e845c155e3', '公司', '毛大仙', '6014d307-9278-4047-8446-8b066d200781', null, '0', '北京市通州区通明湖公园', '{\"lng\":116.584528,\"lat\":39.782202}', '北京', '101010000', '会信用代码：', null, '经营', 'http://127.0.0.1:3003/api/getImg?url=/uploads/file/20240225/file-1708864840876-3.jpg');
INSERT INTO `companylist` VALUES ('业名', 'c3bece8f-536b-4c12-8588-fe3082d439cb', '司简', '撒发生', '21', null, '1', '吉林省吉林市丰满区', '{\"lng\":126.630373,\"lat\":43.842318}', '吉林', '101060000', null, null, '营范', 'http://127.0.0.1:3003/api/getImg?url=/uploads/file/20240225/file-1708868107342-456.png');
INSERT INTO `companylist` VALUES ('啊', 'd93bd661-de20-4ed5-8b81-b96473218382', '阿萨德', '毛大仙', '6014d307-9278-4047-8446-8b066d200781', '2024-02-12', '0', '内蒙古自治区鄂尔多斯市乌审旗', '{\"lng\":108.893878,\"lat\":38.942229}', '山东', '101120000', '方法', '阿萨德', '萨达啊', 'http://127.0.0.1:3003/api/getImg?url=/uploads/file/20240225/file-1708838554936-123.png');

-- ----------------------------
-- Table structure for `dictlist`
-- ----------------------------
DROP TABLE IF EXISTS `dictlist`;
CREATE TABLE `dictlist` (
  `id` varchar(100) COLLATE utf8_bin NOT NULL,
  `data` varchar(20200) COLLATE utf8_bin DEFAULT '',
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
INSERT INTO `dictlist` VALUES ('a294d159-beca-4932-8b70-f38337c583e6', '[{\"value\":101010000,\"label\":\"北京\"},{\"value\":101020000,\"label\":\"上海\"},{\"value\":101030000,\"label\":\"天津\"},{\"value\":101040000,\"label\":\"重庆\"},{\"value\":101050000,\"label\":\"黑龙江\"},{\"value\":101060000,\"label\":\"吉林\"},{\"value\":101070000,\"label\":\"辽宁\"},{\"value\":101080000,\"label\":\"内蒙古\"},{\"value\":101090000,\"label\":\"河北\"},{\"value\":101100000,\"label\":\"山西\"},{\"value\":101110000,\"label\":\"陕西\"},{\"value\":101120000,\"label\":\"山东\"},{\"value\":101130000,\"label\":\"新疆\"},{\"value\":101140000,\"label\":\"西藏\"},{\"value\":101150000,\"label\":\"青海\"},{\"value\":101160000,\"label\":\"甘肃\"},{\"value\":101170000,\"label\":\"宁夏\"},{\"value\":101180000,\"label\":\"河南\"},{\"value\":101190000,\"label\":\"江苏\"},{\"value\":101200000,\"label\":\"湖北\"},{\"value\":101210000,\"label\":\"浙江\"},{\"value\":101220000,\"label\":\"安徽\"},{\"value\":101230000,\"label\":\"福建\"},{\"value\":101240000,\"label\":\"江西\"},{\"value\":101250000,\"label\":\"湖南\"},{\"value\":101260000,\"label\":\"贵州\"},{\"value\":101270000,\"label\":\"四川\"},{\"value\":101280000,\"label\":\"广东\"},{\"value\":101290000,\"label\":\"云南\"},{\"value\":101300000,\"label\":\"广西\"},{\"value\":101310000,\"label\":\"海南\"},{\"value\":101320000,\"label\":\"香港\"},{\"value\":101330000,\"label\":\"澳门\"},{\"value\":101340000,\"label\":\"台湾\"}]', 'province', '全国省份列表');
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
INSERT INTO `piclist` VALUES ('04169bce-2162-4c23-8532-24942f04b340', '/uploads/file/20240225/file-1708864840876-3.jpg');
INSERT INTO `piclist` VALUES ('0a6cf1a8-bd87-4915-8926-21f3e6990c77', '/uploads/file/20240225/file-1708838554936-123.png');
INSERT INTO `piclist` VALUES ('1a3146e3-a729-4661-8349-3ad30ecf0705', '/uploads/file/20230527/file-1685155034491-aPngTest.png');
INSERT INTO `piclist` VALUES ('24ef5ee0-dd36-40de-8733-abff8390a650', '/uploads/file/20231028/file-1698467026246-aXlsTest.xls');
INSERT INTO `piclist` VALUES ('252bff0a-b68e-4e4e-8742-2c6ce7a347ec', '/uploads/file/20240224/file-1708782801859-aPngTest.png');
INSERT INTO `piclist` VALUES ('256b661e-efd4-4ca5-8603-85965cd9b97b', '/uploads/file/20240225/file-1708831662926-456.png');
INSERT INTO `piclist` VALUES ('299351e3-dc50-41ff-a363-3e6f72f91428', '/uploads/file/20240225/file-1708868131475-456.png');
INSERT INTO `piclist` VALUES ('302e4cf2-d24c-422d-8f0b-a52337dc9115', '/uploads/file/20240225/file-1708800580234-profile.jpg');
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
INSERT INTO `piclist` VALUES ('9a5dc41b-09f7-4382-9e09-1ef7d1d8a51f', '/uploads/file/20240225/file-1708832307223-aPngTest.png');
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
INSERT INTO `piclist` VALUES ('f66a5fff-8ecd-4afa-8f56-7e087f7309fe', '/uploads/file/20240225/file-1708831622820-123.png');
INSERT INTO `piclist` VALUES ('f68454a0-d136-4420-b8b2-31e02ba1459b', '/uploads/file/20240225/file-1708868107342-456.png');
INSERT INTO `piclist` VALUES ('fbc403aa-c37a-4af4-be1e-066bcfce9c48', '/uploads/file/20230311/file-1678522646063-girl.jpg');

-- ----------------------------
-- Table structure for `postlist`
-- ----------------------------
DROP TABLE IF EXISTS `postlist`;
CREATE TABLE `postlist` (
  `id` varchar(200) COLLATE utf8_bin NOT NULL,
  `name` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `salary_range` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `avg_range` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `desc` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
  `recruitment_status` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `post_type` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `company_name` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `company_id` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `company_address` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `company_position` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `company_province_id` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `company_province` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `education` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `work_life` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of postlist
-- ----------------------------
INSERT INTO `postlist` VALUES ('1728f2b6-f2c1-4796-85ae-52b3b35fc204', '123', '8-12K', '123', '', '0', '[1010000,1000020,100102]', '京东科技控股股份有限公司', '302f3d54-0c50-409d-991a-45ebb0f971a7', '北京市通州区京东集团总部', '{\"lng\":116.569634,\"lat\":39.792377}', '101010000', '北京', '3', '2');
INSERT INTO `postlist` VALUES ('576afb4d-f19c-4037-83f9-668358a12b1b', '岗位名称', '18-22K', '平均薪资：', '职位描述', '0', '[1010000,1000020,100101]', '企业名称', '14a4319f-8f04-4bd6-8e44-32054bf3fbb5', '吉林省吉林市船营区松江路65号吉林市人民政府', '{\"lng\":126.556056,\"lat\":43.843566}', '101060000', '吉林', '6', '0');
INSERT INTO `postlist` VALUES ('79fbee78-a8d4-4339-b412-fad00f264cc0', '阿萨德', '8-12K', '20k', '职位描述：\n', '0', '[1010000,1000050,100407]', '啊', 'd93bd661-de20-4ed5-8b81-b96473218382', '内蒙古自治区鄂尔多斯市乌审旗', '{\"lng\":108.893878,\"lat\":38.942229}', '101120000', '山东', '4', '2');
INSERT INTO `postlist` VALUES ('c834f1c9-e1b1-4c6f-b033-93b40418334a', '京东科技-产品经理（偏数据策略及分析）', '20-40K·16薪', '80K', '工作内容： \r\n1.搭建并完善基金全面、精细的数据监控体系，提升基金线上销售平台整体数据运营效率。 \r\n2.根据实时数据反馈，制定相应完善数据平台能力，驱动业务效率提升。 \r\n3. 理解数据分析应用场景并抽象为数据产品需求，制定数据模型的产品化策略，推动数据产品的落地；\r\n任职资格： \r\n1.本科及以上学历，5年以上数据分析及产品设计相关经验，参与过基金、券商等金融机构的数据服务相关系统建设的优先。 \r\n2.熟悉统计学理论，熟练常用统计方法，建立分析模型。熟练使用SQL等工具，能够独立完成数据探查输出分析结果，高效使用逻辑与数据有效沟通。 \r\n4.良好的数据分析能力和数据敏感度，具备较强的跨团队合作，协调沟通能力，较强的内驱力，能够持续在业务方向上进行探索与尝试。 \r\n5. 参与或主导过数据体系或报表体系的搭建，有较好的业务抽象能力和系统设计能力。', '0', '[1020000, 1000160, 110101]', '京东科技控股股份有限公司', '302f3d54-0c50-409d-991a-45ebb0f971a7', '北京市北京经济技术开发区科创十一街18号C座2层221室', '1000160', '101010100', '北京', '4', '5');

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
INSERT INTO `userlist` VALUES ('李娅云', 'a123456', 'http://127.0.0.1:3003/api/getImg?url=/uploads/file/20240225/file-1708800580234-profile.jpg', 'token-2s83fe892rw0000000', '用户', '2', 'a642a063-9ef6-4fda-96b2-bb19cb4ca2b0');
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
