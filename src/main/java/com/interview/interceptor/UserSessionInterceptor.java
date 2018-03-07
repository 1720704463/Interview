package com.interview.interceptor;

import com.interview.entity.UserKey;
import com.interview.entity.UserLogin;
import com.interview.service.UserKeyService;
import com.interview.service.UserLoginService;
import com.interview.util.ConstantsUtil;
import com.interview.util.DesCodec;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.Optional;

/**
 * @author rxliuli
 */
public class UserSessionInterceptor extends HandlerInterceptorAdapter {
  @Autowired
  private UserKeyService userKeyService;
  @Autowired
  private UserLoginService userLoginService;

  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    HttpSession session = request.getSession();
    UserLogin userLoginSession = (UserLogin) session.getAttribute(ConstantsUtil.USER_SESSION);
    //如果 session 中已经存在当前用户,那就直接返回好了
    if (userLoginSession != null) {
      return true;
    }
    //否则就去 cookie 里面查询
    Cookie[] cookies = request.getCookies();
    if (cookies == null || cookies.length == 0) {
      return true;
    }
    //查询数组中是否有指定名称的 cookie
    Optional<Cookie> cookieOptional = Arrays.stream(cookies)
      .filter(cookie ->
        StringUtils.equals(cookie.getName(), ConstantsUtil.INTERVIEW_USER_COOKIE)
          && cookie.getValue() != null
      )
      .findFirst();
    //如果在 cookie 中不存在的话就直接返回
    if (!cookieOptional.isPresent()) {
      return true;
    }
    //否则就去查询数据库
    Cookie cookie = cookieOptional.get();
    String userCookie = cookie.getValue();
    //拆分 id 和加密后的密码
    String[] split = StringUtils.split(userCookie, "|");
    //根据 id 获取 userKey
    Long id = Long.valueOf(split[0]);
    UserKey userKey = userKeyService.selectById(id);
    if (userKey == null) {
      return true;
    }
    //对密码解密
    String passwordCookie = DesCodec.decrypt(split[1], userKey.getUserKey());
    //获取用户
    UserLogin userLogin = userLoginService.selectById(id);
    //如果密码正确则将该用户保存到 session 中
    if (StringUtils.equals(userLogin.getPassword(), passwordCookie)) {
      session.setAttribute(ConstantsUtil.USER_SESSION, userLogin);
    }
    return true;
  }
}
