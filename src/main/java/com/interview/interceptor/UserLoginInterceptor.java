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
 * 用户未登录时的拦截器
 * 用户未登录时访问那些需要用户信息的页面需要提醒登录
 *
 * @author rxliuli
 */
public class UserLoginInterceptor extends HandlerInterceptorAdapter {
  /**
   * 这个类的日志对象
   */
  private static final Log logger = LogFactory.getLog(UserLoginInterceptor.class);

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
    //判断 session 中是否存在当前用户对象
    if (userSession == null) {
      try {
        response.sendRedirect(request.getContextPath() + "/user/login");
      } catch (IOException e) {
        logger.info(e.getMessage());
      }
      return false;
    }
    return true;
  }
}
