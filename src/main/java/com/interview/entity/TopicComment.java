package com.interview.entity;

import com.baomidou.mybatisplus.annotations.TableName;

import java.sql.Timestamp;

/**
 * @author rxliuli
 */
@TableName(value = "topic_comment")
public class TopicComment extends BaseEntity {
  private Long id;
  private Long userLoginId;
  private Long topicId;
  private String content;
  private Timestamp commentTime;

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

  public Long getTopicId() {
    return topicId;
  }

  public void setTopicId(Long topicId) {
    this.topicId = topicId;
  }

  public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
  }

  public Timestamp getCommentTime() {
    return commentTime;
  }

  public void setCommentTime(Timestamp commentTime) {
    this.commentTime = commentTime;
  }
}
