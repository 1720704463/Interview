package com.interview.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.interview.dao.UserLoginMapper;
import com.interview.entity.UserLogin;
import com.interview.service.UserLoginService;
import com.interview.util.EncryptUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author rxliuli
 */
@Service
public class UserLoginServiceImpl extends ServiceImpl<UserLoginMapper, UserLogin> implements UserLoginService {
  /**
   * 用户数据库访问接口对象
   */
  @Autowired
  private UserLoginMapper userLoginMapper;

  @Override
  public UserLogin getByUserLogin(UserLogin userLogin) {
    userLogin.setPassword(EncryptUtil.sha512Hex(userLogin.getPassword()));
    return userLoginMapper.selectOne(userLogin);
  }
}
