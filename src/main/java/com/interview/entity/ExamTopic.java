package com.interview.entity;

import com.baomidou.mybatisplus.annotations.TableName;

/**
 * @author rxliuli
 */
@TableName("exam_topic")
public class ExamTopic extends BaseEntity {
  private Long id;
  private Long resultId;
  private Long topicId;
  private Double topicScore;
  private String content;

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public Long getResultId() {
    return resultId;
  }

  public void setResultId(Long resultId) {
    this.resultId = resultId;
  }

  public Long getTopicId() {
    return topicId;
  }

  public void setTopicId(Long topicId) {
    this.topicId = topicId;
  }

  public Double getTopicScore() {
    return topicScore;
  }

  public void setTopicScore(Double topicScore) {
    this.topicScore = topicScore;
  }

  public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
  }
}
