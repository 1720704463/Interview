package com.interview.entity;

import java.sql.Timestamp;

/**
 * @author rxliuli
 */
public class Topic extends BaseEntity {
  private Long id;
  private Long typeId;
  private String title;
  private String answer;
  private Timestamp updateTime;

  public Topic() {
  }

  public Topic(Long typeId, String title, String answer, Timestamp updateTime) {
    this.typeId = typeId;
    this.title = title;
    this.answer = answer;
    this.updateTime = updateTime;
  }

  public Topic(Long id, Long typeId, String title, String answer, Timestamp updateTime) {
    this.id = id;
    this.typeId = typeId;
    this.title = title;
    this.answer = answer;
    this.updateTime = updateTime;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public Long getTypeId() {
    return typeId;
  }

  public void setTypeId(Long typeId) {
    this.typeId = typeId;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getAnswer() {
    return answer;
  }

  public void setAnswer(String answer) {
    this.answer = answer;
  }

  public Timestamp getUpdateTime() {
    return updateTime;
  }

  public void setUpdateTime(Timestamp updateTime) {
    this.updateTime = updateTime;
  }
}
