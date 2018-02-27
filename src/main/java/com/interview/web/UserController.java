package com.interview.web;

import com.interview.entity.UserLogin;
import com.interview.service.UserLoginService;
import com.interview.util.ConstantsUtil;
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


}
