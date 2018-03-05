package com.interview.web;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.interview.entity.*;
import com.interview.service.ExamService;
import com.interview.service.ResultService;
import com.interview.service.TopicService;
import com.interview.service.TopicTypeService;
import com.interview.util.ConstantsUtil;
import com.interview.util.JsonResult;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @author rxliuli
 */
@RestController
public class CommonRestController {
  @Autowired
  private TopicService topicService;
  @Autowired
  private TopicTypeService topicTypeService;
  @Autowired
  private ResultService resultService;
  @Autowired
  private ExamService examService;

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

  /**
   * 添加新的面试题目
   */
  @RequestMapping(path = "/submitTopicExecute")
  public JsonResult<Topic> addTopicExecute(
    @RequestParam(required = false) Long typeId,
    @RequestParam(required = false) String title,
    @RequestParam(required = false) String answer
  ) {
    //服务端判断参数是否合法
    if (StringUtils.isAnyBlank(title, answer) || typeId == null) {
      return JsonResult.getError("面试题目不能存在空值！");
    }
    //设置最后更新时间为当前时间
    Topic topic = new Topic(typeId, title, answer, new Timestamp(System.currentTimeMillis()));
    boolean boo = topicService.insert(topic);
    if (!boo) {
      return JsonResult.getError("面试题目添加失败！");
    }
    return JsonResult.getSuccess(topic);
  }

  /**
   * 获取所有的面试题目类型
   */
  @RequestMapping(path = "/getTopicTypeListExecute")
  public JsonResult<List<TopicType>> getTopicTypeListExecute() {
    return JsonResult.getSuccess(topicTypeService.selectList(new EntityWrapper<>()));
  }

  /**
   * 获取当前用户的考试列表
   */
  @RequestMapping(path = "/getResultList")
  public JsonResult<Map<String, Object>> getResultList(
    @RequestParam(required = false) Integer pageIndex,
    @RequestParam(required = false) Integer pageSize,
    @RequestParam(required = false) Long userLoginId,
    HttpSession session
  ) {
    //如果没有传入用户编号,则查询当前 session 中的用户
    if (userLoginId == null) {
      //查询当前用户
      UserLogin userLogin = (UserLogin) session.getAttribute(ConstantsUtil.USER_SESSION);
      userLoginId = userLogin.getId();
    }
    //根据当前用户查询考试
    Page<Result> resultPage = resultService.selectPage(
      new Page<>(pageIndex, pageSize),
      new EntityWrapper<Result>()
        .eq("userLoginId", userLoginId)
        .orderBy("examId", false)
    );
    List<Long> examIdList = resultPage.getRecords().stream()
      .map(Result::getExamId)
      .collect(Collectors.toList());
    //根据考试编号查询考试的详细信息
    List<Exam> examList = examService.selectBatchIds(examIdList);
    Map<String, Object> map = new HashMap<>(2);
    map.put("resultPage", resultPage);
    map.put("examList", examList);

    return JsonResult.getSuccess(map);
  }
}
