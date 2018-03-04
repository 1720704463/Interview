package com.interview.web;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.google.gson.reflect.TypeToken;
import com.interview.entity.*;
import com.interview.service.*;
import com.interview.util.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @author rxliuli
 */
@Controller
@RequestMapping(path = "/user")
public class UserController {
  @Autowired
  private UserLoginService userLoginService;
  @Autowired
  private TopicService topicService;
  @Autowired
  private ExamService examService;
  @Autowired
  private ResultService resultService;
  @Autowired
  private ExamTopicService examTopicService;
  @Autowired
  private UserKeyService userKeyService;
  @Autowired
  private UserInfoService userInfoService;
  @Autowired
  private UserPictureService userPictureService;

  /**
   * 跳转到登陆
   */
  @RequestMapping(path = "/login")
  public String login() {
    return "foreground/login";
  }

  /**
   * 用户 Ajax 登录
   */
  @RequestMapping(path = "/loginExecute")
  @ResponseBody
  public JsonResult<UserLogin> loginExecute(
    UserLogin userLogin,
    Boolean remember,
    HttpSession session,
    HttpServletRequest request,
    HttpServletResponse response
  ) throws Exception {
    UserLogin result = userLoginService.getByUserLogin(userLogin);
    if (result == null) {
      return JsonResult.getError("用户名或密码错误");
    }
    //存入到 session 中
    session.setAttribute(ConstantsUtil.USER_SESSION, result);
    //判断用户是否选中记住密码
    if (!remember) {
      removeUserCookie(request, response);
    } else {
      //将用户名和密码加密存入到 cookie 中
      String key = DesCodec.initKey();
      //将秘钥添加/更新到数据库
      boolean userKeyBoo = userKeyService.insertOrUpdate(new UserKey(result.getId(), key));
      //只加密密码而不加密用户 id,以此找到用户的秘钥然后对密码进行解密
      String encryptPassword = DesCodec.encrypt(result.getPassword(), key);
      Cookie cookie = new Cookie(
        ConstantsUtil.INTERVIEW_USER_COOKIE,
        result.getId() + "|" + encryptPassword
      );
      //设置有效时间是 1 年
      cookie.setMaxAge(60 * 60 * 24 * 365);
      cookie.setPath("/");
      response.addCookie(cookie);
    }
    return JsonResult.getSuccess(result);
  }

  /**
   * 清除用户当前的 cookie(如果有的话)
   */
  private void removeUserCookie(HttpServletRequest request, HttpServletResponse response) {
    //如果用户没有记住密码则清除本地 cookie(如果有的话)
    Cookie[] cookies = request.getCookies();
    Arrays.stream(cookies)
      .filter(cookie ->
        StringUtils.equals(cookie.getName(), ConstantsUtil.INTERVIEW_USER_COOKIE)
          && cookie.getValue() != null
      )
      .forEach(cookie -> {
        //设置 cookie 的有效周期为 0 然后覆盖掉原本的,也算是变相删除了
        cookie.setValue(null);
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
      });
  }

  /**
   * 跳转到首页
   */
  @RequestMapping(path = "/home")
  public String home() {
    return "foreground/home";
  }

  /**
   * 根据用户名查询用户名是否被占用
   */
  @RequestMapping(path = "/findByUsername")
  @ResponseBody
  public JsonResult<Integer> findByUsername(String username) {
    int count = userLoginService.selectCount(
      new EntityWrapper<UserLogin>()
        .eq("username", username)
    );
    if (count != 0) {
      JsonResult<Integer> error = JsonResult.getError("当前用户名已存在！");
      return error.setData(count);
    }
    return JsonResult.getSuccess(count);
  }

  /**
   * 根据邮箱查询用户名是否被占用
   */
  @RequestMapping(path = "/findByEmail")
  @ResponseBody
  public JsonResult<Integer> findByEmail(String email) {
    int count = userLoginService.selectCount(
      new EntityWrapper<UserLogin>()
        .eq("email", email)
    );
    if (count != 0) {
      JsonResult<Integer> error = JsonResult.getError("当前邮箱已存在！");
      return error.setData(count);
    }
    return JsonResult.getSuccess(count);
  }

  /**
   * 跳转到用户登录页面
   */
  @RequestMapping(path = "/register")
  public String register() {
    return "/foreground/register";
  }

  /**
   * 用户注册
   */
  @RequestMapping(path = "/registerExecute")
  @ResponseBody
  public JsonResult registerExecute(
    UserLogin userLogin,
    HttpSession session
  ) {
    userLogin.setPassword(EncryptUtil.sha512Hex(userLogin.getPassword()));
    boolean userLoginBoo = userLoginService.insert(userLogin);
    if (!userLoginBoo) {
      return JsonResult.getError("注册失败!");
    }
    //添加一个用户注册表中的
    UserInfo userInfo = new UserInfo(userLogin.getId(), userLogin.getUsername(), userPictureService.findByRandom().getPicture());
    boolean userInfoBoo = userInfoService.insert(userInfo);
    if (!userInfoBoo) {
      return JsonResult.getError("注册失败!");
    }
    //存入到 session 中
    session.setAttribute(ConstantsUtil.USER_SESSION, userLogin);
    return JsonResult.getSuccess(null);
  }

