/*
Navicat MySQL Data Transfer

Source Server         : rxliuli
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : interview

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-01-27 11:00:39
*/

SET FOREIGN_KEY_CHECKS = 0;

DROP DATABASE IF EXISTS interview;
CREATE DATABASE interview;
USE interview;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id`         BIGINT(20)   NOT NULL
  COMMENT '管理员编号',
  `adminName`  VARCHAR(20)  NOT NULL
  COMMENT '管理员名字',
  `password`   VARCHAR(128) NOT NULL
  COMMENT '管理员的密码(加密后)',
  `email`      VARCHAR(50)           ,
  `permission` INT(11)      NOT NULL
  COMMENT '管理员权限',
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT ='管理员表';

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('403591502330204160', 'rxliuli', '123456', 'rxliuli@gmail.com', '1');

-- ----------------------------
-- Table structure for exam
-- ----------------------------
DROP TABLE IF EXISTS `exam`;
CREATE TABLE `exam` (
  `id`        BIGINT(20)  NOT NULL
  COMMENT '考试信息表',
  `title`     VARCHAR(20) NOT NULL
  COMMENT '考试名字表',
  `startTime` DATE        NOT NULL
  COMMENT '考试开始时间',
  `endTime`   DATE        NOT NULL
  COMMENT '考试结束时间',
  `topicIds`  TEXT        NOT NULL
  COMMENT '考试题目编号列表',
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT ='考试信息表';

-- ----------------------------
-- Records of exam
-- ----------------------------
INSERT INTO `exam` VALUES ('403591502330204160', 'Java 基础面向对象', '2017-11-10 15:00:00', '2017-11-10 16:00:00', '');

-- ----------------------------
-- Table structure for exam_topic
-- ----------------------------
DROP TABLE IF EXISTS `exam_topic`;
CREATE TABLE `exam_topic` (
  `id`         BIGINT(20) NOT NULL
  COMMENT '考试题目详细信息的编号',
  `resultId`   BIGINT(20) NOT NULL
  COMMENT '考试成绩的编号,外键关联 result 成绩表的 id',
  `topicId`    BIGINT(20) NOT NULL
  COMMENT '面试题目的编号,外键关联 topic 面试题目表的 id',
  `topicScore` DOUBLE     NOT NULL
  COMMENT '当前题目的分数(默认值为 0)',
  `content`    TEXT COMMENT '当前题目的答案(可以为空,因为题目也有可能完全不会)',
  PRIMARY KEY (`id`),
  KEY `resultId` (`resultId`),
  KEY `topicId` (`topicId`),
  CONSTRAINT `exam_topic_ibfk_1` FOREIGN KEY (`resultId`) REFERENCES `result` (`id`),
  CONSTRAINT `exam_topic_ibfk_2` FOREIGN KEY (`topicId`) REFERENCES `topic` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT ='考试题目的信息表';

-- ----------------------------
-- Records of exam_topic
-- ----------------------------
INSERT INTO `exam_topic` VALUES ('403591502330204160', '403591502330204160', '396193667762753537', '0', NULL);

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback` (
  `id`           BIGINT(20) NOT NULL
  COMMENT '用户反馈编号',
  `userLoginId`  BIGINT(20) NOT NULL
  COMMENT '当前用户登录编号,外键关联 user_login 表的 id',
  `content`      TEXT       NOT NULL
  COMMENT '反馈内容',
  `feedbackTime` DATE       NOT NULL
  COMMENT '反馈时间(默认为当前时间)',
  `haveSolve`    TINYINT(1) NOT NULL
  COMMENT '是否已经处理过了',
  `adminId`      BIGINT(20)
  COMMENT '进行处理的管理员编号(可以为空,因为管理员有可能没有进行处理),外键关联 admin 管理员表的 id',
  `solveMethod`  VARCHAR(200)
  COMMENT '处理方法(可以为空,因为管理员有可能没有进行处理)',
  `solveTime`    DATE
  COMMENT '处理的时间(可以为空,因为管理员有可能没有进行处理)',
  PRIMARY KEY (`id`),
  KEY `userLoginId` (`userLoginId`),
  KEY `adminId` (`adminId`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`userLoginId`) REFERENCES `user_login` (`id`),
  CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`adminId`) REFERENCES `admin` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT ='用户反馈信息表';

