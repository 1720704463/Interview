package com.interview.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.interview.dao.UserLogMapper;
import com.interview.entity.UserLog;
import com.interview.service.UserLogService;
import org.springframework.stereotype.Service;

/**
 * @author rxliuli
 */
@Service
public class UserLogServiceImpl extends ServiceImpl<UserLogMapper, UserLog> implements UserLogService {
}
