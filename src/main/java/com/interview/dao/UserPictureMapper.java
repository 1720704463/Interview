package com.interview.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.interview.entity.UserPicture;

/**
 * @author rxliuli
 */
public interface UserPictureMapper extends BaseMapper<UserPicture> {
  /**
   * 随机获取一个头像
   *
   * @return 用户默认头像
   */
  UserPicture findByRandom();
}