-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback` VALUES
  ('403591502330204160', '403591502330204160', '网站速度太慢啦', '2018-01-18 19:22:55', '0', NULL, NULL,
   '2018-01-18 19:22:55');

-- ----------------------------
-- Table structure for result
-- ----------------------------
DROP TABLE IF EXISTS `result`;
CREATE TABLE `result` (
  `id`          BIGINT(20) NOT NULL
  COMMENT '考试编号',
  `userLoginId` BIGINT(20) NOT NULL
  COMMENT '用户编号,外键关联 user_login 表',
  `examId`      BIGINT(20) NOT NULL
  COMMENT '考试编号,外键关联 exam 表',
  `examScore`   DOUBLE     NOT NULL
  COMMENT '分数',
  `startTime`   DATE
  COMMENT '用户实际开始的时间,可以为空(没有进行考试)',
  `endTime`     DATE
  COMMENT '用户实际结束的时间,可以为空(没有进行考试)',
  PRIMARY KEY (`id`),
  KEY `examId` (`examId`),
  KEY `userLoginId` (`userLoginId`),
  CONSTRAINT `result_ibfk_1` FOREIGN KEY (`examId`) REFERENCES `exam` (`id`),
  CONSTRAINT `result_ibfk_2` FOREIGN KEY (`userLoginId`) REFERENCES `user_login` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT ='考试信息表';

-- ----------------------------
-- Records of result
-- ----------------------------
INSERT INTO `result` VALUES
  ('403591502330204160', '396193657629315072', '403591502330204160', '80', '2017-11-10 15:00:00',
   '2017-11-10 16:00:00');

-- ----------------------------
-- Table structure for topic
-- ----------------------------
DROP TABLE IF EXISTS `topic`;
CREATE TABLE `topic` (
  `id`         BIGINT(20)   NOT NULL
  COMMENT '面试题目编号',
  `typeId`     BIGINT(20)   NOT NULL
  COMMENT '面试题目类型,关联面试题目类型表的 id',
  `title`      VARCHAR(200) NOT NULL
  COMMENT '面试题目的标题',
  `answer`     TEXT         NOT NULL
  COMMENT '面试题目的答案',
  `updateTime` DATE         NOT NULL
  COMMENT '最后更新时间(默认为当前时间)',
  PRIMARY KEY (`id`),
  KEY `typeId` (`typeId`),
  CONSTRAINT `topic_ibfk_1` FOREIGN KEY (`typeId`) REFERENCES `topic_type` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT ='面试题目表';

-- ----------------------------
-- Records of topic
-- ----------------------------
INSERT INTO `topic` VALUES ('396193667762753537', '393048438415167488', '什么是Java虚拟机？为什么Java被称作是“平台无关的编程语言”？',
                            'Java虚拟机是一个可以执行Java字节码的虚拟机进程。Java源文件被编译成能被Java虚拟机执行的字节码文件。\r\n\r\nJava被设计成允许应用程序可以运行在任意的平台，而不需要程序员为每一个平台单独重写或者是重新编译。Java虚拟机让这个变为可能，因为它知道底层硬件平台的指令长度和其他特性。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193667762753538', '393048438415167488', 'JDK和JRE的区别是什么？',
                            'Java运行时环境(JRE)是将要执行Java程序的Java虚拟机。它同时也包含了执行applet需要的浏览器插件。Java开发工具包(JDK)是完整的Java软件开发包，包含了JRE，编译器和其他的工具(比如：JavaDoc，Java调试器)，可以让开发者开发.编译.执行Java应用程序。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193667829862400', '393048438415167488', '”static”关键字是什么意思？Java中是否可以覆盖(override)一个private或者是static的方法？',
   '“static”关键字表明一个成员变量或者是成员方法可以在没有所属的类的实例变量的情况下被访问。\r\nJava中static方法不能被覆盖，因为方法覆盖是基于运行时动态绑定的，而static方法是编译时静态绑定的。static方法跟类的任何实例都不相关，所以概念上不适用。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193667829862401', '393048438415167488', '是否可以在static环境中访问非static变量？',
                            'static变量在Java中是属于类的，它在所有的实例中的值是一样的。当类被Java虚拟机载入的时候，会对static变量进行初始化。如果你的代码尝试不用实例来访问非static的变量，编译器会报错，因为这些变量还没有被创建出来，还没有跟任何实例关联上。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193667829862402', '393048438415167488', 'Java支持的数据类型有哪些？什么是自动拆装箱？',
                            'Java语言支持的8中基本数据类型是：\r\n\r\nbyte\r\nshort\r\nint\r\nlong\r\nfloat\r\ndouble\r\nboolean\r\nchar\r\n自动装箱是Java编译器在基本数据类型和对应的对象包装类型之间做的一个转化。比如：把int转化成Integer，double转化成double，等等。反之就是自动拆箱。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193667896971264', '393048438415167488', 'Java中的方法覆盖(Overriding)和方法重载(Overloading)是什么意思？',
   'Java中的方法重载发生在同一个类里面两个或者是多个方法的方法名相同但是参数不同的情况。与此相对，方法覆盖是说子类重新定义了父类的方法。方法覆盖必须有相同的方法名，参数列表和返回类型。覆盖者可能不会限制它所覆盖的方法的访问。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193667896971265', '393048438415167488', 'Java中，什么是构造函数？什么是构造函数重载？什么是复制构造函数？',
                            '当新对象被创建的时候，构造函数会被调用。每一个类都有构造函数。在程序员没有给类提供构造函数的情况下，Java编译器会为这个类创建一个默认的构造函数。\r\n\r\nJava中构造函数重载和方法重载很相似。可以为一个类创建多个构造函数。每一个构造函数必须有它自己唯一的参数列表。\r\n\r\nJava不支持像C++中那样的复制构造函数，这个不同点是因为如果你不自己写构造函数的情况下，Java不会创建默认的复制构造函数。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193667896971266', '393048438415167488', 'Java支持多继承么？', '不支持，Java不支持多继承。每个类都只能继承一个类，但是可以实现多个接口。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193667896971267', '393048438415167488', '接口和抽象类的区别是什么？',
                            'Java提供和支持创建抽象类和接口。它们的实现有共同点，不同点在于：\r\n\r\n接口中所有的方法隐含的都是抽象的。而抽象类则可以同时包含抽象和非抽象的方法。\r\n类可以实现很多个接口，但是只能继承一个抽象类\r\n类如果要实现一个接口，它必须要实现接口声明的所有方法。但是，类可以不实现抽象类声明的所有方法，当然，在这种情况下，类也必须得声明成是抽象的。\r\n抽象类可以在不提供接口方法实现的情况下实现接口。\r\nJava接口中声明的变量默认都是final的。抽象类可以包含非final的变量。\r\nJava接口中的成员函数默认是public的。抽象类的成员函数可以是private，protected或者是public。\r\n接口是绝对抽象的，不可以被实例化。抽象类也不可以被实例化，但是，如果它包含main方法的话是可以被调用的。\r\n也可以参考JDK8中抽象类和接口的区别',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193667959885825', '393048438415167488', '进程和线程的区别是什么？', '进程是执行着的应用程序，而线程是进程内部的一个执行序列。一个进程可以有多个线程。线程又叫做轻量级进程。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193667959885826', '393048438415167488', '创建线程有几种不同的方式？你喜欢哪一种？为什么？',
                            '有三种方式可以用来创建线程：\r\n\r\n继承Thread类\r\n实现Runnable接口\r\n应用程序可以使用Executor框架来创建线程池\r\n实现Runnable接口这种方式更受欢迎，因为这不需要继承Thread类。在应用设计中已经继承了别的对象的情况下，这需要多继承（而Java不支持多继承），只能实现接口。同时，线程池也是非常高效的，很容易实现和使用。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193667959885827', '393048438415167488', '概括的解释下线程的几种可用状态。',
                            '线程在执行过程中，可以处于下面几种状态：\r\n\r\n就绪(Runnable):线程准备运行，不一定立马就能开始执行。\r\n运行中(Running)：进程正在执行线程的代码。\r\n等待中(Waiting):线程处于阻塞的状态，等待外部的处理结束。\r\n睡眠中(Sleeping)：线程被强制睡眠。\r\nI/O阻塞(Blocked on I/O)：等待I/O操作完成。\r\n同步阻塞(Blocked on Synchronization)：等待获取锁。\r\n死亡(Dead)：线程完成了执行。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668026994688', '393048438415167488', '同步方法和同步代码块的区别是什么？',
                            '在Java语言中，每一个对象有一把锁。线程可以使用synchronized关键字来获取对象上的锁。synchronized关键字可应用在方法级别(粗粒度锁)或者是代码块级别(细粒度锁)。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668026994689', '393048438415167488', '在监视器(Monitor)内部，是如何做线程同步的？程序应该做哪种级别的同步？',
                            '监视器和锁在Java虚拟机中是一块使用的。监视器监视一块同步代码块，确保一次只有一个线程执行同步代码块。每一个监视器都和一个对象引用相关联。线程在获取锁之前不允许执行同步代码。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668026994690', '393048438415167488', '什么是死锁(deadlock)？',
                            '两个进程都在等待对方执行完毕才能继续往下执行的时候就发生了死锁。结果就是两个进程都陷入了无限的等待中。', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668026994691', '393048438415167488', '如何确保N个线程可以访问N个资源同时又不导致死锁？',
                            '使用多线程的时候，一种非常简单的避免死锁的方式就是：指定获取锁的顺序，并强制线程按照指定的顺序获取锁。因此，如果所有的线程都是以同样的顺序加锁和释放锁，就不会出现死锁了。\r\n\r\nJava集合类',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668089909248', '393048438415167488', 'Java集合类框架的基本接口有哪些？',
                            'Java集合类提供了一套设计良好的支持对一组对象进行操作的接口和类。Java集合类里面最基本的接口有：\r\n\r\nCollection：代表一组对象，每一个对象都是它的子元素。\r\nSet：不包含重复元素的Collection。\r\nList：有顺序的collection，并且可以包含重复元素。\r\nMap：可以把键(key)映射到值(value)的对象，键不能重复。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668089909249', '393048438415167488', '为什么集合类没有实现Cloneable和Serializable接口？',
                            '集合类接口指定了一组叫做元素的对象。集合类接口的每一种具体的实现类都可以选择以它自己的方式对元素进行保存和排序。有的集合类允许重复的键，有些不允许。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668089909250', '393048438415167488', '什么是迭代器(Iterator)？',
                            'Iterator接口提供了很多对集合元素进行迭代的方法。每一个集合类都包含了可以返回迭代器实例的\r\n迭代方法。迭代器可以在迭代的过程中删除底层集合的元素。\r\n\r\n克隆(cloning)或者是序列化(serialization)的语义和含义是跟具体的实现相关的。因此，应该由集合类的具体实现来决定如何被克隆或者是序列化。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668089909251', '393048438415167488', 'Iterator和ListIterator的区别是什么？',
                            '下面列出了他们的区别：\r\n\r\nIterator可用来遍历Set和List集合，但是ListIterator只能用来遍历List。\r\nIterator对集合只能是前向遍历，ListIterator既可以前向也可以后向。\r\nListIterator实现了Iterator接口，并包含其他的功能，比如：增加元素，替换元素，获取前一个和后一个元素的索引，等等。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668157018112', '393048438415167488', '快速失败(fail-fast)和安全失败(fail-safe)的区别是什么？',
                            'Iterator的安全失败是基于对底层集合做拷贝，因此，它不受源集合上修改的影响。java.util包下面的所有的集合类都是快速失败的，而java.util.concurrent包下面的所有的类都是安全失败的。快速失败的迭代器会抛出ConcurrentModificationException异常，而安全失败的迭代器永远不会抛出这样的异常。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668157018113', '393048438415167488', 'Java中的HashMap的工作原理是什么？',
                            'Java中的HashMap是以键值对(key-value)的形式存储元素的。HashMap需要一个hash函数，它使用hashCode()和equals()方法来向集合/从集合添加和检索元素。当调用put()方法的时候，HashMap会计算key的hash值，然后把键值对存储在集合中合适的索引上。如果key已经存在了，value会被更新成新值。HashMap的一些重要的特性是它的容量(capacity)，负载因子(load factor)和扩容极限(threshold resizing)。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668157018114', '393048438415167488', 'hashCode()和equals()方法的重要性体现在什么地方？',
                            'Java中的HashMap使用hashCode()和equals()方法来确定键值对的索引，当根据键获取值的时候也会用到这两个方法。如果没有正确的实现这两个方法，两个不同的键可能会有相同的hash值，因此，可能会被集合认为是相等的。而且，这两个方法也用来发现重复元素。所以这两个方法的实现对HashMap的精确性和正确性是至关重要的。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668157018115', '393048438415167488', 'HashMap和Hashtable有什么区别？',
                            'HashMap和Hashtable都实现了Map接口，因此很多特性非常相似。但是，他们有以下不同点：\r\nHashMap允许键和值是null，而Hashtable不允许键或者值是null。\r\nHashtable是同步的，而HashMap不是。因此，HashMap更适合于单线程环境，而Hashtable适合于多线程环境。\r\nHashMap提供了可供应用迭代的键的集合，因此，HashMap是快速失败的。另一方面，Hashtable提供了对键的列举(Enumeration)。\r\n一般认为Hashtable是一个遗留的类。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193668224126976', '393048438415167488', '数组(Array)和列表(ArrayList)有什么区别？什么时候应该使用Array而不是ArrayList？',
   '下面列出了Array和ArrayList的不同点：\r\n\r\nArray可以包含基本类型和对象类型，ArrayList只能包含对象类型。\r\nArray大小是固定的，ArrayList的大小是动态变化的。\r\nArrayList提供了更多的方法和特性，比如：addAll()，removeAll()，iterator()等等。\r\n对于基本类型数据，集合使用自动装箱来减少编码工作量。但是，当处理固定大小的基本数据类型的时候，这种方式相对比较慢。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668224126977', '393048438415167488', 'ArrayList和LinkedList有什么区别？',
                            'ArrayList和LinkedList都实现了List接口，他们有以下的不同点：\r\n\r\nArrayList是基于索引的数据接口，它的底层是数组。它可以以O(1)时间复杂度对元素进行随机访问。与此对应，LinkedList是以元素列表的形式存储它的数据，每一个元素都和它的前一个和后一个元素链接在一起，在这种情况下，查找某个元素的时间复杂度是O(n)。\r\n\r\n相对于ArrayList，LinkedList的插入，添加，删除操作速度更快，因为当元素被添加到集合任意位置的时候，不需要像数组那样重新计算大小或者是更新索引。\r\n\r\nLinkedList比ArrayList更占内存，因为LinkedList为每一个节点存储了两个引用，一个指向前一个元素，一个指向下一个元素。\r\n\r\n也可以参考ArrayList vs. LinkedList。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668224126978', '393048438415167488', 'Comparable和Comparator接口是干什么的？列出它们的区别。',
                            'Java提供了只包含一个compareTo()方法的Comparable接口。这个方法可以个给两个对象排序。具体来说，它返回负数，0，正数来表明输入对象小于，等于，大于已经存在的对象。\r\n\r\nJava提供了包含compare()和equals()两个方法的Comparator接口。compare()方法用来给两个输入参数排序，返回负数，0，正数表明第一个参数是小于，等于，大于第二个参数。equals()方法需要一个对象作为参数，它用来决定输入参数是否和comparator相等。只有当输入参数也是一个comparator并且输入参数和当前comparator的排序结果是相同的时候，这个方法才返回true。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668287041536', '393048438415167488', '什么是Java优先级队列(Priority Queue)？',
                            'PriorityQueue是一个基于优先级堆的无界队列，它的元素是按照自然顺序(natural order)排序的。在创建的时候，我们可以给它提供一个负责给元素排序的比较器。PriorityQueue不允许null值，因为他们没有自然顺序，或者说他们没有任何的相关联的比较器。最后，PriorityQueue不是线程安全的，入队和出队的时间复杂度是O(log(n))。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668287041537', '393048438415167488', '你了解大O符号(big-O notation)么？你能给出不同数据结构的例子么？',
                            '大O符号描述了当数据结构里面的元素增加的时候，算法的规模或者是性能在最坏的场景下有多么好。\r\n大O符号也可用来描述其他的行为，比如：内存消耗。因为集合类实际上是数据结构，我们一般使用大O符号基于时间，内存和性能来选择最好的实现。大O符号可以对大量数据的性能给出一个很好的说明。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668287041538', '393048438415167488', '如何权衡是使用无序的数组还是有序的数组？',
                            '有序数组最大的好处在于查找的时间复杂度是O(log n)，而无序数组是O(n)。有序数组的缺点是插入操作的时间复杂度是O(n)，因为值大的元素需要往后移动来给新元素腾位置。相反，无序数组的插入时间复杂度是常量O(1)。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668354150400', '393048438415167488', 'Java集合类框架的最佳实践有哪些？',
                            '根据应用的需要正确选择要使用的集合的类型对性能非常重要，比如：假如元素的大小是固定的，而且能事先知道，我们就应该用Array而不是ArrayList。\r\n有些集合类允许指定初始容量。因此，如果我们能估计出存储的元素的数目，我们可以设置初始容量来避免重新计算hash值或者是扩容。\r\n为了类型安全，可读性和健壮性的原因总是要使用泛型。同时，使用泛型还可以避免运行时的ClassCastException。\r\n使用JDK提供的不变类(immutable class)作为Map的键可以避免为我们自己的类实现hashCode()和equals()方法。\r\n编程的时候接口优于实现。\r\n底层的集合实际上是空的情况下，返回长度是0的集合或者是数组，不要返回null。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668354150401', '393048438415167488', 'Enumeration接口和Iterator接口的区别有哪些？',
                            'Enumeration速度是Iterator的2倍，同时占用更少的内存。但是，Iterator远远比Enumeration安全，因为其他线程不能够修改正在被iterator遍历的集合里面的对象。同时，Iterator允许调用者删除底层集合里面的元素，这对Enumeration来说是不可能的。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668354150402', '393048438415167488', 'HashSet和TreeSet有什么区别？',
                            'HashSet是由一个hash表来实现的，因此，它的元素是无序的。add()，remove()，contains()方法的时间复杂度是O(1)。\r\n\r\n另一方面，TreeSet是由一个树形的结构来实现的，它里面的元素是有序的。因此，add()，remove()，contains()方法的时间复杂度是O(logn)。\r\n\r\n垃圾收集器(Garbage Collectors)',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193668421259264', '393048438415167488', 'Java中垃圾回收有什么目的？什么时候进行垃圾回收？', '垃圾回收的目的是识别并且丢弃应用不再使用的对象来释放和重用资源。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668421259265', '393048438415167488', 'System.gc()和Runtime.gc()会做什么事情？',
                            '这两个方法用来提示JVM要进行垃圾回收。但是，立即开始还是延迟进行垃圾回收是取决于JVM的。', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668421259266', '393048438415167488', 'finalize()方法什么时候被调用？析构函数(finalization)的目的是什么？',
                            '在释放对象占用的内存之前，垃圾收集器会调用对象的finalize()方法。一般建议在该方法中释放对象持有的资源。', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193668421259267', '393048438415167488', '如果对象的引用被置为null，垃圾收集器是否会立即释放对象占用的内存？', '不会，在下一个垃圾回收周期中，这个对象将是可被回收的。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668421259268', '393048438415167488', 'Java堆的结构是什么样子的？什么是堆中的永久代(Perm Gen space)?',
                            'JVM的堆是运行时数据区，所有类的实例和数组都是在堆上分配内存。它在JVM启动的时候被创建。对象所占的堆内存是由自动内存管理系统也就是垃圾收集器回收。\r\n\r\n堆内存是由存活和死亡的对象组成的。存活的对象是应用可以访问的，不会被垃圾回收。死亡的对象是应用不可访问尚且还没有被垃圾收集器回收掉的对象。一直到垃圾收集器把这些对象回收掉之前，他们会一直占据堆内存空间。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668484173824', '393048438415167488', '串行(serial)收集器和吞吐量(throughput)收集器的区别是什么？',
                            '吞吐量收集器使用并行版本的新生代垃圾收集器，它用于中等规模和大规模数据的应用程序。而串行收集器对大多数的小应用(在现代处理器上需要大概100M左右的内存)就足够了。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193668484173825', '393048438415167488', '在Java中，对象什么时候可以被垃圾回收？', '当对象对当前使用这个对象的应用程序变得不可触及的时候，这个对象就可以被回收了。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668484173826', '393048438415167488', 'JVM的永久代中会发生垃圾回收么？',
                            '垃圾回收不会发生在永久代，如果永久代满了或者是超过了临界值，会触发完全垃圾回收(Full GC)。如果你仔细查看垃圾收集器的输出信息，就会发现永久代也是被回收的。这就是为什么正确的永久代大小对避免Full GC是非常重要的原因。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668551282688', '393048438415167488', 'jvm对频繁调用的方法做了哪些优化？',
                            'java虚拟机最开始是通过解释器进行解释执行的，当虚拟机发现某个方法或者代码块的运行特别频繁时，就会把这些代码认定为”热点代码”，为了提高热点代码的执行效率，在运行时，虚拟机会把这些代码编译成与本地平台相关的机器码，并进行各种层次的优化，完成这个任务的编译器称为即时编译器(JIT)。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193668551282689', '393048438415167488', '常见的攻击手段有哪些？如何防范？', 'XSS.CSRF.SQL注入.DOS/DDOS等具体细节见历史文章。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193668551282690', '393048438415167488', 'restful api有哪些设计原则？', '需要考虑的设计原则有：域名.版本.路径.动词.状态码.返回结果等等之后具体会形成文章。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668551282691', '393048438415167488', 'hessian是做什么用的？它的传输单位是什么？',
                            'Hessian是一个轻量级的remoting onhttp工具，使用简单的方法提供了RMI的功能。 相比WebService，Hessian更简单.快捷。采用的是二进制RPC协议，因为采用的是二进制协议，所以它很适合于发送二进制数据。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193668551282692', '393048438415167488', 'http中的post.get有什么区别？base64过后的字符串可以通过get传输吗？', '区别：',
   '2017-12-29 06:52:11');
INSERT INTO `topic`
VALUES ('396193668614197248', '393048438415167488', '两种动作不一样，get是获取资源，post是提交资源', '', '2017-12-29 06:52:11');
INSERT INTO `topic`
VALUES ('396193668614197249', '393048438415167488', 'get参数在URL中不安全，post是放在http body中的相对安全', '', '2017-12-29 06:52:11');
INSERT INTO `topic`
VALUES ('396193668614197250', '393048438415167488', 'get传输字节数受限于URL长度，post无限制', '', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668614197251', '393048438415167488',
                            '后台获取数据的方式get只能是QueryString,post可从InputStream中获取 base64编码后有+=特殊符号的会转码不能经get传输，如果是改进的base64会替换掉特殊符号可以用get传输。',
                            '', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193668681306112', '393048438415167488', '常用的算法都有哪些分类，分别有哪些算法及应用场景？', '一般有散列算法.对称算法.非对称算法，具体细节见历史文章。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193668681306113', '393048438415167488', '死锁是什么？写一个死锁的例子？如何避免死锁？', '死锁就是多线程相互等待对方释放锁造成的假死状态，具体见历史文章。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668681306114', '393048438415167488', '学用的序列化方案都有哪些，说说它们的优缺点？',
                            '序列化有对象序列化，JSON序列化，XML序列化等，像java自带序列化.kryo.protostuff.GSON.jackson.fastjson等之后形成文章。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668681306115', '393048438415167488', '什么是过滤器.拦截器.监听器，它们的顺序是怎样的？',
                            '监听器是容器启动和销毁时触发的动作，过滤器是进入servlet请求之前触发的工作，拦截器是像springmvc框架实现的内部的请求拦截器。\r\n顺序：监听器>过滤器>拦截器',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668681306116', '393048438415167488', 'servle', 't', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193668748414976', '393048438415167488', '0有哪些新规范？', '增加注解不需要web.xml配置.异步处理.可插性支持，性能增强等。', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193668748414977', '393048438415167488', 'zookeeper是什么框架？', 'zookeeper是一个开源的分布式协调服务框架。', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193668748414978', '393048438415167488', '有哪些应用场景？', '应用场景：分布式通知/协调.负载均衡.配置中心.分布式锁.分布式队列等。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668748414979', '393048438415167488', '使用什么协议？', '使用ZAB协议。', '2017-12-29 06:52:11');
INSERT INTO `topic`
VALUES ('396193668748414980', '393048438415167488', '说一说选举算法及流程', '选举算法及流程看最后文章推荐的书。', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193668811329536', '393048438415167488', 'zookeeper有哪几种节点类型？', '节点类型：持久节点.持久顺序节点.临时节点.临时顺序节点。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193668811329537', '393048438415167488', 'zookeeper对节点的watch监听通知是永久的吗？', '不是永久的，一次性的，需要借助第三方工具实现重复注册。',
   '2017-12-29 06:52:11');
INSERT INTO `topic`
VALUES ('396193668811329538', '393048438415167488', '有哪几种部署模式？', '部署模式：单机模式.伪集群模式.集群模式。', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193668811329539', '393048438415167488', '集群中的机器角色都有哪些？', '集群角色：leader.foller.observer。', '2017-12-29 06:52:11');
INSERT INTO `topic`
VALUES ('396193668811329540', '393048438415167488', '集群最少要几台机器，集群规则是怎样的', '集群规则为2N+1台，N>0，即3台。', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193668878438400', '393048438415167488', '集群如果有3台机器，挂掉一台集群还能工作吗？挂掉两台呢？', '集群需要一半以上的机器可用，所以，3台挂掉1台还能工作，2台不能。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668878438401', '393048438415167488', '集群支持动态添加机器吗？', '', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668878438402', '393048438415167488', '5版本开始支持动态扩容。', '', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193668878438403', '393048438415167488', 'zookeeper的java客户端都有哪些？', 'java客户端：zk自带的zkclient及Apache开源的Curator。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668878438404', '393048438415167488', 'chubby是什么，和zookeeper比你怎么看？',
                            'chubby是google的，完全实现paxos算法，不开源。zookeeper是chubby的开源实现，使用zab协议，paxos算法的变种。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193668945547264', '393048438415167488', '说几个zookeeper常用的命令。', '常用命令：ls get set create delete等。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193668945547265', '393048438415167488', '你知道的List都有哪些？', 'ArrayList.LinkedList.Vector等。', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193668945547266', '393048438415167488', 'List和Vector有什么区别？', 'Vector是List接口下线程安全的集合。', '2017-12-29 06:52:11');
INSERT INTO `topic`
VALUES ('396193668945547267', '393048438415167488', 'List是有序的吗？', 'List是有序的。', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193668945547268', '393048438415167488', 'ArrayList和LinkedList的区别？分别用在什么场景？',
                            'ArrayList和LinkedList数据结构不一样，前者用在查询较多的场合，后者适用于插入较多的场合。', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193669008461824', '393048438415167488', 'ArrayList和LinkedList的底层数据结构是什么？',
                            'ArrayList使用的是数组结构，LinkedList使用的是链表结构。', '2017-12-29 06:52:11');
INSERT INTO `topic`
VALUES ('396193669008461825', '393048438415167488', 'ArrayList默认大小是多少，是如何扩容的？', 'Jdk', '2017-12-29 06:52:11');
INSERT INTO `topic`
VALUES ('396193669008461826', '393048438415167488', '7之前ArrayList默认大小是10，JD', 'K', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193669008461827', '393048438415167488', '7之后是0，JDK差异，每次约', '按', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193669008461828', '393048438415167488', '5倍扩容。', '', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193669075570688', '393048438415167488', 'List是线程安全的吗？如果要线程安全要怎么做？',
                            'List中的Vector才是线程安全的，其他要实现线程安全使用工具类Collections.synchronizedList(new ArrayList())方法。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193669075570689', '393048438415167488', '怎么给List排序？', '使用List自身的sort方法，或者使用Collections.sort(list)方法;',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193669075570690', '393048438415167488', 'Arrays.asList方法后的List可以扩容吗？',
                            'Arrays.asList使用的是final数组，并且不支持add方法，不支持扩容。', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193669075570691', '393048438415167488', 'List和Array之间如何互相转换？',
                            'List>Array使用toArray方法，Array>List使用Arrays.asList(array)方法，由于它是固定的，不固定的可以使用new ArrayList(Arrays.asList(array))。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193669075570692', '393048438415167488', '你都知道哪些常用的Map集合?', 'HashMap.HashTable.LinkedHashMap.ConcurrentHashMap。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193669138485248', '393048438415167488', 'Collection集合接口和Map接口有什么关系？', '没关系，Collection是List.Set父接口不是Map父接口。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193669138485249', '393048438415167488', 'HashMap是线程安全的吗？线程安全的Map都有哪些？性能最好的是哪个？',
                            'HashMap不是线程安全的。线程安全的有HashTable.ConcurrentHashMap.SynchronizedMap，性能最好的是ConcurrentHashMap。',
                            '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193669138485250', '393048438415167488', '使用HashMap有什么性能问题吗？', '使用HashMap要注意避免集合的扩容，它会很耗性能，根据元素的数量给它一个初始大小的值。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193669138485251', '393048438415167488', 'HashMap的数据结构是怎样的？默认大小是多少？内部是怎么扩容的？',
                            'HashMap是数组和链表组成的，默认大小为16，当hashmap中的元素个数超过数组大小*loadFactor（默认值为', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193669205594112', '393048438415167488', '75）时就会把数组的大小扩展为原来的两倍大小，然后重新计算每个元素在数组中的位置。', '', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193669205594113', '393048438415167488', '怎么按添加顺序存储元素？怎么按A-Z自然顺序存储元素？怎么自定义排序？',
                            '按添加顺序使用LinkedHashMap,按自然顺序使用TreeMap,自定义排序TreeMap(Comparetor c)。', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193669205594114', '393048438415167488', 'HashMap的链表结构设计是用来解决什么问题的？', 'HashMap的链表结构设计是用来解决key的hash冲突问题的。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES
  ('396193669205594115', '393048438415167488', 'HashMap的键.值可以为NULL吗？HashTable呢？', 'HashMap的键值都可以为NULL，HashTable不行。',
   '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193669205594116', '393048438415167488', 'HashMap使用对象作为key，如果hashcode相同会怎么处理？',
                            'key的hash冲突，如果key equals一致将会覆盖值，不一致就会将值存储在key对应的链表中。', '2017-12-29 06:52:11');
INSERT INTO `topic` VALUES ('396193669272702976', '393048438415167488', 'HashMap中的get操作是什么原理？',
                            '先根据key的hashcode值找到对应的链表，再循环链表，根据key的hash是否相同且key的==或者equals比较操作找到对应的值。',
                            '2017-12-29 06:52:11');

-- ----------------------------
-- Table structure for topic_comment
-- ----------------------------
DROP TABLE IF EXISTS `topic_comment`;
CREATE TABLE `topic_comment` (
  `id`          BIGINT(20)   NOT NULL
  COMMENT '面试题目评论编号',
  `userLoginId` BIGINT(20)   NOT NULL
  COMMENT '评论用户的编号,外键关联用户登录表',
  `topicId`     BIGINT(20)   NOT NULL
  COMMENT '评论题目的编号,外键关联面试题目信息表',
  `content`     VARCHAR(200) NOT NULL
  COMMENT '用户评论的内容',
  `commentTime` DATE         NOT NULL
  COMMENT '用户评论时间',
  PRIMARY KEY (`id`),
  KEY `topicId` (`topicId`),
  KEY `userLoginId` (`userLoginId`),
  CONSTRAINT `topic_comment_ibfk_1` FOREIGN KEY (`topicId`) REFERENCES `topic` (`id`),
  CONSTRAINT `topic_comment_ibfk_2` FOREIGN KEY (`userLoginId`) REFERENCES `user_login` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT ='面试题目评论表';

-- ----------------------------
-- Records of topic_comment
-- ----------------------------
INSERT INTO `topic_comment`
VALUES ('395546493592932352', '396193654793965569', '396193667762753537', 'asdff', '2017-12-27 12:00:46');
INSERT INTO `topic_comment`
VALUES ('395547792094924800', '396193654856880128', '396193667762753538', '123', '2017-12-27 12:07:24');
INSERT INTO `topic_comment`
VALUES ('395618650196938752', '396193654856880129', '396193667829862400', 'asfasdfas', '2017-12-27 16:49:24');
INSERT INTO `topic_comment`
VALUES ('395852421529735168', '396193654856880130', '396193667829862401', '啊发生的', '2017-12-28 08:16:12');
INSERT INTO `topic_comment`
VALUES ('395852818961010688', '396193654923988992', '396193667829862402', 'afsd', '2017-12-28 08:17:47');
INSERT INTO `topic_comment`
VALUES ('395993699919728640', '396193654923988993', '396193667896971264', 'sdfawaf', '2017-12-28 17:37:35');
INSERT INTO `topic_comment`
VALUES ('396102299057000448', '396193654986903552', '396193667896971265', 'asdfafw', '2017-12-29 00:49:07');
INSERT INTO `topic_comment`
VALUES ('396218582951923712', '396193654986903553', '396193667896971266', 'asfd', '2017-12-29 08:31:12');
INSERT INTO `topic_comment`
VALUES ('396230884916858880', '396193655054012416', '396193667896971267', '', '2017-12-29 09:20:05');

-- ----------------------------
-- Table structure for topic_type
-- ----------------------------
DROP TABLE IF EXISTS `topic_type`;
CREATE TABLE `topic_type` (
  `id`          BIGINT(20)  NOT NULL
  COMMENT '面试题目的类型编号',
  `title`       VARCHAR(20) NOT NULL
  COMMENT '面试题目的类型标题',
  `description` VARCHAR(200)
  COMMENT '面试题目类型的说明',
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT ='面试题目类型表';

-- ----------------------------
-- Records of topic_type
-- ----------------------------
INSERT INTO `topic_type` VALUES ('393048438415167488', 'java', '如果你觉得自己的 Java 基本功还不够的话就来这里看看吧!');
INSERT INTO `topic_type` VALUES ('393048438415167489', 'SqlServer', '');
INSERT INTO `topic_type` VALUES ('394870555507036160', 'C#', '');
INSERT INTO `topic_type` VALUES ('394870555507036188', 'MySQL', '');
INSERT INTO `topic_type` VALUES ('394870555507036988', 'HTML', '');
INSERT INTO `topic_type` VALUES ('394870555507036999', 'MyBatis', '');

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `id`       BIGINT(20)  NOT NULL
  COMMENT '用户登录编号',
  `nickname` VARCHAR(20) NOT NULL
  COMMENT '用户昵称',
  `realname` VARCHAR(20)
  COMMENT '用户真实姓名(可以为空)',
  `picture`  VARCHAR(20) NOT NULL
  COMMENT '用户头像(不能为空但在程序中会赋予默认值)',
  `birthday` DATE
  COMMENT '用户生日(可以为空)',
  `gender`   INT(11)
  COMMENT '用户性别(可以为空)',
  `address`  VARCHAR(200)
  COMMENT '用户地址(可以为空)',
  PRIMARY KEY (`id`),
  CONSTRAINT `user_info_ibfk_1` FOREIGN KEY (`id`) REFERENCES `user_login` (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT ='用户详细信息表';

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('403591502330204160', '琉璃', '琉璃', '', '1998-05-26', NULL, NULL);

-- ----------------------------
-- Table structure for user_login
-- ----------------------------
DROP TABLE IF EXISTS `user_login`;
CREATE TABLE `user_login` (
  `id`       BIGINT(20)   NOT NULL
  COMMENT '用户登录编号',
  `username` VARCHAR(20)  NOT NULL
  COMMENT '用户登录名',
  `password` VARCHAR(128) NOT NULL
  COMMENT '用户密码(加密后)',
  `email`    VARCHAR(50)  NOT NULL
  COMMENT '用户邮箱(验证过的)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_login_username_uindex` (`username`),
  UNIQUE KEY `user_login_email_uindex` (`email`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT ='用户登录表';

-- ----------------------------
-- Records of user_login
-- ----------------------------
INSERT INTO `user_login` VALUES ('396193654793965569', '王芳',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王芳@gmail.com');
INSERT INTO `user_login` VALUES ('396193654856880128', '李伟',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李伟@gmail.com');
INSERT INTO `user_login` VALUES ('396193654856880129', '李娜',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李娜@gmail.com');
INSERT INTO `user_login` VALUES ('396193654856880130', '张敏',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张敏@gmail.com');
INSERT INTO `user_login` VALUES ('396193654923988992', '李静',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李静@gmail.com');
INSERT INTO `user_login` VALUES ('396193654923988993', '王静',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王静@gmail.com');
INSERT INTO `user_login` VALUES ('396193654986903552', '刘伟',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘伟@gmail.com');
INSERT INTO `user_login` VALUES ('396193654986903553', '王秀英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王秀英@gmail.com');
INSERT INTO `user_login` VALUES ('396193655054012416', '张丽',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张丽@gmail.com');
INSERT INTO `user_login` VALUES ('396193655054012417', '李秀英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李秀英@gmail.com');
INSERT INTO `user_login` VALUES ('396193655054012418', '王丽',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王丽@gmail.com');
INSERT INTO `user_login` VALUES ('396193655121121280', '张静',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张静@gmail.com');
INSERT INTO `user_login` VALUES ('396193655121121281', '张秀英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张秀英@gmail.com');
INSERT INTO `user_login` VALUES ('396193655184035840', 'zyt',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李强@gmail.com');
INSERT INTO `user_login` VALUES ('396193655184035841', '王敏',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王敏@gmail.com');
INSERT INTO `user_login` VALUES ('396193655184035842', '李敏',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李敏@gmail.com');
INSERT INTO `user_login` VALUES ('396193655251144704', '王磊',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王磊@gmail.com');
INSERT INTO `user_login` VALUES ('396193655251144705', '刘洋',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘洋@gmail.com');
INSERT INTO `user_login` VALUES ('396193655318253568', '王艳',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王艳@gmail.com');
INSERT INTO `user_login` VALUES ('396193655318253569', '王勇',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王勇@gmail.com');
INSERT INTO `user_login` VALUES ('396193655381168128', '李军',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李军@gmail.com');
INSERT INTO `user_login` VALUES ('396193655381168129', '张勇',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张勇@gmail.com');
INSERT INTO `user_login` VALUES ('396193655381168130', '李杰',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李杰@gmail.com');
INSERT INTO `user_login` VALUES ('396193655448276992', '张杰',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张杰@gmail.com');
INSERT INTO `user_login` VALUES ('396193655448276993', '张磊',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张磊@gmail.com');
INSERT INTO `user_login` VALUES ('396193655511191552', '王强',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王强@gmail.com');
INSERT INTO `user_login` VALUES ('396193655511191553', '李娟',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李娟@gmail.com');
INSERT INTO `user_login` VALUES ('396193655578300416', '王军',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王军@gmail.com');
INSERT INTO `user_login` VALUES ('396193655578300417', '张艳',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张艳@gmail.com');
INSERT INTO `user_login` VALUES ('396193655578300418', '张涛',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张涛@gmail.com');
INSERT INTO `user_login` VALUES ('396193655645409280', '王涛',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王涛@gmail.com');
INSERT INTO `user_login` VALUES ('396193655645409281', '李艳',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李艳@gmail.com');
INSERT INTO `user_login` VALUES ('396193655708323840', '王超',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王超@gmail.com');
INSERT INTO `user_login` VALUES ('396193655708323841', '李明',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李明@gmail.com');
INSERT INTO `user_login` VALUES ('396193655708323842', '李勇',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李勇@gmail.com');
INSERT INTO `user_login` VALUES ('396193655775432704', '王娟',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王娟@gmail.com');
INSERT INTO `user_login` VALUES ('396193655775432705', '刘杰',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘杰@gmail.com');
INSERT INTO `user_login` VALUES ('396193655842541568', '刘敏',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘敏@gmail.com');
INSERT INTO `user_login` VALUES ('396193655842541569', '李霞',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李霞@gmail.com');
INSERT INTO `user_login` VALUES ('396193655905456128', '李丽',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李丽@gmail.com');
INSERT INTO `user_login` VALUES ('396193655905456129', '张军',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张军@gmail.com');
INSERT INTO `user_login` VALUES ('396193655905456130', '王杰',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王杰@gmail.com');
INSERT INTO `user_login` VALUES ('396193655980953600', '张强',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张强@gmail.com');
INSERT INTO `user_login` VALUES ('396193655989342208', '王秀兰',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王秀兰@gmail.com');
INSERT INTO `user_login` VALUES ('396193655997730816', '王刚',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王刚@gmail.com');
INSERT INTO `user_login` VALUES ('396193656010313728', '王平',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王平@gmail.com');
INSERT INTO `user_login` VALUES ('396193656018702336', '刘芳',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘芳@gmail.com');
INSERT INTO `user_login` VALUES ('396193656027090944', '张燕',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张燕@gmail.com');
INSERT INTO `user_login` VALUES ('396193656035479552', '刘艳',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘艳@gmail.com');
INSERT INTO `user_login` VALUES ('396193656039673856', '刘军',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘军@gmail.com');
INSERT INTO `user_login` VALUES ('396193656052256768', '李平',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李平@gmail.com');
INSERT INTO `user_login` VALUES ('396193656056451072', '王辉',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王辉@gmail.com');
INSERT INTO `user_login` VALUES ('396193656056451073', '王燕',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王燕@gmail.com');
INSERT INTO `user_login` VALUES ('396193656123559936', '陈静',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈静@gmail.com');
INSERT INTO `user_login` VALUES ('396193656123559937', '刘勇',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘勇@gmail.com');
INSERT INTO `user_login` VALUES ('396193656123559938', '李玲',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李玲@gmail.com');
INSERT INTO `user_login` VALUES ('396193656190668800', '李桂英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李桂英@gmail.com');
INSERT INTO `user_login` VALUES ('396193656190668801', '王丹',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王丹@gmail.com');
INSERT INTO `user_login` VALUES ('396193656253583360', '李刚',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李刚@gmail.com');
INSERT INTO `user_login` VALUES ('396193656253583361', '李丹',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李丹@gmail.com');
INSERT INTO `user_login` VALUES ('396193656320692224', '李萍',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李萍@gmail.com');
INSERT INTO `user_login` VALUES ('396193656320692225', '王鹏',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王鹏@gmail.com');
INSERT INTO `user_login` VALUES ('396193656320692226', '刘涛',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘涛@gmail.com');
INSERT INTO `user_login` VALUES ('396193656383606784', '陈伟',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈伟@gmail.com');
INSERT INTO `user_login` VALUES ('396193656383606785', '张华',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张华@gmail.com');
INSERT INTO `user_login` VALUES ('396193656450715648', '刘静',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘静@gmail.com');
INSERT INTO `user_login` VALUES ('396193656450715649', '李涛',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李涛@gmail.com');
INSERT INTO `user_login` VALUES ('396193656517824512', '王桂英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王桂英@gmail.com');
INSERT INTO `user_login` VALUES ('396193656517824513', '张秀兰',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张秀兰@gmail.com');
INSERT INTO `user_login` VALUES ('396193656517824514', '李红',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李红@gmail.com');
INSERT INTO `user_login` VALUES ('396193656580739072', '李超',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李超@gmail.com');
INSERT INTO `user_login` VALUES ('396193656580739073', '刘丽',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘丽@gmail.com');
INSERT INTO `user_login` VALUES ('396193656647847936', '张桂英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张桂英@gmail.com');
INSERT INTO `user_login` VALUES ('396193656647847937', '王玉兰',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王玉兰@gmail.com');
INSERT INTO `user_login` VALUES ('396193656647847938', '李燕',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李燕@gmail.com');
INSERT INTO `user_login` VALUES ('396193656714956800', '张鹏',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张鹏@gmail.com');
INSERT INTO `user_login` VALUES ('396193656714956801', '李秀兰',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李秀兰@gmail.com');
INSERT INTO `user_login` VALUES ('396193656777871360', '张超',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张超@gmail.com');
INSERT INTO `user_login` VALUES ('396193656777871361', '王玲',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王玲@gmail.com');
INSERT INTO `user_login` VALUES ('396193656844980224', '张玲',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张玲@gmail.com');
INSERT INTO `user_login` VALUES ('396193656844980225', '李华',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李华@gmail.com');
INSERT INTO `user_login` VALUES ('396193656844980226', '王飞',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王飞@gmail.com');
INSERT INTO `user_login` VALUES ('396193656912089088', '张玉兰',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张玉兰@gmail.com');
INSERT INTO `user_login` VALUES ('396193656912089089', '王桂兰',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王桂兰@gmail.com');
INSERT INTO `user_login` VALUES ('396193656975003648', '王英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王英@gmail.com');
INSERT INTO `user_login` VALUES ('396193656975003649', '刘强',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘强@gmail.com');
INSERT INTO `user_login` VALUES ('396193657042112512', '陈秀英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈秀英@gmail.com');
INSERT INTO `user_login` VALUES ('396193657042112513', '李英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李英@gmail.com');
INSERT INTO `user_login` VALUES ('396193657042112514', '李辉',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李辉@gmail.com');
INSERT INTO `user_login` VALUES ('396193657105027072', '李梅',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李梅@gmail.com');
INSERT INTO `user_login` VALUES ('396193657105027073', '陈勇',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈勇@gmail.com');
INSERT INTO `user_login` VALUES ('396193657172135936', '王鑫',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王鑫@gmail.com');
INSERT INTO `user_login` VALUES ('396193657172135937', '李芳',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李芳@gmail.com');
INSERT INTO `user_login` VALUES ('396193657239244800', '张桂兰',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张桂兰@gmail.com');
INSERT INTO `user_login` VALUES ('396193657239244801', '李波',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李波@gmail.com');
INSERT INTO `user_login` VALUES ('396193657239244802', '杨勇',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '杨勇@gmail.com');
INSERT INTO `user_login` VALUES ('396193657302159360', '王霞',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王霞@gmail.com');
INSERT INTO `user_login` VALUES ('396193657302159361', '李桂兰',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李桂兰@gmail.com');
INSERT INTO `user_login` VALUES ('396193657369268224', '王斌',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王斌@gmail.com');
INSERT INTO `user_login` VALUES ('396193657369268225', '李鹏',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李鹏@gmail.com');
INSERT INTO `user_login` VALUES ('396193657369268226', '张平',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张平@gmail.com');
INSERT INTO `user_login` VALUES ('396193657436377088', '张莉',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张莉@gmail.com');
INSERT INTO `user_login` VALUES ('396193657436377089', '张辉',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张辉@gmail.com');
INSERT INTO `user_login` VALUES ('396193657499291648', '张宇',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张宇@gmail.com');
INSERT INTO `user_login` VALUES ('396193657499291649', '刘娟',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘娟@gmail.com');
INSERT INTO `user_login` VALUES ('396193657566400512', '李斌',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李斌@gmail.com');
INSERT INTO `user_login` VALUES ('396193657566400513', '王浩',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王浩@gmail.com');
INSERT INTO `user_login` VALUES ('396193657566400514', '陈杰',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈杰@gmail.com');
INSERT INTO `user_login` VALUES ('396193657629315072', '王凯',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王凯@gmail.com');
INSERT INTO `user_login` VALUES ('396193657629315073', '陈丽',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈丽@gmail.com');
INSERT INTO `user_login` VALUES ('396193657696423936', '陈敏',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈敏@gmail.com');
INSERT INTO `user_login` VALUES ('396193657696423937', '王秀珍',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王秀珍@gmail.com');
INSERT INTO `user_login` VALUES ('396193657763532800', '李玉兰',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李玉兰@gmail.com');
INSERT INTO `user_login` VALUES ('396193657763532801', '刘秀英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘秀英@gmail.com');
INSERT INTO `user_login` VALUES ('396193657763532802', '王萍',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王萍@gmail.com');
INSERT INTO `user_login` VALUES ('396193657826447361', '张波',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张波@gmail.com');
INSERT INTO `user_login` VALUES ('396193657893556224', '刘桂英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘桂英@gmail.com');
INSERT INTO `user_login` VALUES ('396193657893556225', '杨秀英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '杨秀英@gmail.com');
INSERT INTO `user_login` VALUES ('396193657893556226', '张英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张英@gmail.com');
INSERT INTO `user_login` VALUES ('396193657960665088', '杨丽',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '杨丽@gmail.com');
INSERT INTO `user_login` VALUES ('396193657960665089', '张健',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张健@gmail.com');
INSERT INTO `user_login` VALUES ('396193658023579648', '李俊',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李俊@gmail.com');
INSERT INTO `user_login` VALUES ('396193658023579649', '李莉',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李莉@gmail.com');
INSERT INTO `user_login` VALUES ('396193658090688512', '王波',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王波@gmail.com');
INSERT INTO `user_login` VALUES ('396193658090688513', '张红',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张红@gmail.com');
INSERT INTO `user_login` VALUES ('396193658090688514', '刘丹',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘丹@gmail.com');
INSERT INTO `user_login` VALUES ('396193658153603072', '李鑫',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李鑫@gmail.com');
INSERT INTO `user_login` VALUES ('396193658153603073', '王莉',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王莉@gmail.com');
INSERT INTO `user_login` VALUES ('396193658220711936', '杨静',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '杨静@gmail.com');
INSERT INTO `user_login` VALUES ('396193658220711937', '刘超',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘超@gmail.com');
INSERT INTO `user_login` VALUES ('396193658287820800', '张娟',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张娟@gmail.com');
INSERT INTO `user_login` VALUES ('396193658287820801', '杨帆',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '杨帆@gmail.com');
INSERT INTO `user_login` VALUES ('396193658287820802', '刘燕',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘燕@gmail.com');
INSERT INTO `user_login` VALUES ('396193658350735360', '刘英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘英@gmail.com');
INSERT INTO `user_login` VALUES ('396193658350735361', '李雪',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李雪@gmail.com');
INSERT INTO `user_login` VALUES ('396193658417844224', '李秀珍',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李秀珍@gmail.com');
INSERT INTO `user_login` VALUES ('396193658417844225', '张鑫',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张鑫@gmail.com');
INSERT INTO `user_login` VALUES ('396193658417844226', '王健',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王健@gmail.com');
INSERT INTO `user_login` VALUES ('396193658484953088', '刘玉兰',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘玉兰@gmail.com');
INSERT INTO `user_login` VALUES ('396193658484953089', '刘辉',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘辉@gmail.com');
INSERT INTO `user_login` VALUES ('396193658547867648', '刘波',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘波@gmail.com');
INSERT INTO `user_login` VALUES ('396193658547867649', '张浩',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张浩@gmail.com');
INSERT INTO `user_login` VALUES ('396193658614976512', '张明',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张明@gmail.com');
INSERT INTO `user_login` VALUES ('396193658614976513', '陈燕',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈燕@gmail.com');
INSERT INTO `user_login` VALUES ('396193658614976514', '张霞',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张霞@gmail.com');
INSERT INTO `user_login` VALUES ('396193658677891072', '陈艳',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈艳@gmail.com');
INSERT INTO `user_login` VALUES ('396193658677891073', '杨杰',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '杨杰@gmail.com');
INSERT INTO `user_login` VALUES ('396193658744999936', '王帅',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王帅@gmail.com');
INSERT INTO `user_login` VALUES ('396193658744999937', '李慧',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李慧@gmail.com');
INSERT INTO `user_login` VALUES ('396193658812108800', '王雪',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王雪@gmail.com');
INSERT INTO `user_login` VALUES ('396193658812108801', '杨军',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '杨军@gmail.com');
INSERT INTO `user_login` VALUES ('396193658812108802', '张旭',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张旭@gmail.com');
INSERT INTO `user_login` VALUES ('396193658875023360', '刘刚',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘刚@gmail.com');
INSERT INTO `user_login` VALUES ('396193658875023361', '王华',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王华@gmail.com');
INSERT INTO `user_login` VALUES ('396193658942132224', '杨敏',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '杨敏@gmail.com');
INSERT INTO `user_login` VALUES ('396193658942132225', '王宁',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王宁@gmail.com');
INSERT INTO `user_login` VALUES ('396193658942132226', '李宁',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李宁@gmail.com');
INSERT INTO `user_login` VALUES ('396193659009241088', '王俊',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王俊@gmail.com');
INSERT INTO `user_login` VALUES ('396193659009241089', '刘桂兰',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘桂兰@gmail.com');
INSERT INTO `user_login` VALUES ('396193659072155648', '刘斌',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘斌@gmail.com');
INSERT INTO `user_login` VALUES ('396193659072155649', '张萍',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张萍@gmail.com');
INSERT INTO `user_login` VALUES ('396193659139264512', '王婷',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王婷@gmail.com');
INSERT INTO `user_login` VALUES ('396193659139264513', '陈涛',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈涛@gmail.com');
INSERT INTO `user_login` VALUES ('396193659139264514', '王玉梅',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王玉梅@gmail.com');
INSERT INTO `user_login` VALUES ('396193659202179072', '王娜',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王娜@gmail.com');
INSERT INTO `user_login` VALUES ('396193659202179073', '张斌',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张斌@gmail.com');
INSERT INTO `user_login` VALUES ('396193659269287936', '陈龙',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈龙@gmail.com');
INSERT INTO `user_login` VALUES ('396193659269287937', '李林',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李林@gmail.com');
INSERT INTO `user_login` VALUES ('396193659336396800', '王玉珍',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王玉珍@gmail.com');
INSERT INTO `user_login` VALUES ('396193659336396801', '张凤英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张凤英@gmail.com');
INSERT INTO `user_login` VALUES ('396193659336396802', '王红',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王红@gmail.com');
INSERT INTO `user_login` VALUES ('396193659399311360', '李凤英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李凤英@gmail.com');
INSERT INTO `user_login` VALUES ('396193659399311361', '杨洋',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '杨洋@gmail.com');
INSERT INTO `user_login` VALUES ('396193659466420224', '李婷',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李婷@gmail.com');
INSERT INTO `user_login` VALUES ('396193659466420225', '张俊',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张俊@gmail.com');
INSERT INTO `user_login` VALUES ('396193659533529088', '王林',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王林@gmail.com');
INSERT INTO `user_login` VALUES ('396193659533529089', '陈英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈英@gmail.com');
INSERT INTO `user_login` VALUES ('396193659533529090', '陈军',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈军@gmail.com');
INSERT INTO `user_login` VALUES ('396193659596443648', '刘霞',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘霞@gmail.com');
INSERT INTO `user_login` VALUES ('396193659596443649', '陈浩',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈浩@gmail.com');
INSERT INTO `user_login` VALUES ('396193659663552512', '张凯',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张凯@gmail.com');
INSERT INTO `user_login` VALUES ('396193659663552513', '王晶',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王晶@gmail.com');
INSERT INTO `user_login` VALUES ('396193659726467072', '陈芳',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈芳@gmail.com');
INSERT INTO `user_login` VALUES ('396193659726467073', '张婷',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张婷@gmail.com');
INSERT INTO `user_login` VALUES ('396193659726467074', '杨涛',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '杨涛@gmail.com');
INSERT INTO `user_login` VALUES ('396193659793575936', '杨波',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '杨波@gmail.com');
INSERT INTO `user_login` VALUES ('396193659793575937', '陈红',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈红@gmail.com');
INSERT INTO `user_login` VALUES ('396193659860684800', '刘欢',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘欢@gmail.com');
INSERT INTO `user_login` VALUES ('396193659860684801', '王玉英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王玉英@gmail.com');
INSERT INTO `user_login` VALUES ('396193659860684802', '陈娟',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈娟@gmail.com');
INSERT INTO `user_login` VALUES ('396193659923599360', '陈刚',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈刚@gmail.com');
INSERT INTO `user_login` VALUES ('396193659923599361', '王慧',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王慧@gmail.com');
INSERT INTO `user_login` VALUES ('396193659990708224', '张颖',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张颖@gmail.com');
INSERT INTO `user_login` VALUES ('396193659990708225', '张林',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张林@gmail.com');
INSERT INTO `user_login` VALUES ('396193660057817088', '张娜',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张娜@gmail.com');
INSERT INTO `user_login` VALUES ('396193660057817089', '张玉梅',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张玉梅@gmail.com');
INSERT INTO `user_login` VALUES ('396193660057817090', '王凤英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王凤英@gmail.com');
INSERT INTO `user_login` VALUES ('396193660120731648', '张玉英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张玉英@gmail.com');
INSERT INTO `user_login` VALUES ('396193660120731649', '李红梅',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李红梅@gmail.com');
INSERT INTO `user_login` VALUES ('396193660187840512', '刘佳',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘佳@gmail.com');
INSERT INTO `user_login` VALUES ('396193660187840513', '刘磊',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘磊@gmail.com');
INSERT INTO `user_login` VALUES ('396193660250755072', '张倩',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张倩@gmail.com');
INSERT INTO `user_login` VALUES ('396193660250755073', '刘鹏',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘鹏@gmail.com');
INSERT INTO `user_login` VALUES ('396193660250755074', '王旭',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王旭@gmail.com');
INSERT INTO `user_login` VALUES ('396193660317863936', '张雪',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张雪@gmail.com');
INSERT INTO `user_login` VALUES ('396193660317863937', '李阳',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李阳@gmail.com');
INSERT INTO `user_login` VALUES ('396193660384972800', '张秀珍',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张秀珍@gmail.com');
INSERT INTO `user_login` VALUES ('396193660384972801', '王梅',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王梅@gmail.com');
INSERT INTO `user_login` VALUES ('396193660447887360', '王建华',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王建华@gmail.com');
INSERT INTO `user_login` VALUES ('396193660447887361', '李玉梅',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李玉梅@gmail.com');
INSERT INTO `user_login` VALUES ('396193660447887362', '王颖',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王颖@gmail.com');
INSERT INTO `user_login` VALUES ('396193660514996224', '刘平',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘平@gmail.com');
INSERT INTO `user_login` VALUES ('396193660514996225', '杨梅',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '杨梅@gmail.com');
INSERT INTO `user_login` VALUES ('396193660582105088', '李飞',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李飞@gmail.com');
INSERT INTO `user_login` VALUES ('396193660582105089', '王亮',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王亮@gmail.com');
INSERT INTO `user_login` VALUES ('396193660582105090', '李磊',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李磊@gmail.com');
INSERT INTO `user_login` VALUES ('396193660645019648', '李建华',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李建华@gmail.com');
INSERT INTO `user_login` VALUES ('396193660645019649', '王宇',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王宇@gmail.com');
INSERT INTO `user_login` VALUES ('396193660712128512', '陈玲',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈玲@gmail.com');
INSERT INTO `user_login` VALUES ('396193660712128513', '张建华',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张建华@gmail.com');
INSERT INTO `user_login` VALUES ('396193660779237376', '刘鑫',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘鑫@gmail.com');
INSERT INTO `user_login` VALUES ('396193660779237377', '王倩',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王倩@gmail.com');
INSERT INTO `user_login` VALUES ('396193660779237378', '张帅',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张帅@gmail.com');
INSERT INTO `user_login` VALUES ('396193660842151936', '李健',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李健@gmail.com');
INSERT INTO `user_login` VALUES ('396193660842151937', '陈林',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈林@gmail.com');
INSERT INTO `user_login` VALUES ('396193660909260800', '李洋',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李洋@gmail.com');
INSERT INTO `user_login` VALUES ('396193660909260801', '陈强',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈强@gmail.com');
INSERT INTO `user_login` VALUES ('396193660972175360', '赵静',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '赵静@gmail.com');
INSERT INTO `user_login` VALUES ('396193660972175361', '王成',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王成@gmail.com');
INSERT INTO `user_login` VALUES ('396193660972175362', '张玉珍',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张玉珍@gmail.com');
INSERT INTO `user_login` VALUES ('396193661039284224', '陈超',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈超@gmail.com');
INSERT INTO `user_login` VALUES ('396193661039284225', '陈亮',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈亮@gmail.com');
INSERT INTO `user_login` VALUES ('396193661106393088', '刘娜',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘娜@gmail.com');
INSERT INTO `user_login` VALUES ('396193661106393089', '王琴',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王琴@gmail.com');
INSERT INTO `user_login` VALUES ('396193661106393090', '张兰英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张兰英@gmail.com');
INSERT INTO `user_login` VALUES ('396193661169307648', '张慧',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张慧@gmail.com');
INSERT INTO `user_login` VALUES ('396193661169307649', '刘畅',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘畅@gmail.com');
INSERT INTO `user_login` VALUES ('396193661236416512', '李倩',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李倩@gmail.com');
INSERT INTO `user_login` VALUES ('396193661236416513', '杨艳',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '杨艳@gmail.com');
INSERT INTO `user_login` VALUES ('396193661303525376', '张亮',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张亮@gmail.com');
INSERT INTO `user_login` VALUES ('396193661303525377', '张建',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张建@gmail.com');
INSERT INTO `user_login` VALUES ('396193661303525378', '李云',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李云@gmail.com');
INSERT INTO `user_login` VALUES ('396193661366439936', '张琴',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张琴@gmail.com');
INSERT INTO `user_login` VALUES ('396193661366439937', '王兰英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王兰英@gmail.com');
INSERT INTO `user_login` VALUES ('396193661433548800', '李玉珍',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李玉珍@gmail.com');
INSERT INTO `user_login` VALUES ('396193661433548801', '刘萍',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘萍@gmail.com');
INSERT INTO `user_login` VALUES ('396193661496463360', '陈桂英',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈桂英@gmail.com');
INSERT INTO `user_login` VALUES ('396193661496463361', '刘颖',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘颖@gmail.com');
INSERT INTO `user_login` VALUES ('396193661496463362', '杨超',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '杨超@gmail.com');
INSERT INTO `user_login` VALUES ('396193661563572224', '张梅',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张梅@gmail.com');
INSERT INTO `user_login` VALUES ('396193661563572225', '陈平',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈平@gmail.com');
INSERT INTO `user_login` VALUES ('396193661630681088', '王建',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王建@gmail.com');
INSERT INTO `user_login` VALUES ('396193661630681089', '刘红',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘红@gmail.com');
INSERT INTO `user_login` VALUES ('396193661630681090', '赵伟',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '赵伟@gmail.com');
INSERT INTO `user_login` VALUES ('396193661693595648', '张云',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张云@gmail.com');
INSERT INTO `user_login` VALUES ('396193661693595649', '张宁',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张宁@gmail.com');
INSERT INTO `user_login` VALUES ('396193661760704512', '杨林',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '杨林@gmail.com');
INSERT INTO `user_login` VALUES ('396193661760704513', '张洁',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张洁@gmail.com');
INSERT INTO `user_login` VALUES ('396193661823619072', '高峰',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '高峰@gmail.com');
INSERT INTO `user_login` VALUES ('396193661823619073', '王建国',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王建国@gmail.com');
INSERT INTO `user_login` VALUES ('396193661823619074', '杨阳',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '杨阳@gmail.com');
INSERT INTO `user_login` VALUES ('396193661890727936', '陈华',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈华@gmail.com');
INSERT INTO `user_login` VALUES ('396193661890727937', '杨华',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '杨华@gmail.com');
INSERT INTO `user_login` VALUES ('396193661957836800', '王建军',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王建军@gmail.com');
INSERT INTO `user_login` VALUES ('396193661957836801', '杨柳',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '杨柳@gmail.com');
INSERT INTO `user_login` VALUES ('396193662020751360', '刘阳',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘阳@gmail.com');
INSERT INTO `user_login` VALUES ('396193662020751361', '王淑珍',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王淑珍@gmail.com');
INSERT INTO `user_login` VALUES ('396193662020751362', '杨芳',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '杨芳@gmail.com');
INSERT INTO `user_login` VALUES ('396193662087860224', '李春梅',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李春梅@gmail.com');
INSERT INTO `user_login` VALUES ('396193662087860225', '刘俊',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘俊@gmail.com');
INSERT INTO `user_login` VALUES ('396193662154969088', '王海燕',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王海燕@gmail.com');
INSERT INTO `user_login` VALUES ('396193662154969089', '刘玲',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘玲@gmail.com');
INSERT INTO `user_login` VALUES ('396193662154969090', '陈晨',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈晨@gmail.com');
INSERT INTO `user_login` VALUES ('396193662217883648', '王欢',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王欢@gmail.com');
INSERT INTO `user_login` VALUES ('396193662217883649', '李冬梅',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李冬梅@gmail.com');
INSERT INTO `user_login` VALUES ('396193662284992512', '张龙',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '张龙@gmail.com');
INSERT INTO `user_login` VALUES ('396193662284992513', '陈波',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈波@gmail.com');
INSERT INTO `user_login` VALUES ('396193662352101376', '陈磊',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈磊@gmail.com');
INSERT INTO `user_login` VALUES ('396193662352101377', '王云',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王云@gmail.com');
INSERT INTO `user_login` VALUES ('396193662352101378', '王峰',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王峰@gmail.com');
INSERT INTO `user_login` VALUES ('396193662415015936', '王秀荣',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王秀荣@gmail.com');
INSERT INTO `user_login` VALUES ('396193662415015937', '王瑞',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王瑞@gmail.com');
INSERT INTO `user_login` VALUES ('396193662482124800', '李琴',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李琴@gmail.com');
INSERT INTO `user_login` VALUES ('396193662482124801', '李桂珍',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '李桂珍@gmail.com');
INSERT INTO `user_login` VALUES ('396193662545039360', '陈鹏',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈鹏@gmail.com');
INSERT INTO `user_login` VALUES ('396193662545039361', '王莹',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王莹@gmail.com');
INSERT INTO `user_login` VALUES ('396193662545039362', '刘飞',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '刘飞@gmail.com');
INSERT INTO `user_login` VALUES ('396193662612148224', '王秀云',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '王秀云@gmail.com');
INSERT INTO `user_login` VALUES ('396193662612148225', '陈明',
                                 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',
                                 '陈明@gmail.com');
INSERT INTO `user_login` VALUES ('403591502330204160', '琉璃', '123456', 'rxliuli@gmail.com');
INSERT INTO `user_login` VALUES ('406174229839613952', 'rxliuli', '123456', 'rxliuli@qq.com');
INSERT INTO `user_login` VALUES ('406483600276590592', '月姬', '123456', '月姬@gmail.com');
INSERT INTO `user_login` VALUES ('406491809179635712', '灵梦23', '123456', 'lingmeng@qq.com');
INSERT INTO `user_login` VALUES ('406764828586283008', '吴海源', '123456', 'wuhaiyuan@gmail.com');