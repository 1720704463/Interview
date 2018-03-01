package com.interview.entity;


import com.baomidou.mybatisplus.annotations.TableName;

import java.sql.Timestamp;

@TableName(value = "user_log")
public class UserLog extends BaseEntity {
  private Long id;
  private Long userLoginId;
  private String path;
  private String referer;
  private String ip;
  private java.sql.Timestamp dateTimeLog;
  private String userAgent;

  public UserLog() {
  }

  public UserLog(Long userLoginId, String path, String referer, String ip, Timestamp dateTimeLog, String userAgent) {

    this.userLoginId = userLoginId;
    this.path = path;
    this.referer = referer;
    this.ip = ip;
    this.dateTimeLog = dateTimeLog;
    this.userAgent = userAgent;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public Long getUserLoginId() {
    return userLoginId;
  }

  public void setUserLoginId(Long userLoginId) {
    this.userLoginId = userLoginId;
  }

  public String getPath() {
    return path;
  }

  public void setPath(String path) {
    this.path = path;
  }

  public String getReferer() {
    return referer;
  }

  public void setReferer(String referer) {
    this.referer = referer;
  }

  public String getIp() {
    return ip;
  }

  public void setIp(String ip) {
    this.ip = ip;
  }

  public Timestamp getDateTimeLog() {
    return dateTimeLog;
  }

  public void setDateTimeLog(Timestamp dateTimeLog) {
    this.dateTimeLog = dateTimeLog;
  }

  public String getUserAgent() {
    return userAgent;
  }

  public void setUserAgent(String userAgent) {
    this.userAgent = userAgent;
  }
}
