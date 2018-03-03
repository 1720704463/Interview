package com.interview.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.interview.dao.UserPictureMapper;
import com.interview.entity.UserPicture;
import com.interview.service.UserPictureService;
import org.springframework.stereotype.Service;

/**
 * @author rxliuli
 */
@Service
public class UserPictureServiceImpl extends ServiceImpl<UserPictureMapper, UserPicture> implements UserPictureService {
  @Override
  public UserPicture findByRandom() {
    return baseMapper.findByRandom();
  }
}
