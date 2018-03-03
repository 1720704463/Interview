package com.interview.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.interview.dao.UserInfoMapper;
import com.interview.entity.UserInfo;
import com.interview.service.UserInfoService;
import org.springframework.stereotype.Service;

/**
 * @author rxliuli
 */
@Service
public class UserInfoServiceImpl extends ServiceImpl<UserInfoMapper, UserInfo> implements UserInfoService {
}
