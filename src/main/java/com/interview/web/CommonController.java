package com.interview.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 公共的非 Rest 控制器
 * 只负责跳转一些公共的页面,比如首页
 *
 * @author rxliuli
 */
@Controller
public class CommonController {
  /**
   * 跳转到首页
   */
  @RequestMapping(path = "/")
  public String home() {
    return "redirect:/user/home";
  }

  /**
   * 跳转到考试结果详情页面
   */
  @RequestMapping(path = "/resultDetail/{resultId}")
  public String resultDetail(
    @PathVariable Long resultId
  ) {
    return "foreground/resultDetail";
  }
}
