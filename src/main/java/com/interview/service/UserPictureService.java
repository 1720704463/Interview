package com.interview.service;

import com.baomidou.mybatisplus.service.IService;
import com.interview.entity.UserPicture;

/**
 * @author rxliuli
 */
public interface UserPictureService extends IService<UserPicture> {
  /**
   * 随机获取一个头像
   *
   * @return 用户默认头像
   */
  UserPicture findByRandom();
}
