package com.interview.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.interview.dao.TopicTypeMapper;
import com.interview.entity.TopicType;
import com.interview.service.TopicTypeService;
import org.springframework.stereotype.Service;

/**
 * @author rxliuli
 */
@Service
public class TopicTypeServiceImpl extends ServiceImpl<TopicTypeMapper, TopicType> implements TopicTypeService {
}
