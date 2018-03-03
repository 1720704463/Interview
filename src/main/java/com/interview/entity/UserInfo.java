package com.interview.entity;

import com.baomidou.mybatisplus.annotations.TableName;

import java.sql.Date;

/**
 * @author rxliuli
 */
@TableName(value = "user_info")
public class UserInfo extends BaseEntity {
  private Long id;
  private String nickname;
  private String realname;
  private String picture;
  private Date birthday;
  private Integer gender;
  private String address;

  public UserInfo() {
  }

  public UserInfo(Long id, String nickname, String picture) {
    this.id = id;
    this.nickname = nickname;
    this.picture = picture;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getNickname() {
    return nickname;
  }

  public void setNickname(String nickname) {
    this.nickname = nickname;
  }

  public String getRealname() {
    return realname;
  }

  public void setRealname(String realname) {
    this.realname = realname;
  }

  public String getPicture() {
    return picture;
  }

  public void setPicture(String picture) {
    this.picture = picture;
  }

  public Date getBirthday() {
    return birthday;
  }

  public void setBirthday(Date birthday) {
    this.birthday = birthday;
  }

  public Integer getGender() {
    return gender;
  }

  public void setGender(Integer gender) {
    this.gender = gender;
  }

  public String getAddress() {
    return address;
  }

  public void setAddress(String address) {
    this.address = address;
  }
}
