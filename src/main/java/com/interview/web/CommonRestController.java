package com.interview.web;

import com.baomidou.mybatisplus.plugins.Page;
import com.interview.entity.Topic;
import com.interview.service.TopicService;
import com.interview.util.JsonResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * @author rxliuli
 */
@RestController
public class CommonRestController {
  @Autowired
  private TopicService topicService;

  /**
   * 根据标题模糊分页查询面试题列表
   *
   * @param searchTopicTitle 要搜索的标题
   */
  @RequestMapping(path = "/getTopicListByParam")
  public JsonResult<Map<String, Object>> getTopicListByParam(
    @RequestParam(required = false) Integer pageIndex,
    @RequestParam(required = false) Integer pageSize,
    @RequestParam(required = false) String searchTopicTitle
  ) {
    //判断参数的合法性
    if (pageIndex == null) {
      return JsonResult.getError("第几页不能为空！");
    }
    if (pageSize == null) {
      return JsonResult.getError("一页显示的数量不能为空！");
    }
    //执行数据库操作
    Page<Topic> topicPage = new Page<>(pageIndex, pageSize);
    Map<String, Object> map = topicService.listByParam(searchTopicTitle, topicPage);
    return JsonResult.getSuccess(map);
  }
}
