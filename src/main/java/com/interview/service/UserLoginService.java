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
   * 根据用户 id 和密码查询用户
   *
   * @param id       用户 id
   * @param password 用户密码
   * @return 查询到的用户, 没有查询到则返回 null
   */
  UserLogin getByIdAndPassword(Long id, String password);

  /**
   * 删除用户的全部信息
   */
  boolean removeUserAllInfo(Long id);
}
