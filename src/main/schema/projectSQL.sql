# region 创建数据库

CREATE DATABASE interview;
USE interview;

# 用户登录表
CREATE TABLE user_login (
  id       BIGINT PRIMARY KEY  NOT NULL
  COMMENT '用户登录编号',
  username VARCHAR(20)         NOT NULL
  COMMENT '用户登录名',
  password VARCHAR(128)        NOT NULL
  COMMENT '用户密码(加密后)',
  email    VARCHAR(50)         NOT NULL
  COMMENT '用户邮箱(验证过的)'
)
  COMMENT '用户登录表';
INSERT INTO user_login (id, username, password, email)
VALUES
  (403591502330204160, 'rxliuli', '123456', 'rxliuli@gmail.com');
CREATE UNIQUE INDEX user_login_username_uindex
  ON user_login (username);
CREATE UNIQUE INDEX user_login_email_uindex
  ON user_login (email);

# 用户详细信息表
DROP TABLE IF EXISTS user_info;
CREATE TABLE user_info (
  id       BIGINT PRIMARY KEY  NOT NULL
  COMMENT '用户登录编号',
  nickname VARCHAR(20)         NOT NULL
  COMMENT '用户昵称',
  realname VARCHAR(20)
  COMMENT '用户真实姓名(可以为空)',
  picture  VARCHAR(20)         NOT NULL
  COMMENT '用户头像(不能为空但在程序中会赋予默认值)',
  birthday DATE
  COMMENT '用户生日(可以为空)',
  gender   INT
  COMMENT '用户性别(可以为空)',
  address  VARCHAR(200)
  COMMENT '用户地址(可以为空)',
  FOREIGN KEY (id) REFERENCES user_login (id)
)
  COMMENT '用户详细信息表';
INSERT INTO user_info (id, nickname, realname, picture, birthday, gender, address)
VALUES (403591502330204160, '琉璃', '琉璃', '', '1998-05-26', NULL, NULL);

# 面试题目类型表
CREATE TABLE topic_type (
  id          BIGINT PRIMARY KEY NOT NULL
  COMMENT '面试题目的类型编号',
  title       VARCHAR(20)        NOT NULL
  COMMENT '面试题目的类型标题',
  description VARCHAR(200)
  COMMENT '面试题目类型的说明'
)
  COMMENT '面试题目类型表';
INSERT INTO topic_type (id, title, description)
VALUES (403591502330204160, 'Java', '如果你觉得自己的 Java 基本功还不够的话就来这里看看吧!');

# 面试题目表
DROP TABLE IF EXISTS topic;
CREATE TABLE topic (
  id         BIGINT PRIMARY KEY         NOT NULL
  COMMENT '面试题目编号',
  typeId     BIGINT                     NOT NULL
  COMMENT '面试题目类型,关联面试题目类型表的 id',
  title      VARCHAR(200)               NOT NULL
  COMMENT '面试题目的标题',
  answer     TEXT                       NOT NULL
  COMMENT '面试题目的答案',
  updateTime DATETIME DEFAULT now()     NOT NULL
  COMMENT '最后更新时间(默认为当前时间)',
  FOREIGN KEY (typeId) REFERENCES topic_type (id)
)
  COMMENT '面试题目表';
INSERT INTO topic (id, typeId, title, answer, updateTime)
VALUES (
  403591502330204160,
  403591502330204160,
  '什么是Java虚拟机？为什么Java被称作是“平台无关的编程语言”？',
  'Java虚拟机是一个可以执行Java字节码的虚拟机进程。Java源文件被编译成能被Java虚拟机执行的字节码文件。',
  now()
);

# 面试题目评论表
CREATE TABLE topic_comment (
  id          BIGINT PRIMARY KEY     NOT NULL
  COMMENT '面试题目评论编号',
  userLoginId BIGINT                 NOT NULL
  COMMENT '评论用户的编号,外键关联用户登录表',
  topicId     BIGINT                 NOT NULL
  COMMENT '评论题目的编号,外键关联面试题目信息表',
  content     VARCHAR(200)           NOT NULL
  COMMENT '用户评论的内容',
  commentTime DATETIME DEFAULT now() NOT NULL
  COMMENT '用户评论时间',
  FOREIGN KEY (topicId) REFERENCES topic (id),
  FOREIGN KEY (userLoginId) REFERENCES user_login (id)
)
  COMMENT '面试题目评论表';
INSERT INTO topic_comment (id, userLoginId, topicId, content, commentTime)
VALUES (
  403591502330204160,
  403591502330204160,
  403591502330204160,
  '这道题有点意思呀!',
  now()
);

