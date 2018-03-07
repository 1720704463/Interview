package com.interview.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.interview.dao.*;
import com.interview.entity.*;
import com.interview.service.UserLoginService;
import com.interview.util.EncryptUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author rxliuli
 */
@Service
public class UserLoginServiceImpl extends ServiceImpl<UserLoginMapper, UserLogin> implements UserLoginService {
  @Autowired
  private UserInfoMapper userInfoMapper;
  @Autowired
  private UserLogMapper userLogMapper;
  @Autowired
  private UserKeyMapper userKeyMapper;
  @Autowired
  private ResultMapper resultMapper;
  @Autowired
  private ExamTopicMapper examTopicMapper;
  @Autowired
  private TopicCommentMapper topicCommentMapper;
  @Autowired
  private FeedbackMapper feedbackMapper;

  @Override
  public UserLogin getByUserLogin(UserLogin userLogin) {
    userLogin.setPassword(EncryptUtil.sha512Hex(userLogin.getPassword()));
    return baseMapper.selectOne(userLogin);
  }

  @Override
  public boolean removeUserAllInfo(Long id) {
    //删除用户的详细信息
    userInfoMapper.deleteById(id);
    //删除用户的登录加密密钥
    userKeyMapper.deleteById(id);
    //删除用户的日志
    userLogMapper.delete(new EntityWrapper<UserLog>()
      .eq("userLoginId", id)
    );
    //删除用户的评论
    topicCommentMapper.delete(new EntityWrapper<TopicComment>()
      .eq("userLoginId", id)
    );
    //查询用户的所有考试
    List<Result> resultList = resultMapper.selectList(new EntityWrapper<Result>()
      .eq("userLoginId", id)
    );
    //删除用户的考试题目详情
    resultList.forEach(result -> examTopicMapper.delete(
      new EntityWrapper<ExamTopic>()
        .eq("resultId", result.getId())
    ));
    //删除用户的考试
    resultMapper.delete(new EntityWrapper<Result>()
      .eq("userLoginId", id)
    );
    return true;
  }
}
