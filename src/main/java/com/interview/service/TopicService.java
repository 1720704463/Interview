package com.interview.service;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;
import com.interview.entity.Topic;

import java.util.List;
import java.util.Map;

/**
 * @author rxliuli
 */
public interface TopicService extends IService<Topic> {
  /**
   * 根据标题模糊查询面试题列表(分页)
   *
   * @param title 面试题标题
   * @param page  分页信息
   * @return 分页的面试题列表
   */
  Map<String, Object> listByParam(String title, Page<Topic> page);

  /**
   * 随机获取指定数量的面试题目
   *
   * @param topicNumber 指定面试题的数量
   * @return 面试题目列表
   */
  List<Topic> listByRandom(Integer topicNumber);

}