# 考试信息表
CREATE TABLE exam (
  id        BIGINT PRIMARY KEY  NOT NULL
  COMMENT '考试信息表',
  title     VARCHAR(20)         NOT NULL
  COMMENT '考试名字表',
  startTime DATETIME            NOT NULL
  COMMENT '考试开始时间',
  endTime   DATETIME            NOT NULL
  COMMENT '考试结束时间',
  topicIds  TEXT                NOT NULL
  COMMENT '考试题目编号列表'
)
  COMMENT '考试信息表';
INSERT INTO exam (id, title, startTime, endTime, topicIds)
VALUES (
  403591502330204160,
  'Java 基础面向对象',
  '2017-11-10 15:00:00',
  '2017-11-10 16:00:00',
  ''
);

# 考试信息
CREATE TABLE result (
  id          BIGINT PRIMARY KEY NOT NULL
  COMMENT '考试编号',
  userLoginId BIGINT             NOT NULL
  COMMENT '用户编号,外键关联 user_login 表',
  examId      BIGINT             NOT NULL
  COMMENT '考试编号,外键关联 exam 表',
  examScore   DOUBLE             NOT NULL
  COMMENT '分数',
  startTime   DATETIME
  COMMENT '用户实际开始的时间,可以为空(没有进行考试)',
  endTime     DATETIME
  COMMENT '用户实际结束的时间,可以为空(没有进行考试)',
  FOREIGN KEY (examId) REFERENCES exam (id),
  FOREIGN KEY (userLoginId) REFERENCES user_login (id)
)
  COMMENT '考试信息表';
INSERT INTO result (id, userLoginId, examId, examScore, startTime, endTime)
VALUES (
  403591502330204160,
  396193657629315072,
  403591502330204160,
  80.0,
  '2017-11-10 15:00:00',
  '2017-11-10 16:00:00'
);

# 考试题目的信息表
CREATE TABLE exam_topic (
  id         BIGINT PRIMARY KEY         NOT NULL
  COMMENT '考试题目详细信息的编号',
  resultId   BIGINT                     NOT NULL
  COMMENT '考试成绩的编号,外键关联 result 成绩表的 id',
  topicId    BIGINT                     NOT NULL
  COMMENT '面试题目的编号,外键关联 topic 面试题目表的 id',
  topicScore DOUBLE DEFAULT 0           NOT NULL
  COMMENT '当前题目的分数(默认值为 0)',
  content    TEXT
  COMMENT '当前题目的答案(可以为空,因为题目也有可能完全不会)',
  FOREIGN KEY (resultId) REFERENCES result (id),
  FOREIGN KEY (topicId) REFERENCES topic (id)
)
  COMMENT '考试题目的信息表';
INSERT INTO exam_topic (id, resultId, topicId, topicScore, content)
VALUES (
  403591502330204160,
  403591502330204160,
  396193667762753537,
  0,
  NULL
);

# 管理员表
DROP TABLE IF EXISTS admin;
CREATE TABLE admin (
  id         BIGINT PRIMARY KEY  NOT NULL
  COMMENT '管理员编号',
  adminName  VARCHAR(20)         NOT NULL
  COMMENT '管理员名字',
  password   VARCHAR(128)        NOT NULL
  COMMENT '管理员的密码(加密后)',
  email      VARCHAR(50),
  permission INT DEFAULT 0       NOT NULL
  COMMENT '管理员权限'
)
  COMMENT '管理员表';
INSERT INTO admin (id, adminName, password, email, permission)
VALUES (403591502330204160, 'rxliuli', '123456', 'rxliuli@gmail.com', 1);

# 用户反馈表
DROP TABLE IF EXISTS feedback;
CREATE TABLE feedback (
  id           BIGINT PRIMARY KEY     NOT NULL
  COMMENT '用户反馈编号',
  userLoginId  BIGINT                 NOT NULL
  COMMENT '当前用户登录编号,外键关联 user_login 表的 id',
  content      TEXT                   NOT NULL
  COMMENT '反馈内容',
  feedbackTime DATETIME DEFAULT now() NOT NULL
  COMMENT '反馈时间(默认为当前时间)',
  haveSolve    BOOLEAN DEFAULT FALSE  NOT NULL
  COMMENT '是否已经处理过了',
  adminId      BIGINT
  COMMENT '进行处理的管理员编号(可以为空,因为管理员有可能没有进行处理),外键关联 admin 管理员表的 id',
  solveMethod  VARCHAR(200)
  COMMENT '处理方法(可以为空,因为管理员有可能没有进行处理)',
  solveTime    DATETIME DEFAULT now()
  COMMENT '处理的时间(可以为空,因为管理员有可能没有进行处理)'
  ,
  FOREIGN KEY (userLoginId) REFERENCES user_login (id),
  FOREIGN KEY (adminId) REFERENCES admin (id)
)
  COMMENT '用户反馈信息表';
INSERT INTO feedback (id, userLoginId, content, feedbackTime)
VALUES (
  403591502330204160,
  403591502330204160,
  '网站速度太慢啦',
  now()
);

# endregion
