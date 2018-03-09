package com.interview.quartz;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.interview.entity.Feedback;
import com.interview.service.FeedbackService;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.springframework.context.ApplicationContext;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import java.util.List;
import java.util.Map;

/**
 * @author rxliuli
 */
public class FeedbackMessageSendJob implements Job {
  @Override
  public void execute(JobExecutionContext jobExecutionContext) {
    Map dataMap = jobExecutionContext.getJobDetail().getJobDataMap();
    //获取Spring的上下文信息,可以访问容器中的其他任何Bean
    ApplicationContext applicationContext = (ApplicationContext) dataMap.get("applicationContext");
//对JobDataMap中保存的值进行修改，要根据任务类型进行区分
    //如果实现Job接口，这种更改对于下一次执行是不可见的
    //如果实现StatefulJob接口，对于下一次执行是可见的
    FeedbackService feedbackService = applicationContext.getBean(FeedbackService.class);
    JavaMailSenderImpl javaMailSender = applicationContext.getBean("mail163Sender", JavaMailSenderImpl.class);
    List<Feedback> feedbackList = feedbackService.selectList(new EntityWrapper<Feedback>()
      .eq("haveSolve", 0)
    );
    if (!feedbackList.isEmpty()) {
      //<span style="color: #ff0000;"> 注意 SimpleMailMessage 只能用来发送 text 格式的邮件 </span>
      SimpleMailMessage mail = new SimpleMailMessage();

      try {
        // 接受者
        mail.setTo("rxliuli@gmail.com");
        // 发送者, 这里还可以另起 Email 别名，不用和 xml 里的 username 一致
        mail.setFrom("13939621143@163.com");
        // 主题
        mail.setSubject("你还有未处理的用户反馈！");
        // 邮件内容
        mail.setText("数量：" + feedbackList.size() + " 封");
        javaMailSender.send(mail);
      } catch (Exception e) {
        e.printStackTrace();
      }
    }

    System.out.println("hello world");
  }
}
