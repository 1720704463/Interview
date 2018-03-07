package com.interview.service;

import com.baomidou.mybatisplus.service.IService;
import com.interview.entity.UserLogin;

/**
 * @author rxliuli
 */
public interface UserLoginService extends IService<UserLogin> {
  /**
   * 根据用户登录信息查询登录用户
   *
   * @param userLogin 用户登录信息实体
   * @return 用户登录对象
   */
  UserLogin getByUserLogin(UserLogin userLogin);

  /**
   * 删除用户的全部信息
   */
  boolean removeUserAllInfo(Long id);
}
