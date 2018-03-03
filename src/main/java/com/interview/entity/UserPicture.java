package com.interview.entity;

import com.baomidou.mybatisplus.annotations.TableName;

/**
 * @author rxliuli
 */
@TableName(value = "user_picture")
public class UserPicture extends BaseEntity {
  private Long id;
  private String picture;

  public UserPicture() {
  }

  public UserPicture(String picture) {
    this.picture = picture;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }


  public String getPicture() {
    return picture;
  }

  public void setPicture(String picture) {
    this.picture = picture;
  }
}
