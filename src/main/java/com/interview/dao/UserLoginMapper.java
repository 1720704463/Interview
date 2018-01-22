package com.interview.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.interview.entity.UserLogin;

/**
 * @author rxliuli
 */
public interface UserLoginMapper extends BaseMapper<UserLogin> {
  /**
   * 根据用户名/邮箱和密码查询用户的登录信息
   *
   * @param entity 包含用户名/邮箱和密码的实体
   * @return 查询到的用户实体, 或者没有查询到返回 null
   */
  UserLogin selectOneByUserLogin(UserLogin entity);
}
