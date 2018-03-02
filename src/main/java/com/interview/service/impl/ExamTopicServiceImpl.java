package com.interview.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.interview.dao.ExamTopicMapper;
import com.interview.entity.ExamTopic;
import com.interview.service.ExamTopicService;
import org.springframework.stereotype.Service;

/**
 * @author rxliuli
 */
@Service
public class ExamTopicServiceImpl extends ServiceImpl<ExamTopicMapper, ExamTopic> implements ExamTopicService {
}
