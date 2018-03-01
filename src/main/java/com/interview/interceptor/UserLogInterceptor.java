package com.interview.interceptor;

import com.interview.entity.UserLog;
import com.interview.entity.UserLogin;
import com.interview.service.UserLogService;
import com.interview.util.ConstantsUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;

/**
 * 用户访问日志记录的拦截器
 *
 * @author rxliuli
 */
public class UserLogInterceptor extends HandlerInterceptorAdapter {
  /**
   * 这个类的日志对象
   */
  private static final Log logger = LogFactory.getLog(UserNoLoginInterceptor.class);
  @Autowired
  private UserLogService userLogService;

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
    UserLogin userLogin = (UserLogin) session.getAttribute(ConstantsUtil.USER_SESSION);
    UserLog userLog = new UserLog(
      userLogin == null ? null : userLogin.getId(),
      request.getRequestURL().toString(),
      request.getHeader("Referer"),
      request.getRemoteAddr(),
      new Timestamp(System.currentTimeMillis()),
      request.getHeader("User-Agent")
    );
    boolean boo = userLogService.insert(userLog);
    logger.info(boo);
    return true;
  }

}