  /**
   * 跳转到用户提交面试题目页面
   */
  @RequestMapping(path = "/submitTopic")
  public String addTopic() {
    return "foreground/submitTopic";
  }

  /**
   * 跳转到用户面试题目测验页面
   */
  @RequestMapping(path = "/userTestPage")
  public String userTestPage() {
    return "foreground/userTestPage";
  }

  /**
   * 提交用户测验
   */
  @RequestMapping(path = "/submitUserTest")
  @ResponseBody
  public JsonResult<?> submitUserTest(
    @RequestParam(required = false) String topicListString,
    @RequestParam(required = false) Long examId,
    HttpSession session
  ) {
    //获取全部的题目完成情况
    List<Topic> topicList = GsonUtil.gsonToList(topicListString, new TypeToken<List<Topic>>() {
    });
    UserLogin userLogin = (UserLogin) session.getAttribute(ConstantsUtil.USER_SESSION);
    //根据编号查询考试
    Exam exam = examService.selectOne(new EntityWrapper<Exam>().eq("id", examId));
    //获取原本考试的面试题目列表(谨防用户直接修改考试题目)
    String topicIdsOld = exam.getTopicIds();
    //获取提交过来的面试题目编号
    String topicIdsNew = topicList.stream()
      .map(topic -> topic.getId().toString())
      .collect(Collectors.joining("\n"));
    if (!StringUtils.equals(topicIdsOld, topicIdsNew)) {
      return JsonResult.getError("面试题目列表已被修改,请刷新页面重试!");
    }

    Result result = new Result(
      userLogin.getId(),
      examId,
      0D,
      exam.getStartTime(),
      new Timestamp(System.currentTimeMillis())
    );
    //添加考试
    boolean resultBoo = resultService.insert(result);
    List<ExamTopic> examTopicList = topicList.stream()
      .map(topic -> new ExamTopic(result.getId(), topic.getId(), 0D, topic.getAnswer()))
      .collect(Collectors.toList());
    //添加答案
    boolean examTopicListBoo = examTopicService.insertBatch(examTopicList);
    return new JsonResult<>().setSuccess(resultBoo && examTopicListBoo);
  }

  /**
   * 添加一场测试
   * 随机获取指定数量的面试题目列表
   * 存入考试表
   */
  @RequestMapping(path = "/addExamUserTest")
  @ResponseBody
  public JsonResult<Map<String, Object>> addExamUserTest(
    @RequestParam(required = false) Integer topicNumber
  ) {
    //获取指定数量的面试题目
    List<Topic> topicList = topicService.listByRandom(topicNumber);
    //获取面试题目 id 字符串
    List<Long> idList = topicList.stream()
      .map(Topic::getId)
      .collect(Collectors.toList());
    String topicIds = TopicIdsUtil.join(idList);
    //添加一场考试
    long nowTime = System.currentTimeMillis();
    Exam exam = new Exam(
      "用户测试 ",
      new Timestamp(nowTime),
      //一小时之后的时间
      new Timestamp(nowTime + 3_600_000),
      topicIds
    );
    boolean boo = examService.insert(exam);
    if (!boo) {
      return JsonResult.getError("添加新的考试错误了,请尝试刷新页面重试!");
    }
    Map<String, Object> map = new HashMap<>(2);
    map.put("topicList", topicList);
    map.put("exam", exam);
    return JsonResult.getSuccess(map);
  }

  /**
   * 判断用户是否登录
   */
  @RequestMapping(path = "/userWhetherLogin")
  @ResponseBody
  public JsonResult<UserInfo> userWhetherLogin(
    HttpSession session
  ) {
    //查询当前 session 中是否有用户信息
    UserLogin userLogin = (UserLogin) session.getAttribute(ConstantsUtil.USER_SESSION);
    if (userLogin == null) {
      return JsonResult.getError("用户还没有登录");
    }
    //查询用户的详细信息
    UserInfo userInfo = userInfoService.selectById(userLogin.getId());
    return JsonResult.getSuccess(userInfo);
  }

  /**
   * 注销登陆
   */
  @RequestMapping(path = "/logout")
  public String logout(
    HttpServletRequest request,
    HttpServletResponse response,
    HttpSession session
  ) {
    removeUserCookie(request, response);
    session.removeAttribute(ConstantsUtil.USER_SESSION);
    return "redirect:/user/home";
  }

  /**
   * 跳转到考试成绩列表页面
   */
  @RequestMapping(path = "/resultList")
  public String resultList() {
    return "foreground/resultList";
  }
}
