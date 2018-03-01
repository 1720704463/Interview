package com.interview.interceptor;

import com.interview.entity.UserLogin;
import com.interview.util.ConstantsUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 用户已登录时的拦截器
 * 用户登录后不能访问登录/注册页面,需要先退出才行
 *
 * @author rxliuli
 */
public class UserAlreadyLoginInterceptor extends HandlerInterceptorAdapter {
  /**
   * 这个类的日志对象
   */
  private static final Log logger = LogFactory.getLog(UserNoLoginInterceptor.class);


  /**
   * 重写拦截方法
   *
   * @param request  请求
   * @param response 响应
   * @param handler  操作对象
   * @return 是否应该正常执行
   */
  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
    HttpSession session = request.getSession();
    UserLogin userSession = (UserLogin) session.getAttribute(ConstantsUtil.USER_SESSION);
    //判断 session 中是否存在当前用户对象,如果存在就跳转到首页
    if (userSession != null) {
      try {
        response.sendRedirect(request.getContextPath() + "/user/home");
      } catch (IOException e) {
        logger.info(e.getMessage());
      }
      return false;
    }
    return true;
  }

}