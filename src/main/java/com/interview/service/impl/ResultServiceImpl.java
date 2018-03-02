package com.interview.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.interview.dao.ResultMapper;
import com.interview.entity.Result;
import com.interview.service.ResultService;
import org.springframework.stereotype.Service;

/**
 * @author rxliuli
 */
@Service
public class ResultServiceImpl extends ServiceImpl<ResultMapper, Result> implements ResultService {
}
