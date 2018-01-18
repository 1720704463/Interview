# 编码规范

## Java规范
### 命名相关
- 类名采用首字母大写的驼峰命名法，并且需要是自然单词拼接而成。
以下命名是不规范的：
```
//假设这是个测试类，此处存在两处错误，text 单词并非指的是测试而是文本，而且类名开头小写了
class text{}
//严禁英文单词和中文拼音混用
class UserFuWuLei{}
//此处的 User Info Service 是三个单词，所以首字母需要大写
class Userinfoservice{}
```
以上代码应修改成：
```
//假设这是个测试类，此处存在两处错误，text 单词并非指的是测试而是文本，而且类名开头小写了
class Test{}
//严禁英文单词和中文拼音混用
class UserService{}
//此处的 User Info Service 是三个单词，所以首字母需要大写
class UserInfoService{}
```

- Java 源码中所有变量必须以驼峰命名法命名(常量不算是变量)，并且不得使用 i,s,b 之类的命名。
以下命名是不规范的：
```
//没有人知道 i 应该代表什么，即便能够通过阅读上下文推断出来，然而还是禁止此类命名！
int i = 0;
//这种变量命名法(下划线命名法)不应该混用进来
UserInfo user_info = new UserInfo();
```
以上代码应修改成：
```
//假如这个变量指代当前页的话
int pageIndex = 0;
//使用统一的风格更适合阅读源码
UserInfo userInfo = new UserInfo();
```

- Dao,Service,Web 层的类需要加上后缀名，实现类还要加上额外的 Impl 后缀。
以下命名是不规范的：
```
//假设这是个用户的 Service 接口，此处并未加上后缀名，无法准确的识别出这是一个用户 Service 接口，大概误以为是实体类的可能性更大一些
interface User{}
//假设这是上面的那个用户 Service 接口的实现类，这儿的 UserDaoimpl 的后缀应该是大写开头了
class UserServiceimpl implements User {}
```
以上代码应修改成：
```
//简单明了，一眼就能看出来是用户 Service 层的接口
interface UserDao{}
//看起来舒服了一些，也不用再看到编辑器给你的标识符命名抱怨了
class UserServiceImpl implements UserService{}
```
//以下是标准规范的 Dao,Service,Controller 命名
```
//假设用户实体类的名字为
class User{}
//Dao 层用户接口(前提是你使用了 mybatis)
interface UserMapper{}
//与上面 UserMapper 接口对应的 xml 文件
UserMapper.xml
//Service 层用户接口
interface UserService{}
//Service 层用户接口实现类
class UserServiceImpl implements UserService{}
//web 层的用户控制类
class UserController{}
```

- 使用 Spring 自动注入的 Bean 的名称一般使用类的全限定名，禁止大小写不规范！
以下命名是不规范的：
```
//假设这是用户的 Dao 层接口
interface UserMapper {}
//下面两种写法都是不规范的
@Autowired
private UserMapper usermapper;
private UserMapper UserMapper;
```
以上代码应修改成：
```
interface UserMapper {}
//使用类的全限定小写名才是规范的
@Autowried
private UserMapper userMapper;
```

- Controller 控制器的映射方法的 @RequestMapping 注解的 path 属性值，映射方法名需要保持一致(即便不一致也能正常运行，但会使人迷惑)，最好还和映射方法映射的 jsp 逻辑视图名相同(可以不一致，但尽量保持一致).
以下命名是不规范的：
```
//假设这是个查看所有用户信息的页面
userList.jsp
//这是一个典型的反例，path，方法名，返回的逻辑视图名完全不同！
@RequestMapping(path = "user")
public String queryUser() {
	return "userList";
}
```
以上代码应修改成：
```
//假设这是个查看所有用户信息的页面
userList.jsp
//这样看起来就舒服多了，能够很容易的看出来这个映射方法是用来查看用户列表，并且跳转到用户列表页面
@RequestMapping(path = "userList")
public String userList() {
	return "userList";
}
```

## SQL 规范
### 命名相关
- 数据库的名字,表名一般为下划线命名,而在数据库的列命名时,却需要遵守驼峰命名法,因为在 mybatis 进行 **列-字段** 映射时,如果数据库和 Java 的实体类命名不同时,会造成一定的性能损失,而且有可能影响正常使用 `mybatis-plus`.