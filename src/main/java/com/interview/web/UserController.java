package com.interview.web;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.interview.entity.UserLogin;
import com.interview.service.UserLoginService;
import com.interview.util.ConstantsUtil;
import com.interview.util.EncryptUtil;
import com.interview.util.JsonResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * @author rxliuli
 */
@Controller
@RequestMapping(path = "/user")
public class UserController {
  @Autowired
  private UserLoginService userLoginService;

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
  @RequestMapping(path = "/addTopic")
  public String addTopic() {
    return "foreground/submitTopic";
  }
}
