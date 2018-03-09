package com.interview.aop;

import com.interview.entity.Feedback;
import com.interview.util.JsonResult;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

/**
 * 用户反馈后发送邮件通知管理员及时进行处理
 *
 * @author rxliuli
 */
@Aspect
public class FeedbackMessageSendAdminMailAspect {
  /**
   * log4j 的 一个 logger 日志对象
   */
  private static final Log logger = LogFactory.getLog(FeedbackMessageSendAdminMailAspect.class);
  @Autowired
  @Qualifier("mail163Sender")
  private JavaMailSender javaMailSender;

  /**
   * 定义用户发送反馈的切点
   */
  @Pointcut("execution(* com.interview.web.UserController.submitFeedbackExecute(..))")
  public void userFeedbackExecutePointcut() {
  }

  /**
   * 用户发送反馈的 AOP 增强
   */
  @AfterReturning(value = "userFeedbackExecutePointcut()", returning = "result")
  public void afterReturn(Object result) {
    //获取返回值
    //noinspection unchecked
    JsonResult<Feedback> jsonResult = (JsonResult<Feedback>) result;
    Feedback feedback = jsonResult.getData();

    SimpleMailMessage mail = new SimpleMailMessage();
    try {
      // 接受者
      mail.setTo("rxliuli@gmail.com");
      // 发送者, 这里还可以另起 Email 别名，不用和 xml 里的 username 一致
      mail.setFrom("13939621143@163.com");
      // 主题
      mail.setSubject("你有一封新的反馈邮件要进行处理！");
      // 邮件内容
      mail.setText("用户 " + feedback.getUserLoginId()
        + " 发送了反馈,内容是: \n" + feedback.getContent());
      javaMailSender.send(mail);
      //想获取类，方法
    } catch (Exception e) {
      logger.info("用户反馈,发送邮件通知管理员失败: " + e);
    }
  }
}
