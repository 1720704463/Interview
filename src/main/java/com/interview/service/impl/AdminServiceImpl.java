package com.interview.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.interview.dao.AdminMapper;
import com.interview.entity.Admin;
import com.interview.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author rxliuli
 */
@Service
public class AdminServiceImpl extends ServiceImpl<AdminMapper, Admin> implements AdminService {
  @Autowired
  private AdminMapper adminMapper;

}
