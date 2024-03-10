/*
Navicat MySQL Data Transfer

Source Server         : cc
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : exam

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2023-07-22 23:54:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('1', '在就业培训机构', '无', '试题考核');
INSERT INTO `course` VALUES ('2', '交通职业培训机构', '无', '试题考核');

-- ----------------------------
-- Table structure for exam
-- ----------------------------
DROP TABLE IF EXISTS `exam`;
CREATE TABLE `exam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `time` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT '未开始',
  `course_id` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of exam
-- ----------------------------
INSERT INTO `exam` VALUES ('1', '在就业培训考试', '2023-02-09 19:00', '已结束', '1', '120');
INSERT INTO `exam` VALUES ('2', '入职培训考试', '2023-03-30 01:00', '已结束', '2', '180');

-- ----------------------------
-- Table structure for exam_paper
-- ----------------------------
DROP TABLE IF EXISTS `exam_paper`;
CREATE TABLE `exam_paper` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_id` int(11) DEFAULT NULL,
  `paper_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of exam_paper
-- ----------------------------
INSERT INTO `exam_paper` VALUES ('6', '1', '1');

-- ----------------------------
-- Table structure for paper
-- ----------------------------
DROP TABLE IF EXISTS `paper`;
CREATE TABLE `paper` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `scope` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of paper
-- ----------------------------
INSERT INTO `paper` VALUES ('1', '在就业培训试卷', null, '1');
INSERT INTO `paper` VALUES ('2', '入职培训试卷', null, '2');

-- ----------------------------
-- Table structure for paper_question
-- ----------------------------
DROP TABLE IF EXISTS `paper_question`;
CREATE TABLE `paper_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paper_id` int(11) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=347 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of paper_question
-- ----------------------------
INSERT INTO `paper_question` VALUES ('322', '4', '30');
INSERT INTO `paper_question` VALUES ('323', '4', '31');
INSERT INTO `paper_question` VALUES ('324', '4', '32');
INSERT INTO `paper_question` VALUES ('345', '1', '8');
INSERT INTO `paper_question` VALUES ('346', '1', '20');

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `a` varchar(255) DEFAULT NULL,
  `b` varchar(255) DEFAULT NULL,
  `c` varchar(255) DEFAULT NULL,
  `d` varchar(255) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `time` varchar(255) DEFAULT NULL,
  `answer` varchar(255) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES ('8', '青哥哥好不好1', '1', '好', '很好', '差', '很差', '5', '1', '2023-01-29 23:39:06', 'A', null, '1');
INSERT INTO `question` VALUES ('20', '青哥哥好不好2', '1', '好', '很好', '差', '很差', '5', '1', '2023-01-29 23:39:06', 'B', '', '1');
INSERT INTO `question` VALUES ('21', '青哥哥好不好3', '1', '好', '很好', '差', '很差', '5', '1', '2023-01-29 23:39:06', 'C', '', '1');
INSERT INTO `question` VALUES ('22', '青哥哥好不好4', '1', '好', '很好', '差', '很差', '5', '1', '2023-01-29 23:39:06', 'D', '', '1');
INSERT INTO `question` VALUES ('23', '青哥哥好不好5', '1', '好', '很好', '差', '很差', '5', '1', '2023-01-29 23:39:06', 'B', '', '1');
INSERT INTO `question` VALUES ('24', '青哥哥好不好6', '1', '好', '很好', '差', '很差', '5', '1', '2023-01-29 23:39:06', 'B', '', '1');
INSERT INTO `question` VALUES ('25', '青哥哥好不好7', '1', '好', '很好', '差', '很差', '5', '1', '2023-01-29 23:39:06', 'D', '', '1');
INSERT INTO `question` VALUES ('26', '青哥哥好不好8', '1', '好', '很好', '差', '很差', '5', '1', '2023-01-29 23:39:06', 'C', '', '1');
INSERT INTO `question` VALUES ('27', '青哥哥好不好9', '1', '好', '很好', '差', '很差', '5', '1', '2023-01-29 23:39:06', 'A', '', '1');
INSERT INTO `question` VALUES ('28', '青哥哥好不好10', '2', '', '', '', '', '5', '1', '2023-01-29 23:39:06', '是', '', '1');
INSERT INTO `question` VALUES ('29', '青哥哥好不好11', '2', '', '', '', '', '5', '1', '2023-01-29 23:39:06', '是', '', '1');
INSERT INTO `question` VALUES ('30', '青哥哥好不好12', '2', '', '', '', '', '5', '1', '2023-01-29 23:39:06', '是', '', '1');
INSERT INTO `question` VALUES ('31', '青哥哥好不好13', '2', '', '', '', '', '5', '1', '2023-01-29 23:39:06', '是', '', '1');
INSERT INTO `question` VALUES ('32', '青哥哥好不好14', '3', '', '', '', '', '10', '1', '2023-01-29 23:39:06', '略', '', '1');
INSERT INTO `question` VALUES ('33', '青哥哥好不好15', '3', '', '', '', '', '10', '1', '2023-01-29 23:39:06', '略', '', '1');
INSERT INTO `question` VALUES ('34', '青哥哥好不好16', '3', '', '', '', '', '10', '1', '2023-01-29 23:39:06', '略', '', '1');
INSERT INTO `question` VALUES ('35', '青哥哥好不好17', '2', '', '', '', '', '5', '1', '2023-01-29 23:39:06', '是', '', '1');
INSERT INTO `question` VALUES ('36', '青哥哥好不好18', '2', '', '', '', '', '5', '1', '2023-01-29 23:39:06', '是', '', '1');

-- ----------------------------
-- Table structure for sign
-- ----------------------------
DROP TABLE IF EXISTS `sign`;
CREATE TABLE `sign` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `state` varchar(255) DEFAULT '待审核',
  PRIMARY KEY (`id`),
  UNIQUE KEY `exam_user_index` (`exam_id`,`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sign
-- ----------------------------
INSERT INTO `sign` VALUES ('5', '1', '1', '审核不通过');
INSERT INTO `sign` VALUES ('20', '1', '11', '审核通过');
INSERT INTO `sign` VALUES ('38', '2', '11', '审核通过');

-- ----------------------------
-- Table structure for student_paper
-- ----------------------------
DROP TABLE IF EXISTS `student_paper`;
CREATE TABLE `student_paper` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_id` int(11) DEFAULT NULL,
  `paper` text,
  `user_id` int(11) DEFAULT NULL,
  `time` varchar(255) DEFAULT NULL,
  `score` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student_paper
-- ----------------------------
INSERT INTO `student_paper` VALUES ('4', '1', '[{\"id\":8,\"name\":\"青哥哥好不好1\",\"type\":1,\"a\":\"好\",\"b\":\"很好\",\"c\":\"差\",\"d\":\"很差\",\"score\":5,\"userId\":1,\"time\":\"2023-01-29 23:39:06\",\"answer\":\"A\",\"detail\":null,\"courseId\":1,\"studentAnswer\":\"A\"},{\"id\":20,\"name\":\"青哥哥好不好2\",\"type\":1,\"a\":\"好\",\"b\":\"很好\",\"c\":\"差\",\"d\":\"很差\",\"score\":5,\"userId\":1,\"time\":\"2023-01-29 23:39:06\",\"answer\":\"B\",\"detail\":\"\",\"courseId\":1,\"studentAnswer\":\"A\"},{\"id\":21,\"name\":\"青哥哥好不好3\",\"type\":1,\"a\":\"好\",\"b\":\"很好\",\"c\":\"差\",\"d\":\"很差\",\"score\":5,\"userId\":1,\"time\":\"2023-01-29 23:39:06\",\"answer\":\"C\",\"detail\":\"\",\"courseId\":1,\"studentAnswer\":\"A\"},{\"id\":29,\"name\":\"青哥哥好不好11\",\"type\":2,\"a\":\"\",\"b\":\"\",\"c\":\"\",\"d\":\"\",\"score\":5,\"userId\":1,\"time\":\"2023-01-29 23:39:06\",\"answer\":\"是\",\"detail\":\"\",\"courseId\":1,\"studentAnswer\":\"是\"},{\"id\":30,\"name\":\"青哥哥好不好12\",\"type\":2,\"a\":\"\",\"b\":\"\",\"c\":\"\",\"d\":\"\",\"score\":5,\"userId\":1,\"time\":\"2023-01-29 23:39:06\",\"answer\":\"是\",\"detail\":\"\",\"courseId\":1,\"studentAnswer\":\"是\"},{\"id\":33,\"name\":\"青哥哥好不好15\",\"type\":3,\"a\":\"\",\"b\":\"\",\"c\":\"\",\"d\":\"\",\"score\":10,\"userId\":1,\"time\":\"2023-01-29 23:39:06\",\"answer\":\"略\",\"detail\":\"\",\"courseId\":1,\"studentAnswer\":\"1\"}]', '1', '2023-02-02 18:10:20', '30');
INSERT INTO `student_paper` VALUES ('5', '1', '[{\"id\":8,\"name\":\"青哥哥好不好1\",\"type\":1,\"a\":\"好\",\"b\":\"很好\",\"c\":\"差\",\"d\":\"很差\",\"score\":5,\"userId\":1,\"time\":\"2023-01-29 23:39:06\",\"answer\":\"A\",\"detail\":null,\"courseId\":1,\"studentAnswer\":\"D\"},{\"id\":20,\"name\":\"青哥哥好不好2\",\"type\":1,\"a\":\"好\",\"b\":\"很好\",\"c\":\"差\",\"d\":\"很差\",\"score\":5,\"userId\":1,\"time\":\"2023-01-29 23:39:06\",\"answer\":\"B\",\"detail\":\"\",\"courseId\":1,\"studentAnswer\":\"C\"},{\"id\":21,\"name\":\"青哥哥好不好3\",\"type\":1,\"a\":\"好\",\"b\":\"很好\",\"c\":\"差\",\"d\":\"很差\",\"score\":5,\"userId\":1,\"time\":\"2023-01-29 23:39:06\",\"answer\":\"C\",\"detail\":\"\",\"courseId\":1,\"studentAnswer\":\"C\"},{\"id\":29,\"name\":\"青哥哥好不好11\",\"type\":2,\"a\":\"\",\"b\":\"\",\"c\":\"\",\"d\":\"\",\"score\":5,\"userId\":1,\"time\":\"2023-01-29 23:39:06\",\"answer\":\"是\",\"detail\":\"\",\"courseId\":1,\"studentAnswer\":\"否\"},{\"id\":30,\"name\":\"青哥哥好不好12\",\"type\":2,\"a\":\"\",\"b\":\"\",\"c\":\"\",\"d\":\"\",\"score\":5,\"userId\":1,\"time\":\"2023-01-29 23:39:06\",\"answer\":\"是\",\"detail\":\"\",\"courseId\":1,\"studentAnswer\":\"否\"},{\"id\":33,\"name\":\"青哥哥好不好15\",\"type\":3,\"a\":\"\",\"b\":\"\",\"c\":\"\",\"d\":\"\",\"score\":10,\"userId\":1,\"time\":\"2023-01-29 23:39:06\",\"answer\":\"略\",\"detail\":\"\",\"courseId\":1,\"studentAnswer\":\"1\"}]', '11', '2023-02-07 19:01:16', '0');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '内容',
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('coffee', 'el-icon-coffee\r\n', 'icon');
INSERT INTO `sys_dict` VALUES ('document', 'el-icon-document', 'icon');
INSERT INTO `sys_dict` VALUES ('house', 'el-icon-house', 'icon');
INSERT INTO `sys_dict` VALUES ('menu', 'el-icon-menu', 'icon');
INSERT INTO `sys_dict` VALUES ('s-custom', 'el-icon-s-custom', 'icon');
INSERT INTO `sys_dict` VALUES ('s-grid', 'el-icon-s-grid', 'icon');
INSERT INTO `sys_dict` VALUES ('s-marketing', 'el-icon-s-marketing', 'icon');
INSERT INTO `sys_dict` VALUES ('user', 'el-icon-user', 'icon');

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `size` bigint(20) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `is_delete` tinyint(1) DEFAULT '0',
  `enable` tinyint(1) DEFAULT '1',
  `md5` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_file
-- ----------------------------
INSERT INTO `sys_file` VALUES ('8', '1537162703627.jpg', 'jpg', '100', 'http://localhost:9090/file/623c8f7a860a4b48b0e3932d0055804b.jpg', '0', '1', 'a7e877ebbcb42046fc6241d56d180ca1');
INSERT INTO `sys_file` VALUES ('9', '1111.jpg', 'jpg', '100', 'http://localhost:9090/file/adbb0ddcdd8645a78225132c854333c0.jpg', '0', '1', 'a7e877ebbcb42046fc6241d56d180ca1');
INSERT INTO `sys_file` VALUES ('10', '1622308186348.jpeg', 'jpeg', '483', 'http://localhost:9090/file/4c4ff5543c0c4529ba5d722d2000f6c1.jpeg', '1', '1', '650ea619486fe826754529a16b5610ea');
INSERT INTO `sys_file` VALUES ('11', 'QQ图片20220425203510.jpg', 'jpg', '139', 'http://localhost:9090/file/be5d445044db49fb81c55b4922b6147c.jpg', '0', '0', '06fce4864841c2d41a335a6cb056f97f');
INSERT INTO `sys_file` VALUES ('12', '用户信息 (1).xlsx', 'xlsx', '3', 'http://localhost:9090/file/28948748267e45e68612251596a995c1.xlsx', '0', '1', 'd6aae1f8d08c99d62a6600395c0cb018');
INSERT INTO `sys_file` VALUES ('13', '904012490-1-208.mp4', 'mp4', '5022', 'http://localhost:9090/file/73e3a0f61937405b8fc2f53e6b325bec.mp4', '0', '1', 'b17452529c2c90d6fa81ca39c7e5a2ad');
INSERT INTO `sys_file` VALUES ('14', '第十一集 (42).mp4', 'mp4', '18880', 'http://localhost:9090/file/0159ada574b24b75b87843a4689e1760.mp4', '1', '1', '94eb8c92a43ec910128120ade359364b');
INSERT INTO `sys_file` VALUES ('15', '第十一集 (42).mp4', 'mp4', '18880', 'http://localhost:9090/file/5487d9304eee4e6ea3777d38262c3f6c.mp4', '1', '1', '94eb8c92a43ec910128120ade359364b');
INSERT INTO `sys_file` VALUES ('16', '第十一集 (42).mp4', 'mp4', '18880', 'http://localhost:9090/file/b1dbe0923e10409a8e008a7c9dcb9f3b.mp4', '1', '1', '94eb8c92a43ec910128120ade359364b');
INSERT INTO `sys_file` VALUES ('17', '第十一集 (42).mp4', 'mp4', '18880', 'http://localhost:9090/file/dacce7d5b4384710bb1d66ae1debdcc4.mp4', '1', '1', '94eb8c92a43ec910128120ade359364b');
INSERT INTO `sys_file` VALUES ('18', '第十一集 (42).mp4', 'mp4', '18880', 'http://localhost:9090/file/a38fcfed259548848a96f0ccd0341595.mp4', '1', '1', '94eb8c92a43ec910128120ade359364b');
INSERT INTO `sys_file` VALUES ('19', '第十一集 (42).mp4', 'mp4', '18880', 'http://localhost:9090/file/443fed2acda24a99a35dec279d92f9ff.mp4', '0', '1', '94eb8c92a43ec910128120ade359364b');
INSERT INTO `sys_file` VALUES ('20', '第一集 (43).mp4', 'mp4', '9107', 'http://localhost:9090/file/a8bbb2382b5746d387250dc4b338bf43.mp4', '0', '1', '2fe2cd5aef66d5cd50094e110a49715e');
INSERT INTO `sys_file` VALUES ('21', '第一集 (49).mp4', 'mp4', '7435', 'http://localhost:9090/file/067eeb313df44127ae1e7ef0ca591a80.mp4', '1', '1', 'd926d6a93d20cc6cc7826663b7c81d2f');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `page_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='112';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '主页', '/home', 'el-icon-house', '主页', null, 'Home');
INSERT INTO `sys_menu` VALUES ('2', '用户管理', '/user', 'el-icon-document', '用户管理', '5', 'User');
INSERT INTO `sys_menu` VALUES ('3', '角色管理', '/role', 'el-icon-s-custom', '角色管理', '5', 'Role');
INSERT INTO `sys_menu` VALUES ('4', '文件管理', '/file', 'el-icon-document', '文件管理', '5', 'File');
INSERT INTO `sys_menu` VALUES ('5', '系统管理', '', 'el-icon-menu', '系统管理', null, null);
INSERT INTO `sys_menu` VALUES ('9', '菜单管理', '/menu', 'el-icon-s-grid', '菜单管理', '5', 'Menu');
INSERT INTO `sys_menu` VALUES ('14', '机构管理', '/course', 'el-icon-coffee\r\n', '机构信息管理', null, 'Course');
INSERT INTO `sys_menu` VALUES ('16', '题目管理', '/question', 'el-icon-coffee\r\n', '题目管理', null, 'Question');
INSERT INTO `sys_menu` VALUES ('17', '试卷管理', '/paper', 'el-icon-coffee\r\n', '试卷管理', null, 'Paper');
INSERT INTO `sys_menu` VALUES ('18', '考试管理', '/exam', 'el-icon-coffee\r\n', '考试管理', null, 'Exam');
INSERT INTO `sys_menu` VALUES ('19', '报名审核', '/sign', 'el-icon-coffee\r\n', null, null, 'Sign');
INSERT INTO `sys_menu` VALUES ('20', '阅卷管理', '/studentpaper', 'el-icon-coffee\r\n', null, null, 'Studentpaper');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `flag` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('2', '普通用户', '普通用户', 'ROLE_USER');
INSERT INTO `sys_role` VALUES ('3', '超级管理员', '超级管理员', 'ROLE_ROOT');
INSERT INTO `sys_role` VALUES ('4', '管理员', '管理员', 'ROLE_ADMIN');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `menu_id` int(11) NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`role_id`,`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='角色菜单关系表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('2', '1');
INSERT INTO `sys_role_menu` VALUES ('2', '4');
INSERT INTO `sys_role_menu` VALUES ('2', '5');
INSERT INTO `sys_role_menu` VALUES ('3', '1');
INSERT INTO `sys_role_menu` VALUES ('3', '2');
INSERT INTO `sys_role_menu` VALUES ('3', '3');
INSERT INTO `sys_role_menu` VALUES ('3', '4');
INSERT INTO `sys_role_menu` VALUES ('3', '5');
INSERT INTO `sys_role_menu` VALUES ('3', '9');
INSERT INTO `sys_role_menu` VALUES ('3', '14');
INSERT INTO `sys_role_menu` VALUES ('3', '16');
INSERT INTO `sys_role_menu` VALUES ('3', '17');
INSERT INTO `sys_role_menu` VALUES ('3', '18');
INSERT INTO `sys_role_menu` VALUES ('3', '19');
INSERT INTO `sys_role_menu` VALUES ('3', '20');
INSERT INTO `sys_role_menu` VALUES ('4', '1');
INSERT INTO `sys_role_menu` VALUES ('4', '3');
INSERT INTO `sys_role_menu` VALUES ('4', '4');
INSERT INTO `sys_role_menu` VALUES ('4', '5');
INSERT INTO `sys_role_menu` VALUES ('4', '9');
INSERT INTO `sys_role_menu` VALUES ('4', '12');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `role` varchar(255) DEFAULT 'ROLE_USER',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'root', 'root', '2022-01-27 00:29:00', 'ROLE_ROOT');
INSERT INTO `user` VALUES ('5', '猪八戒', 'bai', '2022-04-27 00:29:00', 'ROLE_USER');
INSERT INTO `user` VALUES ('11', '11', '11', '2022-06-27 00:29:00', 'ROLE_USER');
INSERT INTO `user` VALUES ('17', '孙悟空', 'bai', '2022-09-27 00:29:00', 'ROLE_USER');
INSERT INTO `user` VALUES ('124', '沙僧', '22', '2022-11-27 00:29:00', 'ROLE_USER');
INSERT INTO `user` VALUES ('125', 'ss', 'ss', '2023-01-27 00:30:57', 'ROLE_ADMIN');
INSERT INTO `user` VALUES ('126', '24k纯帅', '24k555', '2023-10-27 01:15:28', 'ROLE_USER');

-- ----------------------------
-- Table structure for user_file
-- ----------------------------
DROP TABLE IF EXISTS `user_file`;
CREATE TABLE `user_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `file_id` int(11) DEFAULT NULL,
  `file_type` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_file
-- ----------------------------
INSERT INTO `user_file` VALUES ('1', '11', '13', 'mp4', '已学习');
INSERT INTO `user_file` VALUES ('3', '11', '14', 'mp4', '未学习');
