package com.interview.entity;


import com.baomidou.mybatisplus.annotations.TableName;

/**
 * @author rxliuli
 */
@TableName(value = "user_key")
public class UserKey extends BaseEntity {
  private Long id;
  private String userKey;

  public UserKey() {
  }

  public UserKey(Long id, String userKey) {

    this.id = id;
    this.userKey = userKey;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getUserKey() {
    return userKey;
  }

  public void setUserKey(String userKey) {
    this.userKey = userKey;
  }

}
