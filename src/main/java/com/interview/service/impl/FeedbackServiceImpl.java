package com.interview.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.interview.dao.FeedbackMapper;
import com.interview.entity.Feedback;
import com.interview.service.FeedbackService;
import org.springframework.stereotype.Service;

/**
 * @author rxliuli
 */
@Service
public class FeedbackServiceImpl extends ServiceImpl<FeedbackMapper, Feedback> implements FeedbackService {
}
