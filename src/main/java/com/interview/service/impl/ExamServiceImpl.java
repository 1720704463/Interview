package com.interview.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.interview.dao.ExamMapper;
import com.interview.entity.Exam;
import com.interview.service.ExamService;
import org.springframework.stereotype.Service;

/**
 * @author rxliuli
 */
@Service
public class ExamServiceImpl extends ServiceImpl<ExamMapper, Exam> implements ExamService {
}
