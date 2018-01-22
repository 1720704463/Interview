package com.interview.web;

import com.interview.entity.UserLogin;
import com.interview.service.UserLoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author rxliuli
 */
@Controller
public class UserLoginController {
  @Autowired
  private UserLoginService userLoginService;

  @RequestMapping(path = "/login")
  public String login() {
    return "login";
  }

  @RequestMapping(path = "/loginExecute")
  public String loginExecute(UserLogin userLogin, Model model) {
    UserLogin result = userLoginService.getByUserLogin(userLogin);
    model.addAttribute("info",
      result == null ? "登录失败!" : "登陆成功!");
    return "login";
  }


}
