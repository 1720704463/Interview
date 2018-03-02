package com.interview.web;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.google.gson.reflect.TypeToken;
import com.interview.entity.*;
import com.interview.service.*;
import com.interview.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
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
    HttpSession session) {
    UserLogin result = userLoginService.getByUserLogin(userLogin);
    if (result == null) {
      return JsonResult.getError("用户名或密码错误");
    }
    session.setAttribute(ConstantsUtil.USER_SESSION, result);
    return JsonResult.getSuccess(result);
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
    boolean boo = userLoginService.insert(userLogin);
    session.setAttribute(ConstantsUtil.USER_SESSION, userLogin);
    return new JsonResult().setSuccess(boo);
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
      new Timestamp(nowTime + 60_000),
      topicIds
    );
    boolean boo = examService.insert(exam);
    if (!boo) {
      return JsonResult.getError("添加新的考试错误了,请尝试刷新页面重试!");
    }
    Map<String, Object> map = new HashMap<>(2);
    map.put("topicList", topicList);
    map.put("examId", exam.getId());
    return JsonResult.getSuccess(map);
  }
}
