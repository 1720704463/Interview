package com.interview.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.interview.dao.TopicMapper;
import com.interview.dao.TopicTypeMapper;
import com.interview.entity.Topic;
import com.interview.entity.TopicType;
import com.interview.service.TopicService;
import com.interview.util.MapUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @author rxliuli
 */
@Service
public class TopicServiceImpl extends ServiceImpl<TopicMapper, Topic> implements TopicService {
  @Autowired
  private TopicTypeMapper topicTypeMapper;

  @Override
  public Map<String, Object> listByParam(String title, Page<Topic> page) {
    //查询全部的面试题目类型
    List<TopicType> topicTypeList = topicTypeMapper.selectList(new EntityWrapper<>());
    //分页查询查询面试题目
    Page<Topic> topicPage = page.setRecords(baseMapper.listByTitle(title, page));
    List<TopicType> topicTypeResult = topicPage.getRecords().stream()
      .map(topic ->
        //查询每个面试题对应的类型
        topicTypeList.stream()
          .filter(topicType -> topicType.getId().equals(topic.getTypeId()))
          .findFirst()
          .orElse(null)
      )
      .collect(Collectors.toList());

    return new MapUtil<String, Object>(new HashMap<>(2))
      .add("topicPage", topicPage)
      .add("topicTypeList", topicTypeResult)
      .getMap();
  }
}
