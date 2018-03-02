package com.interview.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.interview.entity.Topic;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author rxliuli
 */
public interface TopicMapper extends BaseMapper<Topic> {
  /**
   * 根据标题模糊查询面试题列表
   *
   * @param title 面试题标题
   * @return 面试题列表
   */
  List<Topic> listByTitle(@Param("title") String title, Pagination page);

  /**
   * 随机获取指定数量的面试题目
   *
   * @param topicNumber 指定面试题的数量
   * @return 面试题目列表
   */
  List<Topic> listByRandom(@Param("topicNumber") Integer topicNumber);
}
