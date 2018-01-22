package com.interview.entity;

import com.baomidou.mybatisplus.annotations.TableName;

/**
 * @author rxliuli
 */
@TableName(value = "topic_type")
public class TopicType extends BaseEntity {
  private Long id;
  private String title;
  private String description;

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

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }
}
