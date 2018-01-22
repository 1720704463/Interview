package com.interview.entity;

import java.sql.Timestamp;

/**
 * @author rxliuli
 */
public class Result extends BaseEntity {
  private Long id;
  private Long userLoginId;
  private Long examId;
  private Double examScore;
  private Timestamp startTime;
  private Timestamp endTime;

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

  public Long getExamId() {
    return examId;
  }

  public void setExamId(Long examId) {
    this.examId = examId;
  }

  public Double getExamScore() {
    return examScore;
  }

  public void setExamScore(Double examScore) {
    this.examScore = examScore;
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
}
