package com.interview.entity;

import java.sql.Timestamp;

/**
 * @author rxliuli
 */
public class Exam extends BaseEntity {
  private Long id;
  private String title;
  private Timestamp startTime;
  private Timestamp endTime;
  private String topicIds;

  public Exam() {
  }

  public Exam(String title, Timestamp startTime, Timestamp endTime, String topicIds) {
    this.title = title;
    this.startTime = startTime;
    this.endTime = endTime;
    this.topicIds = topicIds;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public Timestamp getStartTime() {
    return startTime;
  }

  public void setStartTime(Timestamp startTime) {
    this.startTime = startTime;
  }

  public Timestamp getEndTime() {
    return endTime;
  }

  public void setEndTime(Timestamp endTime) {
    this.endTime = endTime;
  }

  public String getTopicIds() {
    return topicIds;
  }

  public void setTopicIds(String topicIds) {
    this.topicIds = topicIds;
  }
}
