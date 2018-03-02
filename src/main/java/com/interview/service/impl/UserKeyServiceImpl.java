package com.interview.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.interview.dao.UserKeyMapper;
import com.interview.entity.UserKey;
import com.interview.service.UserKeyService;
import org.springframework.stereotype.Service;

/**
 * @author rxliuli
 */
@Service
public class UserKeyServiceImpl extends ServiceImpl<UserKeyMapper, UserKey> implements UserKeyService {
}
